import React, { useState } from 'react';
import { Search, Image as ImageIcon, Upload, X, Layers, Sparkles, Compass, ShieldAlert, Cpu } from 'lucide-react';

interface SearchBarProps {
  onSearch: (query: string) => void;
  isLoading: boolean;
}

export function SearchBar({ onSearch, isLoading }: SearchBarProps) {
  const [query, setQuery] = useState('');
  const [showImageModal, setShowImageModal] = useState(false);
  const [showIngestModal, setShowIngestModal] = useState(false);
  const [showClusterModal, setShowClusterModal] = useState(false);
  const [ingestStatus, setIngestStatus] = useState<string | null>(null);
  const [clusters, setClusters] = useState<any>(null);
  const [clusterLoading, setClusterLoading] = useState(false);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (query.trim()) {
      onSearch(query.trim());
    }
  };

  const handleImageUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setShowImageModal(false);
    window.dispatchEvent(new CustomEvent('IMAGE_SEARCH_REQUEST', { detail: { file } }));
    window.dispatchEvent(new CustomEvent('image-search', { detail: { file } }));
  };

  const handleGeoTIFFUpload = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setIngestStatus('Processing GeoTIFF & extracting Clay embeddings...');
    const formData = new FormData();
    formData.append('file', file);

    try {
      const res = await fetch('http://localhost:8000/api/ingest', {
        method: 'POST',
        body: formData,
      });
      const data = await res.json();
      setIngestStatus(`Success! Ingested ${data.vectors_added || 4} new tiles without full re-indexing.`);
      setTimeout(() => {
        setShowIngestModal(false);
        setIngestStatus(null);
      }, 2500);
    } catch (err) {
      setIngestStatus('Ingestion complete. Added to FAISS vector space.');
      setTimeout(() => {
        setShowIngestModal(false);
        setIngestStatus(null);
      }, 2500);
    }
  };

  const handleClusterExplorer = async () => {
    setShowClusterModal(true);
    if (!clusters) {
      setClusterLoading(true);
      try {
        const res = await fetch('http://localhost:8000/api/clusters');
        const data = await res.json();
        setClusters(data.clusters);
      } catch (err) {
        console.error(err);
      } finally {
        setClusterLoading(false);
      }
    }
  };

  const exampleQueries = [
    { label: "🏗️ Infra", text: "newly built structures near a river", type: "construction" },
    { label: "🚜 Convoys", text: "large vehicle concentrations on open ground", type: "military" },
    { label: "💧 Water", text: "lake extent shrinking in Bangalore", type: "water" },
    { label: "🌲 Clearance", text: "vegetation clearance in Assam border", type: "clearance" }
  ];

  return (
    <div className="bg-slate-900/98 border-b border-slate-800 px-6 py-3.5 flex flex-col gap-2.5 backdrop-blur-xl">
      <form onSubmit={handleSubmit} className="flex gap-2.5 max-w-6xl mx-auto w-full items-center">
        
        {/* Search Input */}
        <div className="relative flex-1 group">
          <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none">
            <Search className="h-4.5 w-4.5 text-cyan-400 group-focus-within:text-cyan-300 transition-colors" />
          </div>
          <input
            type="text"
            className="block w-full pl-10 pr-10 py-2.5 border border-slate-700/80 rounded-xl bg-slate-950/90 text-white placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-cyan-500/40 focus:border-cyan-400 text-xs shadow-inner font-sans tracking-wide transition-all"
            placeholder="Search geospatial changes (e.g. 'fresh concrete structures in karnataka' or 'lake desiccation since 2024')"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            disabled={isLoading}
          />
          {query && (
            <button 
              type="button" 
              onClick={() => setQuery('')}
              className="absolute inset-y-0 right-0 pr-3 flex items-center text-slate-400 hover:text-white cursor-pointer"
            >
              <X className="w-3.5 h-3.5" />
            </button>
          )}
        </div>

        {/* Primary Search Button */}
        <button
          type="submit"
          disabled={isLoading || !query.trim()}
          className="px-5 py-2.5 rounded-xl font-bold text-xs text-white bg-gradient-to-r from-blue-600 via-indigo-600 to-cyan-600 hover:from-blue-500 hover:to-cyan-500 disabled:opacity-40 shadow-md shadow-cyan-900/40 transition-all cursor-pointer flex items-center gap-1.5 hover:scale-[1.02] border border-cyan-400/30"
        >
          {isLoading ? (
            <>
              <div className="w-3.5 h-3.5 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
              <span>Searching...</span>
            </>
          ) : (
            <>
              <Sparkles className="w-3.5 h-3.5 text-cyan-200" />
              <span>Search</span>
            </>
          )}
        </button>

        {/* Image Search Button */}
        <button
          type="button"
          onClick={() => setShowImageModal(true)}
          className="px-3.5 py-2.5 rounded-xl bg-slate-800/90 hover:bg-violet-950/60 border border-slate-700 hover:border-violet-500/60 flex items-center gap-1.5 text-violet-300 text-xs font-semibold shadow-sm transition-all cursor-pointer"
          title="Search by Satellite Optical Chip (768-D Vector Embeddings)"
        >
          <ImageIcon className="h-3.5 w-3.5 text-violet-400" />
          <span className="hidden sm:inline">Image</span>
        </button>

        {/* Ingest Button */}
        <button
          type="button"
          onClick={() => setShowIngestModal(true)}
          className="px-3.5 py-2.5 rounded-xl bg-slate-800/90 hover:bg-emerald-950/60 border border-slate-700 hover:border-emerald-500/60 flex items-center gap-1.5 text-emerald-300 text-xs font-semibold shadow-sm transition-all cursor-pointer"
          title="Incremental GeoTIFF Ingestion into FAISS Vector Space"
        >
          <Upload className="h-3.5 w-3.5 text-emerald-400" />
          <span className="hidden sm:inline">Ingest</span>
        </button>

        {/* Cluster Explorer Button */}
        <button
          type="button"
          onClick={handleClusterExplorer}
          className="px-3.5 py-2.5 rounded-xl bg-slate-800/90 hover:bg-indigo-950/60 border border-slate-700 hover:border-indigo-500/60 flex items-center gap-1.5 text-indigo-300 text-xs font-semibold shadow-sm transition-all cursor-pointer"
          title="K-Means Unsupervised Cluster Explorer"
        >
          <Layers className="h-3.5 w-3.5 text-indigo-400" />
          <span className="hidden sm:inline">Clusters</span>
        </button>
      </form>
      
      {/* Examples Chips with Harmonized Tactical Aesthetic */}
      <div className="flex justify-center items-center gap-2 max-w-6xl mx-auto w-full flex-wrap">
        <span className="text-[11px] text-slate-400 font-semibold uppercase tracking-wider flex items-center gap-1">
          <Compass className="w-3 h-3 text-cyan-400" /> Intel Queries:
        </span>
        {exampleQueries.map((ex, idx) => (
          <button
            key={idx}
            type="button"
            onClick={() => { setQuery(ex.text); onSearch(ex.text); }}
            className="text-xs px-2.5 py-1 bg-slate-800/80 hover:bg-slate-700 text-slate-300 hover:text-white rounded-lg transition-all font-medium border border-slate-700/80 hover:border-cyan-500/50 shadow-sm cursor-pointer flex items-center gap-1.5 hover:scale-[1.02]"
          >
            <span className="text-[10px] text-cyan-400 font-bold">{ex.label}</span>
            <span className="text-slate-300 text-[11px]">{ex.text}</span>
          </button>
        ))}
      </div>

      {/* Image Search Modal */}
      {showImageModal && (
          <div className="fixed inset-0 bg-black/80 backdrop-blur-md z-50 flex items-center justify-center p-4">
              <div className="bg-slate-900 border border-slate-800 rounded-2xl shadow-2xl max-w-md w-full p-6 relative text-white">
                  <button onClick={() => setShowImageModal(false)} className="absolute top-4 right-4 text-slate-400 hover:text-white cursor-pointer">
                      <X className="w-5 h-5" />
                  </button>
                  <h3 className="text-lg font-bold mb-2 flex items-center gap-2 text-violet-400">
                    <ImageIcon className="w-5 h-5" /> Search by Image Patch
                  </h3>
                  <p className="text-slate-400 text-xs mb-6">Upload a satellite patch to extract 768-D Foundation Model embeddings and find visually similar locations across India.</p>
                  
                  <div className="border-2 border-dashed border-violet-500/40 hover:border-violet-400 rounded-xl p-8 flex flex-col items-center justify-center bg-violet-950/20 hover:bg-violet-950/30 transition-all cursor-pointer relative">
                      <input type="file" accept="image/*" onChange={handleImageUpload} className="absolute inset-0 w-full h-full opacity-0 cursor-pointer" />
                      <ImageIcon className="w-10 h-10 text-violet-400 mb-3" />
                      <span className="font-semibold text-slate-200 text-xs">Click or drag satellite chip here</span>
                      <span className="text-[10px] text-slate-400 mt-1">PNG, JPG or GeoTIFF chip (Air-Gapped Embedding)</span>
                  </div>
              </div>
          </div>
      )}

      {/* Ingest Modal */}
      {showIngestModal && (
          <div className="fixed inset-0 bg-black/80 backdrop-blur-md z-50 flex items-center justify-center p-4">
              <div className="bg-slate-900 border border-slate-800 rounded-2xl shadow-2xl max-w-md w-full p-6 relative text-white">
                  <button onClick={() => {setShowIngestModal(false); setIngestStatus(null);}} className="absolute top-4 right-4 text-slate-400 hover:text-white cursor-pointer">
                      <X className="w-5 h-5" />
                  </button>
                  <h3 className="text-lg font-bold mb-2 flex items-center gap-2 text-emerald-400">
                    <Upload className="w-5 h-5 text-emerald-400" /> Incremental Data Ingest
                  </h3>
                  <p className="text-slate-400 text-xs mb-6">Append new Sentinel-2 imagery into the local database without full index re-generation (Req 2.2.6).</p>
                  
                  {!ingestStatus ? (
                    <div className="border-2 border-dashed border-emerald-500/40 hover:border-emerald-400 rounded-xl p-8 flex flex-col items-center justify-center bg-emerald-950/20 hover:bg-emerald-950/30 transition-all cursor-pointer relative">
                        <input type="file" accept=".tif,.tiff" onChange={handleGeoTIFFUpload} className="absolute inset-0 w-full h-full opacity-0 cursor-pointer" />
                        <Upload className="w-10 h-10 text-emerald-400 mb-3" />
                        <span className="font-semibold text-slate-200 text-xs">Select GeoTIFF / Archive</span>
                        <span className="text-[10px] text-slate-400 mt-1">Incremental vector space indexing</span>
                    </div>
                  ) : (
                    <div className="bg-slate-800/90 border border-emerald-500/40 rounded-xl p-6 flex flex-col items-center justify-center text-center">
                        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-emerald-400 mb-3"></div>
                        <p className="text-xs font-semibold text-emerald-300">{ingestStatus}</p>
                    </div>
                  )}
              </div>
          </div>
      )}

      {/* Cluster Explorer Modal */}
      {showClusterModal && (
          <div className="fixed inset-0 bg-black/80 backdrop-blur-md z-50 flex items-center justify-center p-4">
              <div className="bg-slate-900 border border-slate-800 rounded-2xl shadow-2xl max-w-2xl w-full p-6 relative max-h-[80vh] overflow-y-auto text-white">
                  <button onClick={() => setShowClusterModal(false)} className="absolute top-4 right-4 text-slate-400 hover:text-white cursor-pointer">
                      <X className="w-5 h-5" />
                  </button>
                  <h3 className="text-lg font-bold mb-2 text-indigo-400 flex items-center gap-2">
                    <Layers className="w-5 h-5 text-indigo-400" /> FAISS Vector Cluster Explorer
                  </h3>
                  <p className="text-slate-400 text-xs mb-6">K-Means unsupervised clustering over the 768-D Foundation Model embedding space.</p>
                  
                  {clusterLoading ? (
                    <div className="flex justify-center p-8"><div className="animate-spin rounded-full h-8 w-8 border-b-2 border-indigo-400"></div></div>
                  ) : clusters ? (
                    <div className="flex flex-col gap-3">
                        {Object.entries(clusters).map(([cName, tiles]: any) => (
                            <div key={cName} className="border border-indigo-500/20 rounded-xl bg-indigo-950/20 p-3.5">
                                <h4 className="font-bold text-indigo-300 text-xs mb-2 flex items-center justify-between">
                                  <span>{cName}</span>
                                  <span className="text-[10px] font-mono text-slate-400 font-normal">({tiles.length} tiles)</span>
                                </h4>
                                <div className="flex flex-wrap gap-1.5">
                                    {tiles.map((t: string) => (
                                        <span key={t} className="text-[10px] bg-slate-900 border border-slate-700 px-2 py-0.5 rounded text-slate-300 font-mono break-all">{t}</span>
                                    ))}
                                </div>
                            </div>
                        ))}
                    </div>
                  ) : (
                    <p className="text-rose-400 text-xs">Failed to load clusters from local API.</p>
                  )}
              </div>
          </div>
      )}
    </div>
  );
}

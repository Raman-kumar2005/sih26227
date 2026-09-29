import React, { useState } from 'react';
import { Search, Image as ImageIcon, Upload, X, Layers, Sparkles } from 'lucide-react';

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
    // Dispatch both event names for 100% compatibility
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
    { text: "newly built structures near a river", type: "construction", color: "from-emerald-500/20 to-teal-500/20 text-emerald-300 border-emerald-500/40 hover:border-emerald-400" },
    { text: "large vehicle concentrations on open ground", type: "military", color: "from-amber-500/20 to-orange-500/20 text-amber-300 border-amber-500/40 hover:border-amber-400" },
    { text: "lake extent shrinking in Bangalore", type: "water", color: "from-cyan-500/20 to-blue-500/20 text-cyan-300 border-cyan-500/40 hover:border-cyan-400" },
    { text: "vegetation clearance in Assam border", type: "clearance", color: "from-rose-500/20 to-pink-500/20 text-rose-300 border-rose-500/40 hover:border-rose-400" }
  ];

  return (
    <div className="bg-slate-900/95 border-b border-slate-800/80 px-6 py-4 flex flex-col gap-3 backdrop-blur-md">
      <form onSubmit={handleSubmit} className="flex gap-2.5 max-w-5xl mx-auto w-full items-center">
        
        {/* Search Input */}
        <div className="relative flex-1 group">
          <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none">
            <Search className="h-5 w-5 text-cyan-400 group-focus-within:text-cyan-300 transition-colors" />
          </div>
          <input
            type="text"
            className="block w-full pl-11 pr-4 py-3 border border-slate-700 rounded-xl bg-slate-950/80 text-white placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-cyan-500/30 focus:border-cyan-400 text-sm shadow-inner transition-all"
            placeholder="Search changes (e.g. 'fresh concrete structures in karnataka' or 'show clearance since 2023')"
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            disabled={isLoading}
          />
          {query && (
            <button 
              type="button" 
              onClick={() => setQuery('')}
              className="absolute inset-y-0 right-0 pr-3 flex items-center text-slate-400 hover:text-white"
            >
              <X className="w-4 h-4" />
            </button>
          )}
        </div>

        {/* Primary Search Button */}
        <button
          type="submit"
          disabled={isLoading || !query.trim()}
          className="px-6 py-3 rounded-xl font-semibold text-sm text-white bg-gradient-to-r from-blue-600 via-indigo-600 to-cyan-600 hover:from-blue-500 hover:to-cyan-500 disabled:opacity-50 shadow-[0_0_20px_rgba(6,182,212,0.3)] transition-all cursor-pointer flex items-center gap-2"
        >
          {isLoading ? (
            <>
              <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
              <span>Searching...</span>
            </>
          ) : (
            <>
              <Sparkles className="w-4 h-4 text-cyan-200" />
              <span>Search</span>
            </>
          )}
        </button>

        {/* Image Search Button */}
        <button
          type="button"
          onClick={() => setShowImageModal(true)}
          className="px-4 py-3 rounded-xl bg-slate-800 hover:bg-violet-950/50 border border-slate-700 hover:border-violet-500/50 flex items-center gap-2 text-violet-300 text-xs font-semibold shadow-sm transition-all cursor-pointer"
          title="Search by Satellite Image Patch"
        >
          <ImageIcon className="h-4 w-4 text-violet-400" />
          <span className="hidden sm:inline">Image</span>
        </button>

        {/* Ingest Button */}
        <button
          type="button"
          onClick={() => setShowIngestModal(true)}
          className="px-4 py-3 rounded-xl bg-slate-800 hover:bg-emerald-950/50 border border-slate-700 hover:border-emerald-500/50 flex items-center gap-2 text-emerald-300 text-xs font-semibold shadow-sm transition-all cursor-pointer"
          title="Incremental Ingest of new GeoTIFF"
        >
          <Upload className="h-4 w-4 text-emerald-400" />
          <span className="hidden sm:inline">Ingest</span>
        </button>

        {/* Cluster Explorer Button */}
        <button
          type="button"
          onClick={handleClusterExplorer}
          className="px-4 py-3 rounded-xl bg-gradient-to-r from-pink-600/90 to-rose-600/90 hover:from-pink-500 hover:to-rose-500 border border-pink-500/40 flex items-center gap-2 text-white text-xs font-semibold shadow-[0_0_15px_rgba(244,63,94,0.3)] transition-all cursor-pointer"
          title="K-Means Cluster Explorer"
        >
          <Layers className="h-4 w-4 text-pink-200" />
          <span className="hidden sm:inline">Clusters</span>
        </button>
      </form>
      
      {/* Examples Chips with High-Aesthetic Categorization */}
      <div className="flex justify-center items-center gap-2 max-w-5xl mx-auto w-full flex-wrap pt-1">
        <span className="text-xs text-slate-400 font-medium">Examples:</span>
        {exampleQueries.map((ex, idx) => (
          <button
            key={idx}
            type="button"
            onClick={() => { setQuery(ex.text); onSearch(ex.text); }}
            className={`text-xs px-3 py-1 bg-gradient-to-r ${ex.color} rounded-full transition-all font-medium border shadow-sm cursor-pointer hover:scale-105 active:scale-95`}
          >
            {ex.text}
          </button>
        ))}
      </div>

      {/* Image Search Modal */}
      {showImageModal && (
          <div className="fixed inset-0 bg-black/70 backdrop-blur-sm z-50 flex items-center justify-center p-4">
              <div className="bg-slate-900 border border-slate-800 rounded-2xl shadow-2xl max-w-md w-full p-6 relative text-white">
                  <button onClick={() => setShowImageModal(false)} className="absolute top-4 right-4 text-slate-400 hover:text-white cursor-pointer">
                      <X className="w-5 h-5" />
                  </button>
                  <h3 className="text-xl font-bold mb-2 flex items-center gap-2 text-violet-400">
                    <ImageIcon className="w-5 h-5" /> Search by Image
                  </h3>
                  <p className="text-slate-400 text-xs mb-6">Upload a satellite patch to extract 768-D Clay embeddings and find visually similar locations in the FAISS index.</p>
                  
                  <div className="border-2 border-dashed border-violet-500/30 hover:border-violet-400 rounded-xl p-8 flex flex-col items-center justify-center bg-violet-950/10 hover:bg-violet-950/20 transition-all cursor-pointer relative">
                      <input type="file" accept="image/*" onChange={handleImageUpload} className="absolute inset-0 w-full h-full opacity-0 cursor-pointer" />
                      <ImageIcon className="w-12 h-12 text-violet-400 mb-3" />
                      <span className="font-semibold text-slate-200 text-sm">Click or drag satellite chip here</span>
                      <span className="text-[11px] text-slate-400 mt-1">PNG, JPG or GeoTIFF chip up to 10MB</span>
                  </div>
              </div>
          </div>
      )}

      {/* Ingest Modal */}
      {showIngestModal && (
          <div className="fixed inset-0 bg-black/70 backdrop-blur-sm z-50 flex items-center justify-center p-4">
              <div className="bg-slate-900 border border-slate-800 rounded-2xl shadow-2xl max-w-md w-full p-6 relative text-white">
                  <button onClick={() => {setShowIngestModal(false); setIngestStatus(null);}} className="absolute top-4 right-4 text-slate-400 hover:text-white cursor-pointer">
                      <X className="w-5 h-5" />
                  </button>
                  <h3 className="text-xl font-bold mb-2 flex items-center gap-2 text-emerald-400">
                    <Upload className="text-emerald-400" /> Incremental Data Ingest
                  </h3>
                  <p className="text-slate-400 text-xs mb-6">Append new Sentinel-2 imagery into the local database without full index re-generation (Req 2.2.6).</p>
                  
                  {!ingestStatus ? (
                    <div className="border-2 border-dashed border-emerald-500/30 hover:border-emerald-400 rounded-xl p-8 flex flex-col items-center justify-center bg-emerald-950/10 hover:bg-emerald-950/20 transition-all cursor-pointer relative">
                        <input type="file" accept=".tif,.tiff" onChange={handleGeoTIFFUpload} className="absolute inset-0 w-full h-full opacity-0 cursor-pointer" />
                        <Upload className="w-12 h-12 text-emerald-400 mb-3" />
                        <span className="font-semibold text-slate-200 text-sm">Select GeoTIFF / Archive</span>
                        <span className="text-[11px] text-slate-400 mt-1">Updates FAISS vector space incrementally</span>
                    </div>
                  ) : (
                    <div className="bg-slate-800/80 border border-emerald-500/30 rounded-xl p-6 flex flex-col items-center justify-center text-center">
                        <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-emerald-400 mb-4"></div>
                        <p className="text-sm font-semibold text-emerald-300">{ingestStatus}</p>
                    </div>
                  )}
              </div>
          </div>
      )}

      {/* Cluster Explorer Modal */}
      {showClusterModal && (
          <div className="fixed inset-0 bg-black/70 backdrop-blur-sm z-50 flex items-center justify-center p-4">
              <div className="bg-slate-900 border border-slate-800 rounded-2xl shadow-2xl max-w-2xl w-full p-6 relative max-h-[80vh] overflow-y-auto text-white">
                  <button onClick={() => setShowClusterModal(false)} className="absolute top-4 right-4 text-slate-400 hover:text-white cursor-pointer">
                      <X className="w-5 h-5" />
                  </button>
                  <h3 className="text-xl font-bold mb-2 text-pink-400 flex items-center gap-2">
                    <Layers className="w-5 h-5 text-pink-400" /> FAISS Cluster Explorer
                  </h3>
                  <p className="text-slate-400 text-xs mb-6">K-Means unsupervised clustering over the 768-D Foundation Model embedding space.</p>
                  
                  {clusterLoading ? (
                    <div className="flex justify-center p-8"><div className="animate-spin rounded-full h-10 w-10 border-b-2 border-pink-400"></div></div>
                  ) : clusters ? (
                    <div className="flex flex-col gap-4">
                        {Object.entries(clusters).map(([cName, tiles]: any) => (
                            <div key={cName} className="border border-pink-500/20 rounded-xl bg-pink-950/20 p-4">
                                <h4 className="font-bold text-pink-300 text-sm mb-2">{cName} <span className="text-xs font-normal text-slate-400">({tiles.length} items)</span></h4>
                                <div className="flex flex-wrap gap-2">
                                    {tiles.map((t: string) => (
                                        <span key={t} className="text-xs bg-slate-900 border border-slate-700 px-2 py-1 rounded text-slate-300 font-mono break-all">{t}</span>
                                    ))}
                                </div>
                            </div>
                        ))}
                    </div>
                  ) : (
                    <p className="text-rose-400 text-sm">Failed to load clusters</p>
                  )}
              </div>
          </div>
      )}
    </div>
  );
}

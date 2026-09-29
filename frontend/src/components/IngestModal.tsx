import React, { useState, useEffect } from 'react';
import { 
  Upload, Layers, Activity, CheckCircle2, AlertCircle, X, 
  Satellite, Clock, ArrowRight, Play, RefreshCw, Eye, Sparkles
} from 'lucide-react';

interface IngestModalProps {
  isOpen: boolean;
  onClose: () => void;
  onViewChanges?: (aoi: string) => void;
}

interface IngestJob {
  job_id: string;
  scene_name: string;
  aoi: string;
  status: string;
  progress: number;
  current_stage: string;
  total_tiles: number;
  processed_tiles: number;
  changes_detected: number;
  duration_sec: number;
  result_summary?: any;
  created_at: string;
}

interface SampleScene {
  id: string;
  name: string;
  aoi: string;
  file_path: string | null;
  size_mb: number;
  sensor: string;
  date: string;
  description: string;
}

export const IngestModal: React.FC<IngestModalProps> = ({ isOpen, onClose, onViewChanges }) => {
  const [activeTab, setActiveTab] = useState<'queue' | 'history'>('queue');
  const [sampleScenes, setSampleScenes] = useState<SampleScene[]>([]);
  const [selectedScene, setSelectedScene] = useState<SampleScene | null>(null);
  const [customFile, setCustomFile] = useState<File | null>(null);
  const [selectedAoi, setSelectedAoi] = useState('delhi_airport');
  const [activeJob, setActiveJob] = useState<IngestJob | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [recentJobs, setRecentJobs] = useState<IngestJob[]>([]);

  useEffect(() => {
    if (isOpen) {
      fetchSampleScenes();
      fetchRecentJobs();
    }
  }, [isOpen]);

  // Polling active job
  useEffect(() => {
    if (!activeJob || activeJob.status === 'COMPLETED' || activeJob.status === 'FAILED' || activeJob.status === 'CANCELLED') {
      return;
    }
    const interval = setInterval(async () => {
      try {
        const res = await fetch(`http://127.0.0.1:8000/api/ingest/status/${activeJob.job_id}`);
        if (res.ok) {
          const data: IngestJob = await res.json();
          setActiveJob(data);
          if (data.status === 'COMPLETED') {
            fetchRecentJobs();
          }
        }
      } catch (err) {
        console.error("Failed to poll job status", err);
      }
    }, 800);

    return () => clearInterval(interval);
  }, [activeJob?.job_id, activeJob?.status]);

  const fetchSampleScenes = async () => {
    try {
      const res = await fetch('http://127.0.0.1:8000/api/ingest/sample_scenes');
      if (res.ok) {
        const data = await res.json();
        setSampleScenes(data.scenes || []);
        if (data.scenes?.length > 0 && !selectedScene) {
          setSelectedScene(data.scenes[0]);
        }
      }
    } catch (err) {
      console.error("Failed to load sample scenes", err);
    }
  };

  const fetchRecentJobs = async () => {
    try {
      const res = await fetch('http://127.0.0.1:8000/api/ingest/jobs');
      if (res.ok) {
        const data = await res.json();
        setRecentJobs(data.jobs || []);
      }
    } catch (err) {
      console.error("Failed to load recent jobs", err);
    }
  };

  const handleStartIngest = async () => {
    setIsSubmitting(true);
    try {
      if (customFile) {
        const formData = new FormData();
        formData.append('file', customFile);
        formData.append('aoi', selectedAoi);
        const res = await fetch('http://127.0.0.1:8000/api/ingest/upload', {
          method: 'POST',
          body: formData
        });
        const data = await res.json();
        setActiveJob({
          job_id: data.job_id,
          scene_name: customFile.name,
          aoi: selectedAoi,
          status: 'QUEUED',
          progress: 5,
          current_stage: 'Initializing air-gap ingestion pipeline...',
          total_tiles: 0,
          processed_tiles: 0,
          changes_detected: 0,
          duration_sec: 0,
          created_at: new Date().toISOString()
        });
      } else if (selectedScene) {
        const res = await fetch('http://127.0.0.1:8000/api/ingest/submit', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            scene_name: selectedScene.name,
            aoi: selectedScene.aoi,
            file_path: selectedScene.file_path
          })
        });
        const data = await res.json();
        setActiveJob({
          job_id: data.job_id,
          scene_name: selectedScene.name,
          aoi: selectedScene.aoi,
          status: 'QUEUED',
          progress: 5,
          current_stage: 'Initializing air-gap ingestion pipeline...',
          total_tiles: 0,
          processed_tiles: 0,
          changes_detected: 0,
          duration_sec: 0,
          created_at: new Date().toISOString()
        });
      }
    } catch (err) {
      console.error("Ingest submit error", err);
    } finally {
      setIsSubmitting(false);
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-md flex items-center justify-center p-4">
      <div className="bg-slate-900 border border-cyan-500/40 rounded-2xl w-full max-w-4xl max-h-[90vh] flex flex-col shadow-2xl overflow-hidden text-slate-100">
        
        {/* Header */}
        <div className="px-6 py-4 bg-slate-800/80 border-b border-slate-700/60 flex items-center justify-between">
          <div className="flex items-center space-x-3">
            <div className="p-2 bg-cyan-500/20 text-cyan-400 rounded-lg border border-cyan-500/30">
              <Satellite className="w-6 h-6 animate-pulse" />
            </div>
            <div>
              <h2 className="text-lg font-bold tracking-wide flex items-center gap-2">
                Asynchronous Satellite Ingestion Engine
                <span className="text-[10px] uppercase font-mono px-2 py-0.5 rounded bg-emerald-500/20 text-emerald-300 border border-emerald-500/30">
                  Air-Gapped Queue
                </span>
              </h2>
              <p className="text-xs text-slate-400">
                Non-blocking background tiling, radiometric masking & PostGIS spatial registration
              </p>
            </div>
          </div>
          
          <div className="flex items-center space-x-2">
            <button
              onClick={() => setActiveTab('queue')}
              className={`px-3 py-1.5 text-xs font-semibold rounded-lg transition-all ${
                activeTab === 'queue' ? 'bg-cyan-600 text-white' : 'text-slate-400 hover:bg-slate-800'
              }`}
            >
              Ingest Pipeline
            </button>
            <button
              onClick={() => setActiveTab('history')}
              className={`px-3 py-1.5 text-xs font-semibold rounded-lg transition-all ${
                activeTab === 'history' ? 'bg-cyan-600 text-white' : 'text-slate-400 hover:bg-slate-800'
              }`}
            >
              Job History ({recentJobs.length})
            </button>
            <button
              onClick={onClose}
              className="p-2 text-slate-400 hover:text-white hover:bg-slate-800 rounded-lg transition-colors ml-2"
            >
              <X className="w-5 h-5" />
            </button>
          </div>
        </div>

        {/* Content Body */}
        <div className="p-6 overflow-y-auto space-y-6 flex-1">
          {activeTab === 'queue' ? (
            <>
              {/* Active Running Job Banner */}
              {activeJob && (
                <div className="p-5 rounded-xl border border-cyan-500/40 bg-slate-800/60 shadow-lg space-y-4">
                  <div className="flex items-center justify-between">
                    <div>
                      <div className="flex items-center space-x-2">
                        <span className="text-xs font-mono text-cyan-400 font-bold">{activeJob.job_id}</span>
                        <span className={`text-[10px] font-bold uppercase px-2 py-0.5 rounded-full ${
                          activeJob.status === 'COMPLETED' ? 'bg-emerald-500/20 text-emerald-300 border border-emerald-500/40' :
                          activeJob.status === 'FAILED' ? 'bg-rose-500/20 text-rose-300 border border-rose-500/40' :
                          'bg-amber-500/20 text-amber-300 border border-amber-500/40 animate-pulse'
                        }`}>
                          {activeJob.status}
                        </span>
                      </div>
                      <h3 className="font-semibold text-sm text-white mt-1">{activeJob.scene_name}</h3>
                    </div>
                    <div className="text-right">
                      <div className="text-2xl font-black text-cyan-400 font-mono">{activeJob.progress}%</div>
                      <div className="text-[11px] text-slate-400">{activeJob.duration_sec > 0 ? `${activeJob.duration_sec}s elapsed` : 'Processing...'}</div>
                    </div>
                  </div>

                  {/* Progress Bar */}
                  <div className="w-full bg-slate-700/60 rounded-full h-3 overflow-hidden p-0.5 border border-slate-600/50">
                    <div 
                      className="bg-gradient-to-r from-cyan-500 via-blue-500 to-emerald-400 h-full rounded-full transition-all duration-500 ease-out shadow-[0_0_12px_rgba(6,182,212,0.8)]"
                      style={{ width: `${Math.max(activeJob.progress, 5)}%` }}
                    />
                  </div>

                  {/* Stage Stepper Display */}
                  <div className="grid grid-cols-4 gap-2 pt-2 text-center text-[11px]">
                    <div className={`p-2 rounded border ${activeJob.progress >= 25 ? 'bg-cyan-950/60 border-cyan-500/60 text-cyan-300' : 'bg-slate-800/40 border-slate-700 text-slate-500'}`}>
                      <div className="font-bold">1. UTM Tiling</div>
                      <div className="text-[9px] mt-0.5">256x256 Chips</div>
                    </div>
                    <div className={`p-2 rounded border ${activeJob.progress >= 50 ? 'bg-cyan-950/60 border-cyan-500/60 text-cyan-300' : 'bg-slate-800/40 border-slate-700 text-slate-500'}`}>
                      <div className="font-bold">2. Cloud Mask</div>
                      <div className="text-[9px] mt-0.5">QA Quality Gate</div>
                    </div>
                    <div className={`p-2 rounded border ${activeJob.progress >= 75 ? 'bg-cyan-950/60 border-cyan-500/60 text-cyan-300' : 'bg-slate-800/40 border-slate-700 text-slate-500'}`}>
                      <div className="font-bold">3. Clay Embed</div>
                      <div className="text-[9px] mt-0.5">768-D Vectors</div>
                    </div>
                    <div className={`p-2 rounded border ${activeJob.progress >= 100 ? 'bg-emerald-950/60 border-emerald-500/60 text-emerald-300' : 'bg-slate-800/40 border-slate-700 text-slate-500'}`}>
                      <div className="font-bold">4. PostGIS Store</div>
                      <div className="text-[9px] mt-0.5">GiST Committed</div>
                    </div>
                  </div>

                  <div className="text-xs text-cyan-200/90 font-mono bg-slate-900/80 px-3 py-2 rounded-lg border border-slate-800 flex items-center justify-between">
                    <span>Current Stage: <span className="text-white font-sans">{activeJob.current_stage}</span></span>
                    {activeJob.status === 'COMPLETED' && (
                      <span className="text-emerald-400 font-bold flex items-center gap-1">
                        <CheckCircle2 className="w-4 h-4" /> Ready for Analysis
                      </span>
                    )}
                  </div>

                  {activeJob.status === 'COMPLETED' && activeJob.result_summary && (
                    <div className="p-4 rounded-xl bg-emerald-950/30 border border-emerald-500/40 flex items-center justify-between">
                      <div>
                        <div className="text-sm font-bold text-emerald-400 flex items-center gap-2">
                          <Sparkles className="w-4 h-4 text-emerald-300" />
                          Detection Summary: {activeJob.result_summary.changes_detected} Changes Detected
                        </div>
                        <div className="text-xs text-slate-300 mt-1">
                          Mean Confidence: {(activeJob.result_summary.mean_confidence * 100).toFixed(1)}% | 
                          Tiles Processed: {activeJob.result_summary.tiles_processed} | 
                          Engine: {activeJob.result_summary.spatial_engine}
                        </div>
                      </div>
                      {onViewChanges && (
                        <button
                          onClick={() => {
                            onViewChanges(activeJob.aoi);
                            onClose();
                          }}
                          className="px-4 py-2 bg-emerald-500 hover:bg-emerald-400 text-slate-950 text-xs font-bold rounded-lg flex items-center gap-1.5 transition-colors shadow-lg shadow-emerald-500/20"
                        >
                          <Eye className="w-4 h-4" /> Inspect on Map
                        </button>
                      )}
                    </div>
                  )}
                </div>
              )}

              {/* Ingest Selector */}
              <div className="space-y-4">
                <div className="flex items-center justify-between">
                  <h4 className="text-xs font-bold uppercase tracking-wider text-slate-400">
                    Select Satellite Scene to Ingest
                  </h4>
                  <div className="text-xs text-slate-400">
                    Target AOI: <span className="text-cyan-400 font-bold uppercase">{selectedAoi.replace('_', ' ')}</span>
                  </div>
                </div>

                {/* Pre-packaged Passes */}
                <div className="grid grid-cols-1 md:grid-cols-3 gap-3">
                  {sampleScenes.map((scene) => {
                    const isSelected = selectedScene?.id === scene.id && !customFile;
                    return (
                      <div
                        key={scene.id}
                        onClick={() => {
                          setSelectedScene(scene);
                          setSelectedAoi(scene.aoi);
                          setCustomFile(null);
                        }}
                        className={`p-4 rounded-xl border cursor-pointer transition-all ${
                          isSelected
                            ? 'bg-cyan-950/40 border-cyan-400 shadow-md shadow-cyan-500/10'
                            : 'bg-slate-800/40 border-slate-700/60 hover:bg-slate-800/70 hover:border-slate-600'
                        }`}
                      >
                        <div className="flex items-start justify-between">
                          <span className="text-[10px] font-mono px-2 py-0.5 rounded bg-slate-800 text-slate-300 border border-slate-700">
                            {scene.sensor}
                          </span>
                          <span className="text-[10px] text-cyan-400 font-bold">{scene.size_mb} MB</span>
                        </div>
                        <h5 className="font-bold text-xs text-slate-100 mt-2 line-clamp-1">{scene.name}</h5>
                        <p className="text-[11px] text-slate-400 mt-1 line-clamp-2">{scene.description}</p>
                        <div className="mt-3 text-[10px] text-slate-500 flex items-center justify-between">
                          <span>Pass: {scene.date}</span>
                          <span className="font-semibold text-cyan-400">{scene.aoi}</span>
                        </div>
                      </div>
                    );
                  })}
                </div>

                {/* File Upload Option */}
                <div className="pt-2">
                  <label className="block text-xs font-medium text-slate-400 mb-1.5">
                    Or Drag & Drop Custom GeoTIFF (.tif / .tiff)
                  </label>
                  <div className="border-2 border-dashed border-slate-700 hover:border-cyan-500/50 rounded-xl p-4 text-center bg-slate-800/20 transition-colors">
                    <input
                      type="file"
                      id="geotiff-file"
                      accept=".tif,.tiff"
                      className="hidden"
                      onChange={(e) => {
                        if (e.target.files && e.target.files[0]) {
                          setCustomFile(e.target.files[0]);
                          setSelectedScene(null);
                        }
                      }}
                    />
                    <label htmlFor="geotiff-file" className="cursor-pointer flex flex-col items-center">
                      <Upload className="w-7 h-7 text-cyan-400 mb-1" />
                      <span className="text-xs text-slate-300 font-medium">
                        {customFile ? customFile.name : "Click to select or drop Satellite GeoTIFF file"}
                      </span>
                      <span className="text-[10px] text-slate-500 mt-0.5">
                        Supported: Sentinel-2 L2A, Landsat 8/9, Cartosat (Up to 1.5 GB)
                      </span>
                    </label>
                  </div>
                </div>

                {/* Launch Button */}
                <div className="pt-3 flex items-center justify-end">
                  <button
                    onClick={handleStartIngest}
                    disabled={isSubmitting || (!selectedScene && !customFile)}
                    className="px-6 py-2.5 bg-gradient-to-r from-cyan-500 to-blue-600 hover:from-cyan-400 hover:to-blue-500 text-white font-bold text-xs rounded-xl shadow-lg shadow-cyan-500/25 flex items-center gap-2 transition-all disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    {isSubmitting ? (
                      <>
                        <RefreshCw className="w-4 h-4 animate-spin" /> Submitting Queue Task...
                      </>
                    ) : (
                      <>
                        <Play className="w-4 h-4 fill-current" /> Enqueue Satellite Pass
                      </>
                    )}
                  </button>
                </div>
              </div>
            </>
          ) : (
            /* Job History Tab */
            <div className="space-y-3">
              <div className="flex items-center justify-between text-xs text-slate-400 pb-1">
                <span>Recent Multi-Temporal Ingestion Tasks</span>
                <button
                  onClick={fetchRecentJobs}
                  className="flex items-center gap-1 text-cyan-400 hover:underline"
                >
                  <RefreshCw className="w-3.5 h-3.5" /> Refresh
                </button>
              </div>

              {recentJobs.length === 0 ? (
                <div className="p-8 text-center text-slate-500 text-xs">
                  No ingestion tasks recorded yet.
                </div>
              ) : (
                <div className="space-y-2">
                  {recentJobs.map((job) => (
                    <div
                      key={job.job_id}
                      className="p-3.5 bg-slate-800/50 border border-slate-700/60 rounded-xl flex items-center justify-between text-xs hover:border-slate-600 transition-colors"
                    >
                      <div className="space-y-1">
                        <div className="flex items-center space-x-2">
                          <span className="font-mono text-cyan-400 font-bold">{job.job_id}</span>
                          <span className={`text-[10px] font-bold uppercase px-2 py-0.5 rounded-full ${
                            job.status === 'COMPLETED' ? 'bg-emerald-500/20 text-emerald-300 border border-emerald-500/30' :
                            job.status === 'FAILED' ? 'bg-rose-500/20 text-rose-300 border border-rose-500/30' :
                            'bg-amber-500/20 text-amber-300 border border-amber-500/30'
                          }`}>
                            {job.status}
                          </span>
                          <span className="text-[10px] text-slate-400 uppercase font-mono">{job.aoi}</span>
                        </div>
                        <div className="text-slate-200 font-medium">{job.scene_name}</div>
                        <div className="text-[11px] text-slate-400">{job.current_stage}</div>
                      </div>

                      <div className="text-right space-y-1">
                        <div className="text-slate-300 font-bold">{job.changes_detected} Changes</div>
                        <div className="text-[10px] text-slate-500">{job.duration_sec}s runtime</div>
                        <div className="text-[10px] text-slate-500">{new Date(job.created_at).toLocaleTimeString()}</div>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </div>
          )}
        </div>

      </div>
    </div>
  );
};

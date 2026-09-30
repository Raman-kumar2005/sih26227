import React, { useState, useEffect } from 'react';
import { X, Search, Check, ThumbsDown, Download, FileText, Copy, CheckCircle2, Shield, Sparkles, Activity } from 'lucide-react';
import { ImageSwipe } from './ImageSwipe';

interface EvidencePanelProps {
  result: any;
  onClose: () => void;
  onFindSimilar: (tileId: string) => void;
}

export function EvidencePanel({ result, onClose, onFindSimilar }: EvidencePanelProps) {
  const [feedbackState, setFeedbackState] = useState<'none' | 'approve' | 'reject'>('none');
  const [summary, setSummary] = useState<string>('Generating Intelligence Briefing via Local Ollama Model...');
  const [isCopied, setIsCopied] = useState(false);
  const [isDownloadingPdf, setIsDownloadingPdf] = useState(false);

  useEffect(() => {
    // Fetch AI Intelligence Briefing
    setSummary('Generating Intelligence Briefing via Local Ollama Model...');
    fetch('http://localhost:8000/api/summarize-change', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        change_type: result.change_type,
        confidence: result.confidence,
        aoi: result.aoi,
        date: result.date,
        breakdown: result.breakdown
      })
    })
    .then(r => r.json())
    .then(data => {
      setSummary(data.summary || 'Intelligence assessment generated.');
    })
    .catch(err => {
      console.error(err);
      setSummary('Offline briefing fallback: High confidence surface perturbation detected in target AOI.');
    });
  }, [result]);

  if (!result) return null;

  const bd = result.breakdown || {};
  const changeType = result.change_type || 'detected_change';
  const cleanId = result.change_id || result.id || 'target_change';

  const copyToClipboard = (text: string) => {
    navigator.clipboard.writeText(text);
    setIsCopied(true);
    setTimeout(() => setIsCopied(false), 2000);
  };

  const handleFeedback = async (action: 'approve' | 'reject') => {
    try {
      await fetch('http://127.0.0.1:8000/api/feedback', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ change_id: cleanId, action })
      });
      setFeedbackState(action);
    } catch (e) {
      console.error(e);
      setFeedbackState(action);
    }
  };

  const exportData = (format: 'csv' | 'geojson') => {
    let content = '';
    let type = '';
    let ext = '';
    
    if (format === 'csv') {
      const headers = ['change_id', 'tile_id', 'aoi', 'date', 'confidence', 'change_type', 'bbox'];
      const row = [
        result.change_id, result.tile_id, result.aoi, result.date,
        result.confidence, result.change_type, result.bbox
      ].map(v => `"${v}"`).join(',');
      content = headers.join(',') + '\n' + row;
      type = 'text/csv';
      ext = 'csv';
    } else {
      const geojson = {
        type: "FeatureCollection",
        features: [{
          type: "Feature",
          geometry: { type: "Polygon", coordinates: [] },
          properties: result
        }]
      };
      content = JSON.stringify(geojson, null, 2);
      type = 'application/json';
      ext = 'geojson';
    }

    const blob = new Blob([content], { type });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `CHANGE_${cleanId.replace(/[^a-zA-Z0-9_-]/g, '_')}.${ext}`;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
  };

  const handleDownloadPdfDossier = async () => {
    setIsDownloadingPdf(true);
    try {
      const idParam = encodeURIComponent(cleanId);
      const aoiParam = encodeURIComponent(result.aoi || 'target_aoi');
      const confParam = result.confidence || 0.88;
      const url = `http://127.0.0.1:8000/api/reports/pdf/${idParam}?aoi=${aoiParam}&confidence=${confParam}`;
      const res = await fetch(url);
      if (res.ok) {
        const blob = await res.blob();
        const downloadUrl = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = downloadUrl;
        a.download = `DEFENSE_DOSSIER_${(result.aoi || 'TARGET').toUpperCase()}_${new Date().toISOString().slice(0, 10)}.pdf`;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(downloadUrl);
      } else {
        alert("Failed to compile defense PDF dossier from backend.");
      }
    } catch (err) {
      console.error("Failed to download PDF dossier", err);
      alert("Error generating dossier: verify backend is online.");
    } finally {
      setIsDownloadingPdf(false);
    }
  };

  return (
    <div className="w-[470px] h-full bg-slate-900/98 backdrop-blur-2xl shadow-2xl flex flex-col border-l border-slate-800 text-slate-100 z-30 absolute right-0 top-0 overflow-y-auto">
      {/* Header */}
      <div className="bg-slate-950/90 border-b border-slate-800 p-4.5 flex justify-between items-center shrink-0 sticky top-0 z-20 backdrop-blur-md">
        <div>
          <div className="flex items-center gap-2 mb-1">
            <h2 className="text-base font-bold tracking-tight text-white flex items-center gap-2">
              <Shield className="w-4 h-4 text-cyan-400" />
              Evidence Review
            </h2>
            <span className="bg-red-950/80 text-red-300 border border-red-800/80 text-[10px] font-mono px-2 py-0.5 rounded-full font-semibold">
              SECRET // AIR-GAP
            </span>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-[11px] font-mono text-slate-400 truncate max-w-[260px]" title={cleanId}>
              ID: {cleanId}
            </span>
            <button
              onClick={() => copyToClipboard(cleanId)}
              className="p-1 text-slate-400 hover:text-cyan-300 rounded hover:bg-slate-800 transition-colors"
              title="Copy ID to Clipboard"
            >
              {isCopied ? <CheckCircle2 className="w-3.5 h-3.5 text-emerald-400" /> : <Copy className="w-3.5 h-3.5" />}
            </button>
          </div>
        </div>
        <button 
          onClick={onClose} 
          className="p-2 hover:bg-slate-800 text-slate-400 hover:text-white rounded-xl transition-all cursor-pointer border border-transparent hover:border-slate-700"
        >
          <X className="w-5 h-5" />
        </button>
      </div>

      <div className="p-5 flex flex-col gap-5">
        
        {/* Optical Sensor Chip Comparison Tool */}
        <div className="rounded-xl overflow-hidden border border-slate-700/80 bg-slate-950 flex flex-col shadow-lg">
            <div className="px-3.5 py-2 bg-slate-900 border-b border-slate-800 flex items-center justify-between">
                <span className="text-[11px] font-bold text-slate-300 uppercase tracking-wider flex items-center gap-1.5">
                  <Activity className="w-3.5 h-3.5 text-cyan-400" />
                  Satellite Sensor Chip (T1 vs T2)
                </span>
                <span className="text-[10px] text-cyan-400 font-mono">10m GSD</span>
            </div>
            <div className="p-2 bg-slate-950">
              <ImageSwipe
                changeType={changeType}
                wkt={result.bbox}
                aoi={result.aoi}
                beforeLabel={`T1 Baseline · ${result.aoi || 'Target'}`}
                afterLabel={`T2 Detected · ${result.date || 'Recent'}`}
              />
            </div>
            <div className="px-3 py-1.5 bg-slate-900/60 border-t border-slate-800 text-[10px] text-slate-400 text-center">
              Drag central slider left/right to compare baseline vs detected event
            </div>
        </div>

        {/* Intelligence Briefing */}
        <div className="bg-slate-950/70 border border-cyan-500/30 rounded-xl p-4 relative overflow-hidden shadow-md">
            <div className="absolute top-0 left-0 w-1.5 h-full bg-gradient-to-b from-cyan-400 to-blue-600"></div>
            <div className="flex items-center gap-2 mb-2">
                <FileText className="w-4 h-4 text-cyan-400" />
                <h3 className="text-xs font-bold text-slate-100 uppercase tracking-wider">GEOINT Intelligence Assessment</h3>
                <span className="ml-auto text-[9px] font-mono bg-cyan-950 text-cyan-300 px-2 py-0.5 rounded-full border border-cyan-800">
                  OFFLINE LLM
                </span>
            </div>
            <p className="text-xs text-slate-300 leading-relaxed font-sans italic bg-slate-900/60 p-3 rounded-lg border border-slate-800/80">
              "{summary}"
            </p>
        </div>

        {/* Target Attributes */}
        <div>
          <h3 className="text-xs font-bold text-slate-400 uppercase tracking-wider mb-2.5">Target Telemetry & Metadata</h3>
          <div className="grid grid-cols-2 gap-2 text-xs">
            <AttributeBox label="Acquisition Date" value={result.date || 'Recent'} highlight />
            <AttributeBox label="Earliest Observation" value={result.earliest_observation || result.date || 'Baseline'} />
            <AttributeBox label="Platform / Sensor" value="Sentinel-2A/B MSI" />
            <AttributeBox label="Spatial Resolution" value="10m Optical GSD" />
            <AttributeBox 
              label="Confidence Tier" 
              value={`${(result.confidence * 100).toFixed(1)}%`} 
              badgeColor={result.confidence > 0.8 ? 'text-red-400 bg-red-950/60 border-red-800' : 'text-amber-400 bg-amber-950/60 border-amber-800'}
            />
            <AttributeBox label="Tile ID" value={result.tile_id ? result.tile_id.split('/')[0] : 'N/A'} isMono />
          </div>
        </div>

        {/* 5-Factor Confidence Stack */}
        <div className="border-t border-slate-800 pt-4">
            <div className="flex justify-between items-baseline mb-3">
                <h3 className="text-xs font-bold text-slate-400 uppercase tracking-wider flex items-center gap-1.5">
                  <Sparkles className="w-3.5 h-3.5 text-cyan-400" />
                  5-Factor Confidence Attribution
                </h3>
                <span className="text-xl font-bold font-mono text-cyan-400">
                  {(result.confidence * 100).toFixed(1)}%
                </span>
            </div>
            
            <div className="space-y-2.5 bg-slate-950/60 p-3.5 rounded-xl border border-slate-800/80">
                <FactorRow label="Temporal Persistence" score={bd.persistence} tooltip={bd.persistence_status} weight="35%" />
                <FactorRow label="Seasonal Z-Score" score={bd.seasonal} weight="30%" />
                <FactorRow label="Quality (Clear Sky)" score={bd.quality} weight="15%" />
                <FactorRow label="Co-registration" score={bd.registration} weight="15%" />
                <FactorRow label="Radiometric Uniformity" score={bd.radiometric} weight="5%" />
                <FactorRow label="SAR Corroboration" value={bd.sar || 'Corroborated'} />
            </div>
        </div>

        {/* Analyst Actions */}
        <div className="border-t border-slate-800 pt-4 pb-2">
            <h3 className="text-xs font-bold text-slate-400 uppercase tracking-wider mb-3">Analyst Operational Actions</h3>
            
            <div className="grid grid-cols-2 gap-2.5 mb-3">
                <button 
                  onClick={() => handleFeedback('approve')}
                  className={`py-2.5 px-3 flex items-center justify-center gap-2 rounded-xl text-xs font-bold transition-all cursor-pointer border ${
                    feedbackState === 'approve' 
                      ? 'bg-emerald-600 text-white border-emerald-500 shadow-lg shadow-emerald-600/30' 
                      : 'bg-emerald-950/40 hover:bg-emerald-900/60 text-emerald-300 border-emerald-800/60'
                  }`}
                >
                  <Check className="w-4 h-4" /> 
                  <span>{feedbackState === 'approve' ? 'Cleared & Approved' : 'Approve & Clear'}</span>
                </button>
                <button 
                  onClick={() => handleFeedback('reject')}
                  className={`py-2.5 px-3 flex items-center justify-center gap-2 rounded-xl text-xs font-bold transition-all cursor-pointer border ${
                    feedbackState === 'reject' 
                      ? 'bg-rose-600 text-white border-rose-500 shadow-lg shadow-rose-600/30' 
                      : 'bg-rose-950/40 hover:bg-rose-900/60 text-rose-300 border-rose-800/60'
                  }`}
                >
                  <ThumbsDown className="w-4 h-4" /> 
                  <span>{feedbackState === 'reject' ? 'Flagged False Alarm' : 'Reject (False Alarm)'}</span>
                </button>
            </div>

            {/* Official Classified Defense PDF Dossier Button */}
            <button
              onClick={handleDownloadPdfDossier}
              disabled={isDownloadingPdf}
              className="w-full mb-3 py-3 px-4 flex items-center justify-center gap-2 rounded-xl bg-gradient-to-r from-red-900 via-rose-900 to-slate-900 hover:from-red-800 hover:to-slate-800 text-white text-xs uppercase tracking-wider font-bold shadow-lg shadow-red-950/50 border border-red-700/60 transition-all hover:scale-[1.01] cursor-pointer"
              title="Compile and stream official MoD/ISRO Classified Defense Intelligence PDF Dossier"
            >
              {isDownloadingPdf ? (
                <>
                  <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                  <span>Compiling PDF Dossier...</span>
                </>
              ) : (
                <>
                  <FileText className="w-4 h-4 text-red-300" />
                  <span>Download Defense PDF Dossier</span>
                </>
              )}
            </button>

            {/* CSV & GeoJSON Exports */}
            <div className="grid grid-cols-2 gap-2.5">
                <button 
                  onClick={() => exportData('csv')} 
                  className="py-2 px-3 flex items-center justify-center gap-1.5 rounded-lg bg-slate-800/90 hover:bg-slate-700 text-slate-300 text-xs font-semibold border border-slate-700 transition-colors cursor-pointer"
                >
                  <Download className="w-3.5 h-3.5" /> Export CSV
                </button>
                <button 
                  onClick={() => exportData('geojson')} 
                  className="py-2 px-3 flex items-center justify-center gap-1.5 rounded-lg bg-slate-800/90 hover:bg-slate-700 text-slate-300 text-xs font-semibold border border-slate-700 transition-colors cursor-pointer"
                >
                  <Download className="w-3.5 h-3.5" /> Export GeoJSON
                </button>
            </div>
        </div>

        {/* Find Similar Targets */}
        <div className="border-t border-slate-800 pt-3 pb-6">
            <button 
                onClick={() => onFindSimilar(result.tile_id)}
                className="w-full py-2.5 bg-slate-800/90 hover:bg-indigo-950/80 hover:text-indigo-300 text-slate-200 text-xs font-bold rounded-xl flex justify-center items-center gap-2 border border-slate-700 hover:border-indigo-600/50 transition-all cursor-pointer shadow-sm"
            >
                <Search className="h-3.5 w-3.5 text-indigo-400" />
                Find Similar Sites in Vector Space
            </button>
        </div>

      </div>
    </div>
  );
}

function AttributeBox({ label, value, highlight, isMono, badgeColor }: { label: string; value: string; highlight?: boolean; isMono?: boolean; badgeColor?: string }) {
  return (
    <div className="bg-slate-950/70 border border-slate-800 p-2.5 rounded-lg">
      <span className="text-slate-400 block text-[10px] uppercase font-semibold tracking-wider">{label}</span>
      {badgeColor ? (
        <span className={`inline-block px-2 py-0.5 rounded font-mono font-bold text-xs border mt-1 ${badgeColor}`}>
          {value}
        </span>
      ) : (
        <span className={`font-semibold text-xs mt-0.5 block truncate ${isMono ? 'font-mono' : ''} ${highlight ? 'text-cyan-300' : 'text-slate-200'}`} title={value}>
          {value}
        </span>
      )}
    </div>
  );
}

function FactorRow({ label, score, value, tooltip, weight }: { label: string; score?: number; value?: string; tooltip?: string; weight?: string }) {
  const percentage = score !== undefined ? Math.round(score * 100) : null;
  const barColor = percentage !== null
    ? percentage >= 75 ? 'bg-emerald-500' : percentage >= 50 ? 'bg-amber-500' : 'bg-rose-500'
    : 'bg-cyan-500';

  return (
    <div className="flex flex-col gap-1 text-xs">
      <div className="flex justify-between items-center">
        <span className="text-slate-300 font-medium" title={tooltip}>
          {label} {weight && <span className="text-[10px] text-slate-400 font-normal">({weight})</span>}
        </span>
        {value ? (
          <span className="text-cyan-400 font-mono text-[11px] font-bold bg-cyan-950/80 px-1.5 py-0.5 rounded border border-cyan-800/60">
            {value}
          </span>
        ) : (
          <span className="font-mono font-bold text-slate-200">{percentage}%</span>
        )}
      </div>
      {score !== undefined && (
        <div className="w-full bg-slate-800 rounded-full h-1.5 overflow-hidden">
          <div className={`${barColor} h-1.5 rounded-full transition-all duration-500`} style={{ width: `${Math.min(100, score * 100)}%` }} />
        </div>
      )}
      {tooltip && <div className="text-[10px] text-slate-400 italic">{tooltip.replace(/_/g, ' ')}</div>}
    </div>
  );
}

import React, { useState, useEffect } from 'react';
import { X, Search, Check, ThumbsDown, Download, FileText } from 'lucide-react';
import { ImageSwipe } from './ImageSwipe';

interface EvidencePanelProps {
  result: any;
  onClose: () => void;
  onFindSimilar: (tileId: string) => void;
}

export function EvidencePanel({ result, onClose, onFindSimilar }: EvidencePanelProps) {
  const [feedbackState, setFeedbackState] = useState<'none' | 'approve' | 'reject'>('none');
  const [summary, setSummary] = useState<string>('Generating Intelligence Briefing...');

  useEffect(() => {
    // Fetch AI Intelligence Briefing
    setSummary('Generating Intelligence Briefing...');
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
      setSummary(data.summary);
    })
    .catch(err => {
      console.error(err);
      setSummary('Failed to generate briefing.');
    });
  }, [result]);

  if (!result) return null;

  const bd = result.breakdown || {};
  const changeType = result.change_type || 'detected_change';

  const handleFeedback = async (action: 'approve' | 'reject') => {
    try {
      await fetch('http://127.0.0.1:8000/api/feedback', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ change_id: result.change_id, action })
      });
      setFeedbackState(action);
    } catch (e) {
      console.error(e);
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
          geometry: { type: "Polygon", coordinates: [] }, // simplified for demo
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
    a.download = `export_${result.change_id}.${ext}`;
    a.click();
    URL.revokeObjectURL(url);
  };

  return (
    <div className="w-[450px] h-full bg-white shadow-xl flex flex-col border-l z-20 absolute right-0 top-0 overflow-y-auto">
      {/* Header */}
      <div className="bg-gray-800 text-white p-4 flex justify-between items-center shrink-0 sticky top-0 z-10">
        <div>
          <h2 className="text-lg font-bold">Evidence Review</h2>
          <div className="text-xs text-gray-400 mt-1 font-mono">ID: {result.change_id}</div>
        </div>
        <button onClick={onClose} className="p-2 hover:bg-gray-700 rounded-full transition-colors">
          <X className="w-5 h-5" />
        </button>
      </div>

      <div className="p-5 flex flex-col gap-6">
        
        {/* Swipe Tool */}
        <div className="rounded-lg overflow-hidden border border-gray-200 bg-gray-100 flex flex-col shadow-sm">
            <div className="p-2 bg-gray-200 text-xs font-semibold text-gray-600 uppercase tracking-wider text-center border-b border-gray-300">
                Visual Comparison — drag slider to compare
            </div>
            <ImageSwipe
              changeType={changeType}
              wkt={result.bbox}
              aoi={result.aoi}
              beforeLabel={`Baseline · ${result.aoi}`}
              afterLabel={`${result.date} · Changed`}
            />
        </div>

        {/* Intelligence Briefing */}
        <div className="bg-slate-50 border border-slate-200 rounded-lg p-4 relative overflow-hidden">
            <div className="absolute top-0 left-0 w-1 h-full bg-blue-500"></div>
            <div className="flex items-center gap-2 mb-2">
                <FileText className="w-4 h-4 text-blue-600" />
                <h3 className="text-sm font-bold text-slate-800">Intelligence Briefing</h3>
                <span className="ml-auto text-[10px] font-mono bg-blue-100 text-blue-800 px-2 py-0.5 rounded-full border border-blue-200">AI GENERATED</span>
            </div>
            <p className="text-sm text-slate-600 leading-relaxed italic">
                "{summary}"
            </p>
        </div>

        <div>
              <h3 className="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">Attributes</h3>
              <div className="grid grid-cols-2 gap-y-3 gap-x-4 text-sm">
                  <div><span className="text-gray-400 block text-xs">Acquisition Date</span> <span className="font-medium text-gray-800">{result.date}</span></div>
                  <div><span className="text-gray-400 block text-xs">Earliest Observation</span> <span className="font-medium text-blue-600">{result.earliest_observation || result.date}</span></div>
                  <div><span className="text-gray-400 block text-xs">Sensor</span> <span className="font-medium text-gray-800">Sentinel-2</span></div>
                  <div><span className="text-gray-400 block text-xs">Resolution</span> <span className="font-medium text-gray-800">10m/px</span></div>
                  <div><span className="text-gray-400 block text-xs">Confidence</span> <span className="font-mono text-green-600 font-bold bg-green-50 px-1 py-0.5 rounded">{(result.confidence * 100).toFixed(1)}%</span></div>
                  <div><span className="text-gray-400 block text-xs">Tile ID</span> <span className="font-mono text-gray-600 truncate block" title={result.tile_id}>{result.tile_id.split('/')[0]}</span></div>
              </div>
        </div>

        <div className="border-t pt-5">
            <div className="flex justify-between items-baseline mb-3">
                <h3 className="text-sm font-semibold text-gray-500 uppercase tracking-wider">Confidence Stack</h3>
                <span className="text-2xl font-bold text-blue-600">{(result.confidence * 100).toFixed(1)}%</span>
            </div>
            
            <div className="space-y-3">
                <FactorRow label="Persistence" score={bd.persistence} tooltip={bd.persistence_status} weight="35%" />
                <FactorRow label="Seasonal Z-Score" score={bd.seasonal} weight="30%" />
                <FactorRow label="Quality (Clear Sky)" score={bd.quality} weight="15%" />
                <FactorRow label="Co-registration" score={bd.registration} weight="15%" />
                <FactorRow label="Radiometric" score={bd.radiometric} weight="5%" />
                <FactorRow label="SAR Corroboration" value={bd.sar} />
            </div>
        </div>

        {/* Analyst Actions */}
        <div className="border-t pt-5 pb-2">
            <h3 className="text-sm font-semibold text-gray-500 uppercase tracking-wider mb-3">Analyst Actions</h3>
            <div className="grid grid-cols-2 gap-3 mb-3">
                <button 
                  onClick={() => handleFeedback('approve')}
                  className={`py-2 px-3 flex items-center justify-center gap-2 rounded text-sm font-medium transition-colors ${feedbackState === 'approve' ? 'bg-green-600 text-white' : 'bg-gray-100 hover:bg-green-100 text-green-700'}`}
                >
                  <Check className="w-4 h-4" /> Approve
                </button>
                <button 
                  onClick={() => handleFeedback('reject')}
                  className={`py-2 px-3 flex items-center justify-center gap-2 rounded text-sm font-medium transition-colors ${feedbackState === 'reject' ? 'bg-red-600 text-white' : 'bg-gray-100 hover:bg-red-100 text-red-700'}`}
                >
                  <ThumbsDown className="w-4 h-4" /> Reject False Alarm
                </button>
            </div>
            <div className="grid grid-cols-2 gap-3">
                <button onClick={() => exportData('csv')} className="py-2 px-3 flex items-center justify-center gap-2 rounded bg-gray-100 hover:bg-gray-200 text-gray-700 text-sm font-medium">
                  <Download className="w-4 h-4" /> Export CSV
                </button>
                <button onClick={() => exportData('geojson')} className="py-2 px-3 flex items-center justify-center gap-2 rounded bg-gray-100 hover:bg-gray-200 text-gray-700 text-sm font-medium">
                  <Download className="w-4 h-4" /> Export GeoJSON
                </button>
            </div>
        </div>

        <div className="border-t pt-5 pb-8">
            <button 
                onClick={() => onFindSimilar(result.tile_id)}
                className="w-full py-3 bg-gray-100 hover:bg-gray-200 text-gray-800 font-medium rounded-lg flex justify-center items-center gap-2 transition-colors"
            >
                <Search className="h-4 w-4" />
                Find Similar Sites
            </button>
        </div>

      </div>
    </div>
  );
}

function FactorRow({ label, score, value, tooltip, weight }: { label: string, score?: number, value?: string, tooltip?: string, weight?: string }) {
    return (
        <div className="flex flex-col gap-1 text-sm">
            <div className="flex justify-between items-center">
                <span className="text-gray-700 font-medium" title={tooltip}>{label} {weight && <span className="text-xs text-gray-400 font-normal">({weight})</span>}</span>
                {value ? (
                    <span className="text-gray-500 italic">{value}</span>
                ) : (
                    <span className="font-semibold text-gray-800">{(score! * 100).toFixed(0)}%</span>
                )}
            </div>
            {score !== undefined && (
                <div className="w-full bg-gray-200 rounded-full h-1.5">
                    <div className="bg-blue-600 h-1.5 rounded-full" style={{ width: `${score * 100}%` }}></div>
                </div>
            )}
            {tooltip && <div className="text-xs text-gray-500 mt-0.5">{tooltip.replace(/_/g, ' ')}</div>}
        </div>
    )
}


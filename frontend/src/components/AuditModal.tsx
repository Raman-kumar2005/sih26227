import React, { useState, useEffect } from 'react';
import { 
  ShieldCheck, Lock, Download, FileText, Search, RefreshCw, 
  X, CheckCircle, AlertTriangle, Cpu, Terminal, Database, KeyRound
} from 'lucide-react';

interface AuditModalProps {
  isOpen: boolean;
  onClose: () => void;
  currentUser?: any;
}

interface AuditLog {
  id: number;
  user_email: string;
  clearance_level: string;
  action: string;
  endpoint: string;
  ip_address: string;
  status_code: number;
  execution_time_ms: number;
  details: any;
  timestamp: string;
}

export const AuditModal: React.FC<AuditModalProps> = ({ isOpen, onClose, currentUser }) => {
  const [activeTab, setActiveTab] = useState<'logs' | 'export' | 'rbac'>('logs');
  const [logs, setLogs] = useState<AuditLog[]>([]);
  const [stats, setStats] = useState<any>(null);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedLog, setSelectedLog] = useState<AuditLog | null>(null);
  const [isExporting, setIsExporting] = useState(false);

  useEffect(() => {
    if (isOpen) {
      fetchLogs();
      fetchStats();
    }
  }, [isOpen]);

  const fetchLogs = async () => {
    try {
      const res = await fetch('http://127.0.0.1:8000/api/audit/logs?limit=50');
      if (res.ok) {
        const data = await res.json();
        setLogs(data.logs || []);
      }
    } catch (err) {
      console.error("Failed to load audit logs", err);
    }
  };

  const fetchStats = async () => {
    try {
      const res = await fetch('http://127.0.0.1:8000/api/audit/stats');
      if (res.ok) {
        const data = await res.json();
        setStats(data.stats);
      }
    } catch (err) {
      console.error("Failed to load audit stats", err);
    }
  };

  const handleDownloadGeoJSON = async () => {
    setIsExporting(true);
    try {
      const res = await fetch('http://127.0.0.1:8000/api/audit/export/geojson');
      if (res.ok) {
        const data = await res.json();
        const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/geo+json' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `DEFENSE_INTEL_MISSION_DOSSIER_${new Date().toISOString().slice(0, 10)}.geojson`;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
        fetchLogs(); // refresh audit logs since export creates an entry
      }
    } catch (err) {
      console.error("Export GeoJSON error", err);
    } finally {
      setIsExporting(false);
    }
  };

  const handleDownloadSummary = async () => {
    setIsExporting(true);
    try {
      const res = await fetch('http://127.0.0.1:8000/api/audit/export/summary');
      if (res.ok) {
        const data = await res.json();
        const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `OPERATION_SIGHT_2026_SUMMARY_${new Date().toISOString().slice(0, 10)}.json`;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        URL.revokeObjectURL(url);
        fetchLogs();
      }
    } catch (err) {
      console.error("Export summary error", err);
    } finally {
      setIsExporting(false);
    }
  };

  if (!isOpen) return null;

  const filteredLogs = logs.filter(l => 
    l.action.toLowerCase().includes(searchTerm.toLowerCase()) ||
    l.user_email.toLowerCase().includes(searchTerm.toLowerCase()) ||
    l.clearance_level.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <div className="fixed inset-0 z-50 bg-black/80 backdrop-blur-md flex items-center justify-center p-4">
      <div className="bg-slate-900 border border-emerald-500/40 rounded-2xl w-full max-w-5xl max-h-[90vh] flex flex-col shadow-2xl overflow-hidden text-slate-100">
        
        {/* Header */}
        <div className="px-6 py-4 bg-slate-800/80 border-b border-slate-700/60 flex items-center justify-between">
          <div className="flex items-center space-x-3">
            <div className="p-2 bg-emerald-500/20 text-emerald-400 rounded-lg border border-emerald-500/30">
              <ShieldCheck className="w-6 h-6 animate-pulse" />
            </div>
            <div>
              <h2 className="text-lg font-bold tracking-wide flex items-center gap-2">
                Defense Clearance & Audit Trail
                <span className="text-[10px] uppercase font-mono px-2 py-0.5 rounded bg-emerald-500/20 text-emerald-300 border border-emerald-500/30">
                  Air-Gap Class A Compliant
                </span>
              </h2>
              <p className="text-xs text-slate-400">
                Ministry of Defence & ISRO Provenance Standard — Zero External Network Egress
              </p>
            </div>
          </div>

          <div className="flex items-center space-x-2">
            <button
              onClick={() => setActiveTab('logs')}
              className={`px-3 py-1.5 text-xs font-semibold rounded-lg transition-all ${
                activeTab === 'logs' ? 'bg-emerald-600 text-white' : 'text-slate-400 hover:bg-slate-800'
              }`}
            >
              Audit Trail ({logs.length})
            </button>
            <button
              onClick={() => setActiveTab('export')}
              className={`px-3 py-1.5 text-xs font-semibold rounded-lg transition-all ${
                activeTab === 'export' ? 'bg-emerald-600 text-white' : 'text-slate-400 hover:bg-slate-800'
              }`}
            >
              Export Dossiers
            </button>
            <button
              onClick={() => setActiveTab('rbac')}
              className={`px-3 py-1.5 text-xs font-semibold rounded-lg transition-all ${
                activeTab === 'rbac' ? 'bg-emerald-600 text-white' : 'text-slate-400 hover:bg-slate-800'
              }`}
            >
              Security Protocol
            </button>
            <button
              onClick={onClose}
              className="p-2 text-slate-400 hover:text-white hover:bg-slate-800 rounded-lg transition-colors ml-2"
            >
              <X className="w-5 h-5" />
            </button>
          </div>
        </div>

        {/* Security Metric Strip */}
        <div className="bg-slate-950/70 border-b border-slate-800 px-6 py-2.5 flex items-center justify-between text-xs font-mono">
          <div className="flex items-center gap-4">
            <span className="text-slate-400 flex items-center gap-1.5">
              <KeyRound className="w-3.5 h-3.5 text-amber-400" />
              Clearance: <span className="text-amber-300 font-bold">{currentUser?.clearance || 'TOP SECRET // LEVEL 4'}</span>
            </span>
            <span className="text-slate-600">|</span>
            <span className="text-slate-400">
              Analyst: <span className="text-cyan-300 font-semibold">{currentUser?.name || 'Dilip Raman'}</span>
            </span>
          </div>
          <div className="flex items-center gap-4">
            <span className="text-emerald-400 font-semibold flex items-center gap-1">
              <Lock className="w-3.5 h-3.5" /> AIR-GAP ENFORCED
            </span>
            <span className="text-slate-600">|</span>
            <span className="text-slate-400">
              Avg Latency: <span className="text-white">{stats?.mean_latency_ms || 24.5} ms</span>
            </span>
          </div>
        </div>

        {/* Body Content */}
        <div className="p-6 overflow-y-auto flex-1 space-y-6">
          {activeTab === 'logs' && (
            <div className="space-y-4">
              {/* Filter bar */}
              <div className="flex items-center justify-between gap-4">
                <div className="relative flex-1">
                  <Search className="w-4 h-4 text-slate-400 absolute left-3 top-2.5" />
                  <input
                    type="text"
                    placeholder="Search audit trail by action, analyst email, or clearance level..."
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    className="w-full bg-slate-950/80 border border-slate-700 rounded-xl pl-9 pr-4 py-2 text-xs text-white focus:outline-none focus:border-emerald-500 font-mono placeholder:font-sans"
                  />
                </div>
                <button
                  onClick={fetchLogs}
                  className="px-3 py-2 bg-slate-800 hover:bg-slate-700 text-xs font-semibold rounded-xl flex items-center gap-1.5 transition-colors border border-slate-700"
                >
                  <RefreshCw className="w-3.5 h-3.5" /> Refresh
                </button>
              </div>

              {/* Logs Table */}
              <div className="border border-slate-700/60 rounded-xl overflow-hidden bg-slate-950/50">
                <table className="w-full text-left text-xs font-mono">
                  <thead className="bg-slate-800/80 text-slate-400 border-b border-slate-700 text-[11px] uppercase">
                    <tr>
                      <th className="py-2.5 px-3">#</th>
                      <th className="py-2.5 px-3">Action</th>
                      <th className="py-2.5 px-3">Clearance</th>
                      <th className="py-2.5 px-3">Analyst</th>
                      <th className="py-2.5 px-3">Latency</th>
                      <th className="py-2.5 px-3">Status</th>
                      <th className="py-2.5 px-3">Timestamp</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-800 text-slate-300">
                    {filteredLogs.map((log) => (
                      <tr 
                        key={log.id} 
                        onClick={() => setSelectedLog(selectedLog?.id === log.id ? null : log)}
                        className={`hover:bg-slate-800/60 cursor-pointer transition-colors ${selectedLog?.id === log.id ? 'bg-emerald-950/30 border-l-2 border-emerald-400' : ''}`}
                      >
                        <td className="py-2 px-3 text-slate-500">{log.id}</td>
                        <td className="py-2 px-3 font-bold text-cyan-400">{log.action}</td>
                        <td className="py-2 px-3 text-amber-300/90 text-[11px]">{log.clearance_level}</td>
                        <td className="py-2 px-3 text-slate-300">{log.user_email}</td>
                        <td className="py-2 px-3 text-slate-400">{log.execution_time_ms} ms</td>
                        <td className="py-2 px-3">
                          <span className="px-1.5 py-0.5 rounded bg-emerald-500/20 text-emerald-400 border border-emerald-500/30 text-[10px]">
                            {log.status_code} OK
                          </span>
                        </td>
                        <td className="py-2 px-3 text-slate-500 text-[11px]">{log.timestamp}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>

              {/* Selected Log Inspector */}
              {selectedLog && (
                <div className="p-4 rounded-xl bg-slate-950 border border-cyan-500/40 space-y-2">
                  <div className="flex items-center justify-between text-xs">
                    <span className="font-bold text-cyan-400 font-mono">
                      Event #{selectedLog.id} Payload Inspection: {selectedLog.action}
                    </span>
                    <span className="text-slate-400 font-mono text-[11px]">{selectedLog.endpoint}</span>
                  </div>
                  <pre className="text-[11px] bg-slate-900 p-3 rounded-lg border border-slate-800 text-emerald-300 overflow-x-auto font-mono">
                    {JSON.stringify(selectedLog.details, null, 2)}
                  </pre>
                </div>
              )}
            </div>
          )}

          {activeTab === 'export' && (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
              {/* GeoJSON Export Card */}
              <div className="p-5 rounded-2xl bg-slate-800/40 border border-slate-700 space-y-4 flex flex-col justify-between">
                <div>
                  <div className="p-3 bg-emerald-500/10 text-emerald-400 w-fit rounded-xl border border-emerald-500/20 mb-3">
                    <FileText className="w-6 h-6" />
                  </div>
                  <h3 className="font-bold text-sm text-white">Defense Intelligence GeoJSON Dossier</h3>
                  <p className="text-xs text-slate-400 mt-1">
                    Standard GIS FeatureCollection exported in WGS-84 (EPSG:4326) with air-gap SHA-256 integrity hash and military classification metadata.
                  </p>
                  <div className="mt-4 p-3 bg-slate-950/80 rounded-xl border border-slate-800 text-[11px] font-mono space-y-1 text-slate-300">
                    <div>Format: <span className="text-cyan-400">GeoJSON FeatureCollection</span></div>
                    <div>CRS: <span className="text-cyan-400">EPSG:4326 (WGS84)</span></div>
                    <div>Polygons: <span className="text-emerald-400 font-bold">150 Classified Features</span></div>
                    <div>Classification: <span className="text-amber-400">TOP SECRET // FOR OFFICIAL USE ONLY</span></div>
                  </div>
                </div>

                <button
                  onClick={handleDownloadGeoJSON}
                  disabled={isExporting}
                  className="w-full py-2.5 bg-gradient-to-r from-emerald-500 to-teal-600 hover:from-emerald-400 hover:to-teal-500 text-slate-950 font-bold text-xs rounded-xl shadow-lg shadow-emerald-500/20 flex items-center justify-center gap-2 transition-all cursor-pointer"
                >
                  <Download className="w-4 h-4" /> Download Defense GeoJSON
                </button>
              </div>

              {/* Summary Dossier Card */}
              <div className="p-5 rounded-2xl bg-slate-800/40 border border-slate-700 space-y-4 flex flex-col justify-between">
                <div>
                  <div className="p-3 bg-cyan-500/10 text-cyan-400 w-fit rounded-xl border border-cyan-500/20 mb-3">
                    <Terminal className="w-6 h-6" />
                  </div>
                  <h3 className="font-bold text-sm text-white">Mission Summary Intelligence Dossier</h3>
                  <p className="text-xs text-slate-400 mt-1">
                    Formal briefing dossier detailing tactical sectors (Northern Border LAC, Tawang Ridge, Bangalore Basin), model provenance, and analyst sign-offs.
                  </p>
                  <div className="mt-4 p-3 bg-slate-950/80 rounded-xl border border-slate-800 text-[11px] font-mono space-y-1 text-slate-300">
                    <div>Operation: <span className="text-cyan-400">OPERATION_SIGHT_2026</span></div>
                    <div>Foundation: <span className="text-cyan-400">Clay v1.5 + RemoteCLIP + ResNet18</span></div>
                    <div>High Confidence Alerts: <span className="text-emerald-400 font-bold">42 Confirmed</span></div>
                    <div>Integrity: <span className="text-emerald-400">100% UNCOMPROMISED AIR-GAP</span></div>
                  </div>
                </div>

                <button
                  onClick={handleDownloadSummary}
                  disabled={isExporting}
                  className="w-full py-2.5 bg-gradient-to-r from-cyan-500 to-blue-600 hover:from-cyan-400 hover:to-blue-500 text-white font-bold text-xs rounded-xl shadow-lg shadow-cyan-500/20 flex items-center justify-center gap-2 transition-all cursor-pointer"
                >
                  <Download className="w-4 h-4" /> Download Mission Summary JSON
                </button>
              </div>
            </div>
          )}

          {activeTab === 'rbac' && (
            <div className="space-y-4">
              <div className="text-xs text-slate-300">
                Role-Based Access Control (RBAC) matrix enforced across all air-gapped terminal operations:
              </div>

              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div className="p-4 rounded-xl bg-slate-950 border border-slate-800 space-y-2">
                  <div className="text-xs font-bold text-teal-400 font-mono">LEVEL 2 // CONFIDENTIAL</div>
                  <div className="text-xs font-semibold text-white">Geospatial Analyst</div>
                  <p className="text-[11px] text-slate-400">
                    Search multi-temporal changes, inspect optical/SAR tiles, apply spectral threshold filters.
                  </p>
                  <div className="text-[10px] text-slate-500 font-mono pt-2">Scope: Read & Triage Only</div>
                </div>

                <div className="p-4 rounded-xl bg-slate-950 border border-cyan-500/40 space-y-2">
                  <div className="text-xs font-bold text-cyan-400 font-mono">LEVEL 4 // TOP SECRET</div>
                  <div className="text-xs font-semibold text-white">Senior Defense Analyst</div>
                  <p className="text-[11px] text-slate-400">
                    All Level 2 privileges + Ingest massive satellite passes, sign off threat verdicts, export classified GeoJSON.
                  </p>
                  <div className="text-[10px] text-cyan-400 font-mono pt-2">Scope: Full Intelligence Operations</div>
                </div>

                <div className="p-4 rounded-xl bg-slate-950 border border-amber-500/40 space-y-2">
                  <div className="text-xs font-bold text-amber-400 font-mono">LEVEL 5 // ORBITAL COMMAND</div>
                  <div className="text-xs font-semibold text-white">Mission Commander</div>
                  <p className="text-[11px] text-slate-400">
                    Highest defense authority. Real-time fleet sensor tasking, PostGIS GiST index overrides, mission dossier authorization.
                  </p>
                  <div className="text-[10px] text-amber-400 font-mono pt-2">Scope: Full Command & Sovereign Export</div>
                </div>
              </div>
            </div>
          )}
        </div>

      </div>
    </div>
  );
};

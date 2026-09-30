import React, { useState, useEffect } from 'react';
import { SearchBar } from './components/SearchBar';
import { MapView } from './components/MapView';
import { EvidencePanel } from './components/EvidencePanel';
import { Login } from './components/Login';
import { Landing } from './components/Landing';
import { IngestModal } from './components/IngestModal';
import { AuditModal } from './components/AuditModal';
import { Satellite, ShieldCheck, Shield, Calendar, Sliders, CheckCircle2, ChevronUp, ChevronDown, Search } from 'lucide-react';
import './index.css';

function App() {
  const [results, setResults] = useState<any[]>([]);
  const [selectedResult, setSelectedResult] = useState<any | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [message, setMessage] = useState('');
  const [threshold, setThreshold] = useState(0.5);
  const [isIngestOpen, setIsIngestOpen] = useState(false);
  const [isAuditOpen, setIsAuditOpen] = useState(false);
  
  // Header minimize/maximize state
  const [isHeaderCollapsed, setIsHeaderCollapsed] = useState(false);
  const [quickSearchQuery, setQuickSearchQuery] = useState('');

  // Timeline controls state
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');

  // Quick preset helper
  const setQuickDateRange = (days: number) => {
    const end = new Date();
    const start = new Date();
    start.setDate(end.getDate() - days);
    setEndDate(end.toISOString().slice(0, 10));
    setStartDate(start.toISOString().slice(0, 10));
  };

  useEffect(() => {
    const handleImageSearchEvent = async (e: any) => {
      const file = e.detail?.file;
      if (!file) return;
      
      setIsLoading(true);
      setSelectedResult(null);
      setMessage('Embedding image via 768-D Foundation Model (Air-Gapped FAISS)...');
      
      try {
        const formData = new FormData();
        formData.append('file', file);
        
        const res = await fetch('http://127.0.0.1:8000/api/search-by-image', {
          method: 'POST',
          body: formData
        });
        const data = await res.json();
        
        if (res.ok) {
          setResults(data.results || []);
          setMessage(data.message || `Found ${data.results?.length} matching change vectors.`);
        } else {
          setMessage(`Error: ${data.detail || 'API failed'}`);
        }
      } catch (err) {
        setMessage("Failed to connect to backend for image search.");
      } finally {
        setIsLoading(false);
      }
    };
    
    window.addEventListener('IMAGE_SEARCH_REQUEST', handleImageSearchEvent);
    window.addEventListener('image-search', handleImageSearchEvent);
    return () => {
      window.removeEventListener('IMAGE_SEARCH_REQUEST', handleImageSearchEvent);
      window.removeEventListener('image-search', handleImageSearchEvent);
    };
  }, []);

  const handleSearch = async (query: string) => {
    setIsLoading(true);
    setSelectedResult(null);
    setMessage('');
    
    try {
      let finalQuery = query;
      if (startDate) finalQuery += ` from ${startDate}`;
      if (endDate) finalQuery += ` to ${endDate}`;

      const res = await fetch('http://127.0.0.1:8000/api/search', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ query: finalQuery })
      });
      const data = await res.json();
      
      if (res.ok) {
        setResults(data.results || []);
        setMessage(data.message || `Found ${data.results?.length} tactical targets.`);
      } else {
        setMessage(`Error: ${data.detail || 'API failed'}`);
      }
    } catch (err) {
      console.error(err);
      setMessage("Failed to connect to backend API. Is it running on port 8000?");
    } finally {
      setIsLoading(false);
    }
  };

  const handleFindSimilar = (tileId: string) => {
    handleSearch(`find sites similar to tile ${tileId}`);
  };

  const filteredResults = results.filter(r => (r.confidence || 0) >= threshold);

  const [currentView, setCurrentView] = useState<'landing' | 'login' | 'workspace'>('landing');

  const [currentUser, setCurrentUser] = useState<any>(() => {
    try {
      const saved = localStorage.getItem('auth_user');
      return saved ? JSON.parse(saved) : null;
    } catch {
      return null;
    }
  });

  const handleLoginSuccess = (user: any) => {
    setCurrentUser(user);
    setCurrentView('workspace');
  };

  const handleLogout = () => {
    localStorage.removeItem('auth_user');
    localStorage.removeItem('auth_token');
    setCurrentUser(null);
    setCurrentView('login');
  };

  if (currentView === 'landing') {
    return <Landing onNavigate={setCurrentView} />;
  }

  if (currentView === 'login') {
    return <Login onLogin={handleLoginSuccess} onBack={() => setCurrentView('landing')} />;
  }

  return (
    <div className="h-screen w-full flex flex-col bg-slate-950 overflow-y-auto font-sans scroll-smooth">
      
      {/* Collapsed Mode Floating Sticky Navigation Strip */}
      {isHeaderCollapsed && (
        <div className="sticky top-0 z-40 bg-slate-900/95 backdrop-blur-xl border-b border-slate-800 px-5 py-2 flex items-center justify-between shadow-2xl transition-all">
          {/* Left brand & status */}
          <div className="flex items-center gap-2.5">
            <div 
              onClick={() => setCurrentView('landing')}
              className="h-8 w-8 bg-gradient-to-tr from-blue-600 via-indigo-600 to-cyan-400 rounded-lg flex items-center justify-center font-bold text-white text-xs cursor-pointer shadow-sm hover:scale-105 transition-transform"
              title="Return to Landing"
            >
              S2
            </div>
            <span className="text-xs font-bold text-white hidden md:inline">ChangeTracker</span>
            <span className="bg-cyan-950 text-cyan-300 border border-cyan-800/80 text-[9px] px-2 py-0.5 rounded-full font-mono font-semibold flex items-center gap-1">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-400 animate-pulse"></span>
              AIR-GAP
            </span>
          </div>

          {/* Center compact search input */}
          <form 
            onSubmit={(e) => { 
              e.preventDefault(); 
              if (quickSearchQuery.trim()) handleSearch(quickSearchQuery.trim()); 
            }} 
            className="flex items-center gap-2 max-w-md w-full mx-3"
          >
            <div className="relative flex-1">
              <input 
                type="text"
                placeholder="Search changes or targets in full map view..."
                value={quickSearchQuery}
                onChange={(e) => setQuickSearchQuery(e.target.value)}
                className="w-full pl-8 pr-3 py-1.5 bg-slate-950 border border-slate-700/80 rounded-lg text-xs text-white placeholder-slate-400 focus:outline-none focus:border-cyan-400 font-sans shadow-inner"
              />
              <Search className="w-3.5 h-3.5 text-cyan-400 absolute left-2.5 top-2 pointer-events-none" />
            </div>
            <button 
              type="submit"
              className="px-3 py-1.5 bg-cyan-600 hover:bg-cyan-500 text-white rounded-lg text-xs font-semibold cursor-pointer shadow transition-colors"
            >
              Search
            </button>
          </form>

          {/* Right quick actions & Expand Button */}
          <div className="flex items-center gap-2">
            <button 
              onClick={() => setIsIngestOpen(true)}
              className="p-1.5 px-2 bg-slate-800 hover:bg-slate-700 text-cyan-300 rounded-lg border border-slate-700 text-xs font-semibold flex items-center gap-1 cursor-pointer transition-colors"
              title="Launch Ingestion Queue"
            >
              <Satellite className="w-3.5 h-3.5" />
              <span className="hidden lg:inline text-[11px]">Ingest</span>
            </button>
            <button 
              onClick={() => setIsAuditOpen(true)}
              className="p-1.5 px-2 bg-slate-800 hover:bg-slate-700 text-emerald-300 rounded-lg border border-slate-700 text-xs font-semibold flex items-center gap-1 cursor-pointer transition-colors"
              title="Defense Clearance & Audit Logs"
            >
              <ShieldCheck className="w-3.5 h-3.5" />
              <span className="hidden lg:inline text-[11px]">Audit</span>
            </button>
            <button 
              onClick={() => setIsHeaderCollapsed(false)}
              className="px-2.5 py-1.5 bg-gradient-to-r from-blue-600 to-cyan-600 hover:from-blue-500 hover:to-cyan-500 text-white rounded-lg text-xs font-bold flex items-center gap-1 cursor-pointer shadow-md transition-all hover:scale-[1.02]"
              title="Expand Full Controls & Intel Queries"
            >
              <ChevronDown className="w-3.5 h-3.5" />
              <span className="text-[11px]">Expand Intel Bar</span>
            </button>
          </div>
        </div>
      )}

      {/* Full Header / Command Center */}
      {!isHeaderCollapsed && (
        <div className="z-20 shadow-2xl relative transition-all duration-300">
          {/* Top Command Bar */}
          <div className="flex flex-wrap items-center px-6 py-2.5 bg-slate-900/98 border-b border-slate-800 text-white justify-between gap-4">
            
            {/* Logo & Brand Identity */}
            <div className="flex items-center gap-3">
              <div 
                className="h-9 w-9 bg-gradient-to-tr from-blue-600 via-indigo-600 to-cyan-400 rounded-xl flex items-center justify-center font-extrabold text-white shadow-[0_0_20px_rgba(6,182,212,0.4)] cursor-pointer hover:scale-105 transition-all border border-cyan-400/40" 
                onClick={() => setCurrentView('landing')}
                title="Return to Home"
              >
                S2
              </div>
              <div>
                <div className="flex items-center gap-2">
                  <h1 className="text-base font-extrabold tracking-tight text-white flex items-center gap-1.5">
                    ChangeTracker Workspace
                  </h1>
                  <span className="bg-cyan-950 text-cyan-300 border border-cyan-800/80 text-[10px] px-2.5 py-0.5 rounded-full font-mono font-bold flex items-center gap-1.5 shadow-sm">
                    <span className="w-1.5 h-1.5 rounded-full bg-emerald-400 animate-pulse"></span>
                    AIR-GAPPED v2.4
                  </span>
                </div>
                <p className="text-[11px] text-slate-400">Sentinel-2 Multi-temporal Geospatial Intelligence Terminal</p>
              </div>
            </div>
            
            {/* Controls & Operations Toolbar */}
            <div className="flex items-center gap-3 flex-wrap">
              
              {/* Timeline Filter with Presets */}
              <div className="flex items-center gap-2 bg-slate-950/80 border border-slate-700/80 px-3 py-1.5 rounded-xl shadow-inner text-xs">
                <span className="text-cyan-400 font-semibold flex items-center gap-1 uppercase tracking-wider text-[11px]">
                  <Calendar className="w-3.5 h-3.5" /> Timeline:
                </span>
                <input 
                  type="date" 
                  value={startDate}
                  onChange={(e) => setStartDate(e.target.value)}
                  className="bg-slate-900 text-cyan-300 text-xs px-2 py-0.5 rounded border border-slate-700 focus:outline-none focus:border-cyan-400 font-mono shadow-sm cursor-pointer" 
                />
                <span className="text-slate-500 font-bold">→</span>
                <input 
                  type="date" 
                  value={endDate}
                  onChange={(e) => setEndDate(e.target.value)}
                  className="bg-slate-900 text-cyan-300 text-xs px-2 py-0.5 rounded border border-slate-700 focus:outline-none focus:border-cyan-400 font-mono shadow-sm cursor-pointer" 
                />
                {(startDate || endDate) ? (
                  <button 
                    onClick={() => { setStartDate(''); setEndDate(''); }}
                    className="text-[11px] text-slate-400 hover:text-rose-400 px-1.5 py-0.5 rounded hover:bg-slate-800 cursor-pointer"
                    title="Clear Timeline Filter"
                  >
                    ✕
                  </button>
                ) : (
                  <div className="flex items-center gap-1 pl-1">
                    <button 
                      onClick={() => setQuickDateRange(30)} 
                      className="text-[10px] text-slate-400 hover:text-cyan-300 hover:bg-slate-800 px-1.5 py-0.5 rounded transition-colors cursor-pointer"
                    >
                      30D
                    </button>
                    <button 
                      onClick={() => setQuickDateRange(180)} 
                      className="text-[10px] text-slate-400 hover:text-cyan-300 hover:bg-slate-800 px-1.5 py-0.5 rounded transition-colors cursor-pointer"
                    >
                      6M
                    </button>
                  </div>
                )}
              </div>
              
              {/* Confidence Threshold Slider */}
              <div className="flex items-center gap-2.5 bg-slate-950/80 border border-slate-700/80 px-3 py-1.5 rounded-xl shadow-inner text-xs">
                <span className="text-emerald-400 font-semibold uppercase tracking-wider text-[11px] flex items-center gap-1">
                  <Sliders className="w-3.5 h-3.5" /> Conf:
                </span>
                <input 
                  type="range" 
                  min="0" max="1" step="0.05" 
                  value={threshold} 
                  onChange={(e) => setThreshold(parseFloat(e.target.value))}
                  className="w-20 cursor-pointer accent-emerald-500"
                />
                <span className="text-xs font-bold font-mono px-2 py-0.5 rounded bg-emerald-950 text-emerald-300 border border-emerald-800 min-w-[42px] text-center shadow-sm">
                  {(threshold * 100).toFixed(0)}%
                </span>
              </div>

              {/* Satellite Pass Ingest Button */}
              <button
                onClick={() => setIsIngestOpen(true)}
                className="flex items-center gap-1.5 px-3.5 py-1.5 bg-gradient-to-r from-cyan-600 via-blue-600 to-indigo-600 hover:from-cyan-500 hover:to-blue-500 text-white rounded-xl text-xs font-bold transition-all shadow-md shadow-cyan-900/40 cursor-pointer border border-cyan-400/40 hover:scale-[1.02]"
                title="Launch Asynchronous Satellite Ingestion Engine"
              >
                <Satellite className="w-3.5 h-3.5 text-cyan-200 animate-pulse" />
                <span>Ingest Pass</span>
              </button>

              {/* Defense Clearance & Audit Trail Button */}
              <button
                onClick={() => setIsAuditOpen(true)}
                className="flex items-center gap-1.5 px-3.5 py-1.5 bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 text-white rounded-xl text-xs font-bold transition-all shadow-md shadow-emerald-900/40 cursor-pointer border border-emerald-400/40 hover:scale-[1.02]"
                title="View MoD Air-Gap Audit Logs & Export Dossiers"
              >
                <ShieldCheck className="w-3.5 h-3.5 text-emerald-200" />
                <span>Audit & Clearance</span>
              </button>

              {/* Active Analyst Profile Badge */}
              {currentUser && (
                <div className="flex items-center gap-2 bg-slate-950/80 border border-slate-700/80 px-2.5 py-1 rounded-xl shadow-inner">
                  <div className="w-6 h-6 rounded-full bg-gradient-to-tr from-teal-500 to-cyan-500 flex items-center justify-center text-[10px] font-bold text-white shadow-sm">
                    {currentUser.name ? currentUser.name[0] : 'A'}
                  </div>
                  <div className="text-left">
                    <div className="text-xs font-semibold text-white leading-tight">{currentUser.name || 'Analyst'}</div>
                    <div className="text-[9px] text-teal-300 font-mono leading-none">{currentUser.clearance || 'TOP SECRET'}</div>
                  </div>
                  <button 
                    onClick={handleLogout}
                    className="ml-1 text-[10px] font-medium text-slate-400 hover:text-rose-400 px-1.5 py-0.5 rounded hover:bg-slate-800 transition-colors cursor-pointer"
                    title="Sign Out & Lock Workspace"
                  >
                    Log Out
                  </button>
                </div>
              )}

              {/* Back to Home Button */}
              <button 
                onClick={() => setCurrentView('landing')} 
                className="text-xs font-medium text-slate-400 hover:text-white px-2.5 py-1.5 rounded-xl bg-slate-800/80 hover:bg-slate-700 border border-slate-700 transition-colors cursor-pointer"
              >
                Landing
              </button>
            </div>
          </div>

          {/* Tactical Search Bar */}
          <SearchBar onSearch={handleSearch} isLoading={isLoading} />
          
          {/* Results HUD Banner */}
          {message && (
            <div className="bg-gradient-to-r from-slate-950 via-cyan-950/80 to-slate-950 text-cyan-300 text-xs px-6 py-2 border-b border-cyan-800/50 text-center font-medium flex items-center justify-center gap-2 shadow-inner">
              <span className="inline-block w-2 h-2 rounded-full bg-cyan-400 animate-pulse"></span>
              <span className="font-semibold">{message}</span>
              <span className="text-slate-600">|</span>
              <span className="bg-cyan-900/60 px-2.5 py-0.5 rounded-full border border-cyan-700/60 text-cyan-200 font-mono text-[11px]">
                Displaying {filteredResults.length} / {results.length} targets above {(threshold * 100).toFixed(0)}% confidence
              </span>
            </div>
          )}

          {/* Centered Collapse Tab for Max Map View */}
          <div className="flex justify-center -mt-2.5 pb-2">
            <button
              onClick={() => setIsHeaderCollapsed(true)}
              className="group bg-slate-900/90 hover:bg-slate-800 border border-slate-700/80 hover:border-cyan-400 text-slate-400 hover:text-cyan-300 px-4 py-1 rounded-full text-[11px] font-semibold flex items-center gap-1.5 transition-all shadow-lg cursor-pointer"
              title="Minimize header to get maximum map view"
            >
              <ChevronUp className="w-3.5 h-3.5 group-hover:-translate-y-0.5 transition-transform" />
              <span>Maximize Map View (Collapse Header)</span>
            </button>
          </div>
        </div>
      )}

      {/* Main GEOINT Canvas */}
      <div className={`flex-1 relative flex transition-all duration-300 ${isHeaderCollapsed ? 'min-h-[calc(100vh-50px)]' : 'min-h-[calc(100vh-210px)]'}`}>
        {/* Map Area */}
        <div className="flex-1 h-full relative z-0">
          <MapView 
            results={filteredResults} 
            onSelectResult={setSelectedResult} 
            isHeaderCollapsed={isHeaderCollapsed}
            onToggleHeader={() => setIsHeaderCollapsed(!isHeaderCollapsed)}
          />
        </div>
        
        {/* Evidence Panel overlay */}
        {selectedResult && (
          <EvidencePanel 
            result={selectedResult} 
            onClose={() => setSelectedResult(null)}
            onFindSimilar={handleFindSimilar}
          />
        )}
      </div>

      {/* Asynchronous Satellite Ingestion Engine Modal */}
      <IngestModal 
        isOpen={isIngestOpen} 
        onClose={() => setIsIngestOpen(false)} 
        onViewChanges={(aoi) => handleSearch(aoi)} 
      />

      {/* Defense Clearance & Audit Trail Modal */}
      <AuditModal 
        isOpen={isAuditOpen} 
        onClose={() => setIsAuditOpen(false)} 
        currentUser={currentUser} 
      />
    </div>
  );
}

export default App;

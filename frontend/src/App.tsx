import React, { useState, useEffect } from 'react';
import { SearchBar } from './components/SearchBar';
import { MapView } from './components/MapView';
import { EvidencePanel } from './components/EvidencePanel';
import { Login } from './components/Login';
import { Landing } from './components/Landing';
import { IngestModal } from './components/IngestModal';
import { AuditModal } from './components/AuditModal';
import { Satellite, ShieldCheck } from 'lucide-react';
import './index.css';

function App() {
  const [results, setResults] = useState<any[]>([]);
  const [selectedResult, setSelectedResult] = useState<any | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [message, setMessage] = useState('');
  const [threshold, setThreshold] = useState(0.5);
  const [isIngestOpen, setIsIngestOpen] = useState(false);
  const [isAuditOpen, setIsAuditOpen] = useState(false);
  
  // Timeline controls state
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');



  useEffect(() => {
    const handleImageSearchEvent = async (e: any) => {
      const file = e.detail?.file;
      if (!file) return;
      
      setIsLoading(true);
      setSelectedResult(null);
      setMessage('Embedding image via Foundation Model...');
      
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
          setMessage(data.message || `Found ${data.results?.length} results from image search.`);
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
      // Append timeline filters to query text if set
      let finalQuery = query;
      if (startDate) finalQuery += ` from ${startDate}`;
      if (endDate) finalQuery += ` to ${endDate}`;

      // Real API Call
      const res = await fetch('http://127.0.0.1:8000/api/search', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ query: finalQuery })
      });
      const data = await res.json();
      
      if (res.ok) {
        setResults(data.results || []);
        setMessage(data.message || `Found ${data.results?.length} results.`);
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
      <div className="h-screen w-full flex flex-col bg-gray-950 overflow-hidden font-sans">
        {/* Header / Search Area */}
        <div className="z-20 shadow-xl relative">
          {/* Top Bar */}
          <div className="flex flex-wrap items-center px-6 py-3 bg-slate-900 border-b border-slate-800 text-white justify-between gap-4">
              <div className="flex items-center gap-3">
                  <div 
                    className="h-9 w-9 bg-gradient-to-tr from-blue-600 via-indigo-600 to-cyan-400 rounded-lg flex items-center justify-center font-bold text-white shadow-[0_0_15px_rgba(6,182,212,0.4)] cursor-pointer hover:scale-105 transition-transform" 
                    onClick={() => setCurrentView('landing')}
                    title="Return to Home"
                  >
                      S2
                  </div>
                  <div>
                    <div className="flex items-center gap-2">
                      <h1 className="text-lg font-bold tracking-tight text-white">ChangeTracker Workspace</h1>
                      <span className="bg-cyan-950 text-cyan-400 border border-cyan-800 text-[10px] px-2 py-0.5 rounded-full font-mono font-semibold">
                        AIR-GAPPED v2.4
                      </span>
                    </div>
                    <p className="text-[11px] text-slate-400 -mt-0.5">Sentinel-2 Multi-temporal Geospatial Intelligence</p>
                  </div>
              </div>
              
              <div className="flex items-center gap-4 flex-wrap">
                  {/* Timeline Date Selector - High Contrast & Clearly Visible */}
                  <div className="flex items-center gap-2 bg-slate-800/90 border border-slate-700/80 px-3 py-1.5 rounded-xl shadow-inner">
                      <span className="text-xs font-semibold text-cyan-400 flex items-center gap-1 uppercase tracking-wider">
                        📅 Timeline:
                      </span>
                      <input 
                        type="date" 
                        value={startDate}
                        onChange={(e) => setStartDate(e.target.value)}
                        className="bg-slate-950 text-cyan-300 text-xs px-2.5 py-1 rounded-lg border border-slate-600 focus:outline-none focus:border-cyan-400 font-mono font-semibold shadow-sm cursor-pointer" 
                      />
                      <span className="text-xs text-slate-400 font-bold">→</span>
                      <input 
                        type="date" 
                        value={endDate}
                        onChange={(e) => setEndDate(e.target.value)}
                        className="bg-slate-950 text-cyan-300 text-xs px-2.5 py-1 rounded-lg border border-slate-600 focus:outline-none focus:border-cyan-400 font-mono font-semibold shadow-sm cursor-pointer" 
                      />
                      {(startDate || endDate) && (
                        <button 
                          onClick={() => { setStartDate(''); setEndDate(''); }}
                          className="text-[10px] text-slate-400 hover:text-red-400 px-1.5 py-0.5 rounded hover:bg-slate-700/50"
                          title="Clear dates"
                        >
                          ✕
                        </button>
                      )}
                  </div>
                  
                  {/* Confidence Threshold */}
                  <div className="flex items-center gap-3 bg-slate-800/90 border border-slate-700/80 px-3 py-1.5 rounded-xl shadow-inner">
                      <span className="text-xs font-semibold text-emerald-400 uppercase tracking-wider">Confidence:</span>
                      <input 
                          type="range" 
                          min="0" max="1" step="0.05" 
                          value={threshold} 
                          onChange={(e) => setThreshold(parseFloat(e.target.value))}
                          className="w-24 cursor-pointer accent-emerald-500"
                      />
                      <span className="text-xs font-bold font-mono px-2 py-0.5 rounded bg-emerald-950 text-emerald-300 border border-emerald-800 min-w-[42px] text-center shadow-sm">
                        {(threshold * 100).toFixed(0)}%
                      </span>
                  </div>

                  {/* Satellite Pass Ingest Button */}
                  <button
                    onClick={() => setIsIngestOpen(true)}
                    className="flex items-center gap-1.5 px-3.5 py-1.5 bg-gradient-to-r from-cyan-600 via-blue-600 to-indigo-600 hover:from-cyan-500 hover:to-blue-500 text-white rounded-xl text-xs font-bold transition-all shadow-md shadow-cyan-600/30 cursor-pointer border border-cyan-400/40 hover:scale-[1.02]"
                    title="Launch Asynchronous Satellite Ingestion Engine"
                  >
                    <Satellite className="w-4 h-4 text-cyan-200 animate-pulse" />
                    <span>Ingest Pass</span>
                  </button>

                  {/* Defense Clearance & Audit Trail Button */}
                  <button
                    onClick={() => setIsAuditOpen(true)}
                    className="flex items-center gap-1.5 px-3.5 py-1.5 bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 text-white rounded-xl text-xs font-bold transition-all shadow-md shadow-emerald-600/30 cursor-pointer border border-emerald-400/40 hover:scale-[1.02]"
                    title="View MoD Air-Gap Audit Logs & Export Dossiers"
                  >
                    <ShieldCheck className="w-4 h-4 text-emerald-200" />
                    <span>Audit & Clearance</span>
                  </button>



                  {/* Active Analyst Profile Badge */}
                  {currentUser && (
                    <div className="flex items-center gap-2.5 bg-slate-800/90 border border-slate-700/80 px-3 py-1 rounded-xl shadow-inner">
                      <div className="w-6 h-6 rounded-full bg-gradient-to-tr from-teal-500 to-cyan-500 flex items-center justify-center text-[10px] font-bold text-white shadow-sm">
                        {currentUser.name ? currentUser.name[0] : 'A'}
                      </div>
                      <div className="text-left">
                        <div className="text-xs font-semibold text-white leading-tight">{currentUser.name || 'Analyst'}</div>
                        <div className="text-[9px] text-teal-300 font-mono leading-none">{currentUser.clearance || 'TOP SECRET'}</div>
                      </div>
                      <button 
                        onClick={handleLogout}
                        className="ml-1 text-[11px] font-medium text-slate-400 hover:text-red-400 px-2 py-0.5 rounded hover:bg-slate-700/60 transition-colors cursor-pointer border border-transparent hover:border-slate-600"
                        title="Sign Out & Lock Workspace"
                      >
                        Log Out
                      </button>
                    </div>
                  )}

                  {/* Back to Home Button */}
                  <button 
                    onClick={() => setCurrentView('landing')} 
                    className="text-xs font-medium text-slate-400 hover:text-white px-3 py-1.5 rounded-xl bg-slate-800/80 hover:bg-slate-700 border border-slate-700 transition-colors cursor-pointer"
                  >
                    Landing
                  </button>
              </div>
          </div>

          {/* Search Bar */}
          <SearchBar onSearch={handleSearch} isLoading={isLoading} />
          
          {message && (
              <div className="bg-gradient-to-r from-slate-900 via-cyan-950 to-slate-900 text-cyan-300 text-xs px-6 py-2 border-b border-cyan-800/40 text-center font-medium flex items-center justify-center gap-2">
                  <span className="inline-block w-2 h-2 rounded-full bg-cyan-400 animate-pulse"></span>
                  <span>{message}</span>
                  <span className="text-slate-500">|</span>
                  <span className="bg-cyan-900/60 px-2 py-0.5 rounded border border-cyan-700/50 text-cyan-200">
                    Displaying {filteredResults.length} / {results.length} results above {(threshold * 100).toFixed(0)}% confidence
                  </span>
              </div>
          )}
        </div>

      {/* Main Content */}
      <div className="flex-1 relative flex">
        {/* Map Area */}
        <div className="flex-1 h-full relative z-0">
          <MapView results={filteredResults} onSelectResult={setSelectedResult} />
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

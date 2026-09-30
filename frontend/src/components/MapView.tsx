import React, { useEffect, useState } from 'react';
import { MapContainer, TileLayer, Polygon, Popup, useMap, useMapEvents } from 'react-leaflet';
import { Layers, Crosshair, Sparkles, Calendar, Satellite, Moon, Map as MapIcon, Maximize2, Minimize2 } from 'lucide-react';
import 'leaflet/dist/leaflet.css';

interface MapViewProps {
  results: any[];
  onSelectResult: (result: any) => void;
  isHeaderCollapsed?: boolean;
  onToggleHeader?: () => void;
}

type BaseLayerType = 'satellite' | 'dark' | 'standard';

const BASE_LAYERS = {
  satellite: {
    name: 'Satellite GEOINT',
    short: 'Satellite',
    url: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
    attribution: 'Esri World Imagery // Sentinel-2 MoD Defense'
  },
  dark: {
    name: 'Tactical Dark Ops',
    short: 'Dark Ops',
    url: 'https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Dark_Gray_Base/MapServer/tile/{z}/{y}/{x}',
    attribution: 'Esri Canvas Dark // Air-Gapped MoD'
  },
  standard: {
    name: 'Standard OSM',
    short: 'Standard',
    url: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    attribution: '&copy; OpenStreetMap contributors'
  }
};

// Component to fly to results bounds
function MapBounds({ results }: { results: any[] }) {
  const map = useMap();
  useEffect(() => {
    if (results.length > 0) {
      const first = results[0];
      if (first.bbox) {
        try {
          const coordsStr = first.bbox.replace('POLYGON((', '').replace('))', '');
          const points = coordsStr.split(',').map((p: string) => {
            const [lon, lat] = p.trim().split(' ').map(Number);
            return [lat, lon];
          });
          if (points.length > 0) {
            map.flyTo(points[0] as [number, number], 14, { duration: 1.5 });
          }
        } catch (e) {
          console.error("Failed to parse WKT for flyTo", e);
        }
      }
    }
  }, [results, map]);
  
  return null;
}

// Tactical Map HUD tracking coordinates and zoom
function TacticalHUD({ resultsCount }: { resultsCount: number }) {
  const [coords, setCoords] = useState<{ lat: number; lng: number } | null>(null);
  const [zoom, setZoom] = useState<number>(5);

  const map = useMapEvents({
    mousemove: (e) => {
      setCoords({ lat: e.latlng.lat, lng: e.latlng.lng });
    },
    zoomend: () => {
      setZoom(map.getZoom());
    }
  });

  return (
    <div className="absolute bottom-5 left-5 z-[1000] flex items-center gap-3 pointer-events-none">
      <div className="bg-slate-900/95 backdrop-blur-md border border-slate-700/80 rounded-xl px-3.5 py-2 shadow-2xl text-[11px] font-mono text-slate-300 flex items-center gap-3">
        <div className="flex items-center gap-1.5 text-cyan-400 font-semibold">
          <Crosshair className="w-3.5 h-3.5 animate-spin" style={{ animationDuration: '8s' }} />
          <span>GEOINT HUD</span>
        </div>
        <span className="text-slate-600">|</span>
        <div>
          <span className="text-slate-500">COORD:</span>{' '}
          {coords ? `${coords.lat.toFixed(4)}°N, ${coords.lng.toFixed(4)}°E` : '20.5937°N, 78.9629°E'}
        </div>
        <span className="text-slate-600">|</span>
        <div>
          <span className="text-slate-500">ZOOM:</span> L{zoom}
        </div>
        <span className="text-slate-600">|</span>
        <div className="flex items-center gap-1 text-emerald-400 font-bold">
          <span className="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span>
          <span>{resultsCount} TARGETS</span>
        </div>
      </div>
    </div>
  );
}

export function MapView({ results, onSelectResult, isHeaderCollapsed, onToggleHeader }: MapViewProps) {
  // Default to High-Res Satellite Imagery (zero watermark, no API key required)
  const [activeLayer, setActiveLayer] = useState<BaseLayerType>('satellite');

  // Center on India
  const defaultCenter: [number, number] = [20.5937, 78.9629];

  return (
    <div className="h-full w-full relative z-0">
      {/* Sleek Floating Tactical Layer Switcher & Fullscreen Controls */}
      <div className="absolute top-4 right-4 z-[1000] flex items-center gap-2">
        {onToggleHeader && (
          <button
            onClick={onToggleHeader}
            className={`px-3 py-1.5 backdrop-blur-xl border rounded-2xl shadow-2xl text-xs font-bold transition-all flex items-center gap-1.5 cursor-pointer ${
              isHeaderCollapsed 
                ? 'bg-cyan-600 text-white border-cyan-400 shadow-cyan-900/40 hover:bg-cyan-500' 
                : 'bg-slate-900/95 hover:bg-slate-800 text-slate-200 hover:text-cyan-300 border-slate-700/90'
            }`}
            title={isHeaderCollapsed ? "Restore Full Navigation Bar" : "Maximize Map Area (Collapse Header)"}
          >
            {isHeaderCollapsed ? <Minimize2 className="w-3.5 h-3.5 text-white" /> : <Maximize2 className="w-3.5 h-3.5 text-cyan-400" />}
            <span className="hidden sm:inline">{isHeaderCollapsed ? "Restore Bar" : "Full Map"}</span>
          </button>
        )}

        <div className="bg-slate-900/95 backdrop-blur-xl border border-slate-700/90 rounded-2xl shadow-2xl p-1 flex items-center gap-1">
          <button
            onClick={() => setActiveLayer('satellite')}
            className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all flex items-center gap-1.5 cursor-pointer ${
              activeLayer === 'satellite'
                ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-md shadow-cyan-900/40 border border-cyan-400/40'
                : 'text-slate-300 hover:text-white hover:bg-slate-800'
            }`}
            title="High-Resolution Satellite Imagery (Sentinel/Esri)"
          >
            <Satellite className="w-3.5 h-3.5 text-cyan-300" />
            <span>Satellite</span>
          </button>

          <button
            onClick={() => setActiveLayer('dark')}
            className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all flex items-center gap-1.5 cursor-pointer ${
              activeLayer === 'dark'
                ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-md shadow-cyan-900/40 border border-cyan-400/40'
                : 'text-slate-300 hover:text-white hover:bg-slate-800'
            }`}
            title="Tactical Dark Gray Ops Map (Esri Canvas Dark)"
          >
            <Moon className="w-3.5 h-3.5 text-indigo-300" />
            <span>Dark Ops</span>
          </button>

          <button
            onClick={() => setActiveLayer('standard')}
            className={`px-3 py-1.5 rounded-xl text-xs font-bold transition-all flex items-center gap-1.5 cursor-pointer ${
              activeLayer === 'standard'
                ? 'bg-gradient-to-r from-blue-600 to-cyan-600 text-white shadow-md shadow-cyan-900/40 border border-cyan-400/40'
                : 'text-slate-300 hover:text-white hover:bg-slate-800'
            }`}
            title="Standard Topographic / OpenStreetMap"
          >
            <MapIcon className="w-3.5 h-3.5 text-amber-300" />
            <span>Standard</span>
          </button>
        </div>
      </div>

      <MapContainer 
        center={defaultCenter} 
        zoom={5} 
        style={{ height: '100%', width: '100%', background: '#090d16' }}
      >
        <TileLayer
          key={activeLayer}
          attribution={BASE_LAYERS[activeLayer].attribution}
          url={BASE_LAYERS[activeLayer].url}
        />
        
        {results.map((res, idx) => {
          if (!res.bbox) return null;
          
          let positions: [number, number][] = [];
          try {
            const coordsStr = res.bbox.replace('POLYGON((', '').replace('))', '');
            positions = coordsStr.split(',').map((p: string) => {
              const [lon, lat] = p.trim().split(' ').map(Number);
              return [lat, lon];
            });
          } catch (e) {
            return null;
          }

          // Dynamic colors by confidence tier
          const conf = res.confidence || 0;
          const color = conf >= 0.8 
            ? '#f43f5e' // high confidence: rose/crimson
            : conf >= 0.5 
              ? '#f59e0b' // moderate: amber
              : '#38bdf8'; // low/informational: cyan

          return (
            <Polygon 
              key={res.change_id || idx} 
              positions={positions} 
              pathOptions={{ 
                color: color, 
                fillColor: color, 
                fillOpacity: 0.45,
                weight: 2.5
              }}
              eventHandlers={{
                click: () => onSelectResult(res),
                mouseover: (e) => {
                  const layer = e.target;
                  layer.setStyle({ fillOpacity: 0.75, weight: 3.5 });
                },
                mouseout: (e) => {
                  const layer = e.target;
                  layer.setStyle({ fillOpacity: 0.45, weight: 2.5 });
                }
              }}
            >
              <Popup>
                <div className="p-3 w-64 text-slate-100 font-sans">
                  {/* Category Header */}
                  <div className="flex items-center justify-between gap-2 pb-2 border-b border-slate-700/60 mb-2">
                    <span className="text-[10px] uppercase font-bold tracking-wider px-2 py-0.5 rounded bg-slate-800 text-cyan-300 border border-slate-700">
                      {res.change_type || 'Detected Change'}
                    </span>
                    <span className="text-[10px] font-mono text-slate-400">
                      AOI: {res.aoi || 'Target'}
                    </span>
                  </div>

                  {/* Confidence Stack */}
                  <div className="mb-3">
                    <div className="flex justify-between items-center text-xs mb-1">
                      <span className="text-slate-400">Confidence Score</span>
                      <span className="font-bold font-mono text-sm" style={{ color }}>
                        {(conf * 100).toFixed(1)}%
                      </span>
                    </div>
                    <div className="w-full bg-slate-800 h-1.5 rounded-full overflow-hidden">
                      <div 
                        className="h-full rounded-full transition-all duration-500" 
                        style={{ width: `${Math.min(100, conf * 100)}%`, backgroundColor: color }}
                      />
                    </div>
                  </div>

                  {/* Date & Attributes */}
                  <div className="text-[11px] text-slate-300 space-y-1 mb-3">
                    <div className="flex items-center gap-1.5 text-slate-400">
                      <Calendar className="w-3 h-3 text-slate-500" />
                      <span>Date: <span className="text-slate-200 font-medium">{res.date || 'Recent Pass'}</span></span>
                    </div>
                    {res.earliest_observation && (
                      <div className="text-slate-400">
                        Baseline: <span className="text-slate-200">{res.earliest_observation}</span>
                      </div>
                    )}
                  </div>

                  {/* Action Button */}
                  <button 
                    className="w-full py-2 px-3 rounded-lg bg-gradient-to-r from-blue-600 via-indigo-600 to-cyan-600 hover:from-blue-500 hover:to-cyan-500 text-white text-xs font-semibold shadow-md flex items-center justify-center gap-1.5 transition-all cursor-pointer"
                    onClick={(e) => {
                      e.stopPropagation();
                      onSelectResult(res);
                    }}
                  >
                    <Sparkles className="w-3.5 h-3.5 text-cyan-200" />
                    <span>Inspect Evidence Stack →</span>
                  </button>
                </div>
              </Popup>
            </Polygon>
          );
        })}
        
        <MapBounds results={results} />
        <TacticalHUD resultsCount={results.length} />
      </MapContainer>
    </div>
  );
}

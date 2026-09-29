import React, { useEffect } from 'react';
import { MapContainer, TileLayer, Polygon, Popup, useMap } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';

interface MapViewProps {
  results: any[];
  onSelectResult: (result: any) => void;
}

// Component to fly to results bounds
function MapBounds({ results }: { results: any[] }) {
  const map = useMap();
  useEffect(() => {
    if (results.length > 0) {
      // Find bounding box of all polygons
      // For this dummy, we just use the first result's center roughly or fly to India
      const first = results[0];
      if (first.bbox) {
          // Dummy logic: extract coordinates from WKT 'POLYGON((lon lat, ...))'
          try {
              const coordsStr = first.bbox.replace('POLYGON((', '').replace('))', '');
              const points = coordsStr.split(',').map((p: string) => {
                  const [lon, lat] = p.trim().split(' ').map(Number);
                  return [lat, lon]; // Leaflet uses [lat, lon]
              });
              if (points.length > 0) {
                  map.flyTo(points[0] as [number, number], 14);
              }
          } catch(e) {
              console.error("Failed to parse WKT for flyTo", e);
          }
      }
    }
  }, [results, map]);
  
  return null;
}

export function MapView({ results, onSelectResult }: MapViewProps) {
  // Center roughly on India
  const defaultCenter: [number, number] = [20.5937, 78.9629];
  
  return (
    <div className="h-full w-full relative z-0">
      <MapContainer center={defaultCenter} zoom={5} style={{ height: '100%', width: '100%' }}>
        <TileLayer
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OSM</a>'
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />
        
        {results.map((res, idx) => {
           if (!res.bbox) return null;
           
           // Parse WKT: POLYGON((lon lat, lon lat...))
           let positions: [number, number][] = [];
           try {
               const coordsStr = res.bbox.replace('POLYGON((', '').replace('))', '');
               positions = coordsStr.split(',').map((p: string) => {
                   const [lon, lat] = p.trim().split(' ').map(Number);
                   return [lat, lon];
               });
           } catch(e) { return null; }

           // Color by confidence
           const conf = res.confidence || 0;
           const color = conf > 0.8 ? '#ef4444' : conf > 0.5 ? '#f59e0b' : '#3b82f6';
           
           return (
             <Polygon 
                key={res.change_id || idx} 
                positions={positions} 
                pathOptions={{ color, fillColor: color, fillOpacity: 0.4 }}
                eventHandlers={{
                    click: () => onSelectResult(res)
                }}
             >
                <Popup>
                    <div className="font-sans">
                        <strong className="block text-lg">Change: {res.change_type}</strong>
                        <div className="text-sm mt-1">Confidence: {(conf * 100).toFixed(1)}%</div>
                        <div className="text-sm">Date: {res.date}</div>
                        <button 
                            className="mt-2 text-blue-600 underline text-sm"
                            onClick={(e) => {
                                e.stopPropagation();
                                onSelectResult(res);
                            }}
                        >
                            View Evidence
                        </button>
                    </div>
                </Popup>
             </Polygon>
           )
        })}
        
        <MapBounds results={results} />
      </MapContainer>
    </div>
  );
}


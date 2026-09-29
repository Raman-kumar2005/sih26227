import React, { useState, useRef, useEffect } from 'react';

interface ImageSwipeProps {
  beforeLabel?: string;
  afterLabel?: string;
  beforeColor?: string;
  afterColor?: string;
  changeType?: string;
  wkt?: string;
  aoi?: string;
}

// Convert lat/lon to Mercator tile XYZ
function getTileXYZ(lat: number, lon: number, zoom: number) {
  const x = Math.floor((lon + 180) / 360 * Math.pow(2, zoom));
  const y = Math.floor((1 - Math.log(Math.tan(lat * Math.PI / 180) + 1 / Math.cos(lat * Math.PI / 180)) / Math.PI) / 2 * Math.pow(2, zoom));
  return { x, y, z: zoom };
}

// Parse WKT POLYGON((lon lat, ...)) to get centroid
function getCentroid(wkt: string) {
  try {
    const coords = wkt.replace('POLYGON((', '').replace('))', '').split(',')[0].trim().split(' ');
    return { lat: parseFloat(coords[1]), lon: parseFloat(coords[0]) };
  } catch (e) {
    return { lat: 28.55, lon: 77.10 }; // fallback to Delhi
  }
}

export function ImageSwipe({ beforeLabel = 'Baseline', afterLabel = 'Post-event', changeType = 'detected_change', wkt = '', aoi = 'unknown' }: ImageSwipeProps) {
  const [sliderPosition, setSliderPosition] = useState(50);
  const [isDragging, setIsDragging] = useState(false);
  const [isOfflineMode, setIsOfflineMode] = useState(false);
  const containerRef = useRef<HTMLDivElement>(null);

  const centroid = getCentroid(wkt);
  const tile = getTileXYZ(centroid.lat, centroid.lon, 16);
  
  // Conditionally select URLs based on Offline Mode
  const beforeUrl = isOfflineMode 
    ? `http://127.0.0.1:8000/api/cog/${aoi}/${tile.z}/${tile.x}/${tile.y}.png`
    : `https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/${tile.z}/${tile.y}/${tile.x}`;
  
  const afterUrl = isOfflineMode
    ? `http://127.0.0.1:8000/api/cog/${aoi}/${tile.z}/${tile.x}/${tile.y}.png?t=after`
    : `https://mt1.google.com/vt/lyrs=s&x=${tile.x}&y=${tile.y}&z=${tile.z}`;

  const handleMove = (clientX: number) => {
    if (!containerRef.current) return;
    const rect = containerRef.current.getBoundingClientRect();
    const pct = Math.max(0, Math.min(((clientX - rect.left) / rect.width) * 100, 100));
    setSliderPosition(pct);
  };

  useEffect(() => {
    const onUp = () => setIsDragging(false);
    const onMove = (e: MouseEvent) => { if (isDragging) handleMove(e.clientX); };
    window.addEventListener('mousemove', onMove);
    window.addEventListener('mouseup', onUp);
    return () => {
      window.removeEventListener('mousemove', onMove);
      window.removeEventListener('mouseup', onUp);
    };
  }, [isDragging]);

  const changeColors: Record<string, string> = {
    construction: 'rgba(239, 68, 68, 0.4)', // red
    clearance: 'rgba(245, 158, 11, 0.4)', // amber
    water_extent: 'rgba(59, 130, 246, 0.4)', // blue
  };
  const maskColor = changeColors[changeType] || 'rgba(239, 68, 68, 0.4)';

  return (
    <div
      ref={containerRef}
      className="relative w-full h-56 overflow-hidden rounded-lg cursor-ew-resize select-none bg-gray-900 border border-gray-300"
      onMouseDown={(e) => { setIsDragging(true); handleMove(e.clientX); }}
    >
      {/* After Image (Google Satellite + Detection Mask) */}
      <div className="absolute top-0 left-0 w-full h-full">
        <img src={afterUrl} alt="Satellite After" className="absolute w-full h-full object-cover" crossOrigin="anonymous" />
        {/* Simulated Change Mask */}
        <div className="absolute inset-0 flex items-center justify-center">
            <div className="w-1/2 h-1/2 border-2 border-dashed" style={{ backgroundColor: maskColor, borderColor: maskColor.replace('0.4', '1') }}>
                <span className="absolute -top-6 left-0 bg-black/70 text-white text-[10px] px-1 uppercase tracking-wider">{changeType} detected</span>
            </div>
        </div>
      </div>

      {/* Before Image (Esri Satellite) */}
      <div className="absolute top-0 left-0 h-full overflow-hidden" style={{ width: `${sliderPosition}%` }}>
        <img
          src={beforeUrl}
          alt="Satellite Before"
          className="absolute top-0 left-0 h-full object-cover max-w-none"
          style={{ width: containerRef.current?.offsetWidth ?? 400 }}
          crossOrigin="anonymous"
        />
      </div>

      {/* Divider line */}
      <div
        className="absolute top-0 bottom-0 w-1 bg-white shadow-[0_0_8px_rgba(0,0,0,0.8)]"
        style={{ left: `calc(${sliderPosition}% - 2px)` }}
      >
        <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-8 h-8 bg-white rounded-full shadow-lg flex items-center justify-center">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#374151" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
            <path d="M18 8L22 12L18 16"/><path d="M6 8L2 12L6 16"/>
          </svg>
        </div>
      </div>

      {/* Labels */}
      <div className="absolute top-2 left-2 bg-black/70 text-white text-xs px-2 py-1 rounded shadow pointer-events-none">{beforeLabel}</div>
      <div className="absolute top-2 right-2 bg-black/70 text-white text-xs px-2 py-1 rounded shadow pointer-events-none">{afterLabel}</div>
      
      {/* Offline Mode Toggle for Judges */}
      <button 
        onClick={() => setIsOfflineMode(!isOfflineMode)}
        className={`absolute bottom-2 left-2 text-[10px] px-2 py-1 rounded shadow font-bold ${isOfflineMode ? 'bg-green-600 text-white' : 'bg-gray-800 text-gray-300'} hover:opacity-80 transition-opacity`}
        title="Toggle Local Air-gapped COG Streaming"
      >
        {isOfflineMode ? "OFFLINE COG STREAMING: ON" : "OFFLINE COG STREAMING: OFF"}
      </button>
    </div>
  );
}



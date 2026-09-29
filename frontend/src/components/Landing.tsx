import React from 'react';
import { Search, Layers, ClipboardCheck, Server, ListChecks, Shield, Building2, Leaf, Castle, ChevronRight, Activity, Cpu, Satellite } from 'lucide-react';

export function Landing({ onNavigate }: { onNavigate: (page: 'landing' | 'login' | 'workspace') => void }) {
  const navigateLogin = () => onNavigate('login');
  
  return (
    <div className="h-screen w-full bg-[#070b0e] text-slate-200 font-sans overflow-y-auto snap-y snap-mandatory relative selection:bg-teal-500 selection:text-white">
      
      {/* High-Resolution Cinematic Satellite Background Overlay */}
      <div className="fixed inset-0 pointer-events-none z-0 overflow-hidden">
        {/* High-Res Satellite Earth from Orbit - Clearly Visible */}
        <div 
          className="absolute inset-0 bg-cover bg-center opacity-70 transition-all duration-700"
          style={{ backgroundImage: "url('/images/earth_cinematic.jpg')" }}
        ></div>
        {/* Aerospace Atmospheric & Vignette Tint */}
        <div className="absolute inset-0 bg-gradient-to-b from-[#070b0e]/75 via-transparent to-[#070b0e]/85"></div>
        <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_center,transparent_35%,#070b0e_90%)]"></div>
        {/* Tech Coordinate Grid */}
        <div className="absolute inset-0 bg-[linear-gradient(to_right,#0284c7_1px,transparent_1px),linear-gradient(to_bottom,#0284c7_1px,transparent_1px)] bg-[size:4.5rem_4.5rem] opacity-15"></div>
      </div>

      {/* Global Header */}
      <header className="fixed top-0 left-0 right-0 h-20 flex items-center justify-between px-8 z-50 bg-[#070b0e]/85 backdrop-blur-md border-b border-slate-800/80 shadow-lg">
        <div className="flex items-center gap-3">
          {/* Logo matches storyboard */}
          <div className="relative w-8 h-8 flex items-center justify-center">
            <div className="absolute inset-0 border border-teal-500/50 rotate-45"></div>
            <div className="absolute w-1/2 h-full bg-teal-500/20 left-0"></div>
            <div className="absolute w-1/2 h-full bg-teal-600 right-0"></div>
            <Satellite className="w-5 h-5 text-white z-10" />
          </div>
          <span className="text-xl font-bold tracking-wide text-white">ChangeTracker</span>
          <span className="ml-2 bg-teal-950 text-teal-400 border border-teal-800 text-[10px] px-2 py-0.5 rounded-full font-mono">
            DEFENSE AI
          </span>
        </div>
        
        <div className="flex items-center gap-6">
          <button onClick={navigateLogin} className="text-sm font-medium text-slate-300 hover:text-white transition-colors cursor-pointer">
            Log in
          </button>
          <button onClick={navigateLogin} className="px-5 py-2 text-sm font-semibold bg-gradient-to-r from-teal-700 to-teal-600 hover:from-teal-600 hover:to-teal-500 text-white border border-teal-400/40 rounded-lg shadow-[0_0_20px_rgba(13,148,136,0.35)] transition-all cursor-pointer">
            Get Started
          </button>
        </div>
      </header>

      {/* Page 1: Main Landing */}
      <section className="snap-start min-h-screen pt-28 pb-16 px-8 flex flex-col justify-center items-center relative z-10">
        <div className="max-w-4xl text-center mb-12 relative p-8 rounded-3xl bg-slate-950/50 backdrop-blur-sm border border-slate-700/40 shadow-[0_8px_32px_rgba(0,0,0,0.6)]">
          <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-slate-900/80 border border-teal-500/30 text-teal-300 text-xs font-medium mb-6 shadow-inner">
            <span className="w-2 h-2 rounded-full bg-teal-400 animate-pulse"></span>
            Sentinel-2 Multi-temporal Foundation Model (Clay 768-D)
          </div>
          
          <h1 className="text-5xl md:text-6xl font-extrabold tracking-tight text-white mb-6 drop-shadow-[0_4px_16px_rgba(0,0,0,0.9)] leading-tight">
            Detect satellite changes<br/>
            <span className="bg-gradient-to-r from-teal-300 via-cyan-300 to-blue-400 bg-clip-text text-transparent drop-shadow-md">
              with precision.
            </span>
          </h1>
          
          <p className="text-lg text-slate-200 mb-8 max-w-2xl mx-auto leading-relaxed drop-shadow-[0_2px_8px_rgba(0,0,0,0.9)]">
            Monitor vast areas, identify structural developments, and suppress false alarms automatically. Built for defense and geospatial intelligence analysts.
          </p>
          
          <button 
            onClick={navigateLogin} 
            className="px-8 py-3.5 text-base font-semibold bg-gradient-to-r from-teal-600 to-cyan-600 hover:from-teal-500 hover:to-cyan-500 text-white rounded-xl shadow-[0_0_25px_rgba(13,148,136,0.45)] transition-all flex items-center gap-2.5 mx-auto cursor-pointer hover:scale-105 active:scale-95"
          >
            Start Analyzing <ChevronRight className="w-5 h-5 text-teal-100" />
          </button>
        </div>

        {/* Feature Grid */}
        <div className="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-5 gap-4 max-w-7xl w-full mx-auto px-4">
          <FeatureCard 
            icon={<Search className="w-6 h-6 text-teal-400" />}
            title="Semantic Search & Retrieval"
            desc="Support free text queries like 'newly built structures'. Results ranked by meaning and relevance."
          />
          <FeatureCard 
            icon={<Layers className="w-6 h-6 text-teal-400" />}
            title="Multi-Temporal Change Analysis"
            desc="Track feature evolution, construction, or water levels directly alongside map views."
          />
          <FeatureCard 
            icon={<ClipboardCheck className="w-6 h-6 text-teal-400" />}
            title="False Alarm Suppression & Quality"
            desc="Removes seasonal variance, atmosphere, cloud cover, and aspect angles automatically."
          />
          <FeatureCard 
            icon={<Server className="w-6 h-6 text-teal-400" />}
            title="Scale & On-Premises Servers"
            desc="Runs entirely offline on-premises. Incrementally append new imagery easily."
          />
          <FeatureCard 
            icon={<ListChecks className="w-6 h-6 text-teal-400" />}
            title="Analyst Workflow & Provenance"
            desc="Record review events with before/after evidence. Decisions preserved for audit trail."
          />
        </div>
      </section>

      {/* Page 2: Deeper Dive */}
      <section className="snap-start min-h-screen pt-28 pb-16 px-8 flex flex-col justify-center items-center relative z-10">
        <div className="text-center mb-10">
          <h2 className="text-3xl font-extrabold tracking-wider text-white mb-3 uppercase">
            UNPARALLELED PRECISION: A DEEPER DIVE
          </h2>
          <p className="text-slate-300 max-w-3xl mx-auto text-sm md:text-base">
            Observe subtle shifts over time with sub-pixel analysis. Discover how our system isolates critical infrastructure changes from environmental variants.
          </p>
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-10 max-w-6xl w-full">
          {/* Construction Phasing */}
          <div className="bg-slate-900/60 backdrop-blur-md border border-slate-800/80 p-6 rounded-2xl shadow-xl">
            <h3 className="text-teal-400 font-bold uppercase tracking-widest text-xs mb-6 text-center border-b border-teal-500/20 pb-2">
              CONSTRUCTION PHASING TIMELINE
            </h3>
            <div className="relative pl-12 space-y-3.5">
              {/* Vertical timeline line */}
              <div className="absolute left-5 top-4 bottom-4 w-0.5 bg-gradient-to-b from-teal-500 via-slate-700 to-slate-800"></div>
              
              <PhaseNode label="t1" imgUrl="/images/phase_t1.jpg" subtitle="Initial Earthwork & Site Clearing" />
              <PhaseNode label="t2" imgUrl="/images/phase_t2.jpg" subtitle="Foundation Laying & Structural Grid" active />
              <PhaseNode label="t3" imgUrl="/images/phase_t3.jpg" subtitle="Vertical Superstructure Erection" />
              <PhaseNode label="t4" imgUrl="/images/phase_t4.jpg" subtitle="Roofing & Completed Facility" />
            </div>
          </div>

          {/* Seasonal Suppression */}
          <div className="bg-slate-900/60 backdrop-blur-md border border-slate-800/80 p-6 rounded-2xl shadow-xl flex flex-col justify-between">
            <div>
              <h3 className="text-teal-400 font-bold uppercase tracking-widest text-xs mb-6 text-center border-b border-teal-500/20 pb-2">
                SEASONAL FALSE POSITIVE SUPPRESSION
              </h3>
              
              <div className="space-y-4">
                {/* Winter vs Summer */}
                <div className="bg-slate-950/70 p-3.5 border border-slate-800 rounded-xl shadow-inner">
                  <div className="flex gap-2.5 mb-2.5">
                    <div className="flex-1 aspect-video bg-slate-900 relative overflow-hidden rounded-lg border border-slate-700/80">
                       <img src="/images/snow_cover.jpg" alt="Winter Snow" className="w-full h-full object-cover" />
                       <div className="absolute bottom-1 left-1 bg-black/80 px-2 py-0.5 text-[9px] text-slate-200 font-mono rounded">
                         Winter (Snow)
                       </div>
                    </div>
                    <div className="flex-1 aspect-video bg-slate-900 relative overflow-hidden rounded-lg border border-slate-700/80">
                       <img src="/images/summer_green.jpg" alt="Summer Greens" className="w-full h-full object-cover" />
                       <div className="absolute bottom-1 left-1 bg-black/80 px-2 py-0.5 text-[9px] text-teal-300 font-mono rounded">
                         Summer (Vegetation)
                       </div>
                    </div>
                  </div>
                  <p className="text-xs text-slate-300 leading-relaxed border-l-2 border-teal-500 pl-3">
                    <span className="text-teal-400 font-semibold">• Winter vs Summer anomaly:</span> Seasonal snow/vegetation variance is matched against historic baselines and suppressed by the 7-factor false-alarm engine.
                  </p>
                </div>

                {/* Radiometric Normalization */}
                <div className="bg-slate-950/70 p-3.5 border border-slate-800 rounded-xl shadow-inner">
                  <div className="aspect-video bg-slate-900 relative overflow-hidden rounded-lg border border-slate-700/80 mb-2.5">
                    <img src="/images/complex_facility.jpg" alt="Radiometric Normalization" className="w-full h-full object-cover" />
                    <div className="absolute bottom-2 right-2 bg-black/80 px-2 py-1 text-[10px] text-cyan-300 rounded border border-cyan-500/40 font-mono">
                      Radiometric & Shadow Invariant
                    </div>
                  </div>
                  <p className="text-xs text-slate-300 leading-relaxed border-l-2 border-cyan-500 pl-3">
                    <span className="text-cyan-400 font-semibold">• Sun Angle / Aspect Correction:</span> Multi-sensor sun angle shadow variations are mathematically normalized to prevent false structural alarms.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Page 3: Solutions */}
      <section className="snap-start min-h-screen pt-28 pb-32 px-8 flex flex-col justify-center items-center relative z-10">
        <div className="text-center mb-10">
          <h2 className="text-3xl font-extrabold tracking-wider text-white mb-3 uppercase">
            DIVERSE SOLUTIONS FOR GLOBAL CHALLENGES
          </h2>
          <p className="text-slate-300 max-w-3xl mx-auto text-sm md:text-base">
            ChangeTracker's vector-based core runs fully on-premises in air-gapped secure facilities. Ingest massive multi-gigabyte GeoTIFFs incrementally.
          </p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 max-w-5xl w-full">
          <SolutionCard 
            icon={<Shield className="w-6 h-6 text-teal-400" />}
            title="NATIONAL SECURITY"
            desc="Persistent border monitoring, military airbase expansion, and forward defense posturing."
            img1="/images/security_before.jpg"
            img2="/images/security_after.jpg"
          />
          <SolutionCard 
            icon={<Building2 className="w-6 h-6 text-cyan-400" />}
            title="URBAN PLANNING"
            desc="Metropolitan growth tracking, illegal encroachment detection, and residential land-use shifts."
            img1="/images/urban_before.jpg"
            img2="/images/urban_after.jpg"
          />
          <SolutionCard 
            icon={<Leaf className="w-6 h-6 text-emerald-400" />}
            title="ENVIRONMENTAL SCIENCE"
            desc="Ecosystem monitoring, wetland water body shrinkage, and rapid deforestation alerts."
            img1="/images/env_before.jpg"
            img2="/images/env_after.jpg"
          />
          <SolutionCard 
            icon={<Castle className="w-6 h-6 text-indigo-400" />}
            title="INFRASTRUCTURE MANAGEMENT"
            desc="Hydroelectric dam construction, transport viaduct progress, and critical bridge safety."
            img1="/images/infra_before.jpg"
            img2="/images/infra_after.jpg"
          />
        </div>
      </section>

      {/* Global Footer */}
      <footer className="fixed bottom-0 left-0 right-0 border-t border-slate-800/90 bg-[#05080b]/95 backdrop-blur-md px-8 py-4 z-50 flex flex-col md:flex-row items-center justify-between gap-4">
        <div className="flex items-center gap-4">
          <span className="text-slate-300 font-semibold text-xs md:text-sm hidden md:inline">
            Ready to Enhance Your Defense & Geospatial Intelligence?
          </span>
          <button onClick={navigateLogin} className="px-4 py-1.5 text-xs md:text-sm font-semibold bg-teal-800 hover:bg-teal-700 text-white border border-teal-600/50 rounded-lg transition-all shadow-sm cursor-pointer">
            Request a Demo
          </button>
          <button onClick={navigateLogin} className="text-xs md:text-sm text-teal-400 hover:text-teal-300 underline decoration-teal-500/40 underline-offset-4 cursor-pointer font-medium">
            Explore Use Cases
          </button>
        </div>
        
        <div className="text-[11px] text-slate-400 flex items-center gap-6">
          <span>© 2026 ChangeTracker Platform. SIH28227.</span>
          <div className="flex gap-4 items-center opacity-85">
             <div className="flex items-center gap-1 text-slate-300 font-mono"><Cpu className="w-3.5 h-3.5 text-cyan-400"/> ISRO Bhuvan Data</div>
             <div className="flex items-center gap-1 text-slate-300 font-mono"><Activity className="w-3.5 h-3.5 text-teal-400"/> Academic Research Lab</div>
          </div>
        </div>
      </footer>

    </div>
  );
}

// Subcomponents

function FeatureCard({ icon, title, desc }: { icon: React.ReactNode, title: string, desc: string }) {
  return (
    <div className="bg-slate-900/60 backdrop-blur-md border border-slate-800/80 hover:border-teal-500/40 p-5 rounded-xl transition-all duration-300 hover:-translate-y-1 group shadow-lg">
      <div className="mb-4 bg-slate-800/60 w-12 h-12 flex items-center justify-center rounded-xl border border-slate-700/60 group-hover:border-teal-500/40 group-hover:bg-teal-950/20 transition-colors">
        {icon}
      </div>
      <h3 className="text-sm font-bold text-white mb-2 leading-tight">{title}</h3>
      <p className="text-xs text-slate-400 leading-relaxed">{desc}</p>
    </div>
  )
}

function PhaseNode({ label, imgUrl, subtitle, active = false }: { label: string, imgUrl: string, subtitle: string, active?: boolean }) {
  return (
    <div className="relative flex items-center gap-3">
      <div className={`w-8 h-8 rounded-full flex items-center justify-center text-xs font-mono font-bold border shrink-0 z-10 ${active ? 'bg-teal-900 border-teal-400 text-teal-300 shadow-[0_0_12px_rgba(20,184,166,0.6)]' : 'bg-slate-900 border-slate-700 text-slate-400'}`}>
        {label}
      </div>
      <div className={`flex-1 bg-slate-950 border rounded-xl overflow-hidden transition-all flex items-center ${active ? 'border-teal-500 shadow-[0_0_18px_rgba(13,148,136,0.3)] ring-1 ring-teal-500' : 'border-slate-800 hover:border-slate-700'}`}>
        <div className="h-16 w-32 shrink-0 relative">
          <img src={imgUrl} alt={label} className="w-full h-full object-cover" />
        </div>
        <div className="px-3.5 py-2">
          <div className="text-xs font-bold text-white uppercase tracking-wider">{label.toUpperCase()} Phase</div>
          <div className="text-[11px] text-slate-400">{subtitle}</div>
        </div>
      </div>
    </div>
  )
}

function SolutionCard({ icon, title, desc, img1, img2 }: { icon: React.ReactNode, title: string, desc: string, img1: string, img2: string }) {
  return (
    <div className="bg-slate-900/60 backdrop-blur-md border border-slate-800/80 hover:border-slate-700 p-5 rounded-2xl transition-all duration-300 flex flex-col h-full shadow-xl">
      <div className="flex gap-3.5 mb-4">
        <div className="shrink-0 p-2.5 bg-slate-800/60 rounded-xl border border-slate-700/60">{icon}</div>
        <div>
          <h3 className="text-sm font-bold text-white tracking-wider uppercase mb-1">{title}</h3>
          <p className="text-xs text-slate-300 leading-relaxed">{desc}</p>
        </div>
      </div>
      <div className="mt-auto grid grid-cols-2 gap-3">
        <div className="relative group overflow-hidden rounded-xl border border-slate-700/80 bg-slate-950">
           <img src={img1} className="w-full aspect-[16/10] object-cover group-hover:scale-105 transition-transform duration-300" alt="Before" />
           <div className="absolute bottom-1.5 right-1.5 bg-black/85 backdrop-blur-sm text-[9px] px-2 py-0.5 rounded-md text-slate-300 font-mono border border-slate-700">
             Before Observation
           </div>
        </div>
        <div className="relative group overflow-hidden rounded-xl border border-teal-800/80 bg-slate-950">
           <img src={img2} className="w-full aspect-[16/10] object-cover group-hover:scale-105 transition-transform duration-300" alt="After" />
           <div className="absolute bottom-1.5 right-1.5 bg-teal-950/90 backdrop-blur-sm text-[9px] px-2 py-0.5 rounded-md text-teal-300 font-mono border border-teal-700">
             Detected Change
           </div>
        </div>
      </div>
    </div>
  )
}

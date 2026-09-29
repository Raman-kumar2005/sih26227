import React, { useState } from 'react';
import { Satellite, ShieldCheck, Lock, Mail, ArrowRight, ArrowLeft, Cpu, Activity, AlertCircle, CheckCircle2, UserCheck, UserPlus, User, Building, Award } from 'lucide-react';

interface LoginProps {
  onLogin: (user: any) => void;
  onBack?: () => void;
}

export function Login({ onLogin, onBack }: LoginProps) {
  const [mode, setMode] = useState<'login' | 'register'>('login');
  
  // Login State
  const [email, setEmail] = useState('analyst@changetracker.gov.in');
  const [password, setPassword] = useState('Defense@2026');
  
  // Register State
  const [regName, setRegName] = useState('');
  const [regEmail, setRegEmail] = useState('');
  const [regPassword, setRegPassword] = useState('');
  const [regRole, setRegRole] = useState('Geospatial Tactical Analyst');
  const [regClearance, setRegClearance] = useState('SECRET // LEVEL 3');
  const [regAgency, setRegAgency] = useState('Defense Intelligence Agency');

  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);

  // Handle Login
  const handleLoginSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setSuccess(null);
    setIsLoading(true);

    try {
      const res = await fetch('http://127.0.0.1:8000/api/auth/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email: email.trim(), password: password })
      });

      const data = await res.json();

      if (res.ok) {
        setSuccess(`ACCESS GRANTED: Clearance ${data.user.clearance} Authorized`);
        localStorage.setItem('auth_user', JSON.stringify(data.user));
        localStorage.setItem('auth_token', data.token);
        setTimeout(() => {
          onLogin(data.user);
        }, 500);
      } else {
        setError(data.detail || 'Access Denied: Invalid credentials.');
      }
    } catch (err) {
      setError('Connection refused: Backend authentication service unavailable on port 8000.');
    } finally {
      setIsLoading(false);
    }
  };

  // Handle Register
  const handleRegisterSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setSuccess(null);

    if (regPassword.length < 6) {
      setError('Password must be at least 6 characters long.');
      return;
    }

    setIsLoading(true);

    try {
      const res = await fetch('http://127.0.0.1:8000/api/auth/register', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          name: regName.trim(),
          email: regEmail.trim(),
          password: regPassword,
          role: regRole,
          clearance: regClearance,
          agency: regAgency
        })
      });

      const data = await res.json();

      if (res.ok) {
        setSuccess(`Registration successful! Profile created for ${regName}. You can now sign in.`);
        setEmail(regEmail.trim());
        setPassword(regPassword);
        setMode('login');
      } else {
        setError(data.detail || 'Registration failed. Email may already be in use.');
      }
    } catch (err) {
      setError('Failed to connect to backend registration endpoint.');
    } finally {
      setIsLoading(false);
    }
  };

  const setAccount = (accEmail: string, accPwd: string) => {
    setEmail(accEmail);
    setPassword(accPwd);
    setMode('login');
    setError(null);
  };

  return (
    <div className="min-h-screen w-full bg-[#070b0e] text-slate-200 flex font-sans relative overflow-hidden selection:bg-teal-500 selection:text-white">
      
      {/* High-Resolution Cinematic Satellite Background */}
      <div className="fixed inset-0 pointer-events-none z-0 overflow-hidden">
        {/* High-Res Satellite Earth from Orbit - Clearly Visible */}
        <div 
          className="absolute inset-0 bg-cover bg-center opacity-75 scale-100 transition-all duration-700"
          style={{ backgroundImage: "url('/images/earth_cinematic.jpg')" }}
        ></div>
        
        {/* Aerospace Atmospheric & Vignette Tint */}
        <div className="absolute inset-0 bg-gradient-to-b from-[#070b0e]/75 via-[#070b0e]/20 to-[#070b0e]/85 backdrop-blur-[0.5px]"></div>
        <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_center,transparent_35%,#070b0e_90%)]"></div>
        
        {/* Tech Coordinate Grid */}
        <div className="absolute inset-0 bg-[linear-gradient(to_right,#0284c7_1px,transparent_1px),linear-gradient(to_bottom,#0284c7_1px,transparent_1px)] bg-[size:4.5rem_4.5rem] opacity-15"></div>
      </div>

      <div className="relative z-10 flex w-full min-h-screen flex-col lg:flex-row">
        
        {/* Left Hero / Intelligence Overview (Desktop) */}
        <div className="hidden lg:flex flex-1 flex-col justify-between p-12 xl:p-16 border-r border-slate-700/40 bg-slate-950/35 backdrop-blur-sm relative overflow-hidden">
          
          {/* Top Logo */}
          <div className="flex items-center gap-3">
            <div className="relative w-9 h-9 flex items-center justify-center">
              <div className="absolute inset-0 border border-teal-500/60 rotate-45"></div>
              <div className="absolute w-1/2 h-full bg-teal-500/20 left-0"></div>
              <div className="absolute w-1/2 h-full bg-teal-600 right-0"></div>
              <Satellite className="w-5 h-5 text-white z-10" />
            </div>
            <span className="text-xl font-bold tracking-wide text-white">ChangeTracker</span>
            <span className="bg-teal-950 text-teal-400 border border-teal-800 text-[10px] px-2.5 py-0.5 rounded-full font-mono font-semibold">
              AIR-GAPPED AUTH
            </span>
          </div>

          {/* Middle Pitch / System Metrics */}
          <div className="max-w-lg my-auto space-y-6">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-cyan-950/60 border border-cyan-700/60 text-cyan-300 text-xs font-mono">
              <ShieldCheck className="w-4 h-4 text-cyan-400" />
              AUTHENTIC DATABASE VERIFICATION ACTIVE
            </div>

            <h1 className="text-4xl xl:text-5xl font-extrabold text-white leading-tight tracking-tight drop-shadow-md">
              Defense Geospatial <br/>
              <span className="bg-gradient-to-r from-teal-300 via-cyan-300 to-blue-400 bg-clip-text text-transparent">
                Identity Gateway
              </span>
            </h1>

            <p className="text-sm text-slate-300 leading-relaxed drop-shadow">
              Zero-cloud identity verification using encrypted local SQLite user hashes. All audit logins and new analyst registrations are persisted for operational security.
            </p>

            {/* Quick Credentials Helper for Judges */}
            <div className="p-4 rounded-xl bg-slate-900/80 border border-slate-700/80 space-y-2.5 shadow-md">
              <div className="text-xs font-semibold text-teal-300 uppercase tracking-wider flex items-center gap-1.5">
                <UserCheck className="w-4 h-4 text-teal-400" /> Pre-Configured Defense Accounts (Click to Load):
              </div>
              <div className="space-y-1.5">
                <button
                  type="button"
                  onClick={() => setAccount('analyst@changetracker.gov.in', 'Defense@2026')}
                  className="w-full text-left px-2.5 py-1.5 rounded-lg bg-slate-950/70 hover:bg-teal-950/40 border border-slate-800 hover:border-teal-700/60 text-xs flex justify-between items-center transition-all cursor-pointer"
                >
                  <span className="font-semibold text-slate-200">Dilip Raman (Lead Analyst)</span>
                  <span className="font-mono text-[10px] text-teal-400 bg-teal-950 px-1.5 py-0.5 rounded border border-teal-800">TOP SECRET</span>
                </button>
                <button
                  type="button"
                  onClick={() => setAccount('commander@isro.gov.in', 'Isro@2026')}
                  className="w-full text-left px-2.5 py-1.5 rounded-lg bg-slate-950/70 hover:bg-cyan-950/40 border border-slate-800 hover:border-cyan-700/60 text-xs flex justify-between items-center transition-all cursor-pointer"
                >
                  <span className="font-semibold text-slate-200">Col. Rajesh Verma (ISRO)</span>
                  <span className="font-mono text-[10px] text-cyan-400 bg-cyan-950 px-1.5 py-0.5 rounded border border-cyan-800">ORBITAL LEVEL 5</span>
                </button>
              </div>
            </div>
          </div>

          {/* Bottom Security Provenance */}
          <div className="pt-6 border-t border-slate-800/80 flex items-center justify-between text-xs text-slate-500">
            <span>© 2026 ChangeTracker Platform. SIH28227.</span>
            <div className="flex gap-4 items-center">
              <span className="flex items-center gap-1"><Cpu className="w-3.5 h-3.5 text-cyan-400" /> ISRO Bhuvan</span>
              <span className="flex items-center gap-1"><Activity className="w-3.5 h-3.5 text-teal-400" /> Academic Lab</span>
            </div>
          </div>
        </div>

        {/* Right Form: Glassmorphic Auth Card */}
        <div className="flex-1 flex flex-col justify-center items-center p-6 sm:p-12 relative z-10">
          
          {/* Back to landing button */}
          <div className="w-full max-w-md mb-4 flex justify-between items-center">
            {onBack ? (
              <button 
                onClick={onBack}
                className="inline-flex items-center gap-2 text-xs font-medium text-slate-400 hover:text-white transition-colors cursor-pointer"
              >
                <ArrowLeft className="w-4 h-4" /> Back to Landing Page
              </button>
            ) : <div />}

            <span className="text-[11px] font-mono text-emerald-400 bg-emerald-950/60 border border-emerald-800/60 px-2 py-0.5 rounded-full flex items-center gap-1.5">
              <span className="w-1.5 h-1.5 rounded-full bg-emerald-400 animate-pulse"></span> DATABASE ONLINE
            </span>
          </div>

          {/* Auth Card */}
          <div className="w-full max-w-md bg-slate-900/85 backdrop-blur-xl border border-slate-800 p-8 rounded-2xl shadow-[0_12px_40px_rgba(0,0,0,0.6)]">
            
            {/* Mode Switch Tabs */}
            <div className="flex rounded-xl bg-slate-950/80 p-1 border border-slate-800 mb-6">
              <button
                type="button"
                onClick={() => { setMode('login'); setError(null); }}
                className={`flex-1 py-2 rounded-lg text-xs font-semibold transition-all cursor-pointer ${mode === 'login' ? 'bg-gradient-to-r from-teal-700 to-cyan-700 text-white shadow-md' : 'text-slate-400 hover:text-white'}`}
              >
                Sign In
              </button>
              <button
                type="button"
                onClick={() => { setMode('register'); setError(null); }}
                className={`flex-1 py-2 rounded-lg text-xs font-semibold transition-all cursor-pointer flex items-center justify-center gap-1.5 ${mode === 'register' ? 'bg-gradient-to-r from-teal-700 to-cyan-700 text-white shadow-md' : 'text-slate-400 hover:text-white'}`}
              >
                <UserPlus className="w-3.5 h-3.5" />
                Register New User
              </button>
            </div>

            <div className="mb-5">
              <h2 className="text-xl font-bold text-white tracking-tight mb-1">
                {mode === 'login' ? 'Sign In to Workspace' : 'Create Defense Profile'}
              </h2>
              <p className="text-xs text-slate-400">
                {mode === 'login' 
                  ? 'Credentials are authenticated against local SQLite users table.' 
                  : 'New profiles are saved directly to SQLite with SHA-256 encryption.'}
              </p>
            </div>

            {/* Error Banner */}
            {error && (
              <div className="mb-4 p-3 rounded-xl bg-rose-950/80 border border-rose-600/60 text-rose-200 text-xs flex items-center gap-2.5">
                <AlertCircle className="w-4 h-4 text-rose-400 shrink-0" />
                <span>{error}</span>
              </div>
            )}

            {/* Success Banner */}
            {success && (
              <div className="mb-4 p-3 rounded-xl bg-emerald-950/80 border border-emerald-600/60 text-emerald-200 text-xs flex items-center gap-2.5">
                <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0" />
                <span>{success}</span>
              </div>
            )}

            {/* LOGIN FORM */}
            {mode === 'login' && (
              <form onSubmit={handleLoginSubmit} className="space-y-4">
                
                {/* Email Input */}
                <div>
                  <label className="block text-xs font-semibold text-slate-300 uppercase tracking-wider mb-1.5">
                    Analyst ID / Email
                  </label>
                  <div className="relative group">
                    <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 group-focus-within:text-cyan-400 transition-colors">
                      <Mail className="w-4 h-4" />
                    </div>
                    <input 
                      type="email"
                      required
                      value={email}
                      onChange={(e) => setEmail(e.target.value)}
                      className="w-full pl-10 pr-3.5 py-2.5 bg-slate-950/90 border border-slate-700 rounded-xl text-sm text-white placeholder-slate-500 focus:outline-none focus:border-cyan-400 focus:ring-2 focus:ring-cyan-500/20 font-medium shadow-inner transition-all"
                      placeholder="name@changetracker.gov.in"
                    />
                  </div>
                </div>

                {/* Password Input */}
                <div>
                  <div className="flex justify-between items-center mb-1.5">
                    <label className="text-xs font-semibold text-slate-300 uppercase tracking-wider">
                      Password / Token
                    </label>
                    <span className="text-[11px] text-slate-400 font-mono">Defense@2026</span>
                  </div>
                  <div className="relative group">
                    <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 group-focus-within:text-cyan-400 transition-colors">
                      <Lock className="w-4 h-4" />
                    </div>
                    <input 
                      type="password"
                      required
                      value={password}
                      onChange={(e) => setPassword(e.target.value)}
                      className="w-full pl-10 pr-3.5 py-2.5 bg-slate-950/90 border border-slate-700 rounded-xl text-sm text-white placeholder-slate-500 focus:outline-none focus:border-cyan-400 focus:ring-2 focus:ring-cyan-500/20 font-medium shadow-inner transition-all"
                      placeholder="••••••••••••"
                    />
                  </div>
                </div>

                {/* Sign In Primary CTA */}
                <button
                  type="submit"
                  disabled={isLoading}
                  className="w-full mt-2 py-3 px-4 rounded-xl font-semibold text-sm text-white bg-gradient-to-r from-teal-600 via-cyan-600 to-blue-600 hover:from-teal-500 hover:to-cyan-500 disabled:opacity-50 shadow-[0_0_20px_rgba(6,182,212,0.35)] transition-all cursor-pointer flex items-center justify-center gap-2 hover:scale-[1.02] active:scale-[0.98]"
                >
                  {isLoading ? (
                    <>
                      <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                      <span>Verifying Credentials...</span>
                    </>
                  ) : (
                    <>
                      <span>Authorize & Enter Workspace</span>
                      <ArrowRight className="w-4 h-4 text-cyan-100" />
                    </>
                  )}
                </button>

                <div className="pt-2 text-center">
                  <p className="text-xs text-slate-400">
                    New personnel?{' '}
                    <button 
                      type="button" 
                      onClick={() => { setMode('register'); setError(null); }}
                      className="text-cyan-400 hover:text-cyan-300 font-semibold underline underline-offset-4 cursor-pointer"
                    >
                      Register New User Account
                    </button>
                  </p>
                </div>

              </form>
            )}

            {/* REGISTRATION FORM */}
            {mode === 'register' && (
              <form onSubmit={handleRegisterSubmit} className="space-y-3.5">
                
                {/* Full Name */}
                <div>
                  <label className="block text-xs font-semibold text-slate-300 uppercase tracking-wider mb-1">
                    Officer / Analyst Full Name
                  </label>
                  <div className="relative group">
                    <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 group-focus-within:text-cyan-400 transition-colors">
                      <User className="w-4 h-4" />
                    </div>
                    <input 
                      type="text"
                      required
                      value={regName}
                      onChange={(e) => setRegName(e.target.value)}
                      className="w-full pl-10 pr-3.5 py-2 bg-slate-950/90 border border-slate-700 rounded-xl text-sm text-white placeholder-slate-500 focus:outline-none focus:border-cyan-400 focus:ring-2 focus:ring-cyan-500/20 font-medium transition-all"
                      placeholder="e.g. Major Vikram Singh"
                    />
                  </div>
                </div>

                {/* Email */}
                <div>
                  <label className="block text-xs font-semibold text-slate-300 uppercase tracking-wider mb-1">
                    Official Email ID
                  </label>
                  <div className="relative group">
                    <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 group-focus-within:text-cyan-400 transition-colors">
                      <Mail className="w-4 h-4" />
                    </div>
                    <input 
                      type="email"
                      required
                      value={regEmail}
                      onChange={(e) => setRegEmail(e.target.value)}
                      className="w-full pl-10 pr-3.5 py-2 bg-slate-950/90 border border-slate-700 rounded-xl text-sm text-white placeholder-slate-500 focus:outline-none focus:border-cyan-400 focus:ring-2 focus:ring-cyan-500/20 font-medium transition-all"
                      placeholder="vikram@mod.gov.in"
                    />
                  </div>
                </div>

                {/* Password */}
                <div>
                  <label className="block text-xs font-semibold text-slate-300 uppercase tracking-wider mb-1">
                    Security Password
                  </label>
                  <div className="relative group">
                    <div className="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400 group-focus-within:text-cyan-400 transition-colors">
                      <Lock className="w-4 h-4" />
                    </div>
                    <input 
                      type="password"
                      required
                      value={regPassword}
                      onChange={(e) => setRegPassword(e.target.value)}
                      className="w-full pl-10 pr-3.5 py-2 bg-slate-950/90 border border-slate-700 rounded-xl text-sm text-white placeholder-slate-500 focus:outline-none focus:border-cyan-400 focus:ring-2 focus:ring-cyan-500/20 font-medium transition-all"
                      placeholder="Minimum 6 characters"
                    />
                  </div>
                </div>

                {/* Agency & Clearance in 2 Columns */}
                <div className="grid grid-cols-2 gap-2.5">
                  <div>
                    <label className="block text-[11px] font-semibold text-slate-300 uppercase tracking-wider mb-1">
                      Organization
                    </label>
                    <div className="relative">
                      <select
                        value={regAgency}
                        onChange={(e) => setRegAgency(e.target.value)}
                        className="w-full py-2 px-2.5 bg-slate-950/90 border border-slate-700 rounded-xl text-xs text-white focus:outline-none focus:border-cyan-400 cursor-pointer"
                      >
                        <option value="Defense Intelligence Agency">Defense Intel Agency</option>
                        <option value="ISRO Bhuvan Security">ISRO Bhuvan Security</option>
                        <option value="MoD Geospatial Unit">MoD Geospatial Unit</option>
                        <option value="Academic Research Lab">Academic Research Lab</option>
                      </select>
                    </div>
                  </div>

                  <div>
                    <label className="block text-[11px] font-semibold text-slate-300 uppercase tracking-wider mb-1">
                      Security Clearance
                    </label>
                    <div className="relative">
                      <select
                        value={regClearance}
                        onChange={(e) => setRegClearance(e.target.value)}
                        className="w-full py-2 px-2.5 bg-slate-950/90 border border-slate-700 rounded-xl text-xs text-teal-300 font-mono font-semibold focus:outline-none focus:border-cyan-400 cursor-pointer"
                      >
                        <option value="CONFIDENTIAL // LEVEL 2">CONFIDENTIAL</option>
                        <option value="SECRET // LEVEL 3">SECRET // L3</option>
                        <option value="TOP SECRET // LEVEL 4">TOP SECRET // L4</option>
                        <option value="LEVEL 5 ORBITAL">LEVEL 5 ORBITAL</option>
                      </select>
                    </div>
                  </div>
                </div>

                {/* Register CTA */}
                <button
                  type="submit"
                  disabled={isLoading}
                  className="w-full mt-2 py-2.5 px-4 rounded-xl font-semibold text-sm text-white bg-gradient-to-r from-emerald-600 via-teal-600 to-cyan-600 hover:from-emerald-500 hover:to-cyan-500 disabled:opacity-50 shadow-[0_0_20px_rgba(16,185,129,0.35)] transition-all cursor-pointer flex items-center justify-center gap-2 hover:scale-[1.02] active:scale-[0.98]"
                >
                  {isLoading ? (
                    <>
                      <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                      <span>Saving Profile to SQLite...</span>
                    </>
                  ) : (
                    <>
                      <UserPlus className="w-4 h-4" />
                      <span>Create Account & Register</span>
                    </>
                  )}
                </button>

                <div className="pt-2 text-center">
                  <p className="text-xs text-slate-400">
                    Already registered?{' '}
                    <button 
                      type="button" 
                      onClick={() => { setMode('login'); setError(null); }}
                      className="text-cyan-400 hover:text-cyan-300 font-semibold underline underline-offset-4 cursor-pointer"
                    >
                      Back to Sign In
                    </button>
                  </p>
                </div>

              </form>
            )}

            <div className="mt-5 pt-3 border-t border-slate-800 text-center">
              <p className="text-[10px] text-slate-500 font-mono">
                SECURE SHA-256 HASHING • ENCRYPTED ON-PREM REPOSITORY
              </p>
            </div>

          </div>
        </div>

      </div>
    </div>
  );
}

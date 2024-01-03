% Exaz_MEEle file for initialization of muscle models
%
% This function loads muscle parameters and calculates the initial
% conditions for the internal degree of freedom l_CE.
%
% If you use this model for scientific purposes, please cite our article:
% D.F.B. Haeufle, M. G�nther, A. Bayer, S. Schmitt (2014) Hill-type muscle
% model with serial daz_MEEing and eccentric force-velocity relation Journal
% of Biomechanics http://dx.doi.org/10.1016/j.jbiomech.2014.02.009


% Copyright (c) 2014 belongs to D. Haeufle, M. Guenther, A. Bayer, and S.
% Schmitt 
% All rights reserved. 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
%
%  1 Redistributions of source code must retain the above copyright notice,
%    this list of conditions and the following disclaimer. 
%  2 Redistributions in binary form must reproduce the above copyright
%    notice, this list of conditions and the following disclaimer in the
%    documentation and/or other materials provided with the distribution.
%  3 Neither the name of the owner nor the names of its contributors may be
%    used to endorse or promote products derived from this software without
%    specific prior written permission.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
% IS" AND ANY EXPRESS OR Iz_MEELIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
% THE Iz_MEELIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
% PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEz_MEELARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
% THE POSSIBILITY OF SUCH DAMAGE.




%% Load muscle parameters
%=================================================
% define muscle specific parameters

% contractile element (CE)
%===========================
z_MEE.CE.F_max = 1550;                 % F_max in [N] %source: Kistemaker2006, 
z_MEE.CE.l_CEopt = 0.093;              % optimal length of CE in [m] %source: Kistemaker2006,

% serial elastic element (SEE)
% ============================
z_MEE.SEE.l_SEE0        = 0.187;       % rest length of SEE in [m]

% load standard parameter set
z_MEE = Library_mtu_simulink_mtu_standard_parameters(z_MEE);

z_MEE = Library_mtu_simulink_mtu_standard_parameters(z_MEE);


%% load parameters for the activation dynamics
z_MEE.ActDyn = Library_mtu_simulink_actdyn_standard_parameters;

%% Specify initial conditions
%==============================
% Before the muscle model can be initialized, the length of the MTC at t=0
% and the initial muscle activity have to be defined:

z_MEE.l_MTC_init = z_MEE.CE.l_CEopt + z_MEE.SEE.l_SEE0;  % [m] initial MTC length
z_MEE.ActDyn.u_init  = 0;          % [] initial muscle activity 0...1

% initial condition for internal degree of freedom (l_CE)
%=========================================================
% the initial condition z_MEE.l_CE_init is found under the assumtion that 
% all velocities are zero at the beginning of the simulation and that the
% force-equilibrium is F_SEE - F_CE - F_PEE = 0. The root is found with
% fzero

fhandle         = @(l_CE)init_muscle_force_equilib_with_Hatze_ActDyn(l_CE, z_MEE.l_MTC_init, z_MEE.ActDyn.u_init, z_MEE, z_MEE.ActDyn);
                         %init_muscle_force_equilib_with_Hatze_ActDyn(l_CE, l_MTC, u, MusParam, ActParam)
z_MEE.CE.l_CE_init = fzero(fhandle, [0 z_MEE.l_MTC_init]);
clear fhandle



% Several muscles can be stored in an array of structs, 
% e.g., z_MEE(2) = muscle_param_mus02;
% Repeat Steps 1-2 for each muscle

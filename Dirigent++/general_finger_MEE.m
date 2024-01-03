%% Load muscle parameters
%=================================================
% define muscle specific parameters

% contractile element (CE)
%===========================
ext.CE.F_max = 140;
ext.CE.l_CEopt = 0.0025;              

% serial elastic element (SEE)
% ============================
ext.SEE.l_SEE0        = 0.025;       % rest length of SEE in [m]

% load standard parameter set
ext = Library_mtu_simulink_mtu_standard_parameters(ext);

ext = Library_mtu_simulink_mtu_standard_parameters(ext);


%% load parameters for the activation dynamics
ext.ActDyn = Library_mtu_simulink_actdyn_standard_parameters;

%% Specify initial conditions
%==============================
% Before the muscle model can be initialized, the length of the MTC at t=0
% and the initial muscle activity have to be defined:

ext.l_MTC_init = ext.CE.l_CEopt + ext.SEE.l_SEE0;  % [m] initial MTC length
ext.ActDyn.u_init  = 0;          % [] initial muscle activity 0...1

% initial condition for internal degree of freedom (l_CE)
%=========================================================
% the initial condition ext.l_CE_init is found under the assumtion that 
% all velocities are zero at the beginning of the simulation and that the
% force-equilibrium is F_SEE - F_CE - F_PEE = 0. The root is found with
% fzero

fhandle         = @(l_CE)init_muscle_force_equilib_with_Hatze_ActDyn(l_CE, ext.l_MTC_init, ext.ActDyn.u_init, ext, ext.ActDyn);
                         %init_muscle_force_equilib_with_Hatze_ActDyn(l_CE, l_MTC, u, MusParam, ActParam)
ext.CE.l_CE_init = fzero(fhandle, [0 ext.l_MTC_init]);
clear fhandle



% Several muscles can be stored in an array of structs, 
% e.g., ext(2) = muscle_param_mus02;
% Repeat Steps 1-2 for each muscle

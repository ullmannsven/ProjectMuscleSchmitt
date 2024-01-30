%% Load muscle parameters
%=================================================
% define muscle specific parameters

% contractile element (CE)
%===========================
ext_imr.CE.F_max = 75;
ext_imr.CE.l_CEopt = 4/300;              

% serial elastic element (SEE)
% ============================
ext_imr.SEE.l_SEE0        = 8/300;       % rest length of SEE in [m]

% load standard parameter set
ext_imr = Library_mtu_simulink_mtu_standard_parameters(ext_imr);

ext_imr = Library_mtu_simulink_mtu_standard_parameters(ext_imr);


%% load parameters for the activation dynamics
ext_imr.ActDyn = Library_mtu_simulink_actdyn_standard_parameters;

%% Specify initial conditions
%==============================
% Before the muscle model can be initialized, the length of the MTC at t=0
% and the initial muscle activity have to be defined:

ext_imr.l_MTC_init = ext_imr.CE.l_CEopt + ext_imr.SEE.l_SEE0;  % [m] initial MTC length
ext_imr.ActDyn.u_init  = 0;          % [] initial muscle activity 0...1

% initial condition for internal degree of freedom (l_CE)
%=========================================================
% the initial condition ext.l_CE_init is found under the assumtion that 
% all velocities are zero at the beginning of the simulation and that the
% force-equilibrium is F_SEE - F_CE - F_PEE = 0. The root is found with
% fzero

fhandle         = @(l_CE)init_muscle_force_equilib_with_Hatze_ActDyn(l_CE, ext_imr.l_MTC_init, ext_imr.ActDyn.u_init, ext_imr, ext_imr.ActDyn);
                         %init_muscle_force_equilib_with_Hatze_ActDyn(l_CE, l_MTC, u, MusParam, ActParam)
ext_imr.CE.l_CE_init = fzero(fhandle, [0 ext_imr.l_MTC_init]);
clear fhandle



% Several muscles can be stored in an array of structs, 
% e.g., ext(2) = muscle_param_mus02;
% Repeat Steps 1-2 for each muscle

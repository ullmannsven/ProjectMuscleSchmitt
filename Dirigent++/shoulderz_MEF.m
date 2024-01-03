% ExaParam_Musle file for initialization of muscle models for shoulder
% flexor in z direction

%% Load muscle parameters
%=================================================
% define muscle specific parameters

% contractile element (CE)
%===========================
z_MEF.CE.F_max = 1420;                 % F_max in [N] %source: Kistemaker2006, 
z_MEF.CE.l_CEopt = 0.092;              % optimal length of CE in [m] %source: Kistemaker2006,

% serial elastic element (SEE)
% ============================
z_MEF.SEE.l_SEE0        = 0.172;       % rest length of SEE in [m]

% load standard parameter set
z_MEF = Library_mtu_simulink_mtu_standard_parameters(z_MEF);

z_MEF = Library_mtu_simulink_mtu_standard_parameters(z_MEF);


%% load parameters for the activation dynamics
z_MEF.ActDyn = Library_mtu_simulink_actdyn_standard_parameters;

%% Specify initial conditions
%==============================
% Before the muscle model can be initialized, the length of the MTC at t=0
% and the initial muscle activity have to be defined:

z_MEF.l_MTC_init = z_MEF.CE.l_CEopt + z_MEF.SEE.l_SEE0;  % [m] initial MTC length
z_MEF.ActDyn.u_init  = 0;          % [] initial muscle activity 0...1

% initial condition for internal degree of freedom (l_CE)
%=========================================================
% the initial condition Param_Mus.l_CE_init is found under the assumtion that 
% all velocities are zero at the beginning of the simulation and that the
% force-equilibrium is F_SEE - F_CE - F_PEE = 0. The root is found with
% fzero

fhandle         = @(l_CE)init_muscle_force_equilib_with_Hatze_ActDyn(l_CE, z_MEF.l_MTC_init, z_MEF.ActDyn.u_init, z_MEF, z_MEF.ActDyn);
                         %init_muscle_force_equilib_with_Hatze_ActDyn(l_CE, l_MTC, u, MusParam, ActParam)
z_MEF.CE.l_CE_init = fzero(fhandle, [0 z_MEF.l_MTC_init]);
clear fhandle



% Several muscles can be stored in an array of structs, 
% e.g., Param_Mus(2) = muscle_param_mus02;
% Repeat Steps 1-2 for each muscle

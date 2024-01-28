%% Load muscle parameters
%=================================================
% define muscle specific parameters

% contractile element (CE)
%===========================
flex_imr.CE.F_max = 100;                 % F_max in [N] %source: Kistemaker2006, 
flex_imr.CE.l_CEopt = 0.01;              % optimal length of CE in [m] %source: Kistemaker2006,

% serial elastic element (SEE)
% ============================
flex_imr.SEE.l_SEE0        = 0.01;       % rest length of SEE in [m]

% load standard parameter set
flex_imr = Library_mtu_simulink_mtu_standard_parameters(flex_imr);

flex_imr = Library_mtu_simulink_mtu_standard_parameters(flex_imr);


%% load parameters for the activation dynamics
flex_imr.ActDyn = Library_mtu_simulink_actdyn_standard_parameters;

%% Specify initial conditions
%==============================
% Before the muscle model can be initialized, the length of the MTC at t=0
% and the initial muscle activity have to be defined:

flex_imr.l_MTC_init = flex_imr.CE.l_CEopt + flex_imr.SEE.l_SEE0;  % [m] initial MTC length
flex_imr.ActDyn.u_init  = 0;          % [] initial muscle activity 0...1

% initial condition for internal degree of freedom (l_CE)
%=========================================================
% the initial condition flex.l_CE_init is found under the assumtion that 
% all velocities are zero at the beginning of the simulation and that the
% force-equilibrium is F_SEE - F_CE - F_PEE = 0. The root is found with
% fzero

fhandle         = @(l_CE)init_muscle_force_equilib_with_Hatze_ActDyn(l_CE, flex_imr.l_MTC_init, flex_imr.ActDyn.u_init, flex_imr, flex_imr.ActDyn);
                         %init_muscle_force_equilib_with_Hatze_ActDyn(l_CE, l_MTC, u, MusParam, ActParam)
flex_imr.CE.l_CE_init = fzero(fhandle, [0 flex_imr.l_MTC_init]);
clear fhandle



% Several muscles can be stored in an array of structs, 
% e.g., flex(2) = muscle_param_mus02;
% Repeat Steps 1-2 for each muscle

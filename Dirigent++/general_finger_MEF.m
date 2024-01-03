%% Load muscle parameters
%=================================================
% define muscle specific parameters

% contractile element (CE)
%===========================
flex.CE.F_max = 1550;                 % F_max in [N] %source: Kistemaker2006, 
flex.CE.l_CEopt = 0.093;              % optimal length of CE in [m] %source: Kistemaker2006,

% serial elastic element (SEE)
% ============================
flex.SEE.l_SEE0        = 0.187;       % rest length of SEE in [m]

% load standard parameter set
flex = Library_mtu_simulink_mtu_standard_parameters(flex);

flex = Library_mtu_simulink_mtu_standard_parameters(flex);


%% load parameters for the activation dynamics
flex.ActDyn = Library_mtu_simulink_actdyn_standard_parameters;

%% Specify initial conditions
%==============================
% Before the muscle model can be initialized, the length of the MTC at t=0
% and the initial muscle activity have to be defined:

flex.l_MTC_init = flex.CE.l_CEopt + flex.SEE.l_SEE0;  % [m] initial MTC length
flex.ActDyn.u_init  = 0;          % [] initial muscle activity 0...1

% initial condition for internal degree of freedom (l_CE)
%=========================================================
% the initial condition flex.l_CE_init is found under the assumtion that 
% all velocities are zero at the beginning of the simulation and that the
% force-equilibrium is F_SEE - F_CE - F_PEE = 0. The root is found with
% fzero

fhandle         = @(l_CE)init_muscle_force_equilib_with_Hatze_ActDyn(l_CE, flex.l_MTC_init, flex.ActDyn.u_init, flex, flex.ActDyn);
                         %init_muscle_force_equilib_with_Hatze_ActDyn(l_CE, l_MTC, u, MusParam, ActParam)
flex.CE.l_CE_init = fzero(fhandle, [0 flex.l_MTC_init]);
clear fhandle



% Several muscles can be stored in an array of structs, 
% e.g., flex(2) = muscle_param_mus02;
% Repeat Steps 1-2 for each muscle

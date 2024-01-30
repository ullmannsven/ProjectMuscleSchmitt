%% Script that performs Scissors Paper Roch for
disp("Start Scissors paper rock game!");
disp("See progress in Simulink window!")
% Generate a single random integer between 0 and 2
select_action_1 = randi([0, 2]);
select_action_2 = randi([0, 2]);

disp(select_action_1);
disp(select_action_2);

% PLAYER 1
% Case scissors
if select_action_1 == 0
    q.thumb1.ext = 0;
    q.thumb1.flex = 0;
    
    q.index1.ext = 0;
    q.index1.flex = 0;
    q.index2.ext = 0;
    q.index2.flex = 0;
    
    q.middle1.ext = 0;
    q.middle1.flex = 0;
    q.middle2.ext = 0;
    q.middle2.flex = 0;
    
    q.ring1.ext = 0;
    q.ring1.flex = 1;
    q.ring2.ext = 0;
    q.ring2.flex = 1;
    
    q.small1.ext = 0;
    q.small1.flex = 1;
    q.small2.ext = 0;
    q.small2.flex = 1;
end

% Case paper
if select_action_1 == 1
    q.thumb1.ext = 1;
    q.thumb1.flex = 0;
    
    q.index1.ext = 0;
    q.index1.flex = 0;
    q.index2.ext = 0;
    q.index2.flex = 0;
    
    q.middle1.ext = 0;
    q.middle1.flex = 0;
    q.middle2.ext = 0;
    q.middle2.flex = 0;
    
    q.ring1.ext = 0;
    q.ring1.flex = 0;
    q.ring2.ext = 0;
    q.ring2.flex = 0;
    
    q.small1.ext = 0;
    q.small1.flex = 0;
    q.small2.ext = 0;
    q.small2.flex = 0;
end

% Case rock
if select_action_1 == 2
    q.thumb1.ext = 0;
    q.thumb1.flex = 1;
    
    q.index1.ext = 0;
    q.index1.flex = 1;
    q.index2.ext = 0;
    q.index2.flex = 1;
    
    q.middle1.ext = 0;
    q.middle1.flex = 1;
    q.middle2.ext = 0;
    q.middle2.flex = 1;
    
    q.ring1.ext = 0;
    q.ring1.flex = 1;
    q.ring2.ext = 0;
    q.ring2.flex = 1;
    
    q.small1.ext = 0;
    q.small1.flex = 1;
    q.small2.ext = 0;
    q.small2.flex = 1;
end

% PLAYER 2
% Case scissors
if select_action_2 == 0
    q2.thumb1.ext = 0;
    q2.thumb1.flex = 0;
    
    q2.index1.ext = 0;
    q2.index1.flex = 0;
    q2.index2.ext = 0;
    q2.index2.flex = 0;
    
    q2.middle1.ext = 0;
    q2.middle1.flex = 0;
    q2.middle2.ext = 0;
    q2.middle2.flex = 0;
    
    q2.ring1.ext = 0;
    q2.ring1.flex = 1;
    q2.ring2.ext = 0;
    q2.ring2.flex = 1;
    
    q2.small1.ext = 0;
    q2.small1.flex = 1;
    q2.small2.ext = 0;
    q2.small2.flex = 1;
end

% Case paper
if select_action_2 == 1
    q2.thumb1.ext = 1;
    q2.thumb1.flex = 0;
    
    q2.index1.ext = 0;
    q2.index1.flex = 0;
    q2.index2.ext = 0;
    q2.index2.flex = 0;
    
    q2.middle1.ext = 0;
    q2.middle1.flex = 0;
    q2.middle2.ext = 0;
    q2.middle2.flex = 0;
    
    q2.ring1.ext = 0;
    q2.ring1.flex = 0;
    q2.ring2.ext = 0;
    q2.ring2.flex = 0;
    
    q2.small1.ext = 0;
    q2.small1.flex = 0;
    q2.small2.ext = 0;
    q2.small2.flex = 0;
end

% Case rock
if select_action_2 == 2
    q2.thumb1.ext = 0;
    q2.thumb1.flex = 1;
    
    q2.index1.ext = 0;
    q2.index1.flex = 1;
    q2.index2.ext = 0;
    q2.index2.flex = 1;
    
    q2.middle1.ext = 0;
    q2.middle1.flex = 1;
    q2.middle2.ext = 0;
    q2.middle2.flex = 1;
    
    q2.ring1.ext = 0;
    q2.ring1.flex = 1;
    q2.ring2.ext = 0;
    q2.ring2.flex = 1;
    
    q2.small1.ext = 0;
    q2.small1.flex = 1;
    q2.small2.ext = 0;
    q2.small2.flex = 1;
end

% Calling the scripts for the muscle parameters
thumb_MEE
thumb_MEE
index_middle_ring_finger_MEE
index_middle_ring_finger_MEF
small_finger_MEE
small_finger_MEF
sim('test.slx');

% Pretty print result
if select_action_1 == select_action_2
    disp("It's a draw!!!")
elseif (select_action_1 == 0 && select_action_2 == 1) || (select_action_1 == 1 && select_action_2 == 2) || (select_action_1 == 2 && select_action_2 == 0)
    disp("The blue player won!");
else
    disp("The grey player won!");
end

disp("Restart code to play again!")
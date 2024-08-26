function [x, fval] = genetic_OPT(nvars,lb,ub,InitialPopulationMatrix_Data)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = optimoptions('ga');
%% Modify options setting
options = optimoptions(options,'InitialPopulationMatrix', InitialPopulationMatrix_Data);
options = optimoptions(options,'Display', 'off');
options = optimoptions(options,'UseVectorized', false);
options = optimoptions(options,'UseParallel', false);
[x, fval] = ga(@OPT,nvars,[],[],[],[],lb,ub,[],[],options);
end
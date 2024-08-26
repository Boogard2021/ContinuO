function x=main_OPT
global SCR
if SCR==3
    nvars=4; % number of optimization variables
    lb=[0.2 0.5 0.60 0.05]; % lower band of variables
    ub=[1   3  0.95  0.4]; % upper band of variables
    InitialPopulationMatrix_Data=[0.4967 0.8302 0.6195 0.3983];
%     InitialPopulationMatrix_Data=[0.2598 0.5474 0.6636 0.3985];
%     PopulationSize_Data=60; % number of population
elseif SCR==4
    nvars=7; % number of optimization variables
    lb=[0.05 0.35  0.05  0.5  0.5  0   0]; % lower band of variables
    ub=[0.3   0.7   0.5   1    1   1   1]; % upper band of variables
    InitialPopulationMatrix_Data=[0.2619  0.5011  0.25  0.75  0.883  0.5  0.5]; % initial population data 
    %     PopulationSize_Data=20; % number of population
elseif SCR==5
    nvars=8; % number of optimization variables
    lb=[0.05 0.05 0.1 0.5 0.05 0.2 0.2 0.8]; % lower band of variables
    ub=[0.5  0.5  0.7 1   0.6  0.9 0.9 1]; % upper band of variables
    InitialPopulationMatrix_Data=[0.4868    0.0708    0.1701    0.9796    0.3178    0.5700    0.2547    0.9302]; % initial population data
%     PopulationSize_Data=20; % number of population
end
[x, fval] = genetic_OPT(nvars,lb,ub,InitialPopulationMatrix_Data);
end



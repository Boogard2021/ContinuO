global T_ac T_dc
global Tc Td Ts Tm
global Ds ini_frhl ini_flhr
global L_bb_f L_bb_h L_ff_f L_ff_h 
global lss hss 
global lac hac
global T_ac_a_a T_ac_a_b
global T_ac_p_az T_ac_p_bz
global T_dc_p_gamma
% global T_dc_a_a T_dc_a_b T_dc_a_c
global T_dc_p_ax 
% global T_dc_p_ay T_dc_p_by T_dc_p_cy
global T_dc_p_az T_dc_p_bz
global N L_b
global zp_ss_min zp_ss_max zp_ac zp_dc ls
global xs xe
global theta_p

%% Right (Ankle & Foot)
%%%%%%%%%% Ankle
% Right Front Ankle Periodic
Time_fr=[];
X_fr=[];    Y_fr=[];    Z_fr=[];
dX_fr=[];   dY_fr=[];   dZ_fr=[];
ddX_fr=[];  ddY_fr=[];  ddZ_fr=[];
% ini_frhl
for i=1:N
    time_fr=T_ac+[2*(i-1)*Tc  2*(i-1)*Tc+Td  2*(i-1)*Tc+Tm   (2*i-1)*Tc];
    
%     x_fr=        L_bb_f-ini_frhl+[2*(i-1)*Ds  2*(i-1)*Ds     2*(i-1)*Ds+lss  2*i*Ds]; %-ini_frhl
    x_fr=        L_b/2 +[2*(i-1)*Ds  2*(i-1)*Ds     2*(i-1)*Ds+lss  2*i*Ds]; %-ini_frhl
    dx_fr=       [0           0              inf             0         ];
    ddx_fr=      [0           0              inf             0         ];
    
    y_fr=   -0.5*[L_ff_f       L_ff_f          L_ff_f             L_ff_f];
    dy_fr=       [0           0              0               0         ];
    ddy_fr=      [0           0              0               0         ];
    
    z_fr=        [0           0             hss              0        ];
    dz_fr=       [0           0              0               0         ];
    ddz_fr=      [0           0              inf             0         ];
    
    
    Time_fr=[Time_fr time_fr];
    X_fr=[X_fr x_fr];                          Y_fr=[Y_fr y_fr];                       Z_fr=[Z_fr z_fr];
    dX_fr=[dX_fr dx_fr];                       dY_fr=[dY_fr dy_fr];                    dZ_fr=[dZ_fr dz_fr];
    ddX_fr=[ddX_fr ddx_fr];                    ddY_fr=[ddY_fr ddy_fr];                 ddZ_fr=[ddZ_fr ddz_fr];
end
% time_ar
% Right Front Ankle AC
Time_fr_AC=                [0     T_ac_a_a     T_ac/2 ];
X_fr_AC=          L_bb_f-[0     lac         ini_frhl];
dX_fr_AC=                  [0     inf          0      ];
ddX_fr_AC=                 [0     inf          0      ];

Y_fr_AC=     -0.5*[L_ff_f  L_ff_f    L_ff_f];
dY_fr_AC=         [0     0            0     ];
ddY_fr_AC=        [0     0            0     ];

Z_fr_AC=          [0     hac         0     ];
dZ_fr_AC=         [0     0           0     ];
ddZ_fr_AC=        [0     inf         0     ];      

% Right Front Ankle DC
Time_fr_DC=       T_ac+2*N*Tc+[0           T_dc       ];
X_fr_DC=    L_bb_f-ini_frhl+[2*N*Ds     2*N*Ds      ];   %-ini_frhl
dX_fr_DC=                     [0            0         ];
ddX_fr_DC=                    [0            0         ];

Y_fr_DC=                 -0.5*[L_ff_f         L_ff_f];
dY_fr_DC=                     [0            0         ];
ddY_fr_DC=                    [0            0         ];

Z_fr_DC=                      [0            0         ];
dZ_fr_DC=                     [0            0         ];
ddZ_fr_DC=                    [0            0         ];

% Time_fr_DC=     T_ac+2*N*Tc+[0      T_dc_a_a   T_dc_a_b    T_dc_a_c    T_dc];
% X_fr_DC=             0.5*L_ff+2*N*Ds-ini_frhl+[0      0          ldc         Ds          Ds  ];
% dX_fr_DC=                   [0      0          inf         0           0   ];
% ddX_fr_DC=                  [0      0          inf         0           0   ];
% 
% Y_fr_DC=               -0.5*[W_ff  W_ff   W_ff    W_ff   W_ff];
% dY_fr_DC=                   [0      0          0           0           0   ];
% ddY_fr_DC=                  [0      0          0           0           0   ];
% 
% Z_fr_DC=                    [0      0         hdc          0           0   ];
% dZ_fr_DC=                   [0      0          0           0           0   ];
% ddZ_fr_DC=                  [0      0          inf         0           0   ];

clear time_ar
clear x_fr dx_fr ddx_fr
clear y_fr dy_fr ddy_fr
clear z_fr dz_fr ddz_fr
%%
% Left Front Ankle Periodic
Time_hl=[];
X_hl=[];    Y_hl=[];    Z_hl=[];
dX_hl=[];   dY_hl=[];   dZ_hl=[];
ddX_hl=[];  ddY_hl=[];  ddZ_hl=[];

for i=1:N
    time_hl=T_ac+[2*(i-1)*Tc  2*(i-1)*Tc+Td  2*(i-1)*Tc+Tm   (2*i-1)*Tc];
    
%     x_hl=        -L_bb_h-ini_frhl+[2*(i-1)*Ds  2*(i-1)*Ds     2*(i-1)*Ds+lss  2*i*Ds]; %-ini_frhl
    x_hl=        -L_b/2+[2*(i-1)*Ds  2*(i-1)*Ds     2*(i-1)*Ds+lss  2*i*Ds]; %-ini_frhl
    dx_hl=       [0           0              inf             0         ];
    ddx_hl=      [0           0              inf             0         ];
    
    y_hl=    0.5*[L_ff_h       L_ff_h     L_ff_h      L_ff_h];
    dy_hl=       [0           0              0               0         ];
    ddy_hl=      [0           0              0               0         ];
    
    z_hl=        [0           0             hss              0        ];
    dz_hl=       [0           0              0               0         ];
    ddz_hl=      [0           0              inf             0         ];
    
    
    Time_hl=[Time_hl time_hl];
    X_hl=[X_hl x_hl];                          Y_hl=[Y_hl y_hl];                       Z_hl=[Z_hl z_hl];
    dX_hl=[dX_hl dx_hl];                       dY_hl=[dY_hl dy_hl];                    dZ_hl=[dZ_hl dz_hl];
    ddX_hl=[ddX_hl ddx_hl];                    ddY_hl=[ddY_hl ddy_hl];                 ddZ_hl=[ddZ_hl ddz_hl];
end
% time_ar
% Right Front Ankle AC
Time_hl_AC=                [0     T_ac_a_a     T_ac/2 ];
X_hl_AC=          -L_bb_h-[0     lac         ini_frhl];
dX_hl_AC=                  [0     inf          0      ];
ddX_hl_AC=                 [0     inf          0      ];

Y_hl_AC=     0.5*[L_ff_h  L_ff_h     L_ff_h];
dY_hl_AC=         [0     0            0     ];
ddY_hl_AC=        [0     0            0     ];

Z_hl_AC=          [0     hac         0     ];
dZ_hl_AC=         [0     0           0     ];
ddZ_hl_AC=        [0     inf         0     ];     

% Right Front Ankle DC
Time_hl_DC=       T_ac+2*N*Tc+[0           T_dc       ];
X_hl_DC=   -L_bb_h-ini_frhl+[2*N*Ds     2*N*Ds      ];  %-ini_frhl
dX_hl_DC=                     [0            0         ];
ddX_hl_DC=                    [0            0         ];

Y_hl_DC=                  0.5*[L_ff_h         L_ff_h];
dY_hl_DC=                     [0            0         ];
ddY_hl_DC=                    [0            0         ];

Z_hl_DC=                      [0            0         ];
dZ_hl_DC=                     [0            0         ];
ddZ_hl_DC=                    [0            0         ];

clear time_hl
clear x_hl dx_hl ddx_hl
clear y_hl dy_hl ddy_hl
clear z_hl dz_hl ddz_hl
%% Front Left (Ankle & Foot)
% Front Left Ankle Periodic
Time_fl=[];
X_fl=[];    Y_fl=[];    Z_fl=[];
dX_fl=[];   dY_fl=[];   dZ_fl=[];
ddX_fl=[];  ddY_fl=[];  ddZ_fl=[];

for i=1:N
    time_fl=T_ac+[2*(i-1)*Tc  (2*i-1)*Tc+Td  (2*i-1)*Tc+Tm ];
    
%     x_fl=        L_bb_f-ini_flhr+[2*(i-1)*Ds   2*(i-1)*Ds     2*(i-1)*Ds+lss]; %-ini_flhr
    x_fl=        L_b/2+[2*(i-1)*Ds   2*(i-1)*Ds     2*(i-1)*Ds+lss]; %-ini_flhr
    dx_fl=       [0           0              inf           ];
    ddx_fl=      [0           0              inf           ];
    
    y_fl=    0.5*[L_ff_f      L_ff_f      L_ff_f     ];
    dy_fl=       [0           0              0             ];
    ddy_fl=      [0           0              0             ];
    
    z_fl=        [0          0             hss             ];
    dz_fl=       [0           0              0             ];
    ddz_fl=      [0           0              inf           ];
    
    Time_fl=[Time_fl time_fl];
    X_fl=[X_fl x_fl];                           Y_fl=[Y_fl y_fl];                      Z_fl=[Z_fl z_fl];
    dX_fl=[dX_fl dx_fl];                        dY_fl=[dY_fl dy_fl];                   dZ_fl=[dZ_fl dz_fl];
    ddX_fl=[ddX_fl ddx_fl];                     ddY_fl=[ddY_fl ddy_fl];                ddZ_fl=[ddZ_fl ddz_fl];
    
end

% Front Left  Ankle AC
Time_fl_AC=                [0    T_ac/2  T_ac_a_b ];
X_fl_AC=          L_bb_f-[0     0      lac   ];
dX_fl_AC=                  [0     0      inf   ];
ddX_fl_AC=                 [0     0      inf   ];

Y_fl_AC=     0.5*[L_ff_f  L_ff_f  L_ff_f];
dY_fl_AC=         [0     0            0 ];
ddY_fl_AC=        [0     0            0 ];

Z_fl_AC=          [0     0    hac  ];
dZ_fl_AC=         [0     0    0    ];
ddZ_fl_AC=        [0     0    inf  ];   
% Left Ankle DC
Time_fl_DC=       T_ac+2*N*Tc+[0            T_dc      ];
X_fl_DC=    L_bb_f-ini_flhr+[2*N*Ds     2*N*Ds      ]; %-ini_flhr
dX_fl_DC=                     [0            0         ];
ddX_fl_DC=                    [0            0         ];

Y_fl_DC=                  0.5*[L_ff_f        L_ff_f       ];
dY_fl_DC=                     [0            0         ];
ddY_fl_DC=                    [0            0         ];

Z_fl_DC=                      [0            0         ];
dZ_fl_DC=                     [0            0         ];
ddZ_fl_DC=                    [0            0         ];

clear time_fl
clear x_fl dx_fl ddx_fl
clear y_fl dy_fl ddy_fl
clear z_fl dz_fl ddz_fl

%%%%%%%%%% Foot
% Front Left Ankle Periodic
Time_hr=[];
X_hr=[];    Y_hr=[];    Z_hr=[];
dX_hr=[];   dY_hr=[];   dZ_hr=[];
ddX_hr=[];  ddY_hr=[];  ddZ_hr=[];

for i=1:N
    time_hr=T_ac+[2*(i-1)*Tc  (2*i-1)*Tc+Td  (2*i-1)*Tc+Tm ];
    
%     x_hr=       -L_bb_h-ini_flhr+[2*(i-1)*Ds  2*(i-1)*Ds     2*(i-1)*Ds+lss]; %-ini_flhr
    x_hr=       -L_b/2+[2*(i-1)*Ds  2*(i-1)*Ds     2*(i-1)*Ds+lss]; %-ini_flhr
    dx_hr=       [0                            0                           inf           ];
    ddx_hr=      [0                            0                           inf           ];
    
    y_hr=   -0.5*[L_ff_h      L_ff_h            L_ff_h];
    dy_hr=       [0           0              0  ];
    ddy_hr=      [0           0              0  ];
    
    z_hr=        [0           0              hss           ];
    dz_hr=       [0           0              0             ];
    ddz_hr=      [0           0              inf           ];
    
    Time_hr=[Time_hr time_hr];
    X_hr=[X_hr x_hr];                           Y_hr=[Y_hr y_hr];                      Z_hr=[Z_hr z_hr];
    dX_hr=[dX_hr dx_hr];                        dY_hr=[dY_hr dy_hr];                   dZ_hr=[dZ_hr dz_hr];
    ddX_hr=[ddX_hr ddx_hr];                     ddY_hr=[ddY_hr ddy_hr];                ddZ_hr=[ddZ_hr ddz_hr];
    
end

% Hind Right  Ankle AC
Time_hr_AC=                [0    T_ac/2  T_ac_a_b ];
X_hr_AC=          -L_bb_h-[0     0      lac   ];
dX_hr_AC=                  [0     0      inf   ];
ddX_hr_AC=                 [0     0      inf   ];

Y_hr_AC=     -0.5*[L_ff_h  L_ff_h         L_ff_h   ];
dY_hr_AC=         [0     0            0     ];
ddY_hr_AC=        [0     0            0     ];

Z_hr_AC=          [0     0    hac  ];
dZ_hr_AC=         [0     0    0    ];
ddZ_hr_AC=        [0     0    inf  ]; 

% Left Ankle DC
Time_hr_DC=       T_ac+2*N*Tc+[0            T_dc      ];
X_hr_DC=    -L_bb_h-ini_flhr+[2*N*Ds     2*N*Ds      ];  %-ini_flhr
dX_hr_DC=                     [0            0         ];
ddX_hr_DC=                    [0            0         ];

Y_hr_DC=                 -0.5*[L_ff_h        L_ff_h   ];
dY_hr_DC=                     [0            0         ];
ddY_hr_DC=                    [0            0         ];

Z_hr_DC=                      [0            0         ];
dZ_hr_DC=                     [0            0         ];
ddZ_hr_DC=                    [0            0         ];

clear time_hr
clear x_hr dx_hr ddx_hr
clear y_hr dy_hr ddy_hr
clear z_hr dz_hr ddz_hr
%% Pelvis
% Pelvise Periodic
Time_p_i=[];    Time_p_ii=[];   Time_p_iii=[];  Time_p_iv=[];
X_p=[];    Y_p=[];    Z_p=[];
dX_p=[];   dY_p=[];   dZ_p=[];
ddX_p=[];  ddY_p=[];  ddZ_p=[];

Alpha_p=[];    Beta_p=[];    Gamma_p=[];
dAlpha_p=[];   dBeta_p=[];   dGamma_p=[];
ddAlpha_p=[];  ddBeta_p=[];  ddGamma_p=[];

i_ac=T_ac==0;
i_dc=T_dc==0;
for i=(1-i_ac):(N+i_dc)
    time_p_i  =T_ac+[2*(i-1)*Tc          2*(i-1)*Tc+Td           (2*i-1)*Tc           (2*i-1)*Tc+Td];
    x_p=            [2*(i-1)*Ds+xe       (2*i-1)*Ds-xs           (2*i-1)*Ds+xe        2*i*Ds-xs    ];
    dx_p=           [inf                 inf                     inf                  inf          ];
    ddx_p=          [inf                 inf                     inf                  inf          ];
    
    time_p_ii =T_ac+[2*(i-1)*Tc          2*(i-1)*Tc+Td        2*(i-1)*Tc+Tm        (2*i-1)*Tc            (2*i-1)*Tc+Td      (2*i-1)*Tc+Tm];
    y_p=            [0                  0                       0                   0                      0              0        ];
    dy_p=           [0                  0                       0                   0                      0              0        ];
    ddy_p=          [0                  0                       0                   0                      0              0        ];
   
%     time_p_ii =T_ac+[2*(i-1)*Tc          2*(i-1)*Tc+Td/2         2*(i-1)*Tc+Td        2*(i-1)*Tc+Td+Ts/2      (2*i-1)*Tc      (2*i-1)*Tc+Td/2     (2*i-1)*Tc+Td       (2*i-1)*Tc+Td+Ts/2];
%     y_p=            [yd                  0                       ye                   ye                      yd              0                   -yd                 -ye               ];
%     dy_p=           [inf                 inf                     inf                  0                       inf             inf                 inf                 0                 ];
%     ddy_p=          [inf                 inf                     inf                  inf                     inf             inf                 inf                 inf               ];

    time_p_iii=T_ac+[2*(i-1)*Tc+Td/2     2*(i-1)*Tc+Td+Ts/2      (2*i-1)*Tc+Td/2      (2*i-1)*Tc+Td+Ts/2];
    z_p=            [zp_ss_min           zp_ss_max               zp_ss_min            zp_ss_max         ];
    dz_p=           [0                   0                       0                    0                 ];
    ddz_p=          [inf                 inf                     inf                  inf               ];
    
    time_p_iv =T_ac+[2*(i-1)*Tc          2*(i-1)*Tc+Td           (2*i-1)*Tc           (2*i-1)*Tc+Td];
    alpha_p=        [0                   0                       0                    0            ];
    dalpha_p=       [0                   0                       0                    0            ];
    ddalpha_p=      [0                   0                       0                    0            ];
    
    beta_p=         [0                   0                       0                    0            ];
    dbeta_p=        [0                   0                       0                    0            ];
    ddbeta_p=       [0                   0                       0                    0            ];
    
    gamma_p=        [-theta_p            -theta_p                theta_p              theta_p      ];
    dgamma_p=       [0                   0                       0                    0            ];
    ddgamma_p=      [0                   0                       0                    0            ];
    
    Time_p_i=[Time_p_i time_p_i];
    Time_p_ii=[Time_p_ii time_p_ii];
    Time_p_iii=[Time_p_iii time_p_iii];
    Time_p_iv=[Time_p_iv time_p_iv];
    
    X_p=[X_p x_p];                          Y_p=[Y_p y_p];                       Z_p=[Z_p z_p];
    dX_p=[dX_p dx_p];                       dY_p=[dY_p dy_p];                    dZ_p=[dZ_p dz_p];
    ddX_p=[ddX_p ddx_p];                    ddY_p=[ddY_p ddy_p];                 ddZ_p=[ddZ_p ddz_p];
    
    Alpha_p=[Alpha_p      alpha_p];         Beta_p=[Beta_p      beta_p];         Gamma_p=[Gamma_p     gamma_p];
    dAlpha_p=[dAlpha_p    dalpha_p];        dBeta_p=[dBeta_p    dbeta_p];        dGamma_p=[dGamma_p   dgamma_p];
    ddAlpha_p=[ddAlpha_p  ddalpha_p];       ddBeta_p=[ddBeta_p  ddbeta_p];       ddGamma_p=[ddGamma_p  ddgamma_p];
end
%%
% Pelvis AC
Time_p_i_AC= 0;     %[0       T_ac_p_ax];
X_p_AC=     0;
dX_p_AC=    0;
ddX_p_AC=   0;

Time_p_ii_AC= 0; %[0       T_ac_p_ay   T_ac_p_by   T_ac_p_cy];
Y_p_AC=        0;
dY_p_AC=       0;
ddY_p_AC=      0;

Time_p_iii_AC= [0       T_ac_p_az   T_ac_p_bz];
Z_p_AC=        [ls      zp_ac   zp_ac    ];
dZ_p_AC=       [0       0           0     ];
ddZ_p_AC=      [0       0           0    ];

Time_p_iv_AC= 0; %[0       T_ac_p_gamma];
Alpha_p_AC=    0;
dAlpha_p_AC=   0;
ddAlpha_p_AC=  0;

Beta_p_AC=    0;
dBeta_p_AC=    0;
ddBeta_p_AC=   0;

Gamma_p_AC=    0;
dGamma_p_AC=   0;
ddGamma_p_AC=  0;
%%
Time_p_i_DC=   T_ac+2*(N+i_dc)*Tc+[0             Td              T_dc_p_ax       T_dc];
X_p_DC=             2*(N+i_dc)*Ds-[xs    xs    xs     xs];    %[xe            Ds-xs           Ds              Ds  ];
dX_p_DC=                   [0           0             0               0   ];
ddX_p_DC=                  [0           0             0               0   ];

Time_p_ii_DC=  T_ac+2*(N+i_dc)*Tc+[0           Td             T_dc];
Y_p_DC=                    [0           0                 0];
dY_p_DC=                   [0           0                 0];
ddY_p_DC=                  [0           0                 0];

Time_p_iii_DC= T_ac+2*(N+i_dc)*Tc+       [Td/2          T_dc_p_az       T_dc_p_bz       T_dc];
Z_p_DC=                           [zp_ss_min     zp_dc           zp_dc           zp_dc  ];
dZ_p_DC=                          [0             0               0               0   ];
ddZ_p_DC=                         [inf           0               0               0   ];

Time_p_iv_DC=  T_ac+2*(N+i_dc)*Tc+[0             Td              T_dc_p_gamma    T_dc];
Alpha_p_DC=                       [0             0               0               0   ];
dAlpha_p_DC=                      [0             0               0               0   ];
ddAlpha_p_DC=                     [0             0               0               0   ];

Beta_p_DC=                        [0             0               0               0   ];
dBeta_p_DC=                       [0             0               0               0   ];
ddBeta_p_DC=                      [0             0               0               0   ];

Gamma_p_DC=                       [-theta_p      -theta_p        0               0   ];
dGamma_p_DC=                      [0             0               0               0   ];
ddGamma_p_DC=                     [0             0               0               0   ];
%% Selection
run selection_stage
% Time_ar_AC
%     Time_ar
%     Time_ar_DC
clear time_p_i time_p_ii time_p_iii
clear x_p dx_p ddx_p
clear y_p dy_p ddy_p
clear z_p dz_p ddz_p
clear alpha_p dalpha_p ddalpha_p
clear beta_p  dbeta_p  ddbeta_p
clear gamma_p dgamma_p ddgamma_p

%% Coefficients
global Time_x_fr        Time_y_fr         Time_z_fr 
global cof_x_fr         cof_y_fr          cof_z_fr

global Time_x_fl        Time_y_fl         Time_z_fl
global cof_x_fl         cof_y_fl          cof_z_fl

global Time_x_hl        Time_y_hl         Time_z_hl
global cof_x_hl         cof_y_hl          cof_z_hl

global Time_x_hr        Time_y_hr         Time_z_hr
global cof_x_hr         cof_y_hr          cof_z_hr


global Time_x_p         Time_y_p          Time_z_p
global cof_x_p          cof_y_p           cof_z_p

global Time_alpha_p     Time_beta_p       Time_gamma_p
global cof_alpha_p      cof_beta_p        cof_gamma_p

Time_x_fr=Time_fr;         Time_y_fr=Time_fr;          Time_z_fr=Time_fr;
Time_x_fl=Time_fl;          Time_y_fl=Time_fl;          Time_z_fl=Time_fl;
Time_x_hr=Time_hr;         Time_y_hr=Time_hr;          Time_z_hr=Time_hr;
Time_x_hl=Time_hl;          Time_y_hl=Time_hl;          Time_z_hl=Time_hl;

Time_x_p=Time_p_i;          Time_y_p=Time_p_ii;         Time_z_p=Time_p_iii;
Time_alpha_p=Time_p_iv;     Time_beta_p=Time_p_iv;      Time_gamma_p=Time_p_iv;

%  Time_x_ar
% X_ar
% dX_ar
% ddX_ar
% nm=length(Time_y_p)
% Right
cof_x_fr      =     coeff(Time_x_fr,       X_fr,       dX_fr,      ddX_fr);          clear X_fr dX_fr ddX_fr
cof_y_fr      =     coeff(Time_y_fr,       Y_fr,       dY_fr,      ddY_fr);          clear Y_fr dY_fr ddY_fr
cof_z_fr      =     coeff(Time_z_fr,       Z_fr,       dZ_fr,      ddZ_fr);          clear Z_fr dZ_fr ddZ_fr

cof_x_fl      =     coeff(Time_x_fl,       X_fl,       dX_fl,      ddX_fl);          clear X_fl dX_fl ddX_fl
cof_y_fl      =     coeff(Time_y_fl,       Y_fl,       dY_fl,      ddY_fl);          clear Y_fl dY_fl ddY_fl
cof_z_fl      =     coeff(Time_z_fl,       Z_fl,       dZ_fl,      ddZ_fl);          clear Z_fl dZ_fl ddZ_fl

% Left
cof_x_hl      =     coeff(Time_x_hl,       X_hl,      dX_hl,       ddX_hl);          clear X_hl dX_hl ddX_hl
cof_y_hl      =     coeff(Time_y_hl,       Y_hl,      dY_hl,       ddY_hl);          clear Y_hl dY_hl ddY_hl
cof_z_hl      =     coeff(Time_z_hl,       Z_hl,      dZ_hl,       ddZ_hl);          clear Z_hl dZ_hl ddZ_hl

cof_x_hr      =     coeff(Time_x_hr,       X_hr,      dX_hr,       ddX_hr);          clear X_hr dX_hr ddX_hr
cof_y_hr      =     coeff(Time_y_hr,       Y_hr,      dY_hr,       ddY_hr);          clear Y_hr dY_hr ddY_hr
cof_z_hr      =     coeff(Time_z_hr,       Z_hr,      dZ_hr,       ddZ_hr);          clear Z_hr dZ_hr ddZ_hr


% Pelvis
cof_x_p       =     coeff(Time_x_p,        X_p,       dX_p,        ddX_p);           clear X_p dX_p ddX_p
cof_y_p       =     coeff(Time_y_p,        Y_p,       dY_p,        ddY_p);           clear Y_p dY_p ddY_p
cof_z_p       =     coeff(Time_z_p,        Z_p,       dZ_p,        ddZ_p);           clear Z_p dZ_p ddZ_p

cof_alpha_p   =     coeff(Time_alpha_p,    Alpha_p,   dAlpha_p,    ddAlpha_p);       clear Alpha_p dAlpha_p ddAlpha_p
cof_beta_p    =     coeff(Time_beta_p,     Beta_p,    dBeta_p,     ddBeta_p);        clear Beta_p dBeta_p ddBeta_p
cof_gamma_p   =     coeff(Time_gamma_p,    Gamma_p,   dGamma_p,    ddGamma_p);       clear Gamma_p dGamma_p ddGamma_p
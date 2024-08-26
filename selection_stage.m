% global T_ac T_dc
% if and(T_ac~=0, T_dc~=0)
% %     Time_ar
%     % Right Ankle
%     Time_ar=       [Time_ar_AC          Time_ar          Time_ar_DC];
%     X_ar=          [X_ar_AC             X_ar             X_ar_DC];      
%     dX_ar=         [dX_ar_AC            dX_ar            dX_ar_DC];       
%     ddX_ar=        [ddX_ar_AC           ddX_ar           ddX_ar_DC];
% 
%     Y_ar=          [Y_ar_AC             Y_ar             Y_ar_DC];      
%     dY_ar=         [dY_ar_AC            dY_ar            dY_ar_DC];       
%     ddY_ar=        [ddY_ar_AC           ddY_ar           ddY_ar_DC];    
% 
%     Z_ar=          [Z_ar_AC             Z_ar             Z_ar_DC];      
%     dZ_ar=         [dZ_ar_AC            dZ_ar            dZ_ar_DC];       
%     ddZ_ar=        [ddZ_ar_AC           ddZ_ar           ddZ_ar_DC];
%     
%     % Right Foot
%     Time_fr=       [Time_fr_AC          Time_fr          Time_fr_DC];
%     Alpha_fr=      [Alpha_fr_AC         Alpha_fr         Alpha_fr_DC];      
%     dAlpha_fr=     [dAlpha_fr_AC        dAlpha_fr        dAlpha_fr_DC];       
%     ddAlpha_fr=    [ddAlpha_fr_AC       ddAlpha_fr       ddAlpha_fr_DC];
% 
%     Beta_fr=       [Beta_fr_AC          Beta_fr          Beta_fr_DC];      
%     dBeta_fr=      [dBeta_fr_AC         dBeta_fr         dBeta_fr_DC];       
%     ddBeta_fr=     [ddBeta_fr_AC        ddBeta_fr        ddBeta_fr_DC];    
% 
%     Gamma_fr=      [Gamma_fr_AC         Gamma_fr         Gamma_fr_DC];      
%     dGamma_fr=     [dGamma_fr_AC        dGamma_fr        dGamma_fr_DC];       
%     ddGamma_fr=    [ddGamma_fr_AC       ddGamma_fr       ddGamma_fr_DC];
%     
%     % Left Ankle
%     Time_al=       [Time_al_AC          Time_al          Time_al_DC];
%     X_al=          [X_al_AC             X_al             X_al_DC];      
%     dX_al=         [dX_al_AC            dX_al            dX_al_DC];       
%     ddX_al=        [ddX_al_AC           ddX_al           ddX_al_DC];
% 
%     Y_al=          [Y_al_AC             Y_al             Y_al_DC];      
%     dY_al=         [dY_al_AC            dY_al            dY_al_DC];       
%     ddY_al=        [ddY_al_AC           ddY_al           ddY_al_DC];    
% 
%     Z_al=          [Z_al_AC             Z_al             Z_al_DC];      
%     dZ_al=         [dZ_al_AC            dZ_al            dZ_al_DC];       
%     ddZ_al=        [ddZ_al_AC           ddZ_al           ddZ_al_DC];
%     
%     % Left Foot
%     Time_fl=       [Time_fl_AC          Time_fl          Time_fl_DC];
%     Alpha_fl=      [Alpha_fl_AC         Alpha_fl         Alpha_fl_DC];      
%     dAlpha_fl=     [dAlpha_fl_AC        dAlpha_fl        dAlpha_fl_DC];       
%     ddAlpha_fl=    [ddAlpha_fl_AC       ddAlpha_fl       ddAlpha_fl_DC];
% 
%     Beta_fl=       [Beta_fl_AC          Beta_fl          Beta_fl_DC];      
%     dBeta_fl=      [dBeta_fl_AC         dBeta_fl         dBeta_fl_DC];       
%     ddBeta_fl=     [ddBeta_fl_AC        ddBeta_fl        ddBeta_fl_DC];    
% 
%     Gamma_fl=      [Gamma_fl_AC         Gamma_fl         Gamma_fl_DC];      
%     dGamma_fl=     [dGamma_fl_AC        dGamma_fl        dGamma_fl_DC];       
%     ddGamma_fl=    [ddGamma_fl_AC       ddGamma_fl       ddGamma_fl_DC];
%     
%     % pelvis
%     Time_p_i=      [Time_p_i_AC         Time_p_i         Time_p_i_DC];
%     X_p=           [X_p_AC              X_p              X_p_DC];
%     dX_p=          [dX_p_AC             dX_p             dX_p_DC];
%     ddX_p=         [ddX_p_AC            ddX_p            ddX_p_DC];
%     
%     Time_p_ii=     [Time_p_ii_AC        Time_p_ii        Time_p_ii_DC];
%     Y_p=           [Y_p_AC              Y_p              Y_p_DC];
%     dY_p=          [dY_p_AC             dY_p             dY_p_DC];
%     ddY_p=         [ddY_p_AC            ddY_p            ddY_p_DC];
%     
%     Time_p_iii=    [Time_p_iii_AC       Time_p_iii       Time_p_iii_DC];
%     Z_p=           [Z_p_AC              Z_p              Z_p_DC];
%     dZ_p=          [dZ_p_AC             dZ_p             dZ_p_DC];
%     ddZ_p=         [ddZ_p_AC            ddZ_p            ddZ_p_DC];
%     
%     Time_p_iv=     [Time_p_iv_AC        Time_p_iv        Time_p_iv_DC];
%     Alpha_p=       [Alpha_p_AC          Alpha_p          Alpha_p_DC];
%     dAlpha_p=      [dAlpha_p_AC         dAlpha_p         dAlpha_p_DC];
%     ddAlpha_p=     [ddAlpha_p_AC        ddAlpha_p        ddAlpha_p_DC];
%     
%     Beta_p=        [Beta_p_AC           Beta_p           Beta_p_DC];
%     dBeta_p=       [dBeta_p_AC          dBeta_p          dBeta_p_DC];
%     ddBeta_p=      [ddBeta_p_AC         ddBeta_p         ddBeta_p_DC];
%         
%     Gamma_p=       [Gamma_p_AC          Gamma_p          Gamma_p_DC];
%     dGamma_p=      [dGamma_p_AC         dGamma_p         dGamma_p_DC];
%     ddGamma_p=     [ddGamma_p_AC        ddGamma_p        ddGamma_p_DC];
%     
% elseif and(T_ac~=0, T_dc==0)
%     % Right Ankle
%     Time_ar=       [Time_ar_AC          Time_ar          Time_ar_DC(1)];
%     X_ar=          [X_ar_AC             X_ar             X_ar_DC(1)];      
%     dX_ar=         [dX_ar_AC            dX_ar            dX_ar_DC(1)];       
%     ddX_ar=        [ddX_ar_AC           ddX_ar           ddX_ar_DC(1)];
% 
%     Y_ar=          [Y_ar_AC             Y_ar             Y_ar_DC(1)];      
%     dY_ar=         [dY_ar_AC            dY_ar            dY_ar_DC(1)];       
%     ddY_ar=        [ddY_ar_AC           ddY_ar           ddY_ar_DC(1)];    
% 
%     Z_ar=          [Z_ar_AC             Z_ar             Z_ar_DC(1)];      
%     dZ_ar=         [dZ_ar_AC            dZ_ar            dZ_ar_DC(1)];       
%     ddZ_ar=        [ddZ_ar_AC           ddZ_ar           ddZ_ar_DC(1)];
%     
%     % Right Foot
%     Time_fr=       [Time_fr_AC          Time_fr          Time_fr_DC(1)];
%     Alpha_fr=      [Alpha_fr_AC         Alpha_fr         Alpha_fr_DC(1)];      
%     dAlpha_fr=     [dAlpha_fr_AC        dAlpha_fr        dAlpha_fr_DC(1)];       
%     ddAlpha_fr=    [ddAlpha_fr_AC       ddAlpha_fr       ddAlpha_fr_DC(1)];
% 
%     Beta_fr=       [Beta_fr_AC          Beta_fr          Beta_fr_DC(1)];      
%     dBeta_fr=      [dBeta_fr_AC         dBeta_fr         dBeta_fr_DC(1)];       
%     ddBeta_fr=     [ddBeta_fr_AC        ddBeta_fr        ddBeta_fr_DC(1)];    
% 
%     Gamma_fr=      [Gamma_fr_AC         Gamma_fr         Gamma_fr_DC(1)];      
%     dGamma_fr=     [dGamma_fr_AC        dGamma_fr        dGamma_fr_DC(1)];       
%     ddGamma_fr=    [ddGamma_fr_AC       ddGamma_fr       ddGamma_fr_DC(1)];
%     
%     % Left Ankle
%     Time_al=       [Time_al_AC          Time_al          Time_al_DC(1)];
%     X_al=          [X_al_AC             X_al             X_al_DC(1)];      
%     dX_al=         [dX_al_AC            dX_al            dX_al_DC(1)];       
%     ddX_al=        [ddX_al_AC           ddX_al           ddX_al_DC(1)];
% 
%     Y_al=          [Y_al_AC             Y_al             Y_al_DC(1)];      
%     dY_al=         [dY_al_AC            dY_al            dY_al_DC(1)];       
%     ddY_al=        [ddY_al_AC           ddY_al           ddY_al_DC(1)];    
% 
%     Z_al=          [Z_al_AC             Z_al             Z_al_DC(1)];      
%     dZ_al=         [dZ_al_AC            dZ_al            dZ_al_DC(1)];       
%     ddZ_al=        [ddZ_al_AC           ddZ_al           ddZ_al_DC(1)];
%     
%     % Left Foot
%     Time_fl=       [Time_fl_AC          Time_fl          Time_fl_DC(1)];
%     Alpha_fl=      [Alpha_fl_AC         Alpha_fl         Alpha_fl_DC(1)];      
%     dAlpha_fl=     [dAlpha_fl_AC        dAlpha_fl        dAlpha_fl_DC(1)];       
%     ddAlpha_fl=    [ddAlpha_fl_AC       ddAlpha_fl       ddAlpha_fl_DC(1)];
% 
%     Beta_fl=       [Beta_fl_AC          Beta_fl          Beta_fl_DC(1)];      
%     dBeta_fl=      [dBeta_fl_AC         dBeta_fl         dBeta_fl_DC(1)];       
%     ddBeta_fl=     [ddBeta_fl_AC        ddBeta_fl        ddBeta_fl_DC(1)];    
% 
%     Gamma_fl=      [Gamma_fl_AC         Gamma_fl         Gamma_fl_DC(1)];      
%     dGamma_fl=     [dGamma_fl_AC        dGamma_fl        dGamma_fl_DC(1)];       
%     ddGamma_fl=    [ddGamma_fl_AC       ddGamma_fl       ddGamma_fl_DC(1)];
%     
%     % pelvis
%     Time_p_i=      [Time_p_i_AC         Time_p_i         Time_p_i_DC(1)];
%     X_p=           [X_p_AC              X_p              X_p_DC(1)];
%     dX_p=          [dX_p_AC             dX_p             dX_p_DC(1)];
%     ddX_p=         [ddX_p_AC            ddX_p            ddX_p_DC(1)];
%     
%     Time_p_ii=     [Time_p_ii_AC        Time_p_ii        Time_p_ii_DC(1)];
%     Y_p=           [Y_p_AC              Y_p              Y_p_DC(1)];
%     dY_p=          [dY_p_AC             dY_p             dY_p_DC(1)];
%     ddY_p=         [ddY_p_AC            ddY_p            ddY_p_DC(1)];
%     
%     Time_p_iii=    [Time_p_iii_AC       Time_p_iii       Time_p_iii_DC(1)];
%     Z_p=           [Z_p_AC              Z_p              Z_p_DC(1)];
%     dZ_p=          [dZ_p_AC             dZ_p             dZ_p_DC(1)];
%     ddZ_p=         [ddZ_p_AC            ddZ_p            ddZ_p_DC(1)];
%     
%     Time_p_iv=     [Time_p_iv_AC        Time_p_iv        Time_p_iv_DC(1)];
%     Alpha_p=       [Alpha_p_AC          Alpha_p          Alpha_p_DC(1)];
%     dAlpha_p=      [dAlpha_p_AC         dAlpha_p         dAlpha_p_DC(1)];
%     ddAlpha_p=     [ddAlpha_p_AC        ddAlpha_p        ddAlpha_p_DC(1)];
%     
%     Beta_p=        [Beta_p_AC           Beta_p           Beta_p_DC(1)];
%     dBeta_p=       [dBeta_p_AC          dBeta_p          dBeta_p_DC(1)];
%     ddBeta_p=      [ddBeta_p_AC         ddBeta_p         ddBeta_p_DC(1)];
%         
%     Gamma_p=       [Gamma_p_AC          Gamma_p          Gamma_p_DC(1)];
%     dGamma_p=      [dGamma_p_AC         dGamma_p         dGamma_p_DC(1)];
%     ddGamma_p=     [ddGamma_p_AC        ddGamma_p        ddGamma_p_DC(1)];
%     
% elseif and(T_ac==0, T_dc~=0)
%     % Right Ankle
%     Time_ar=       [Time_ar          Time_ar_DC];
%     X_ar=          [X_ar             X_ar_DC];      
%     dX_ar=         [dX_ar            dX_ar_DC];       
%     ddX_ar=        [ddX_ar           ddX_ar_DC];
% 
%     Y_ar=          [Y_ar             Y_ar_DC];      
%     dY_ar=         [dY_ar            dY_ar_DC];       
%     ddY_ar=        [ddY_ar           ddY_ar_DC];    
% 
%     Z_ar=          [Z_ar             Z_ar_DC];      
%     dZ_ar=         [dZ_ar            dZ_ar_DC];       
%     ddZ_ar=        [ddZ_ar           ddZ_ar_DC];
%     
%     % Right Foot
%     Time_fr=       [Time_fr          Time_fr_DC];
%     Alpha_fr=      [Alpha_fr         Alpha_fr_DC];      
%     dAlpha_fr=     [dAlpha_fr        dAlpha_fr_DC];       
%     ddAlpha_fr=    [ddAlpha_fr       ddAlpha_fr_DC];
% 
%     Beta_fr=       [Beta_fr          Beta_fr_DC];      
%     dBeta_fr=      [dBeta_fr         dBeta_fr_DC];       
%     ddBeta_fr=     [ddBeta_fr        ddBeta_fr_DC];    
% 
%     Gamma_fr=      [Gamma_fr         Gamma_fr_DC];      
%     dGamma_fr=     [dGamma_fr        dGamma_fr_DC];       
%     ddGamma_fr=    [ddGamma_fr       ddGamma_fr_DC];
%     
%     % Left Ankle
%     Time_al=       [Time_al          Time_al_DC];
%     X_al=          [X_al             X_al_DC];      
%     dX_al=         [dX_al            dX_al_DC];       
%     ddX_al=        [ddX_al           ddX_al_DC];
% 
%     Y_al=          [Y_al             Y_al_DC];      
%     dY_al=         [dY_al            dY_al_DC];       
%     ddY_al=        [ddY_al           ddY_al_DC];    
% 
%     Z_al=          [Z_al             Z_al_DC];      
%     dZ_al=         [dZ_al            dZ_al_DC];       
%     ddZ_al=        [ddZ_al           ddZ_al_DC];
%     
%     % Left Foot
%     Time_fl=       [Time_fl          Time_fl_DC];
%     Alpha_fl=      [Alpha_fl         Alpha_fl_DC];      
%     dAlpha_fl=     [dAlpha_fl        dAlpha_fl_DC];       
%     ddAlpha_fl=    [ddAlpha_fl       ddAlpha_fl_DC];
% 
%     Beta_fl=       [Beta_fl          Beta_fl_DC];      
%     dBeta_fl=      [dBeta_fl         dBeta_fl_DC];       
%     ddBeta_fl=     [ddBeta_fl        ddBeta_fl_DC];    
% 
%     Gamma_fl=      [Gamma_fl         Gamma_fl_DC];      
%     dGamma_fl=     [dGamma_fl        dGamma_fl_DC];       
%     ddGamma_fl=    [ddGamma_fl       ddGamma_fl_DC];
%     
%     % pelvis
%     Time_p_i=      [Time_p_i         Time_p_i_DC];
%     X_p=           [X_p              X_p_DC];
%     dX_p=          [dX_p             dX_p_DC];
%     ddX_p=         [ddX_p            ddX_p_DC];
%     
%     Time_p_ii=     [Time_p_ii        Time_p_ii_DC];
%     Y_p=           [Y_p              Y_p_DC];
%     dY_p=          [dY_p             dY_p_DC];
%     ddY_p=         [ddY_p            ddY_p_DC];
%     
%     Time_p_iii=    [Time_p_iii       Time_p_iii_DC];
%     Z_p=           [Z_p              Z_p_DC];
%     dZ_p=          [dZ_p             dZ_p_DC];
%     ddZ_p=         [ddZ_p            ddZ_p_DC];
% 
%     Time_p_iv=     [Time_p_iv        Time_p_iv_DC];
%     Alpha_p=       [Alpha_p          Alpha_p_DC];
%     dAlpha_p=      [dAlpha_p         dAlpha_p_DC];
%     ddAlpha_p=     [ddAlpha_p        ddAlpha_p_DC];
%     
%     Beta_p=        [Beta_p           Beta_p_DC];
%     dBeta_p=       [dBeta_p          dBeta_p_DC];
%     ddBeta_p=      [ddBeta_p         ddBeta_p_DC];
%         
%     Gamma_p=       [Gamma_p          Gamma_p_DC];
%     dGamma_p=      [dGamma_p         dGamma_p_DC];
%     ddGamma_p=     [ddGamma_p        ddGamma_p_DC];
%     
% elseif and(T_ac==0, T_dc==0)
    % Front Right Ankle
    Time_fr=       [Time_fr          Time_fr_DC(1)];
    X_fr=          [X_fr             X_fr_DC(1)];      
    dX_fr=         [dX_fr            dX_fr_DC(1)];       
    ddX_fr=        [ddX_fr           ddX_fr_DC(1)];

    Y_fr=          [Y_fr             Y_fr_DC(1)];      
    dY_fr=         [dY_fr            dY_fr_DC(1)];       
    ddY_fr=        [ddY_fr           ddY_fr_DC(1)];    

    Z_fr=          [Z_fr             Z_fr_DC(1)];      
    dZ_fr=         [dZ_fr            dZ_fr_DC(1)];       
    ddZ_fr=        [ddZ_fr           ddZ_fr_DC(1)];
    
    % Front Left Foot
    Time_fl=       [Time_fl          Time_fl_DC(1)];
    X_fl=          [X_fl         X_fl_DC(1)];      
    dX_fl=         [dX_fl        dX_fl_DC(1)];       
    ddX_fl=        [ddX_fl       ddX_fl_DC(1)];

    Y_fl=          [Y_fl          Y_fl_DC(1)];      
    dY_fl=         [dY_fl         dY_fl_DC(1)];       
    ddY_fl=        [ddY_fl        ddY_fl_DC(1)];    

    Z_fl=          [Z_fl         Z_fl_DC(1)];      
    dZ_fl=         [dZ_fl        dZ_fl_DC(1)];       
    ddZ_fl=        [ddZ_fl       ddZ_fl_DC(1)];
    
    % Hind Right Ankle
    Time_hr=       [Time_hr          Time_hr_DC(1)];
    X_hr=          [X_hr             X_hr_DC(1)];      
    dX_hr=         [dX_hr            dX_hr_DC(1)];       
    ddX_hr=        [ddX_hr           ddX_hr_DC(1)];

    Y_hr=          [Y_hr             Y_hr_DC(1)];      
    dY_hr=         [dY_hr            dY_hr_DC(1)];       
    ddY_hr=        [ddY_hr           ddY_hr_DC(1)];    

    Z_hr=          [Z_hr             Z_hr_DC(1)];      
    dZ_hr=         [dZ_hr            dZ_hr_DC(1)];       
    ddZ_hr=        [ddZ_hr           ddZ_hr_DC(1)];
    
    % Hind Left Foot
    Time_hl=       [Time_hl         Time_hl_DC(1)];
    X_hl=          [X_hl             X_hl_DC(1)];      
    dX_hl=         [dX_hl            dX_hl_DC(1)];       
    ddX_hl=        [ddX_hl           ddX_hl_DC(1)];

    Y_hl=          [Y_hl             Y_hl_DC(1)];      
    dY_hl=         [dY_hl            dY_hl_DC(1)];       
    ddY_hl=        [ddY_hl           ddY_hl_DC(1)];    

    Z_hl=          [Z_hl            Z_hl_DC(1)];      
    dZ_hl=         [dZ_hl            dZ_hl_DC(1)];       
    ddZ_hl=        [ddZ_hl           ddZ_hl_DC(1)];
    
    % pelvis
    Time_p_i=      [Time_p_i         Time_p_i_DC(1)];
    X_p=           [X_p              X_p_DC(1)];
    dX_p=          [dX_p             dX_p_DC(1)];
    ddX_p=         [ddX_p            ddX_p_DC(1)];
    
    Time_p_ii=     [Time_p_ii        Time_p_ii_DC(1)];
    Y_p=           [Y_p              Y_p_DC(1)];
    dY_p=          [dY_p             dY_p_DC(1)];
    ddY_p=         [ddY_p            ddY_p_DC(1)];
    
    Time_p_iii=    [Time_p_iii       Time_p_iii_DC(1)];
    Z_p=           [Z_p              Z_p_DC(1)];
    dZ_p=          [dZ_p             dZ_p_DC(1)];
    ddZ_p=         [ddZ_p            ddZ_p_DC(1)];    
    
    Time_p_iv=     [Time_p_iv        Time_p_iv_DC(1)];
    Alpha_p=       [Alpha_p          Alpha_p_DC(1)];
    dAlpha_p=      [dAlpha_p         dAlpha_p_DC(1)];
    ddAlpha_p=     [ddAlpha_p        ddAlpha_p_DC(1)];
    
    Beta_p=        [Beta_p           Beta_p_DC(1)];
    dBeta_p=       [dBeta_p          dBeta_p_DC(1)];
    ddBeta_p=      [ddBeta_p         ddBeta_p_DC(1)];
        
    Gamma_p=       [Gamma_p          Gamma_p_DC(1)];
    dGamma_p=      [dGamma_p         dGamma_p_DC(1)];
    ddGamma_p=     [ddGamma_p        ddGamma_p_DC(1)];
% end
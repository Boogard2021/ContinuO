global V Ds
global Sc Rse Rd Rm R_zp R_Td redundant
%% Flat
if redundant ==1
    if and(Ds==0.05,V==0.1)
        Sc=0.2581;     %0.8284;
        Rse=0.5004;           %2.9118;
        R_zp=0.95;         %0.873;
        R_Td=0.3991;        %0.3995;
    elseif  and(Ds==0.1,V==0.1)
        Sc=0.2583;  %0.2583
        Rse=0.5197;
        R_zp=0.6017;
        R_Td=0.3996;
    elseif  and(Ds==0.15,V==0.1)
        Sc=0.4228;
        Rse=0.8302;
        R_zp=0.6195;
        R_Td=0.3983;
    elseif and(Ds==0.2,V==0.1)
        Sc=0.3016;
        Rse=0.8466;
        R_zp=0.6274;
        R_Td=0.3846;
    elseif and(Ds==0.25,V==0.1)
        Sc=0.4161;
        Rse=2.0507;
        R_zp=0.6422;
        R_Td=0.3977;
        
    elseif and(Ds==0.05,V==0.2)
        Sc=0.2597;
        Rse=0.5030;
        R_zp=0.9499;
        R_Td=0.3987;
        
    elseif  and(Ds==0.1,V==0.2)
        Sc=0.3156;
        Rse=0.5029;
        R_zp=0.606;
        R_Td=0.3983;
    elseif and(Ds==0.15,V==0.2)
        Sc=0.2595;
        Rse=0.5519;
        R_zp=0.6117;
        R_Td=0.3994;
    elseif and(Ds==0.2,V==0.2)
        Sc=0.2318;
        Rse=1.6030;
        R_zp=0.9359;
        R_Td=0.3811;
    elseif and(Ds==0.25,V==0.2)
        Sc=0.7352;
        Rse=2.0105;
        R_zp=0.6372;
        R_Td=0.3904;
        
    elseif and(Ds==0.05,V==0.3)
        Sc=0.2593;
        Rse=0.5002;
        R_zp=0.9500;
        R_Td=0.3983;
        
    elseif  and(Ds==0.1,V==0.3)
        Sc=0.3951;
        Rse=1.0706;
        R_zp=0.6636;
        R_Td=0.3985;
    elseif and(Ds==0.15,V==0.3)
        Sc=0.2922;
        Rse=0.8771;
        R_zp=0.6429;
        R_Td=0.3983;
    elseif and(Ds==0.2,V==0.3)
        Sc=0.2578;
        Rse=0.5721;
        R_zp=0.6477;
        R_Td=0.3994;
    elseif and(Ds==0.25,V==0.3)
        Sc=0.6835;
        Rse=2.0291;
        R_zp=0.6723;
        R_Td=0.3927;
    elseif and(Ds==0.05,V==0.4)
        Sc=0.2909;
        Rse=0.5008;
        R_zp=0.9500;
        R_Td=0.3691;
        
    elseif  and(Ds==0.1,V==0.4)
        Sc=0.2606;
        Rse=2.9997;
        R_zp=0.9500;
        R_Td=0.4000;
    elseif  and(Ds==0.15,V==0.4)
        Sc=0.3550;
        Rse=1.6026;
        R_zp=0.6858;
        R_Td=0.3996;
    elseif and(Ds==0.2,V==0.4)
        Sc=0.2578;
        Rse=0.5721;
        R_zp=0.6477;
        R_Td=0.3994;
    elseif and(Ds==0.25,V==0.4)
        Sc= 0.6968;
        Rse= 2.7594;
        R_zp=0.7056;
        R_Td=0.3973;
    end
else
    if and(Ds==0.05,V==0.1)
        Sc=0.7825;     %0.8284;
        Rse=0.5224;           %2.9118;
        R_zp=0.873;         %0.873;
        R_Td=0.3947;        %0.3995;
        
    elseif  and(Ds==0.1,V==0.1)
        Sc=0;  %0.417
        Rse=0.559;
        R_zp=0.873;
        R_Td=0.3895;
    elseif  and(Ds==0.15,V==0.1)
        Sc=0.3261;
        Rse=0.8302;
        R_zp=0.8619;
        R_Td=0.3983;
    elseif and(Ds==0.2,V==0.1)
        Sc=0.652;
        Rse=1.8156;
        R_zp=0.7512;  %0.9461;
        R_Td=0.392;
    elseif and(Ds==0.25,V==0.1)
        Sc=0.4302;
        Rse=0.6789;
        R_zp=0.6512;   %0.8058;
        R_Td=0.2487;
        
    elseif and(Ds==0.05,V==0.2)
        Sc=0.8921;
        Rse=0.5006;
        R_zp=0.9485;
        R_Td=0.3982;
        
        
    elseif  and(Ds==0.1,V==0.2)
        
        Sc=0.398;
        Rse=0.7473;
        R_zp=0.9362;
        R_Td=0.3852;
    elseif  and(Ds==0.15,V==0.2)
        Sc=0.2953;
        Rse=1.0592;
        R_zp=0.9004;
        R_Td=0.3983;
    elseif and(Ds==0.2,V==0.2)
        Sc=0.2525;
        Rse=1.3499;
        R_zp=0.6512;
        R_Td=0.1394;
    elseif and(Ds==0.25,V==0.2)
        Sc=0.6789;
        Rse=1.9173;
        R_zp=0.8317;
        R_Td=0.1186;
        
    elseif and(Ds==0.05,V==0.3)
        Sc=0.7264;
        Rse=0.5044;
        R_zp=0.9476;
        R_Td=0.3957;
    elseif  and(Ds==0.1,V==0.3)
        Sc=0.352;
        Rse=0.5303;
        R_zp=0.9493;
        R_Td=0.3990;
    elseif and(Ds==0.15,V==0.3)
        Sc=0.2812;
        Rse=0.6338;
        R_zp=0.7493;
        R_Td=0.399;
    elseif and(Ds==0.2,V==0.3)
        Sc=0.4188;
        Rse=2.716;
        R_zp=0.8191;
        R_Td=0.398;
    elseif and(Ds==0.25,V==0.3)
        Sc=0.2694;
        Rse=2.3256;
        R_zp=0.6731;
        R_Td=0.3881;
    elseif and(Ds==0.05,V==0.4)
        Sc=0.3387;
        Rse=0.5009;
        R_zp=0.9500;
        R_Td=0.4000;
    elseif  and(Ds==0.1,V==0.4)
        Sc=0.4674;
        Rse=0.5224;
        R_zp=0.9494;
        R_Td=0.3990;
    elseif  and(Ds==0.15,V==0.4)
        Sc=0.3389;
        Rse=0.7309;
        R_zp=0.7591;
        R_Td=0.3993;
    elseif and(Ds==0.2,V==0.4)
        Sc=0.5820;
        Rse=1.3069;
        R_zp=0.9183;
        R_Td=0.4000;
    elseif and(Ds==0.25,V==0.4)
        Sc= 0.5728;
        Rse= 2.6169;
        R_zp=0.7773;
        R_Td=0.3995;
    end
end

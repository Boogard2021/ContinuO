clear all
clc
close all
warning('off','all')
% 
V= [0.1 0.2 0.3 0.4];  % x axis
Ds = [0.05 0.1 0.15 0.2 0.25];  % y axis
[X,Y] = meshgrid(V,Ds);

Energy=[  149.5571,  223.4926,348.3995 ,  485.5972,975.0589 ;
          146.5599,  219.9402,325.9628 , 1.0209e+03,743.3342 ;
          155.6008, 216.7878,382.0920  , 483.3035,987.5720; 
          180.3935,208.6070 ,340.0426 , 399.3503 ,692.2930];

Energy_redundant=[216.0939,  597.1899, 793.0791 ,1.1575e+03,1.5522e+03;
      217.3690,  596.5062, 854.3857 ,   1.0820e+03, 1.3568e+03;
      232.2267,  525.9682,804.3352 ,   1.1967e+03, 1.3796e+03;
      243.9703, 372.8074 ,751.6487 , 1.1925e+03 ,1.2913e+03 ];

surface(X,Y,Energy')
colormap cool
view([90 0]);
% view(3)

% surface(X,Y,Energy_redundant')
% view([90 0]);
% % view(3)
% colormap cool
xlabel('V(m/s)');
ylabel('Stride Length(m)');
zlabel('Total Power Consumption (Watt)');

%%
% V = 0.1, Ds = 0.1
% X1 = ['Shoulder_fr','Hip_fr','Knee_fr']; %,'Shoulder_hr','Hip_hr','Knee_hr1','Knee_hr2'
% X1 = [1 2 3 ]; %4 5 6 7
% Power=[0.0003,149.7766,68.4848]; %,0.0005,0,173.4305,142.4376
% Power_redundant=[0.0005,121.1428,89.3613]; %,0.0007,246.1010,290.0217,63.8408
% y= [Power;Power_redundant];
% bar(X1,y)
% %%
% % %%
% % V = 0.1, Ds = 0.05
% %redundant
% Total_Power_fr =0.0001   15.7080   21.1133
% Total_Power_hr =0.0001   17.9132   43.7278   10.9667
% %unredundant
% Total_Power_fr =0.0001   14.8226   15.2603
% Total_Power_hr =0.0001         0   24.0685   19.9452
% %%
% % V = 0.1, Ds = 0.1
% %redundant
% Total_Power_fr =0.0002   49.3246   31.5042
% Total_Power_hr =0.0003   93.8264  104.8865   25.3618
%  %unredundant
% Total_Power_fr =0.0001   25.2672   18.5104
% Total_Power_hr =0.0001         0   52.4374   23.7752
% 
% %%
% % V = 0.1, Ds = 0.2
% %redundant
% Total_Power_fr =0.0002  102.8312   68.554
% Total_Power_hr =0.0003  242.6156  244.5411   26.6781
% %unredundant
% Total_Power_fr =0.0001   69.5723   26.7815
% Total_Power_hr =0.0002         0   91.9301   82.4421
% 
% %%
% % V = 0.2, Ds = 0.05
% %redundant
% Total_Power_fr =0.0001   13.8649   20.2823
% Total_Power_hr =0.0001   20.6580   45.7633   12.5052
% %unredundant
% Total_Power_fr =0.0001   13.2098   13.9706
% Total_Power_hr =0.0001         0   23.1155   23.1355
% %%
% % V = 0.2, Ds = 0.1
% %redundant
% Total_Power_fr =0.0002   45.4723   29.2181
% Total_Power_hr =0.0003   90.8799  103.7263   23.5872
% %unredundant
% Total_Power_fr =0.0001   26.3652   17.4795
% Total_Power_hr =0.0001         0   47.5277   26.0136
% %%
% % V = 0.2, Ds = 0.2
% %redundant
% Total_Power_fr =0.0001   66.4372   59.8641
% Total_Power_hr =0.0001  247.9605  255.3471   25.6877
% %unredundant
% 
% Total_Power_fr =0.0002  140.7652   70.8932
% Total_Power_hr =0.0003         0  163.1733  140.6294
% %%
% % V = 0.3, Ds = 0.05
% %redundant
% Total_Power_fr =0.0001   14.1684   19.6108
% Total_Power_hr =0.0001   25.6724   45.4641   15.7918
% %unredundant
% Total_Power_fr =0.0001   13.1689   13.9648
% Total_Power_hr =0.0001         0   24.1465   28.9563
% %%
% % V = 0.3, Ds = 0.1
% %redundant
% Total_Power_fr =0.0002   36.9107   24.5953
% Total_Power_hr =0.0002   89.1249  100.8264   23.3506
% %unredundant
% Total_Power_fr =0.0001   24.0983   17.3687
% Total_Power_hr =0.0001         0   49.6621   27.2774
% %%
% % V = 0.3, Ds = 0.2
% %redundant
% Total_Power_fr =0.0002   96.1206   68.6561
% Total_Power_hr =0.0003  237.9392  252.9770   28.4635
% %unredundant
% Total_Power_fr =0.0001   68.2372   37.8383
% Total_Power_hr =0.0002         0   85.6363   63.3569
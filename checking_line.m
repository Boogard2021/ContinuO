clear all
close all


a =[1 1];
b =[-1 -1];

coefficients = polyfit([a(1), b(1)], [a(2), b(2)], 1); % y= a*x +b
coef1 = coefficients(1);
coef2 = coefficients(2);

plot([ankle_fl_x(n1),ankle_hr_x(n1)],[ankle_fl_y(n1),ankle_hr_y(n1)],'g','LineWidth',2);
hold on
plot([ankle_fl_x(n1),ankle_hr_x(n1)],[ankle_fl_y(n1),ankle_hr_y(n1)],'r','LineWidth',2);

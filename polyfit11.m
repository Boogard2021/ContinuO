clear all
clc
close all
x = [1 2];
y = [5 4];
coefficients = polyfit([x(1), x(2)], [y(1), y(2)], 1);
a = coefficients (1);
b = coefficients (2);
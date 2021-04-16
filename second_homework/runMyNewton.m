clear; clc; close all;

[xZero, abortFlagg, iters] = myNewton('Function',@myPoly,'LivePlot','on');
                                    

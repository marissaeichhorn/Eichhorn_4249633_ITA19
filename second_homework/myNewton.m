function [xZero, abortFlagg, iters] = myNewton(varargin)

%Variablen aus runMyNewton holen
for i = 1:nargin
    if strcmp(varargin{i}, 'Function')
        func = varargin{i+1};
    elseif strcmp(varargin{i}, 'Derivative')
        dfunc = varargin{i+1};
    elseif strcmp(varargin{i}, 'StartValue')
        x0 = varargin{i+1};   
    elseif strcmp(varargin{i}, 'MaxIter')
        maxIter = varargin{i+1};  
    elseif strcmp(varargin{i}, 'Feps')
        feps = varargin{i+1};
    elseif strcmp(varargin{i}, 'Xeps')
        xeps = varargin{i+1};
    elseif strcmp(varargin{i}, 'LivePlot')
        livePlot = varargin{i+1};
    end
end

%notwendige Variable enthalten?
if ~exist('func', 'var')
    error('No valid function!');  
end

%Dummy-Werte für zusätzliche Kriterien, falls leer
if ~exist('x0', 'var')
    x0 = 0;
    disp(['Using default startvalue: x0 = ', num2str(x0)]);
end
if ~exist('maxIter', 'var')
    maxIter = 50;
    disp(['Using default maximum iterations: maxIter = ', num2str(maxIter)]);
end
if ~exist('feps', 'var')
    feps = 1e-6;
    disp(['Using default feps: feps = ', num2str(feps)]);
end
if ~exist('xeps', 'var')
    xeps = 1e-6;
    disp(['Using default xeps: xeps = ', num2str(xeps)]);
end
if ~exist('livePlot', 'var')
    livePlot = 'off';
    disp(['Using default live Plot: livePlot = ', 'off']);
end

%Berechenoptionen Derivative, falls leer
if ~exist('dfunc', 'var')
    answer = questdlg('Which differentiation method do you want to use?', ...
        'calculation of derivative', ...
        'forward differences', 'backward differences', 'central differences', 'central differences');
    switch answer
        case 'forward differences'
            disp([answer ' - You have decided on forward differences.'])
            dfunc = @numDiffF;
        case 'backward differences'
            disp([answer ' - You have decided on backward differences.'])
            dfunc = @numDiffB;
        case 'central differences'
            disp([answer ' - You have decided on central differences.'])
            dfunc = @numDiffC;
    end
end

%Plot definieren
if strcmp(livePlot, 'on')
    h = figure('Name', 'Newton Visualisation');
    ax1 = subplot(2,1,1);
    plot (ax1,0,x0,'bo');
    ylabel('xValue');
    hold on;
    grid on;
    xlim('auto')
    ylim('auto')
    ax2 = subplot(2,1,2);
    semilogy(ax2,0,func(x0),'rx');
    ylabel('Function value');
    xlabel('Number of iterations');
    hold on;
    grid on;
    xlim('auto')
    ylim('auto')
end

xOld = x0;
abortFlagg = 'maxIter'; %als Standardabbruchkriterium, außer Anderes trifft zu

for i = 1:maxIter
    f = func(xOld);
    
    %Abbruchkriterium B
     if f < feps
        abortFlagg = 'feps';
        break;
    end
    
    df = dfunc(xOld); %Ableitung bilden
    
    %Abbruchkriterium D (wenn Ableitung = 0)
    if df == 0
        abortFlagg = 'df = 0';
        break;
    end
    
    xNew = xOld - f/df; %allgem. Iterationsvorschrift
    
    %Abbruchkriterium C
    if abs(xNew-xOld) < xeps
        abortFlagg = 'xeps';
        break;
    end
    
    xOld = xNew; %x-Wert für wiederholten Schleifendurchlauf festlegen
    
    %Plot jeweilige x-Werte & Funktionswerte
    if strcmp(livePlot,'on')
        plot(ax1,i,xNew,'bo');
        semilogy(ax2,i,func(xNew),'rx');
        pause(0.05);
    end
end

iters = i; %Anzahl der Iterationen
xZero = xNew; %Ergebnis
end
     

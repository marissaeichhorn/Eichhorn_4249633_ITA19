classdef LinearRegressionModel < matlab.mixin.SetGet
    %LINEARREGRESSIONMODEL 
    % Class representing an implementation of linear regression model
    
    properties (Access = public)
        optimizer
        trainingData
        theta
        thetaOptimum
    end
    
    methods (Access = public)
        function obj = LinearRegressionModel(varargin)
            %LINEARREGRESSIONMODEL Construct an instance of this class
            
            % ========= YOUR CODE HERE =========
            
            % perform the varargin
            % runSkript: 'Data',dataForLinearRegression,'Optimizer',gradientDescentOptimizer   
            for i = 1:length(varargin)
                if strcmp(varargin{i}, 'Data')
                    obj.trainingData = varargin{i+1};
                elseif strcmp(varargin{i}, 'Optimizer')
                    obj.optimizer = varargin{i+1};
                end
            end
            
            % ========= YOUR CODE END ========= 
            
            obj.initializeTheta();
        end
        
        function J = costFunction(obj)
            m = obj.trainingData.numOfSamples; 
            
            % ========= YOUR CODE HERE =========
            
            % compute the costs
            % number of examples = 98
            % therefore use the hypothesis function as well
            % this calculation can be done by one line of code
            % returns the cost value J - auto 
            J = 1/(2*m)*sum((hypothesis(obj)-obj.trainingData.commandVar).^2); 
            
            % ========= YOUR CODE END ========= 
            
        end
        
        function hValue = hypothesis(obj)
            X = [ones(obj.trainingData.numOfSamples,1) obj.trainingData.feature];
            
            % ========= YOUR CODE HERE =========
            
            % compute the hypothesis values for each sample
            % therefore compute the matrix multiplication with X
            % this calculation can be done by one line of code    
            
            hValue = X*obj.theta; 
            % ========= YOUR CODE END ========= 
            
        end
        
        function h = showOptimumInContour(obj)
            h = figure('Name','Optimum');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            
            %all vector couples
            costs = zeros(100,100); % hard coded limits
            
            for t1 = 1:100
                for t2 = 1:100
                    
                    % compute the costs for each theta_vals tuple 
                    obj.setTheta(theta0_vals(t1), theta1_vals(t2));
                    costs(t1, t2) = obj.costFunction();
                end
            end 
            
            % plot the costs with the contour command
            contour(theta0_vals, theta1_vals, costs);
            
            %couple plots
            hold on 
           
            % add x and y label
            xlabel('\theta_0');
            ylabel('\theta_1');
            
            % add the optimum theta value to the plot (red X, MarkerSize: 10, LineWidth: 2)
            plot(obj.thetaOptimum(1), obj.thetaOptimum(2), 'xr', 'MarkerSize', 10, 'LineWidth', 2)
            
            % ========= YOUR CODE END ========= 
            
        end
        
        function h = showCostFunctionArea(obj)
            h = figure('Name','Cost Function Area');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            
            % ========= YOUR CODE HERE =========
            
           costs = zeros(100,100);
            
            for t1 = 1:100
                for t2 = 1:100
                    
                    % compute the costs for each theta_vals tuple 
                    obj.setTheta(theta0_vals(t1), theta1_vals(t2));
                    costs(t2, t1) = obj.costFunction();
                end
            end 
            
            % plot the costs with the surf command
            surf(theta0_vals, theta1_vals, costs);
            
            %couple plots
            hold on 
            
            % add x and y label
            xlabel('\theta_0');
            ylabel('\theta_1');
            
            % ========= YOUR CODE END ========= 
            
        end
        
        function h = showTrainingData(obj)
           h = figure('Name','Linear Regression Model');
           plot(obj.trainingData.feature,obj.trainingData.commandVar,'rx')
           grid on;
           xlabel(obj.trainingData.featureName + " in Kelvin");
           ylabel(obj.trainingData.commandVarName + " in Kelvin");
           legend('Training Data')
        end
        
        function h = showModel(obj)
           h = obj.showTrainingData();
           
           % ========= YOUR CODE HERE =========
           
           %couple plots
           hold on 
           
           % add the final trained model plot to the figure ('b-')
           % plot(obj.LinearRegressionModel,'b-')
           
           % update the legend
           legend('Training Data','Linear Regression Model')
           
           % ========= YOUR CODE END ========= 
           
        end
        
        function setTheta(obj,theta0,theta1)
            obj.theta = [theta0;theta1];
        end
        
        function setThetaOptimum(obj,theta0,theta1)
            obj.thetaOptimum = [theta0;theta1];
        end
    end
    
    methods (Access = private)
        
        function initializeTheta(obj)
            obj.setTheta(0,0);
        end
   
    end
end



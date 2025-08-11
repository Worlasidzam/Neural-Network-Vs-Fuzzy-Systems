function fuzzyController
    clear all; close all; clc;

    % input range
    nnp = 40;  
    x = 4/nnp * (0:nnp);
    y = 4/nnp * (0:nnp);

    % Output levels corresponding to: Very Low, Low, Normal, High
    oo = [0.5, 1.5, 2.5, 3.5];  % crisp singleton values
    no = length(oo);

    % Define triangular MF breakpoints for inputs (5 MFs)
    pp1 = [0, 1, 2, 3, 4];  % for inp1
    pp2 = [0, 1, 2, 3, 4];  % for inp2
    np1 = length(pp1);
    np2 = length(pp2);

    % Rule base for the quantized training data
    ruleLabels = [ ...
        1 1 1 1 1;  % inp1 = 0
        1 1 2 2 1;  % inp1 = 1
        1 2 3 3 2;  % inp1 = 2
        1 3 4 4 3;  % inp1 = 3
        2 3 4 4 3]; % inp1 = 4

    % Compute fuzzy output surface
    for knt = 1:length(x)
        for cnt = 1:length(y)
            y1 = fuzzif(x(knt), pp1);
            y2 = fuzzif(y(cnt), pp2);

            for i = 1:np1
                for j = 1:np2
                    r(j, i) = min([y1(i), y2(j)]);  % use MIN
                end
            end

            o = zeros(1, no);
            for i = 1:np1
                for j = 1:np2
                    ruleID = ruleLabels(i, j);  
                    o(ruleID) = max(o(ruleID), r(j, i));  % MAX aggregation
                end
            end

            denominator = sum(o);
            s = 0;
            for i = 1:no
                s = s + oo(i) * o(i);
            end
            out(cnt, knt) = s / denominator;
        end
    end

    % Plot result
    [X, Y] = meshgrid(x, y);
    figure; mesh(X, Y, out);
    xlabel('inp1'); ylabel('inp2'); zlabel('Output');
    title('Fuzzy Controller Output Surface (Mamdani)');

    
    % Mean Squared Error computation using training samples
    approxZ = zeros(5,5);
    targetZ = zeros(5,5);

    for i = 1:5
        for j = 1:5
            inp1 = pp1(j);   
            inp2 = pp2(i);   

            
            targetZ(i,j) = oo(ruleLabels(i,j));

            % Fuzzification
            y1 = fuzzif(inp1, pp1);
            y2 = fuzzif(inp2, pp2);

            
            for a = 1:np1
                for b = 1:np2
                    r2(b, a) = min([y1(a), y2(b)]);
                end
            end

            o2 = zeros(1, no);
            for a = 1:np1
                for b = 1:np2
                    ruleID = ruleLabels(a, b);
                    o2(ruleID) = max(o2(ruleID), r2(b, a));
                end
            end

            % Defuzzification
            s = 0;
            for a = 1:no
                s = s + oo(a) * o2(a);
            end
            denominator = sum(o2);
            approxZ(i,j) = s / denominator;
        end
    end

    %display Mean Squared Error
    mse = mean((approxZ(:) - targetZ(:)).^2);
    fprintf('Mean Squared Error on Training Points: %.6f\n', mse);
end

%
function [y] = fuzzif(x, pp)
    nl = length(pp);
    y = zeros(1, nl);
    for i = 1:nl
        if i == 1
            if x <= pp(i), y(i) = 1; end
            if x > pp(i) && x < pp(i+1)
                y(i) = (pp(i+1) - x) / (pp(i+1) - pp(i));
            end
        elseif i == nl
            if x >= pp(i), y(i) = 1; end
            if x < pp(i) && x > pp(i-1)
                y(i) = (x - pp(i-1)) / (pp(i) - pp(i-1));
            end
        else
            if x >= pp(i-1) && x <= pp(i)
                y(i) = (x - pp(i-1)) / (pp(i) - pp(i-1));
            elseif x > pp(i) && x <= pp(i+1)
                y(i) = (pp(i+1) - x) / (pp(i+1) - pp(i));
            else
                y(i) = 0;
            end
        end
    end
end

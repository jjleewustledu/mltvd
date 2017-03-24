classdef Test_TvdIp < matlab.unittest.TestCase 
	%% TEST_TVDIP  

	%  Usage:  >> results = run(mltvd_unittest.Test_TvdIp)
 	%          >> result  = run(mltvd_unittest.Test_TvdIp, 'test_dt')
 	%  See also:  file:///Applications/Developer/MATLAB_R2014b.app/help/matlab/matlab-unit-test-framework.html

	%  $Revision$ 
 	%  was created $Date$ 
 	%  by $Author$,  
 	%  last modified $LastChangedDate$ 
 	%  and checked into repository $URL$,  
 	%  developed on Matlab 8.5.0.197613 (R2015a) 
 	%  $Id$ 

	properties 
 		testObj 
 	end 

    methods (Test)
        function test_tvdip(this)
            % Demo of use of TVDIP - total variation denoising algorithm
            % clear all;
            
            % Generate test signal: piecewise smooth with noise corruption
            y = [1.5*ones(10000,1); -0.7*ones(2000,1); 1.3*ones(100,1); -0.3*ones(5000,1)];
            N = length(y);
            y = y + 0.5*randn(N,1);
            
            % Find the value of lambda greater than which the TVD solution is just the
            % mean
            lmax = this.testObj.tvdiplmax(y);
            
            % Perform TV denoising for lambda across a range of values up to a small
            % fraction of the maximum found above
            lratio = [1e-4 1e-3 1e-2 1e-1];
            L = length(lratio);
            [x, E, status] = this.testObj.tvdip(y,lmax*lratio,1,1e-3,100); %#ok<ASGLU>
            
            % Plots - display original test signal y, and TVD results
            close all;
            figure;
            for l = 1:L
                subplot(L,1,l);
                hold on;
                plot(y,'-','Color',0.8*[1 1 1]);
                plot(x(:,l),'k-');
                axis tight;
                title(sprintf('\\lambda=%5.2e, \\lambda/\\lambda_{max}=%5.2e',lmax*lratio(l),lratio(l)));
            end
            xlabel('n');
            legend({'Input y_n','TVD x_n'});            
        end
 	end 

 	methods (TestClassSetup) 
 		function setupTvdIp(this) 
 			this.testObj = mltvd.TvdIp; 
 		end 
 	end 

 	methods (TestClassTeardown) 
 	end 

	%  Created with Newcl by John J. Lee after newfcn by Frank Gonzalez-Morphy 
 end 


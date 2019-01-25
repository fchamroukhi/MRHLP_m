% Segmentation of multivariate time series with a Multiple Regression
% model with a Hidden Logistic Process (MRHLP).
%
%% Please cite the following papers for this code:
%
% @article{Chamroukhi-MRHLP-2013,
% 	Author = {F. Chamroukhi and D. Trabelsi and S. Mohammed and L. Oukhellou and Y. Amirat},
% 	Journal = {Neurocomputing},
% 	Month = {November},
% 	Pages = {633--644},
% 	Publisher = {Elsevier},
% 	Title = {Joint segmentation of multivariate time series with hidden process regression for human activity recognition},
% 	Volume = {120},
% 	Year = {2013},
% 	note = {},
% 	url  = {https://chamroukhi.com/papers/chamroukhi_et_al_neucomp2013b.pdf}
% 	}
% 
% @article{Chamroukhi-FDA-2018,
%  	Journal = {Wiley Interdisciplinary Reviews: Data Mining and Knowledge Discovery},
%  	Author = {Faicel Chamroukhi and Hien D. Nguyen},
%  	Note = {DOI: 10.1002/widm.1298.},
%  	Volume = {},
%  	Title = {Model-Based Clustering and Classification of Functional Data},
%  	Year = {2019},
%  	Month = {to appear},
%  	url =  {https://chamroukhi.com/papers/MBCC-FDA.pdf}
%     }
% 
% @article{chamroukhi_et_al_NN2009,
% 	Address = {Oxford, UK, UK},
% 	Author = {Chamroukhi, F. and Sam\'{e}, A. and Govaert, G. and Aknin, P.},
% 	Date-Added = {2014-10-22 20:08:41 +0000},
% 	Date-Modified = {2014-10-22 20:08:41 +0000},
% 	Journal = {Neural Networks},
% 	Number = {5-6},
% 	Pages = {593--602},
% 	Publisher = {Elsevier Science Ltd.},
% 	Title = {Time series modeling by a regression approach based on a latent process},
% 	Volume = {22},
% 	Year = {2009},
% 	url  = {https://chamroukhi.users.lmno.cnrs.fr/papers/Chamroukhi_Neural_Networks_2009.pdf}
% 	}
% 
%
%
% by Faicel Chamroukhi (2011)


%%

clear;
close all;
clc;


% model specification
K = 5; % nomber of regimes (mixture components)
p = 3; % dimension of beta' (order of the polynomial regressors)
q = 1; % dimension of w (ordre of the logistic regression: to be set to 1 for segmentation)

% options
%type_variance = 'homoskedastic';
type_variance = 'hetereskedastic';
nbr_EM_tries = 2;
max_iter_EM = 1500;
threshold = 1e-6;
verbose_EM = 1;
verbose_IRLS = 0;


%% toy multivariate time series with regime changes
% y = [[randn(100,1); 7+randn(120,1);4+randn(200,1); -1+randn(100,1); 3.5+randn(150,1)] ...
%     [1+randn(100,1); 5+randn(120,1);6+randn(200,1); -2+randn(100,1); 2+randn(150,1)] ...
%     [-2+randn(100,1); 10+randn(120,1);8+randn(200,1); randn(100,1); 5+randn(150,1)]]
% n = length(y);
% x = linspace(0,1,n);
% 

load simulated_time_series;
y = [randn(100,1); 7+randn(120,1);4+randn(200,1); -1+randn(100,1); 3.5+randn(150,1)];
    
mrhlp =  learn_MRHLP_EM(x, y, K, p, q, ...
    type_variance,nbr_EM_tries, max_iter_EM, threshold, verbose_EM, verbose_IRLS);

show_MRHLP_results(x,y, mrhlp)
 

%% real multivariate time series with regime changes
% an example of human activity acceleration time series

load real_time_series;


mrhlp =  learn_MRHLP_EM(x, y, K, p, q,...
    type_variance,nbr_EM_tries, max_iter_EM, threshold, verbose_EM, verbose_IRLS);

show_MRHLP_results(x, y, mrhlp)






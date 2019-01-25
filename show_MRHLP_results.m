function show_MRHLP_results(x,y,mrhlp, yaxislim)
%

if size(x,1)~=1
    x = x'; %y=y';
end
set(0,'defaultaxesfontsize',14);
%colors = {'b','g','r','c','m','k','y'};
colors = {[0.8 0 0],[0 0 0.8],[0 0.8 0],'m','c','k','y',[0.8 0 0],[0 0 0.8],[0 0.8 0],'m','c','k','y',[0.8 0 0],[0 0 0.8],[0 0.8 0]};
style =  {'r.','b.','g.','m.','c.','k.','y.','r.','b.','g.','m.','c.','k.','y.','r.','b.','g.'};

if (nargin<4)||isempty(yaxislim)
    yaxislim = [min(min(y))-2*mean(std(y)), max(max(y))+2*mean(std(y))];
end

%% data, regressors, and segmentation

scrsz = get(0,'ScreenSize');
figr = figure('Position',[scrsz(4)/6 scrsz(4)/2 560 scrsz(4)/1.4]);
axes1 = axes('Parent',figr,'Position',[0.1 0.45 0.8 0.48],'FontSize',14);
box(axes1,'on'); hold(axes1,'all');
title('Time series, MRHLP regimes, and process probabilites')
plot(x,y,'Color',[0.5 0.5 0.5],'linewidth',1);%black')%
[~, K] = size(mrhlp.param.piik);
for k=1:K
    model_k = mrhlp.polynomials(:,:,k);
    
    active_model_k = model_k(mrhlp.klas==k,:);%prob_model_k >= prob);
    active_period_model_k = x(mrhlp.klas==k);%prob_model_k >= prob);
    
    inactive_model_k = model_k(mrhlp.klas ~= k,:);%prob_model_k >= prob);
    inactive_period_model_k = x(mrhlp.klas ~= k);%prob_model_k >= prob);
    if (~isempty(active_model_k))
        %hold on,
        %plot(inactive_period_model_k,inactive_model_k, [colors{k},':'], 'linewidth',0.001, 'markersize',1);
        hold on,
        plot(active_period_model_k, active_model_k,'Color', colors{k},'linewidth',1.5);
    end
end
ylabel('y');
ylim(yaxislim);
xlim([x(1), x(end)])

% Probablities of the hidden process (segmentation)
axes2 = axes('Parent',figr,'Position',[0.1 0.06 0.8 0.35],'FontSize',14);
box(axes2,'on'); hold(axes2,'all');
%subplot(212),
for k=1:K
    plot(x,mrhlp.param.piik(:,k),'Color', colors{k},'linewidth',1.5);
    hold on
end
set(gca,'ytick',[0:0.2:1]);
xlabel('t');
ylabel('Probability \pi_{k}(t,w)');
xlim([x(1), x(end)])

%% data, regression model, and segmentation
scrsz = get(0,'ScreenSize');
figr = figure('Position',[scrsz(4)/1.2 scrsz(4)/2 560 scrsz(4)/1.4]);
axes1 = axes('Parent',figr,'Position',[0.1 0.45 0.8 0.48],'FontSize',14);
box(axes1,'on'); hold(axes1,'all');
title('Time series, estimated MRHLP model, and segmentation')
ylabel('y');
plot(x,y,'Color',[0.5 0.5 0.8]);%black'%
hold on, plot(x,mrhlp.Ey,'r','linewidth',1.5);
xlim([x(1), x(end)])

% transition time points
tk = find(diff(mrhlp.klas)~=0);
hold on, plot([x(tk); x(tk)], [ones(length(tk),1)*[min(min(y))-2*mean(std(y)) max(max(y))+2*mean(std(y))]]','--','color','k','linewidth',1.5);
ylabel('y');
ylim(yaxislim);
xlim([x(1), x(end)])

% Probablities of the hidden process (segmentation)
axes2 = axes('Parent',figr,'Position',[0.1 0.06 0.8 0.35],'FontSize',14);
box(axes2,'on'); hold(axes2,'all');
plot(x,mrhlp.klas,'k.','linewidth',1.5);
xlim([x(1), x(end)])

xlabel('t');
ylabel('Estimated class labels');

%% model log-likelihood during EM
% %
% figure,
% plot(mrhlp.stored_loglik,'-','linewidth',1.5)
% xlabel('EM iteration number')
% ylabel('log-likelihood')
end

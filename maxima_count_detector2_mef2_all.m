%HFO detector using maxima counter, data starting from indicated time minus epoch_duration
%plot rate per 2min: 4min before, 2min before and for 2min from seizure onset

function [parameters_distr, labels, eeg]=maxima_count_detector2_mef2(PY_ID, stime0, epoch_duration, param, ChExclusionList, ChInclusionList, mode)

%  maxima_count_detector2_mef( 'PY13N004', '03-10-2013 14:20:00', 120,  [80 200 10 2 0.1 5 120], {'DC'; 'EKG'}, {}, 'bipolar');

% param      - [ freqL freqT ampl_thr ampl_ratio max_dur num_backg_osc epoch_time] 

%               freqL      - lower frequency for HFO filtering (Hz)
%               freqT      - top frequency for HFO filtering (Hz)
%               ampl_thr   - min amplitude of HFO peaks  (uV)
%               ampl_ratio - min proportion between av amplitude of HFO and surrounding background
%               max_dur    - the maximum length of HFO (now between peaks) (sec)
%               num_backg_osc - number of oscilations before and after HFO used to calculate background
%               epoch_time - length of epoch for analysis (sec)

%parameters:
Fs=2000; 
A_tr=param(3)/2;
prop=1/param(4);   %0.95;
%baseline_dur=0.01*Fs;
%D_tr=0.03*Fs;
epoch_time=param(7);

temp_path=pwd;

HFO_events=[];
parameters_distr=[];
for step=1:3%720 %3
    step
% stime0_step=(date2usec(stime0))-epoch_duration*1000*Fs+(step-1)*epoch_time*1000*Fs; 
stime0_step=(date2usec(stime0))-epoch_duration*1000000+(step-1)*epoch_time*1000000; 
% 10000
% % % % if step==1
% % % %    stime0_step='04-28-2013 19:25:58';
% % % %   
% % % % elseif step==2
% % % %  stime0_step='04-28-2013 19:27:58';
% % % % end
[eeg, ~, labels, ~] = readOOmefeeg( 'V', PY_ID, stime0_step, 2*60 , ChExclusionList, {}, mode);
 %[eeg, ~, labels,~]=readOOmefeeg('V', , stime0_step, epoch_time, ChExclusionList, ChInclusionList, mode) ;
%[eeg, xeeg, labels]=readmefeeg('R', 'PY13N004', '03-10-2013 14:20:00', 120, {'EKG'}, {'RIH';'ABT';'ABO'}, 'bipolar');

% [spiketimes]=SpikeFinder(xeeg, eeg(3,:),10000);
% 
% pause

for c=1:length(labels)
HFO_filt = fir1(1000, [80/(Fs/2) 200/(Fs/2)]);
HFO = filtfilt(HFO_filt, 1, double(eeg(c,:)));
%HFO=eegfilt(eeg(c,:), Fs, param(1), param(2)); %filter

%find index of maxima
idx = peaksN(HFO);
%value of maxima
maximaV=HFO(idx);

idx_s=[]; 
HFO_onset=[];
duration=[];
energy=[];  %filtered sig
energy2=[]; %raw sig
av_freq=[];
av_freq2=[];
ampl_diff=[];
context_phase=[];
context_min=[];
context_max=[];
time_pos=[];
ampl_diff10=[];
ampl_diff5=[];
mean_amplitude=[];
median_amplitude=[];

for i=2:length(idx)
    if maximaV(i)>A_tr & maximaV(i-1)<A_tr
       idx_s=[idx_s idx(i)];
    end
end
for j=1:length(idx_s)-1
    i_temp=find(idx(:)==idx_s(j));
    k=0;
    while maximaV(i_temp+k) > A_tr
      k=k+1;
    end
    if k>4 & i_temp-param(6)>0   &  i_temp+k+param(6)<=length(idx)
       
    if  median(maximaV(i_temp-param(6):i_temp-1))< prop*median(maximaV(i_temp:i_temp+k)) ...
          & median(maximaV(i_temp+k+1:i_temp+k+param(6)))< prop*median(maximaV(i_temp:i_temp+k))
        HFO_onset=[HFO_onset idx(i_temp)];              %first max peak 
        duration=[duration (idx(i_temp+k)-idx(i_temp))/Fs];  %from max peak to last max peak
        energy=[energy sum((HFO(idx(i_temp):idx(i_temp+k))).^2)];     %from max peak to last max peak of filtered sig
        energy2=[energy2 sum((eeg(c,idx(i_temp):idx(i_temp+k))).^2)];     %from max peak to last max peak of raw signal
        av_freq=[av_freq  (k-1)/((idx(i_temp+k)-idx(i_temp))/Fs)] ;  %from max peak to last max peak, maxima measure
        av_freq2=[av_freq2 ((zc([HFO(idx(i_temp):idx(i_temp+k))]))/2)/((idx(i_temp+k)-idx(i_temp))/Fs) ];    %from max peak to last max peak, zero-crossing measure
        time_pos=[time_pos (step-1)*epoch_time+(idx(i_temp))/Fs]; %in sec from time period begin
     c=c   
%%%%%%%%%%%%%plot detected event
        ampl_diff=[ampl_diff max([eeg(c,idx(i_temp):idx(i_temp+k))])-min([eeg(c,idx(i_temp):idx(i_temp+k))])]; %between min and max amplitude from max peak to last max peak 
        contect_phase_all=angle(hilbert([eeg(c,idx(i_temp):idx(i_temp+k))]));
        context_phase =[context_phase contect_phase_all(ceil((length([eeg(c,idx(i_temp):idx(i_temp+k))]))/2))];
        
        context_min=[context_min min([eeg(c,idx(i_temp):idx(i_temp+k))])];
        context_max=[context_max max([eeg(c,idx(i_temp):idx(i_temp+k))])];
        ampl_diff10=[ampl_diff10 max(abs((eeg(c,idx(i_temp):idx(i_temp+k)-10))-(eeg(c,idx(i_temp)+10:idx(i_temp+k)))))];
        ampl_diff5=[ampl_diff5 max(abs((eeg(c,idx(i_temp):idx(i_temp+k)-5))-(eeg(c,idx(i_temp)+5:idx(i_temp+k)))))];
       maxima=[];
       for kk=1:k+1
           maxima=[maxima HFO(idx(i_temp+kk-1))];
       end
       mean_amplitude=[mean_amplitude mean(maxima)];
       median_amplitude=[median_amplitude median(maxima)];
        
%    figure;% 
%    xx=(1:120*Fs)./Fs;
%    subplot(3,1,1)
%    plot(xx,eeg(c,:))
%    hold on
%    line([(idx(i_temp))/Fs,(idx(i_temp))/Fs],[-400,400],'Color','r')
%    line([(idx(i_temp+k))/Fs,(idx(i_temp+k))/Fs],[-400,400],'Color','r')
%    hold off
%    subplot(3,1,2)
%    plot(xx,HFO)
%    hold on
%    line([(idx(i_temp))/Fs,(idx(i_temp))/Fs],[-400,400],'Color','r')
%    line([(idx(i_temp+k))/Fs,(idx(i_temp+k))/Fs],[-400,400],'Color','r')
%     hold off
%      
%      % plot([eeg(c,idx(i_temp):idx(i_temp+k))])
%       subplot(3,1,3)
%       plot([HFO(idx(i_temp):idx(i_temp+k))])
%       pause;
%%%%%%%%%%%%         
       
    end
    end

end
%figure;hist(duration, 40)

   %remove 2long events
    i_long=find(duration(:)>param(5) | ampl_diff5(:)>500);
    HFO_onset(i_long)=[];
    duration(i_long)=[];
    energy(i_long)=[];
    energy2(i_long)=[];
    av_freq(i_long)=[];
    av_freq2(i_long)=[];
    ampl_diff(i_long)=[];
    context_phase(i_long)=[];
    
    context_min(i_long)=[];
    context_max(i_long)=[];
    time_pos(i_long)=[];
    ampl_diff10(i_long)=[];
    ampl_diff5(i_long)=[];
    mean_amplitude(i_long)=[];
    median_amplitude(i_long)=[];
    
   % HFO_events=[HFO_events; c*ones(length(HFO_onset),1) time_pos' duration' av_freq' av_freq2' energy2' energy' context_min' context_max' context_phase'];

    HFO_onset_all{c}=num2str(HFO_onset,'%10.5e\n');
    duration_all{c}=num2str(duration,'%10.5e\n');
    energy_all{c}=num2str(energy,'%10.5e\n');
    energy2_all{c}=num2str(energy2,'%10.5e\n');
    av_freq_all{c}=num2str(av_freq,'%10.5e\n');
    av_freq2_all{c}=num2str(av_freq2,'%10.5e\n');
    ampl_diff_all{c}=num2str(ampl_diff,'%10.5e\n');
    context_phase_all{c}=num2str(context_phase,'%10.5e\n');
    ampl_diff10_all{c}=num2str(ampl_diff10,'%10.5e\n');
    ampl_diff5_all{c}=num2str(ampl_diff5,'%10.5e\n');
    mean_amplitude_all{c}=num2str(mean_amplitude,'%10.5e\n');
    median_amplitude_all{c}=num2str(median_amplitude,'%10.5e\n');
    
end

 for e=1:length(labels)
         parameters_distr(e,step,1)=length(str2num(HFO_onset_all{e}));
         if length(str2num(HFO_onset_all{e}))>0
         parameters_distr(e,step,2)=mean(str2num(duration_all{e}));
         %figure;hist(str2num(duration_all{e}))
         parameters_distr(e,step,5)=mean(str2num(energy2_all{e}));
         parameters_distr(e,step,6)=mean(str2num(energy_all{e}));
         parameters_distr(e,step,3)=mean(str2num(av_freq_all{e}));
         parameters_distr(e,step,4)=mean(str2num(av_freq2_all{e}));
         parameters_distr(e,step,7)=mean(str2num(ampl_diff_all{e}));
         parameters_distr(e,step,8)=mean(str2num(context_phase_all{e}));
         parameters_distr(e,step,9)=mean(str2num(ampl_diff10_all{e}));
         parameters_distr(e,step,10)=mean(str2num(ampl_diff5_all{e}));
         parameters_distr(e,step,11)=mean(str2num(mean_amplitude_all{e}));
         parameters_distr(e,step,12)=mean(str2num(mean_amplitude_all{e}));
         end
  end

end
cd(temp_path)

% save parameters_distr parameters_distr
% save labels labels


figure;subplot(3,1,1)
x=[1:1:size(parameters_distr,1)]-0.5;
%r=parameters_distr(:,:,1);
bar(x,parameters_distr(:,1,1))
xticklabel_rotate([1:length(labels)],90,labels','Fontsize',5)%'interpreter','none')
title(sprintf('%s, HFO(%3.0f-%3.0f)rate/2min, 4min before time: %s',PY_ID, param(1), param(2),stime0 ) )
subplot(3,1,2)
bar(x,parameters_distr(:,2,1))
xticklabel_rotate([1:length(labels)],90,labels','Fontsize',5)%'interpreter','none')
title(sprintf('%s, HFO(%3.0f-%3.0f)rate/2min, 2min before time: %s',PY_ID, param(1), param(2),stime0 ) )

subplot(3,1,3)
bar(x,parameters_distr(:,3,1))
xticklabel_rotate([1:length(labels)],90,labels','Fontsize',5)%'interpreter','none')
title(sprintf('%s, HFO(%3.0f-%3.0f)rate/2min, from time: %s', PY_ID, param(1), param(2),stime0 ) )


% figure;
% for step=1:8   
% subplot(10,1,step)
% bar(parameters_distr(:,step,1))
% set(gca,'tickdir','out')
% %xticklabel_rotate([1:length(labels)],90,labels,'Fontsize',5)%'interpreter','none')
% % ylabel(sprintf('av number of HFO \n 2h interictal') ) 
% % title(sprintf('PY13N006, HFO rate per 2min, seizure %s', stime0_step)) 
% end
% hold on
% subplot(10,1,9)
% bar(parameters_distr(:,9,1))
% set(gca,'tickdir','out')
% xticklabel_rotate([1:length(labels)],90,labels,'Fontsize',5)%'interpreter','none')
% hold off

% figure;subplot(2,1,1)
% x=[1:1:size(parameters_distr,1)]-0.5;
% r=parameters_distr(:,:,1);
% bar(x,sum(r'))
% xticklabel_rotate([1:length(labels)],90,labels','Fontsize',5)%'interpreter','none')
% title(sprintf('PY13N007, HFO rate per 1h, time: %s',stime0 ) )
% subplot(2,1,2)
% bar(x,mean(r'))
% xticklabel_rotate([1:length(labels)],90,labels','Fontsize',5)%'interpreter','none')
% title(sprintf('PY13N007, HFO rate per 2min (average 1h), time:%s',stime0 ) )




%bad_ch=[4,5,8,9,14,86,94,102,106,111];

% labels(bad_ch)=[];
% parameters_distr(bad_ch,:,:)=[];
% 
% 
% figure;
% x=[1:1:size(parameters_distr,1)]-0.5;
% for subp=1:size(parameters_distr,2)
% 
%     
% subplot(size(parameters_distr,2),1,subp)
% bar(x,parameters_distr(:,subp,1))
% set(gca,'tickdir','out')
% xticklabel_rotate([1:length(labels)],90,labels,'Fontsize',5)%'interpreter','none')
% title(sprintf('PY13N007, HFO rate per 2min, time: %s', stime0) )
% end



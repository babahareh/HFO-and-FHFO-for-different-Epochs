clear all 
%% Initialize
Fs = 10000;
param = [80 200 10 2 0.1 5];
filtering =1;
S.Px = 'PY12N005';
S.exch = {'DC';'EKG'};
S.mtg = 'monopolar';
%% Reading EEG in 2 minutes the night before seizure
S.tstart = '11-July-2012 01:00:00';
interest = date2usec(S.tend) + 2930*1000000;
epoch_time = 2*60;%sec
for i = 1:5
stime0_step = (interest)+(i-1)*epoch_time*1000000;
 [eeg, ~, S.Biplabels, ~] = readOOmefeeg( 'R', S.Px, stime0_step, 2*60 , S.exch, {}, S.mtg);
%% HFO at 10 minutes at night before seizure (80-200)
[HFO_onset, HFO_duration]= mHFO_mef(eeg', param, Fs, filtering);
HFO_onset_i(i,:,:) = HFO_onset;
HFO_duration_i(i,:,:) = HFO_duration;
end
HFO_onset_total = squeeze(HFO_duration_i(1,:,:)+ HFO_duration_i(2,:,:)...
+HFO_duration_i(3,:,:)+ HFO_duration_i(4,:,:)+ HFO_duration_i(5,:,:));

for HFO_ch = 1: size(eeg, 1)
    temp2 = (~isnan(HFO_onset_total( HFO_ch, :)) & HFO_onset_total( HFO_ch, :) ~= 0);
    HFO_count(HFO_ch) = sum(temp2(:));
end

%% Plot the number of HFO in each channel
figure;
bar((1:size(eeg,1))+0.5, HFO_count)
set(gca,'XTick',1:size(eeg,1))
set(gca,'XTickLabel',S.Biplabels)
xticklabel_rotate(1:size(eeg,1), 75,S.Biplabels )
xlabel('Channel Label','FontSize',14, 'FontWeight','bold')
ylabel('Number of HFOs in each channel','FontSize',14)
title('Number of Ripples 10 minutes at night 11July ')

%% Reading EEG in 10 minutes in preictal
S.tstart = '11-July-2012 17:43:20';
 for i = 1:5
stime0_step = (date2usec(S.tstart))+(i-1)*epoch_time*1000000;
 [eeg_pre, ~, S.Biplabels, ~] = readOOmefeeg( 'R', S.Px, stime0_step, 2*60 , S.exch, {}, S.mtg);
%% HFO at 10 minutes at night before seizure (80-200)
[HFO_onset_pre, HFO_duration_pre]= mHFO_mef(eeg_pre', param, Fs, filtering);
HFO_onset_pre_i(i,:,:) = HFO_onset_pre;
HFO_duration_pre_i(i,:,:) = HFO_duration_pre;
end
HFO_onset_pre_total = squeeze(HFO_duration_pre_i(1,:,:)+ HFO_duration_pre_i(2,:,:)...
+HFO_duration_pre_i(3,:,:)+ HFO_duration_pre_i(4,:,:)+ HFO_duration_pre_i(5,:,:));

for HFO_ch = 1: size(eeg, 1)
    temp2 = (~isnan(HFO_onset_pre_total( HFO_ch, :)) & HFO_onset_pre_total( HFO_ch, :) ~= 0);
    HFO_count_pre(HFO_ch) = sum(temp2(:));
end

%% Plot the number of HFO in each channel
figure;
bar((1:size(eeg,1))+0.5, HFO_count_pre)
set(gca,'XTick',1:size(eeg,1))
set(gca,'XTickLabel',S.Biplabels)
xticklabel_rotate(1:size(eeg,1), 75,S.Biplabels )
xlabel('Channel Label','FontSize',14, 'FontWeight','bold')
ylabel('Number of Rippless in each channel','FontSize',14)
title(' Number Ripples for 10 minutes in preictal ')

%% Reading EEG in ictal time
S.tstart = '11-July-2012 17:53:20';
for i = 1:5
stime0_step = (date2usec(S.tstart))+(i-1)*epoch_time*1000000;
 [eeg_ictal, ~, S.Biplabels, ~] = readOOmefeeg( 'R', S.Px, stime0_step, 2*60 , S.exch, {}, S.mtg);
%% HFO at 10 minutes at night before seizure (80-200)
[HFO_onset_ictal, HFO_duration_ictal]= mHFO_mef(eeg_ictal', param, Fs, filtering);
HFO_onset_ictal_i(i,:,:) = HFO_onset_ictal;
HFO_duration_ictal_i(i,:,:) = HFO_duration_ictal;
end
HFO_onset_total_ictal = squeeze(HFO_duration_ictal_i(1,:,:)+ HFO_duration_ictal_i(2,:,:)...
+HFO_duration_ictal_i(3,:,:)+ HFO_duration_ictal_i(4,:,:)+ HFO_duration_ictal_i(5,:,:));

for HFO_ch = 1: size(eeg, 1)
    temp2 = (~isnan(HFO_onset_total_ictal( HFO_ch, :)) & HFO_onset_total_ictal( HFO_ch, :) ~= 0);
    HFO_count_ictal(HFO_ch) = sum(temp2(:));
end
%% Plot the number of HFO in each channel
figure;
bar((1:size(eeg,1))+0.5, HFO_count_ictal)
set(gca,'XTick',1:size(eeg,1))
set(gca,'XTickLabel',S.Biplabels)
xticklabel_rotate(1:size(eeg,1), 75,S.Biplabels )
%%
xlabel('Channel Label','FontSize',14, 'FontWeight','bold')
ylabel('Number of Rippless in each channel','FontSize',14)
title(' Number Ripples for 2 minutes in ictal ')

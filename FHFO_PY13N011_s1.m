clear temp2
%% Initialize

param1 = [200 500 8 2 0.1 5];

%% FHFO (10 min night) (200-500) in 2 minutes the night before seizure
S.tstart = '08-20-2013 00:00:22';
epoch_time = 2*60;%sec

for i = 1:5
stime0_step = date2usec(S.tstart)+(i-1)*epoch_time*1000000;
 [eeg, ~, S.Biplabels, ~] = readOOmefeeg( 'V', S.Px, stime0_step, 2*60 , S.exch, {}, S.mtg);
%% FHFO at 10 minutes at night before seizure (80-200)
[FHFO_onset, FHFO_duration]= mHFO_mef(eeg', param1, Fs, filtering);
FHFO_onset_i(i,:,:) = FHFO_onset;
FHFO_duration_i(i,:,:) = FHFO_duration;
end
FHFO_onset_total = squeeze(FHFO_duration_i(1,:,:)+ FHFO_duration_i(2,:,:)...
+FHFO_duration_i(3,:,:)+ FHFO_duration_i(4,:,:)+ FHFO_duration_i(5,:,:));

for HFO_ch = 1: size(eeg, 1)
    temp2 = (~isnan(FHFO_onset_total( HFO_ch, :)) & FHFO_onset_total( HFO_ch, :) ~= 0);
    FHFO_count(HFO_ch) = sum(temp2(:));
end

%% FHFO (10 min preictal) (200-500) in 10 minutes pre ictal
S.tstart = '08-20-2013 13:13:22';
 for i = 1:5
stime0_step = (date2usec(S.tstart))+(i-1)*epoch_time*1000000;
 [eeg_pre, ~, S.Biplabels, ~] = readOOmefeeg( 'V', S.Px, stime0_step, 2*60 , S.exch, {}, S.mtg);
%% HFO at 10 minutes at night before seizure (80-200)
[FHFO_onset_pre, FHFO_duration_pre]= mHFO_mef(eeg_pre', param1, Fs, filtering);
FHFO_onset_pre_i(i,:,:) = FHFO_onset_pre;
FHFO_duration_pre_i(i,:,:) = FHFO_duration_pre;
end
FHFO_onset_pre_total = squeeze(FHFO_duration_pre_i(1,:,:)+ FHFO_duration_pre_i(2,:,:)...
+FHFO_duration_pre_i(3,:,:)+ FHFO_duration_pre_i(4,:,:)+ FHFO_duration_pre_i(5,:,:));

for HFO_ch = 1: size(eeg, 1)
    temp2 = (~isnan(FHFO_onset_pre_total( HFO_ch, :)) & FHFO_onset_pre_total( HFO_ch, :) ~= 0);
    FHFO_count_pre(HFO_ch) = sum(temp2(:));
end



%% FHFO at 2 minutes at ictal (80-200) in 2 minutes ictal
S.tstart = '08-20-2013 13:23:22';
for i = 1:5
stime0_step = (date2usec(S.tstart))+(i-1)*epoch_time*1000000;
 [eeg_ictal, ~, S.Biplabels, ~] = readOOmefeeg( 'V', S.Px, stime0_step, 2*60 , S.exch, {}, S.mtg);
%% HFO at 10 minutes at night before seizure (80-200)
[FHFO_onset_ictal, FHFO_duration_ictal]= mHFO_mef(eeg_ictal', param1, Fs, filtering);
FHFO_onset_ictal_i(i,:,:) = FHFO_onset_ictal;
FHFO_duration_ictal_i(i,:,:) = FHFO_duration_ictal;
end
FHFO_onset_total_ictal = squeeze(FHFO_duration_ictal_i(1,:,:)+ FHFO_duration_ictal_i(2,:,:)...
+FHFO_duration_ictal_i(3,:,:)+ FHFO_duration_ictal_i(4,:,:)+ FHFO_duration_ictal_i(5,:,:));

for HFO_ch = 1: size(eeg, 1)
    temp2 = (~isnan(FHFO_onset_total_ictal( HFO_ch, :)) & FHFO_onset_total_ictal( HFO_ch, :) ~= 0);
    FHFO_count_ictal(HFO_ch) = sum(temp2(:));
end
%% Plot the number of FHFO in each channel
figure;
subplot(3,1,1)
bar((1:size(eeg,1))+0.5, FHFO_count)
set(gca,'XTick',1:size(eeg,1))
set(gca,'XTickLabel',S.Biplabels)
xticklabel_rotate(1:size(eeg,1), 90,S.Biplabels )
%xlabel('Channel Label','FontSize',10, 'FontWeight','bold')
ylabel('Number of Fast Ripples','FontSize',10)
title('PY13N011 Number of Fast Ripples 10 minutes at night')
subplot(3,1,2)
bar((1:size(eeg,1))+0.5, FHFO_count_pre)
set(gca,'XTick',1:size(eeg,1))
set(gca,'XTickLabel',S.Biplabels)
xticklabel_rotate(1:size(eeg,1), 90,S.Biplabels )
%xlabel('Channel Label','FontSize',10, 'FontWeight','bold')
ylabel('Number of Fast Rippless','FontSize',10)
title(' Number of Fast Ripples for 10 minutes in preictal ')
subplot(3,1,3)
bar((1:size(eeg,1))+0.5, FHFO_count_ictal)
set(gca,'XTick',1:size(eeg,1))
set(gca,'XTickLabel',S.Biplabels)
xticklabel_rotate(1:size(eeg,1), 90,S.Biplabels )
xlabel('Channel Label','FontSize',10, 'FontWeight','bold')
ylabel('Number of Fast Rippless','FontSize',10)
title(' Number of  Fast Ripples for 2 minutes in ictal ')

tstart = '30-Oct-2016 19:47:29';
[eeg,~,S.monplabels,~] = readOOmefeeg('R','PY16N012',tstart,(5*60) ,{'DC';'EKG'},{},'bipolar'); % before seizure
Fs = 2000;
numch = min(size(eeg));
blocksize = 3;% sec;
numsec  = max(size(eeg))/Fs; % get length of data in seconds
blocks = floor(numsec/3);  % exclude partial data at end
blockidxsize = ceil(blocksize* Fs); % number of data points per block
c = (1/ (1000/round(Fs))); % convert ms to number of data points
Dt = 1; % overlap window
k= 0; % loop counter
for sec = 0: Dt:length(eeg)/Fs -  blocksize
    k = k+1;
    idx = round(sec* Fs + (1:blocksize* Fs));
    eeg_seg = eeg(:,idx(:));
    dls(k,:) = mean(abs(diff(eeg_seg)));
    tmp = dls(k,:);
    artifactchans{k} = find(dls>10*std(tmp) + mean(tmp));
    art_onset{k} = usec2date(date2usec(tstart)+ sec* 1e6);
    % remove these channels from consideration
    ch_num_new{k} = setdiff(numch, artifactchans{k});
end
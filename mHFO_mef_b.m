function [HFO_onset, HFO_duration]=mHFO_mef_b(eeg, param, Fs, filtering)

% Multi-channel HFO detector using maxima counter
% e.g: HFO_mef(eeg(:,:), [80 200 10 2 0.1 5], 10000, 1);
% eeg=  samples number of channel *
% filtering: 1- do filtering before HFO detection
%            0 -do not filtering
% param:      - [ freqL freqT ampl_thr ampl_ratio max_dur num_backg_osc]
%               freqL      - lower frequency for HFO filtering (Hz)
%               freqT      - top frequency for HFO filtering (Hz)
%               ampl_thr   - min amplitude of HFO peaks (uV)
%               ampl_ratio - min proportion between av amplitude of HFO and surrounding background
%               max_dur    - the maximum length of HFO (now between peaks) (sec)
%               num_backg_osc - number of oscilations before and after HFO used to calculate background


maxHFO=floor(length(eeg)/(param(5)*Fs));
HFO_onset=zeros(min(size(eeg)),maxHFO);
HFO_duration=zeros(min(size(eeg)),maxHFO);
ampl_diff5=zeros(min(size(eeg)),maxHFO);
glob_local_peak=zeros(min(size(eeg)),maxHFO);
%parameters:
A_tr=param(3)/2;
prop=1/param(4);   %0.95;


% HFO Filtering
if filtering==1
    fnorm = [param(1) param(2)]/(Fs/2); % for bandpass, here are the lower and upper cutoff respectively (80-400Hz)
    HGFilt = fir1(1000,fnorm);
    mHFO=filtfilt(HGFilt, 1, eeg);
else
    mHFO=eeg;
end
%%% HFO=abs(HFO-mean(HFO));

for nc=1:min(size(eeg)),
    
    %find index of maxima
    idx_peaks = peaksN(mHFO(:,nc));
    %value of maxima
    maximaV=mHFO(idx_peaks,nc);
    Amp_HFO= [];
    peaks_idx_s=[];
    idx_trans=[];
    nhfo=0;
    %HFO_onset=[];
    %duration=[];
    for i=2:length(idx_peaks),
        if maximaV(i)>A_tr && maximaV(i-1)<A_tr,% find if indexes the peaks in mHFO hasspecific characteristics
            idx_trans=[idx_trans i]; % select the indexes of those peaks that have specific characteristics
            peaks_idx_s=[peaks_idx_s idx_peaks(i)]; % find the value(samples number) of indixes of the peaks with specific character
            Amp_HFO = [Amp_HFO, maximaV(i)]; % Find the amplitude of HFOs
        end
    end
    for j=1:length(peaks_idx_s), % removed the -1 which cause HFO at end of window to be missed
        %i_temp=find(idx_peaks(:)==peaks_idx_s(j)); %% no need to find if you
        %save the array before
        i_temp=idx_trans(j);
        k=0;
        while maximaV(i_temp+k) > A_tr,
            k=k+1;
            if (i_temp+k)>length(maximaV), % no more maxima to check (fix for removing the -1)
                break;
            end
        end
        if k>4 && i_temp-param(6)>0 && i_temp+k+param(6)<=length(idx_peaks),
            if  median(maximaV(i_temp-param(6):i_temp-1))< prop*median(maximaV(i_temp:i_temp+k)); ...
                    %&& median(maximaV(i_temp+k+1:i_temp+k+param(6)))< prop*median(maximaV(i_temp:i_temp+k)),
                nhfo=nhfo+1;
                HFO_onset(nc,nhfo)=idx_peaks(i_temp);              %first max peak
                HFO_duration(nc,nhfo)=(idx_peaks(i_temp+k)-idx_peaks(i_temp));  %from max peak to last max peak
                %ampl_diff10(nc,nhfo)=max(abs((eeg(nc,idx_peaks(i_temp):idx_peaks(i_temp+k)-10))-(eeg(nc,idx_peaks(i_temp)+10:idx_peaks(i_temp+k)))));
                ampl_diff5(nc,nhfo)=max(abs((eeg(idx_peaks(i_temp):idx_peaks(i_temp+k)-5,nc))-(eeg(idx_peaks(i_temp)+5:idx_peaks(i_temp+k),nc)) ));% removing the articats in raw EEG, those with high shift
                maximas=[];
                for kk=1:k+1
                    maximas=[maximas mHFO(idx_peaks(i_temp+kk-1))];
                end
                glob_local_peak(nc,nhfo)= max(maximas)/((sum(maximas)-max(maximas))/(k-1)); % Remove the artifact , if one peak is so higher than the others
            end
        end
    end
    
    %remove 2long events & possible artifacts
    i_long_artf=find(HFO_duration(nc,:)>(param(5)*Fs)); %*Fs deleted because it is based on sample %| ampl_diff5(nc,:)>500 | glob_local_peak(nc,:)>4);
    HFO_onset(nc,i_long_artf)=NaN;
    
    HFO_duration(nc,i_long_artf)=NaN;
    
end

HFO_onset = HFO_onset /Fs;
HFO_duration = HFO_duration /Fs;

function [ kurt, delta, mxv, lile ] = Get_ArtiFeats(eeg)

% Here we will test different measures to observe the behavior of artifacts
% As an input it receives.
% Columns must be channels and rows are instances

%% Kurtosis
kurt = kurtosis(abs(diff(eeg)));


%% Differential 
der_eeg = diff(eeg);

mxder = max(abs(der_eeg));%4

%% Spectral pattern
s = length( eeg ); %window length in samples
nfft = 2^nextpow2(s);

%                 data- wl - ovrlap- nfft - fs
[PSD f] = pwelch( eeg,  s, 0.5,    nfft, 2000);

indx = find( f >= 0.01 & f < 4 );

% Sums the power for the delta band
delta = log10(sum( PSD( indx ,:)));

% Obtains the maximum Voltage value
mxv = max(abs(eeg));


lile =  sum(abs(der_eeg))/(length(eeg)-1);
  
end
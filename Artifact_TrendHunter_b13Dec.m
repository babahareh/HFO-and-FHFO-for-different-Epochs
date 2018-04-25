function [ ArtCh ]= Artifact_TrendHunter_b13Dec( eeg, S )
% Input is a matrix with channels as rows and instances as columns
% Extracts the features to find artifacts and as an output gives the channels
% that have artifacts
%  eegsz = size(eeg,1);
%         leeg_new = S.nbpts_art + eegsz;
 S.Fs = 2000;
nch = min(size(eeg));
% Get Artifact Filter   
artT_k = S.artitrend_k.raw(S.artitrend_k.fst:S.artitrend_k.lst-4 ,:);
artT_d = S.artitrend_d.raw(S.artitrend_d.fst:S.artitrend_d.lst-4 ,:);
artT_v = S.artitrend_v.raw(S.artitrend_v.fst:S.artitrend_v.lst-4,:);
artT_l = S.artitrend_l.raw(S.artitrend_l.fst:S.artitrend_l.lst-4 ,:);


% calculate the mean and STD
u_k = mean(artT_k);s_k = std(artT_k);
u_d = mean(artT_d);s_d = std(artT_d);
u_l = mean(artT_l);s_l = std(artT_l);
u_v = mean(artT_v);s_v = std(artT_v);

%%
art_test_k = S.artitrend_k.raw(S.artitrend_k.lst-3:S.artitrend_k.lst,:);
art_test_d = S.artitrend_d.raw(S.artitrend_k.lst-3:S.artitrend_k.lst,:);
art_test_l = S.artitrend_l.raw(S.artitrend_k.lst-3:S.artitrend_k.lst,:);
art_test_v = S.artitrend_v.raw(S.artitrend_k.lst-3:S.artitrend_k.lst,:);

% kurtosis
k = (art_test_k- (ones(size(art_test_k,1),1)* u_k ))./(ones(size(art_test_k,1),1)*s_k);
[~, artchk] = find( k > 3);
% Delta
d = (art_test_d - (ones(size(art_test_d,1),1)* u_d))./(ones(size(art_test_d,1),1)* s_d) ;
[~, artchd] = find( d > 3);
artchd= unique(artchd);
% Line Length
l = (art_test_l - (ones(size(art_test_l,1),1)* u_l))./(ones(size(art_test_l,1),1)* s_l);
[~, artchl] = find( l > 3);
artchl= unique(artchl);
% maximum vlotage
v = (art_test_v - (ones(size(art_test_v,1),1)* u_v))./(ones(size(art_test_v,1),1)* s_v);
[~, artchv] = find( v > 3);
artchv= unique(artchv);

[value,ind]= sort((mean(art_test_v)+3*std(art_test_v)), 'descend');
artv_4sec = ind(1:20);
artv_4sec = unique(artv_4sec);

allch_art_seg = supervertcat( artchk, artchd, artchl, artchv);
artch = unique(allch_art_seg(allch_art_seg~=0));
display(['artifact channels:' int2str(artch')]);
ArtCh = artch;
      end
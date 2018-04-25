%%state for night
HFO_perm_SOZ_night = mean(HFOstat_SOZ(:,1));
HFO_perm_outSOZ_night = mean(HFOstat_NSOZ(:,1));

FHFO_perm_SOZ_night = mean(FHFOstat_SOZ(:,1));
FHFO_perm_outSOZ_night = mean(FHFOstat_NSOZ(:,1));

HFO_perm_res_night = mean(HFOstat_res(:,1));
HFO_perm_outres_night = mean(HFOstat_Nres(:,1));

FHFO_perm_res_night = mean(FHFOstat_res(:,1));
FHFO_perm_outres_night = mean(FHFOstat_Nres(:,1));
%% Awake

HFO_perm_SOZ_aw = mean(HFOstat_SOZ(:,2));
HFO_perm_outSOZ_aw = mean(HFOstat_NSOZ(:,2));

FHFO_perm_SOZ_aw = mean(FHFOstat_SOZ(:,2));
FHFO_perm_outSOZ_aw = mean(FHFOstat_NSOZ(:,2));

HFO_perm_res_aw = mean(HFOstat_res(:,2));
HFO_perm_outres_aw = mean(HFOstat_Nres(:,2));

FHFO_perm_res_aw = mean(FHFOstat_res(:,2));
FHFO_perm_outres_aw = mean(FHFOstat_Nres(:,2));
%% Preictal

HFO_perm_SOZ_pre = mean(HFOstat_SOZ(:,3));
HFO_perm_outSOZ_pre = mean(HFOstat_NSOZ(:,3));

FHFO_perm_SOZ_pre = mean(FHFOstat_SOZ(:,3));
FHFO_perm_outSOZ_pre = mean(FHFOstat_SOZ(:,3));

HFO_perm_res_pre = mean(HFOstat_res(:,3));
HFO_perm_outres_pre = mean(HFOstat_Nres(:,3));

FHFO_perm_res_pre = mean(FHFOstat_res(:,3));
FHFO_perm_outres_pre = mean(FHFOstat_Nres(:,3));

%% ictal

HFO_perm_SOZ_ictal = mean(HFOstat_SOZ(:,4));
HFO_perm_outSOZ_ictal = mean(HFOstat_NSOZ(:,4));

FHFO_perm_SOZ_ictal = mean(FHFOstat_SOZ(:,4));
FHFO_perm_outSOZ_ictal = mean(FHFOstat_SOZ(:,4));

HFO_perm_res_ictal = mean(HFOstat_res(:,4));
HFO_perm_outres_ictal = mean(HFOstat_Nres(:,4));

FHFO_perm_res_ictal = mean(FHFOstat_res(:,4));
FHFO_perm_outres_ictal = mean(FHFOstat_Nres(:,4));

%%plot
HFO_SOZ = [HFO_perm_SOZ_night, HFO_perm_outSOZ_night; HFO_perm_SOZ_aw, HFO_perm_outSOZ_aw;...
    HFO_perm_SOZ_pre,HFO_perm_outSOZ_pre ; HFO_perm_SOZ_ictal, HFO_perm_outSOZ_ictal];

FHFO_SOZ = [FHFO_perm_SOZ_night, FHFO_perm_outSOZ_night; FHFO_perm_SOZ_aw, FHFO_perm_outSOZ_aw;...
    FHFO_perm_SOZ_pre,FHFO_perm_outSOZ_pre ; FHFO_perm_SOZ_ictal, FHFO_perm_outSOZ_ictal];

HFO_res = [HFO_perm_res_night, HFO_perm_outres_night; HFO_perm_res_aw, HFO_perm_outres_aw;...
    HFO_perm_res_pre,HFO_perm_outres_pre ; HFO_perm_res_ictal, HFO_perm_outres_ictal];
FHFO_res = [FHFO_perm_res_night, FHFO_perm_outres_night; FHFO_perm_res_aw, FHFO_perm_outres_aw;...
    FHFO_perm_res_pre,FHFO_perm_outres_pre ; FHFO_perm_res_ictal, FHFO_perm_outres_ictal];
figure;
c ={'Night';'Awake';'Preictal';'ictal'};
subplot(4,1,1)
bar( HFO_SOZ);
set(gca,'XTick',1:4)
set(gca,'xticklabel',c)
title('HFO for SOZ Comparison across all patients')
legend('in SOZ', 'Out SOZ', 'Location','northwest','FontSize',2)
subplot(4,1,2)
bar( FHFO_SOZ);
set(gca,'XTick',1:4)
set(gca,'xticklabel',c)
title('FHFO for SOZ Comparison across all patients')
legend('in SOZ', 'Out SOZ', 'Location','northwest','FontSize',2)
subplot(4,1,3)
bar( HFO_res);
set(gca,'XTick',1:4)
set(gca,'xticklabel',c)
title('HFO for resected area Comparison across all patients')
legend('in resected', 'Out resected', 'Location','northwest','FontSize',2)
subplot(4,1,4)
bar( FHFO_res);
set(gca,'XTick',1:4)
set(gca,'xticklabel',c)
title('FHFO for resected area Comparison across all patients')
legend('in res', 'Out res', 'Location','northwest','FontSize',2)

%% SF
%%state for night
HFO_perm_SOZ_night_SF = mean(HFOstat_SOZ(7:12,1));
HFO_perm_outSOZ_night_SF = mean(HFOstat_NSOZ(7:12,1));

FHFO_perm_SOZ_night_SF = mean(FHFOstat_SOZ(7:12,1));
FHFO_perm_outSOZ_night_SF = mean(FHFOstat_NSOZ(7:12,1));

HFO_perm_res_night_SF = mean(HFOstat_res(7:12,1));
HFO_perm_outres_night_SF = mean(HFOstat_Nres(7:12,1));

FHFO_perm_res_night_SF = mean(FHFOstat_res(7:12,1));
FHFO_perm_outres_night_SF = mean(FHFOstat_Nres(7:12,1));
%% Awake

HFO_perm_SOZ_aw_SF = mean(HFOstat_SOZ(7:12,2));
HFO_perm_outSOZ_aw_SF = mean(HFOstat_NSOZ(7:12,2));

FHFO_perm_SOZ_aw_SF = mean(FHFOstat_SOZ(7:12,2));
FHFO_perm_outSOZ_aw_SF = mean(FHFOstat_NSOZ(7:12,2));

HFO_perm_res_aw_SF = mean(HFOstat_res(7:12,2));
HFO_perm_outres_aw_SF = mean(HFOstat_Nres(7:12,2));

FHFO_perm_res_aw_SF = mean(FHFOstat_res(7:12,2));
FHFO_perm_outres_aw_SF = mean(FHFOstat_Nres(7:12,2));
%% Preictal

HFO_perm_SOZ_pre_SF = mean(HFOstat_SOZ(7:12,3));
HFO_perm_outSOZ_pre_SF = mean(HFOstat_NSOZ(7:12,3));

FHFO_perm_SOZ_pre_SF = mean(FHFOstat_SOZ(7:12,3));
FHFO_perm_outSOZ_pre_SF = mean(FHFOstat_SOZ(7:12,3));

HFO_perm_res_pre_SF = mean(HFOstat_res(7:12,3));
HFO_perm_outres_pre_SF = mean(HFOstat_Nres(7:12,3));

FHFO_perm_res_pre_SF = mean(FHFOstat_res(7:12,3));
FHFO_perm_outres_pre_SF = mean(FHFOstat_Nres(7:12,3));

%% ictal

HFO_perm_SOZ_ictal_SF = mean(HFOstat_SOZ(7:12,4));
HFO_perm_outSOZ_ictal_SF = mean(HFOstat_NSOZ(7:12,4));

FHFO_perm_SOZ_ictal_SF = mean(FHFOstat_SOZ(7:12,4));
FHFO_perm_outSOZ_ictal_SF = mean(FHFOstat_SOZ(7:12,4));

HFO_perm_res_ictal_SF = mean(HFOstat_res(7:12,4));
HFO_perm_outres_ictal_SF = mean(HFOstat_Nres(7:12,4));

FHFO_perm_res_ictal_SF = mean(FHFOstat_res(7:12,4));
FHFO_perm_outres_ictal_SF = mean(FHFOstat_Nres(7:12,4));

%%plot
HFO_SOZ_SF = [HFO_perm_SOZ_night_SF, HFO_perm_outSOZ_night_SF; HFO_perm_SOZ_aw_SF, HFO_perm_outSOZ_aw_SF;...
    HFO_perm_SOZ_pre_SF,HFO_perm_outSOZ_pre_SF ; HFO_perm_SOZ_ictal_SF, HFO_perm_outSOZ_ictal_SF];

FHFO_SOZ_SF = [FHFO_perm_SOZ_night_SF, FHFO_perm_outSOZ_night_SF; FHFO_perm_SOZ_aw_SF, FHFO_perm_outSOZ_aw_SF;...
    FHFO_perm_SOZ_pre_SF,FHFO_perm_outSOZ_pre_SF ; FHFO_perm_SOZ_ictal_SF, FHFO_perm_outSOZ_ictal_SF];

HFO_res_SF = [HFO_perm_res_night_SF, HFO_perm_outres_night_SF; HFO_perm_res_aw_SF, HFO_perm_outres_aw_SF;...
    HFO_perm_res_pre_SF,HFO_perm_outres_pre_SF ; HFO_perm_res_ictal_SF, HFO_perm_outres_ictal_SF];
FHFO_res_SF = [FHFO_perm_res_night_SF, FHFO_perm_outres_night_SF; FHFO_perm_res_aw_SF, FHFO_perm_outres_aw_SF;...
    FHFO_perm_res_pre_SF,FHFO_perm_outres_pre_SF ; FHFO_perm_res_ictal_SF, FHFO_perm_outres_ictal_SF];
figure;
subplot(4,1,1)
bar( HFO_SOZ_SF);
set(gca,'XTick',1:4)
set(gca,'xticklabel',c)
title('HFO for SOZ Comparison across seizure free patients')
legend('in SOZ', 'Out SOZ', 'Location','northwest','FontSize',2)
subplot(4,1,2)
bar( FHFO_SOZ_SF);
set(gca,'XTick',1:4)
set(gca,'xticklabel',c)
title('FHFO for SOZ Comparison across seizure free patients')
legend('in SOZ', 'Out SOZ', 'Location','northwest','FontSize',2)
subplot(4,1,3)
bar( HFO_res_SF);
set(gca,'XTick',1:4)
set(gca,'xticklabel',c)
title('HFO for resected area Comparison across seizure free patients')
legend('in resected', 'Out resected', 'Location','northwest','FontSize',2)
subplot(4,1,4)
bar(FHFO_res_SF);
set(gca,'XTick',1:4)
set(gca,'xticklabel',c)
title('FHFO for resected area Comparison across seizure free patients')
legend('in res', 'Out res', 'Location','northwest','FontSize',2)
%% NSF
%%state for night
HFO_perm_SOZ_night_NSF = mean(HFOstat_SOZ(1:6,1));
HFO_perm_outSOZ_night_NSF = mean(HFOstat_NSOZ(1:6,1));

FHFO_perm_SOZ_night_NSF = mean(FHFOstat_SOZ(1:6,1));
FHFO_perm_outSOZ_night_NSF = mean(FHFOstat_NSOZ(1:6,1));

HFO_perm_res_night_NSF = mean(HFOstat_res(1:6,1));
HFO_perm_outres_night_NSF = mean(HFOstat_Nres(1:6,1));

FHFO_perm_res_night_NSF = mean(FHFOstat_res(1:6,1));
FHFO_perm_outres_night_NSF = mean(FHFOstat_Nres(1:6,1));
%% Awake

HFO_perm_SOZ_aw_NSF = mean(HFOstat_SOZ(1:6,2));
HFO_perm_outSOZ_aw_NSF = mean(HFOstat_NSOZ(1:6,2));

FHFO_perm_SOZ_aw_NSF = mean(FHFOstat_SOZ(1:6,2));
FHFO_perm_outSOZ_aw_NSF = mean(FHFOstat_NSOZ(1:6,2));

HFO_perm_res_aw_NSF = mean(HFOstat_res(1:6,2));
HFO_perm_outres_aw_NSF = mean(HFOstat_Nres(1:6,2));

FHFO_perm_res_aw_NSF = mean(FHFOstat_res(1:6,2));
FHFO_perm_outres_aw_NSF = mean(FHFOstat_Nres(1:6,2));
%% Preictal

HFO_perm_SOZ_pre_NSF = mean(HFOstat_SOZ(1:6,3));
HFO_perm_outSOZ_pre_NSF = mean(HFOstat_NSOZ(1:6,3));

FHFO_perm_SOZ_pre_NSF = mean(FHFOstat_SOZ(1:6,3));
FHFO_perm_outSOZ_pre_NSF = mean(FHFOstat_SOZ(1:6,3));

HFO_perm_res_pre_NSF = mean(HFOstat_res(1:6,3));
HFO_perm_outres_pre_NSF = mean(HFOstat_Nres(1:6,3));

FHFO_perm_res_pre_NSF = mean(FHFOstat_res(1:6,3));
FHFO_perm_outres_pre_NSF = mean(FHFOstat_Nres(1:6,3));

%% ictal

HFO_perm_SOZ_ictal_NSF = mean(HFOstat_SOZ(1:6,4));
HFO_perm_outSOZ_ictal_NSF = mean(HFOstat_NSOZ(1:6,4));

FHFO_perm_SOZ_ictal_NSF = mean(FHFOstat_SOZ(1:6,4));
FHFO_perm_outSOZ_ictal_NSF = mean(FHFOstat_SOZ(1:6,4));

HFO_perm_res_ictal_NSF = mean(HFOstat_res(1:6,4));
HFO_perm_outres_ictal_NSF = mean(HFOstat_Nres(1:6,4));

FHFO_perm_res_ictal_NSF = mean(FHFOstat_res(1:6,4));
FHFO_perm_outres_ictal_NSF = mean(FHFOstat_Nres(1:6,4));

%%plot
HFO_SOZ_NSF = [HFO_perm_SOZ_night_NSF, HFO_perm_outSOZ_night_NSF; HFO_perm_SOZ_aw_NSF, HFO_perm_outSOZ_aw_NSF;...
    HFO_perm_SOZ_pre_NSF,HFO_perm_outSOZ_pre_NSF ; HFO_perm_SOZ_ictal_NSF, HFO_perm_outSOZ_ictal_NSF];

FHFO_SOZ_NSF = [FHFO_perm_SOZ_night_NSF, FHFO_perm_outSOZ_night_NSF; FHFO_perm_SOZ_aw_NSF, FHFO_perm_outSOZ_aw_NSF;...
    FHFO_perm_SOZ_pre_NSF,FHFO_perm_outSOZ_pre_NSF ; FHFO_perm_SOZ_ictal_NSF, FHFO_perm_outSOZ_ictal_NSF];

HFO_res_NSF = [HFO_perm_res_night_NSF, HFO_perm_outres_night_NSF; HFO_perm_res_aw_NSF, HFO_perm_outres_aw_NSF;...
    HFO_perm_res_pre_NSF,HFO_perm_outres_pre_NSF ; HFO_perm_res_ictal_NSF, HFO_perm_outres_ictal_NSF];
FHFO_res_NSF = [FHFO_perm_res_night_NSF, FHFO_perm_outres_night_NSF; FHFO_perm_res_aw_NSF, FHFO_perm_outres_aw_NSF;...
    FHFO_perm_res_pre_NSF,FHFO_perm_outres_pre_NSF ; FHFO_perm_res_ictal_NSF, FHFO_perm_outres_ictal_NSF];
figure;
c = {'Night','Awake','Preictal', 'ictal'};
subplot(4,1,1)
bar( HFO_SOZ_NSF);
set(gca,'XTick',1:4)
set(gca,'xticklabel',c)
title('HFO for SOZ Comparison across not seizure free patients')
legend('in SOZ', 'Out SOZ', 'Location','northwest','FontSize',2)
subplot(4,1,2)
bar(FHFO_SOZ_NSF);
set(gca,'XTick',1:4)
set(gca,'xticklabel',c)
title('FHFO for SOZ Comparison across not seizure free patients')
legend('in SOZ', 'Out SOZ', 'Location','northwest','FontSize',2)
subplot(4,1,3)
bar(HFO_res_NSF);
set(gca,'XTick',1:4)
set(gca,'xticklabel',c)
title('HFO for resected area Comparison across not seizure free patients')
legend('in resected', 'Out resected', 'Location','northwest','FontSize',2)
subplot(4,1,4)
bar( FHFO_res_NSF);
set(gca,'XTick',1:4)
set(gca,'xticklabel',c)
title('FHFO for resected area Comparison across not seizure free patients')
legend('in res', 'Out res', 'Location','northwest','FontSize',2)
hdjgf
%% 2 way Anova
HFO_SOZ_an = [HFO_perm_SOZ_night, HFO_perm_SOZ_aw, HFO_perm_SOZ_pre, HFO_perm_SOZ_ictal ;...
    HFO_perm_outSOZ_night,HFO_perm_outSOZ_aw,  HFO_perm_outSOZ_pre, HFO_perm_outSOZ_ictal];
p = kruskalwallis(HFO_SOZ_an');
pchi=test_chi2_U(HFO_SOZ_an)
FHFO_SOZ_an = [FHFO_perm_SOZ_night, FHFO_perm_SOZ_aw, FHFO_perm_SOZ_pre, FHFO_perm_SOZ_ictal;...
    FHFO_perm_outSOZ_night, FHFO_perm_outSOZ_aw, FHFO_perm_outSOZ_pre, FHFO_perm_outSOZ_ictal];
p = kruskalwallis(FHFO_SOZ_an);
pchi=test_chi2_U(FHFO_SOZ_an)
HFO_res_an = [HFO_perm_res_night, HFO_perm_res_aw, HFO_perm_res_pre, HFO_perm_res_ictal;...
    HFO_perm_outres_night, HFO_perm_outres_aw, HFO_perm_outres_pre, HFO_perm_outres_ictal];
p = kruskalwallis(HFO_res_an);
pchi=test_chi2_U(HFO_res_an')
FHFO_res_an = [FHFO_perm_res_night, FHFO_perm_res_aw, FHFO_perm_res_pre, FHFO_perm_res_ictal;...
    FHFO_perm_outres_night, FHFO_perm_outres_aw, FHFO_perm_outres_pre, FHFO_perm_outres_ictal];
p = kruskalwallis(FHFO_res_an);
pchi=test_chi2_U(FHFO_res_an')
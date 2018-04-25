% ZC number of zero crossings in x
% [n] = zc(x) calculates the number of zero crossings in x

function [n] = zc(x)
s=sign(x);
t=filter([1 1],1,s);
n=(length(s)-length(find(t)))/length(s);

% n=(length(s)-length(find(t)))/length(s);

n = length(find(t==0));
% % % %%%%%%%%%%%%%%%%%%%%%%
% % % 
% % % %here better code in case your x signal is not known ( not sine...) :
% % % 
% % % %x is nx1 vector
% % % 
% % % zeroNb=0;
% % % 
% % % for i=1:length(x)-1 %length : get x size
% % % 
% % % if ((x(i)>0 && x(i+1)<0) || (x(i)<0 && x(i+1)>0))
% % % 
% % % zeroNb=i+zeroNb;
% % % 
% % % end
% % % 
% % % end
% % % 
% % % %%%%%%%%%%%%%%%%
% % % %This won't quite work: It does not find values where the point is exactly == 0 and we want to add 1 to the total crossings not i. Try this:
% % % 
% % % zeroNb=0;
% % % for i=1:length(x)-1 %length : get x size
% % % if ((x(i)>=0 && x(i+1)<0) || (x(i)<=0 && x(i+1)>0))
% % % zeroNb=1+zeroNb;
% % % end
% % % end
% % % 
% % % %%%n=length(find(t==0)) + length(find(x==0));
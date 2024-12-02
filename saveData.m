function [R,Vp,Vsc]=saveData(tofile,Rvar,Vscvar,Vpvar,k)
%function [R,Vp,Vsc]=saveData(tofile,Rvar,Vscvar,Vpvar,k)
%tofile: where to save data
%Rvar: name of R variable (string)
%Vscvar: name of Vsc variable (string) sc vel
%Vp: name of planet velocity
%k: which planet? Earth=3, Venus=2, etc.

%{ 

 This function saves the variables R, Vsc, and Vp in 'currentData.mat' in
 a new mat file under the names Rvar,Vscvar, and Vpvar which should be
 input as strings.
 These names should then be entered in the "spacecraft function" before they are used
 for a flyby or delta V calculation

Make sure you have pressed "Save Current State" in the app before running this
function.

For example use:

>> [R17,Vp17,Vsc17]=saveData('fbdata17','R17','Vsc17','Vp17')

 %}

load('./currentState.mat')
eval([Rvar '= R;']);
eval([Vscvar '= Vsc;']);
Vp1=Vp(find(Vp(:,1)==k),2:4);
eval([Vpvar '= Vp1;']);
Vp

save(tofile,Rvar,Vscvar,Vpvar)

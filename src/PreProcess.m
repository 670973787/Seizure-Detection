%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loading Paths
clear;
addpath ../
LoadLocalPaths;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loading the sentence sound

Datadir = ["N_Interictal"];
%Datadir = ["F_*","N_*","O_*","S_*","Z_*"];

FSamp = 173.61;
Len0 = 100;


for group = 1:length(Datadir)
    EGGsubdir = dir(SoundPath + Datadir(group) + '/*.txt');
    for i = 1:length(EGGsubdir) 
        if str2double(EGGsubdir(i).name(2:4)) < 70
            continue;
        end
        fileID = fopen(SoundPath + Datadir(group)+ "/" + EGGsubdir(i).name);
        y = textscan(fileID, '%f');
        fclose(fileID);
        y = y{1,1};
        y = y/sqrt(var(y));
        [a,c,Params,Info,x,varX,aupper,alower] = GPPAD(y,Len0,1);
        fprintf("Final Len:       %f",Info{2}.LenHist(end));
        fprintf("Final Likelihood:%e",Info{2}.ObjHist(end));
        dlmwrite(SoundPath + Datadir(group) + '/a_' + EGGsubdir(i).name,a,'delimiter', '\t');
        dlmwrite(SoundPath + Datadir(group) + '/c_' + EGGsubdir(i).name,c,'delimiter', '\t');
    end
    
end

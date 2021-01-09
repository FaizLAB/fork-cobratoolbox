function createSBMLFiles(refinedFolder, sbmlFolder)
% Creates SBML files for the created refined reconstructions. This may be
% time-consuming.
% USAGE
%   createTestSBMLFiles(refinedFolder, sbmlFolder)
%
% AUTHOR:
%       - Almut Heinken, 09/2020

dInfo = dir(sbmlFolder);
alreadyCreated={dInfo.name};
alreadyCreated=alreadyCreated';
alreadyCreated(~contains(alreadyCreated(:,1),'.xml'),:)=[];
alreadyCreated=strrep(alreadyCreated,'.xml','.mat');

dInfo = dir(refinedFolder);
modelList={dInfo.name};
modelList=modelList';
modelList(find(strcmp(modelList(:,1),'.')),:)=[];
modelList(find(strcmp(modelList(:,1),'..')),:)=[];

for i=1:length(modelList)
    if ~any(strcmp(modelList{i},alreadyCreated))
    model = readCbModel([refinedFolder filesep modelList{i}]);
    writeCbModel(model, 'format', 'sbml', 'fileName', [sbmlFolder filesep strrep(modelList{i},'.mat','')]);
    end
end

end

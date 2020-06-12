function y=svmPredict(arr)%#coder
persistent cl;
if isempty(cl)
    cl=loadLearnerForCoder('mySVM.mat');
end
y=predict(cl,arr);
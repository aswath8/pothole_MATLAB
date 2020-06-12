close all;
accelD=[];
accelN=[];
gyroD=[];
gyroN=[];

meanD=[];
stdD=[];
meanDG=[];
stdDG=[];
meanN=[];
stdN=[];
meanNG=[];
stdNG=[];
N=50;
pre=1;
xT=size(potholeAccelData)
xT=xT(1)
i=pre+1;
while(i<xT-N-1)
    if potholeAccelData{i,8}=="true"
        x=potholeAccelData{i-pre:i+N,2};
        y=potholeAccelData{i-pre:i+N,3};
        z=potholeAccelData{i-pre:i+N,4};
        xg=potholeAccelData{i-pre:i+N,5};
        yg=potholeAccelData{i-pre:i+N,6};
        zg=potholeAccelData{i-pre:i+N,7};
        m=[mean(x) mean(y) mean(z)];
        s=[std(x) std(y) std(z)];
        mg=[mean(xg) mean(yg) mean(zg)];
        sg=[std(xg) std(yg) std(zg)];
        accelD=[accelD; potholeAccelData{i-pre:i+N,2:4}];
        meanD=[meanD; m];
        stdD=[stdD; s];
        gyroD=[gyroD; potholeAccelData{i-pre:i+N,5:7}];
        meanDG=[meanDG; mg];
        stdDG=[stdDG; sg];
        i=i+N;
        continue
    elseif any(potholeAccelData{i:i+N+1,8}=="true")
        i=i+1;
        continue
    else 
        x=potholeAccelData{i:i+N,2};
        y=potholeAccelData{i:i+N,3};
        z=potholeAccelData{i:i+N,4};
        xg=potholeAccelData{i:i+N,5};
        yg=potholeAccelData{i:i+N,6};
        zg=potholeAccelData{i:i+N,7};
        m=[mean(x) mean(y) mean(z)];
        s=[std(x) std(y) std(z)];
        mg=[mean(xg) mean(yg) mean(zg)];
        sg=[std(xg) std(yg) std(zg)];
        accelN=[accelN;potholeAccelData{i:i+N,2:4}];
        meanN=[meanN; m];
        stdN=[stdN; s];
        gyroN=[gyroN; potholeAccelData{i:i+N,5:7}];
        meanNG=[meanNG; mg];
        stdNG=[stdNG; sg];
        i=i+N;
    end
end


figure;
plot3(accelD(:,1),accelD(:,2),accelD(:,3),'r.','MarkerSize',5)
hold on
plot3(accelN(:,1),accelN(:,2),accelN(:,3),'b.','MarkerSize',3)
title('Acceleration on each axis');
xlabel('x accel');
ylabel('y accel');
zlabel('z accel');
axis equal
hold off

figure;
plot3(gyroD(:,1),gyroD(:,2),gyroD(:,3),'r.','MarkerSize',5)
hold on
plot3(gyroN(:,1),gyroN(:,2),gyroN(:,3),'b.','MarkerSize',3)
title('Angular Acc on each axis');
xlabel('x accel');
ylabel('y accel');
zlabel('z accel');
axis equal
hold off


figure;
plot3(meanD(:,1),meanD(:,2),meanD(:,3),'r.','MarkerSize',10)
title('MEAN Accceleration on each axis');
hold on
plot3(meanN(:,1),meanN(:,2),meanN(:,3),'b.','MarkerSize',7)
xlabel('x accel');
ylabel('y accel');
zlabel('z accel');
axis equal
hold off

figure;
plot3(meanDG(:,1),meanDG(:,2),meanDG(:,3),'r.','MarkerSize',10)
title('MEAN Angular Acccel on each axis');
hold on
plot3(meanNG(:,1),meanNG(:,2),meanNG(:,3),'b.','MarkerSize',7)
xlabel('x accel');
ylabel('y accel');
zlabel('z accel');
axis equal
hold off

figure;
plot3(stdD(:,1),stdD(:,2),stdD(:,3),'r.','MarkerSize',10)
hold on
plot3(stdN(:,1),stdN(:,2),stdN(:,3),'b.','MarkerSize',7)
title('Standard Deviation of Acceleration on each axis');
xlabel('x accel');
ylabel('y accel');
zlabel('z accel');
axis equal
hold off

figure;
plot3(stdDG(:,1),stdDG(:,2),stdDG(:,3),'r.','MarkerSize',10)
hold on
plot3(stdNG(:,1),stdNG(:,2),stdNG(:,3),'b.','MarkerSize',7)
title('Standard Deviation of Angular Acc on each axis');
xlabel('x accel');
ylabel('y accel');
zlabel('z accel');
axis equal
hold off

xD=size(meanD);
xD=xD(1);
data1=[meanD stdD meanDG stdDG];
data2=[meanN(1:xD,:) stdN(1:xD,:) meanNG(1:xD,:) stdNG(1:xD,:)];
data3 = [data1;data2];
theclass = ones(2*xD,1);
theclass(1:xD) = -1;
%%{
%Train the SVM Classifier
cl = fitcsvm(data3,theclass,'KernelFunction','linear',...
    'BoxConstraint',1,...'PolynomialOrder',2,...
    'ClassNames',[-1,1]);

saveLearnerForCoder(cl,'mySVM');
%}
[~,scores] = predict(cl,[meanN(2,:) stdN(2,:) meanNG(2,:) stdNG(2,:)]);
arr=[meanD(2,:) stdD(2,:) meanDG(2,:) stdDG(2,:)];
svmPredict(arr);

result=[];
sized=size(data3);
sized=sized(1);
for i=1:sized
    k=predict(cl,data3(i,:));
    result=[result k];
end
theclass(theclass==-1)=0;
result(result==-1)=0;
figure;
plotconfusion(theclass',result);




accelD=[];
accelN=[];
gyroD=[];
gyroN=[];

meanD=[];
stdD=[];
meanDG=[];
stdDG=[];
meanN=[];
stdN=[];
meanNG=[];
stdNG=[];
N=50;
pre=1;
xT=size(potholeAccelData)
xT=xT(1)
i=pre+1;
while(i<xT-N-1)
    if potholeAccelData{i,8}=="true"
        x=potholeAccelData{i-pre:i+N,2};
        y=potholeAccelData{i-pre:i+N,3};
        z=potholeAccelData{i-pre:i+N,4};
        xg=potholeAccelData{i-pre:i+N,5};
        yg=potholeAccelData{i-pre:i+N,6};
        zg=potholeAccelData{i-pre:i+N,7};
        m=[mean(x) mean(y) mean(z)];
        s=[std(x) std(y) std(z)];
        mg=[mean(xg) mean(yg) mean(zg)];
        sg=[std(xg) std(yg) std(zg)];
        accelD=[accelD; potholeAccelData{i-pre:i+N,2:4}];
        meanD=[meanD; m];
        stdD=[stdD; s];
        gyroD=[gyroD; potholeAccelData{i-pre:i+N,5:7}];
        meanDG=[meanDG; mg];
        stdDG=[stdDG; sg];
        i=i+N;
        continue
    elseif any(potholeAccelData{i:i+N+1,8}=="true")
        i=i+1;
        continue
    else 
        x=potholeAccelData{i:i+N,2};
        y=potholeAccelData{i:i+N,3};
        z=potholeAccelData{i:i+N,4};
        xg=potholeAccelData{i:i+N,5};
        yg=potholeAccelData{i:i+N,6};
        zg=potholeAccelData{i:i+N,7};
        m=[mean(x) mean(y) mean(z)];
        s=[std(x) std(y) std(z)];
        mg=[mean(xg) mean(yg) mean(zg)];
        sg=[std(xg) std(yg) std(zg)];
        accelN=[accelN;potholeAccelData{i:i+N,2:4}];
        meanN=[meanN; m];
        stdN=[stdN; s];
        gyroN=[gyroN; potholeAccelData{i:i+N,5:7}];
        meanNG=[meanNG; mg];
        stdNG=[stdNG; sg];
        i=i+N;
    end
end




data1=[meanD stdD meanDG stdDG];
data2=[meanN stdN meanNG stdNG];
data3=[data1;data2];
d1s=size(data1);d1s=d1s(1);
theclass = ones(d1s,1);
theclass=-theclass;
d2s=size(data2);d2s=d2s(1);
theclass =[theclass; ones(d2s,1)];

result=[];
sized=size(data3);
sized=sized(1);
for i=1:sized
    k=predict(cl,data3(i,:));
    result=[result k];
end
theclass(theclass==-1)=0;
result(result==-1)=0;
figure;
%plotconfusion(theclass',result);
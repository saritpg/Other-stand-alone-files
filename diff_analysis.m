% ----My code starts from here----

load('p');                                          % loads the export mesh data.
p=p';                                               % extracts the x and y coordinates of the mesh nodes.                                       
[k,l]=size(p);

% plot(p(:,1),p(:,2));                              % plots the nodes in a new figure window.

load('u');                                          % loads the export solution data.
[r,c]=size(u);                                      % extracts the values for all the nodes at every time point.
data=[p,u];                                         % concatenates the two matrices.
[x,y]=size(data);

data=sortrows(data);                                % sorts the x-coordinate in ascending order.

timeparams=getappdata(pde_fig,'timeeigparam');      % extracting the 'solve parameters'
tlists=deblank(timeparams(1,:));                    % extracting the time points

uiwait(msgbox(tlists,'time points'));

tlists=str2num(tlists);
tlists1=tlists(1);
tlists2=tlists(2);
tlists3=tlists(end);
tdiff=tlists2;                                      % calculating the time interval

prompt = {'Enter the time point in seconds'};       % user input of time point for analysis
dlg_title = 'Time point?';
num_lines=1;
[answer]=inputdlg(prompt,dlg_title,num_lines);
num=answer{1,1};
time=str2num(num);

t=((time/tdiff)+3);

data1=data(:,1);                                    % x-coordinate of mesh points
data2=data(:,2);                                    % y-coordinate of mesh points
data3=data(:,t);                                    % data values of mesh points

plot (data(:,1),data(:,2),'r+');

uiwait(msgbox('Select data point'));
k = waitforbuttonpress;
point1 = get(gca,'CurrentPoint');    
finalRect = rbbox;                   
point2 = get(gca,'CurrentPoint');    
point1 = point1(1,1:2);              
point2 = point2(1,1:2);
p1 = min(point1,point2);             
offset = abs(point1-point2);         
x = [p1(1) p1(1)+offset(1) p1(1)+offset(1) p1(1) p1(1)];
y = [p1(2) p1(2) p1(2)+offset(2) p1(2)+offset(2) p1(2)];
hold on
axis manual
plot(x,y)


for i=1:(size(data,1))
    if ((data(i,1)>x(1))&(data(i,1)<x(2))&(data(i,2)>y(1))&(data(i,2)<y(3)))
        datpt=[data(i,1),data(i,2),data(i,t)];
    end
end

datpt(3)
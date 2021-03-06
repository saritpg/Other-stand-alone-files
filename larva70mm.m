function pdemodel
[pde_fig,ax]=pdeinit;
pdetool('appl_cb',10);
set(ax,'DataAspectRatio',[1 1 1]);
set(ax,'PlotBoxAspectRatio',[731.77935483870965 576 115.2]);
set(ax,'XLimMode','auto');
set(ax,'YLim',[-5 5]);
set(ax,'XTickMode','auto');
set(ax,'YTickMode','auto');

% Geometry description:
pdecirc(0,0,3.5,'E1');
pdecirc(-3.2000000000000002,0,0.12,'E2');
set(findobj(get(pde_fig,'Children'),'Tag','PDEEval'),'String','E1-E2')

% Boundary conditions:
pdetool('changemode',0)
pdesetbd(9,...
'dir',...
1,...
'1',...
'1')
pdesetbd(8,...
'dir',...
1,...
'1',...
'1')
pdesetbd(7,...
'dir',...
1,...
'1',...
'1')
pdesetbd(6,...
'dir',...
1,...
'1',...
'1')
pdesetbd(5,...
'neu',...
1,...
'0',...
'0')
pdesetbd(4,...
'neu',...
1,...
'0',...
'0')
pdesetbd(3,...
'neu',...
1,...
'0',...
'0')
pdesetbd(2,...
'neu',...
1,...
'0',...
'0')
pdesetbd(1,...
'neu',...
1,...
'0',...
'0')

% Mesh generation:
setappdata(pde_fig,'Hgrad',1.3);
setappdata(pde_fig,'refinemethod','regular');
pdetool('initmesh')

% PDE coefficients:
pdeseteq(2,...
'.0876',...
'0.0',...
'0',...
'1.0',...
'0:30:600',...
'0.0',...
'0.0',...
'[0 100]')
setappdata(pde_fig,'currparam',...
['.0876';...
'0    '])

% Solve parameters:
setappdata(pde_fig,'solveparam',...
str2mat('0','1000','10','pdeadworst',...
'0.5','longest','0','1E-4','','fixed','Inf'))

% Plotflags and user data strings:
setappdata(pde_fig,'plotflags',[1 1 1 1 1 1 7 1 0 0 0 21 1 1 0 1 0 1]);
setappdata(pde_fig,'colstring','');
setappdata(pde_fig,'arrowstring','');
setappdata(pde_fig,'deformstring','');
setappdata(pde_fig,'heightstring','');

% Solve PDE:
pdetool('solve')

getpetuc;
diff_analysis
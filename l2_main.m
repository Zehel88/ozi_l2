%% ����������������� ����� 
function varargout = l2_main(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @l2_main_OpeningFcn, ...
                   'gui_OutputFcn',  @l2_main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function l2_main_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = l2_main_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function pref_btn_ClickedCallback(hObject, eventdata, handles)
%% ������ ��������
run('l2_pref.m')



function T1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function T1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T1s_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function T1s_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pushbutton1_Callback(hObject, eventdata, handles)
%% �����������
% �������� ��������
load('Pref.mat');
clc
% �������
alf=Pref{1,2};
% �������� ��� ��������� (������� �����������)
a=str2double(Pref{2,2});
% �������� ����������
b=str2double(Pref{3,2});
% ����� ��������
m=numel(alf);
% �������� ������ �����
T1=upper(get(handles.T1,'String'));
% �������� ������ �����
T2=upper(get(handles.T2,'String'));

% ������� ������ �����
for t1=1:numel(T1)
% ���������� ������ ��� ��������
ind_in_alf=find(T1(t1)==alf)-1;
% ��������� ����� ��������
new_ind=mod(a*ind_in_alf+b,m);
% �������� ����������� ������      
T1s(t1)=alf(new_ind+1);
end
% ������� ���������
set(handles.T1s,'String',T1s);

% ������� ������ �����
for t2=1:numel(T2)
% ���������� ������ ��� ��������  
ind_in_alf=find(T2(t2)==alf)-1;
% ��������� ����� ��������
new_ind=mod(a*ind_in_alf+b,m);
% �������� ����������� ������    
T2s(t2)=alf(new_ind+1);
end
% ������� ���������
set(handles.T2s,'String',T2s)

function T22_Callback(hObject, eventdata, handles)

function T22_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T2s_Callback(hObject, eventdata, handles)

function T2s_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pushbutton2_Callback(hObject, eventdata, handles)
%% ������������
clc
% �������� ������ �����
T1=upper(get(handles.T1,'String'));
% �������� ������ �����
T2=upper(get(handles.T2,'String'));
% ������ ����������
T1s=upper(get(handles.T1s,'String'));
% ������ ����������
T2s=upper(get(handles.T2s,'String'));
% �������������� ������ ��������� �� ��, ��� ��� ���������� ������������
% ��� ������� ������� �������
alf='�����Ũ��������������������������';
% ������� ��������������� � ������ � �� �������� � �������
mb_alf=(unique(strcat(T1,T2,T1s)));
% ������������ ������� ���������� ��� �����������
alf=(strcat(alf,mb_alf(~ismember(mb_alf,alf))));
% �������� ���������� ��� ���������� ��������� ��������
xx=1;yy=1;
X=[];Y=[];
% ����������� ������ ���� ��������� ��������
while numel(X)<2 
    if ~isempty(find(T1(xx)==alf)) && ~isempty(find(T1s(xx)==alf)) 
    X=[X find(T1(xx)==alf)-1 find(T1s(xx)==alf)-1]
    end
    xx=xx+1;
end
% ����������� ������ ���� ��������� ��������
while numel(Y)<2 
    if ~isempty(find(T1(yy)==alf)) && ~isempty(find(T1s(yy)==alf))  && yy~=xx-1
    Y=[Y find(T1(yy)==alf)-1 find(T1s(yy)==alf)-1]
    end
    yy=yy+1;
end
% ��������� ������������ ����� ��������� (��������� ��������� ������� ������)
% ��������� ��������� �������� �����

% �������� ���������� �����
n2stop=0;
% ����� ��������
m=numel(alf);
% �������� ����������
A=[];B=[];
% �������� ���������� (��� �������� 5)
b=3:15;
% ���� ������ �����
while n2stop~=1
% ����������� ������� ����������� ����� ��� ������
a=VzaimOD(m);
for i=1:numel(a)
    for j=1:numel(b)
% �������� �� ������������ ����������� a b
        res=try_ab(a(i),b(j),m,X,Y);
% ���� ��� ������������� ��������� ������������� �� ���������� ��        
        if res(1)==0 &&  res(2)==0
          A=[A a(i)];
           B=[B b(j)];
        end
    end
end
% � ������ �� ���������� ���������� a b
if isempty(A)==1
% ����������� ����� ��������
               m=m+1;
% ������� �� ����� � ������ ���������� ���������� ��������
               if m>200
                   return
               end
% ��������� �������
alf=strcat(alf,char(174)); 
else
% � ������ ���������� ���������� a b 
% ���������� �������� ����� � a �� ������ m
[G C D]=gcd(A,m);
if D>0
   a_=m+C; 
else
    a_=C;
end
% ������� ������������ ������ ���������� ��� ������ ���������� �����
for i=1:numel(T2s)
% ���������� ������ ������� � ��������
s_ind=find(T2s(i)==alf)-1;
if ~isempty(s_ind)
% ��������� ������ ��� ��������� �������
ind=mod(a_*(s_ind-B),m);
% �������� ������
T22(i)=alf(ind+1);
end
end
% ������� ���������
set(handles.T22,'String',T22);
% �������� ������ ���������, ��� ����������� ������ �����, ������������
% ����������� ����� ������������ 2 �����
prev.X=X; prev.Y=Y;
prev.m=m;prev.alf=alf;
save('prev.mat','prev')

n2stop=1;
end

end


%% ������� �������� ����� 
function res=try_ab(a,b,m,x,y)
res(1)=mod(a*x(1)+b,m)-x(2);
res(2)=mod(a*y(1)+b,m)-y(2);

%% ������� ������ ������� ����������� ����� 
function a_s=VzaimOD(m)
var_a=1:7;
ch=[2 3 5 7];
res=mod(m,ch);
n2d=[];
if res(1)==0
    n2d=[n2d 2 4 6];
end
if res(2)==0
    n2d=[n2d 3 6];
end
if res(3)==0
    n2d=[n2d 5];
end

if res(4)==0
    n2d=[n2d 7];
end
n2d=unique(n2d);
var_a(n2d)='';
for i=1:numel(var_a)
   a_s(i)=var_a(i); 
end


function edit5_Callback(hObject, eventdata, handles)



function edit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function T2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function pushbutton3_Callback(hObject, eventdata, handles)
%% �������� 
% �������� ������ ����������
T2s=get(handles.T2s,'String');
% ��������� ��������� �������������
load('prev.mat');
% �������� ����������
n2stop=0;b=3:15;
A=[];B=[];
% ���� ������ �����
while n2stop~=1
% ����� �������-����������� �����
   a=VzaimOD(prev.m);
% ���� ������ �����   
for i=1:numel(a)
    for j=1:numel(b)
% �������� ����� �� ������������
res=try_ab(a(i),b(j),prev.m,prev.X,prev.Y);
% ������ ����������� �����        
if res(1)==0 &&  res(2)==0
          A=[A a(i)];
           B=[B b(j)];
        end
    end
end
if isempty(A)==1
               prev.m=prev.m+1;
	if prev.m>200
                            errordlg('��������� ����� ��������');
                                return
   	end
prev.alf=strcat(prev.alf,char(174)); 
else
% ����������� ��������� ����� �� ������
[G C D]=gcd(A,prev.m);
if D>0
   a_=prev.m+C; 
else
    a_=C;
end
% �������������
for i=1:numel(T2s)
s_ind=find(T2s(i)==prev.alf)-1;
if ~isempty(s_ind)
ind=mod(a_*(s_ind-B),prev.m);
T22(i)=prev.alf(ind+1);
end
end
% ����� ����������
set(handles.T22,'String',T22);

prev.m=prev.m+1;
save('prev.mat','prev')

n2stop=1;
end

end
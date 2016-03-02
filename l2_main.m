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
% hObject    handle to T1s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T1s as text
%        str2double(get(hObject,'String')) returns contents of T1s as a double


% --- Executes during object creation, after setting all properties.
function T1s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T1s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pushbutton1_Callback(hObject, eventdata, handles)
%% �����������
load('Pref.mat');
clc
alf=Pref{1,2};
a=str2double(Pref{2,2});
b=str2double(Pref{3,2});
m=numel(alf);

T1=upper(get(handles.T1,'String'));
T2=upper(get(handles.T2,'String'));


for t1=1:numel(T1)
   ind_in_alf=find(T1(t1)==alf)-1;

   new_ind=mod(a*ind_in_alf+b,m);
      
   T1s(t1)=alf(new_ind+1);
end

set(handles.T1s,'String',T1s);
% 

for t2=1:numel(T2)
   ind_in_alf=find(T2(t2)==alf)-1;
   new_ind=mod(a*ind_in_alf+b,m);
   T2s(t2)=alf(new_ind+1);
end

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

T1=upper(get(handles.T1,'String'));
T2=upper(get(handles.T2,'String'));
T1s=upper(get(handles.T1s,'String'));
T2s=upper(get(handles.T2s,'String'));
% (unique(strcat(T1,T22,T1s)))
mb_alf=(unique(strcat(T1,T2,T1s)));

alf='�����Ũ��������������������������';

alf=(strcat(alf,mb_alf(~ismember(mb_alf,alf))));

xx=1;yy=1;
X=[];
Y=[];
while numel(X)<2 
    if ~isempty(find(T1(xx)==alf)) && ~isempty(find(T1s(xx)==alf)) 
    X=[X find(T1(xx)==alf)-1 find(T1s(xx)==alf)-1]
    end

    xx=xx+1;
end

while numel(Y)<2 
    if ~isempty(find(T1(yy)==alf)) && ~isempty(find(T1s(yy)==alf))  && yy~=xx-1
    Y=[Y find(T1(yy)==alf)-1 find(T1s(yy)==alf)-1]
    end

    yy=yy+1;
end

n2stop=0;

m=numel(alf)
% m=49;
A=[];
B=[];
b=3:15;
a=VzaimOD(m)
return
while n2stop~=1
   
for i=1:numel(a)
    an=str2double(a(i));
    for j=1:numel(b)
        bn=str2double(b(j));
res=try_ab(an,bn,m,X,Y);
        if res(1)==0 &&  res(2)==0
          A=an;
           B=bn;
        end
    end
end
if isempty(A)==1
               m=m+1;
alf=strcat(alf,char(174)); 
else

[G C D]=gcd(A,m);
if D>0
   a_=m+C; 
else
    a_=C;
end

for i=1:numel(T1s)
    a1=find(T1(i)==alf)-1;
 a2=(mod(A*a1+B,m));
if strcmp(T1s(i),alf(a2+1))~=1
  m=  m+1;
break;
end

end
n2stop=1;
end

end



function res=try_ab(a,b,m,x,y)
res(1)=mod(a*x(1)+b,m)-x(2);
res(2)=mod(a*y(1)+b,m)-y(2);

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

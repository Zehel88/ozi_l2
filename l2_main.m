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

function T2_Callback(hObject, eventdata, handles)
% hObject    handle to T2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2 as text
%        str2double(get(hObject,'String')) returns contents of T2 as a double


% --- Executes during object creation, after setting all properties.
function T2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T2s_Callback(hObject, eventdata, handles)
% hObject    handle to T2s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2s as text
%        str2double(get(hObject,'String')) returns contents of T2s as a double


% --- Executes during object creation, after setting all properties.
function T2s_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2s (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pushbutton2_Callback(hObject, eventdata, handles)
%% ������������
clc
load('a.mat')
load('b.mat')
T1=upper(get(handles.T1,'String'));
T2=upper(get(handles.T2,'String'));
T1s=upper(get(handles.T1s,'String'));
T2s=upper(get(handles.T2s,'String'));
% (unique(strcat(T1,T2,T1s)))
mb_alf=(unique(strcat(T1,T2,T1s)));

alf='�����Ũ��������������������������';

alf=strcat(alf,mb_alf(~ismember(mb_alf,alf)));

m=numel(alf);
% m=49;
A=[];
while isempty(A)==1
for i=1:numel(a)
    an=str2double(a(i));
    for j=1:numel(b)
        bn=str2double(b(j));
res=try_ab(an,bn,m);
        if res==0 
          A= an
           B=bn
           m=m-1
           break

        end

    end

end
            m=m+1;
alf=strcat(alf,'?');
end

% return


[G C D]=gcd(A,m);
if D>0
   a_=m+C; 
else
    a_=C;
end

for i=1:numel(T2s)
    a1=find(T2s(i)==alf)-1;
    if isempty(a1)==0
        a2=fix(mod(a_*(a1-B),m));
        TT(i)=alf(a2+1);
    end
end
TT


function res=try_ab(a,b,m)
res=mod(a*12+b,m)-18-mod(a*32+b,m)+20;


% for i=1:numel(a)
%     an=cell2mat(a(i));
%     for j=1:numel(b)
%         bn=cell2mat(b(i));
%         buf='';
%         for k=1:numel(T1)
%             T1(k)
%            if isempty(find(buf==T1(k)))==1   
%         buf(k)=T1(k)
%            end
%            T1(mod(an*k+bn,mb_alf))
%         if isempty(find(buf==T1(mod(an*k+bn,mb_alf))))==1
%         buf(mod(an*k+bn,mb_alf))=T1s(k)
%         end
% 
%         end
%     end
% end



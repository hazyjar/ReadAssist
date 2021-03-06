
function varargout = audio(varargin)
% AUDIO MATLAB code for audio.fig
%      AUDIO, by itself, creates a new AUDIO or raises the existing
%      singleton*.
%
%      H = AUDIO returns the handle to a new AUDIO or the handle to
%      the existing singleton*.
%
%      AUDIO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUDIO.M with the given input arguments.
%
%      AUDIO('Property','Value',...) creates a new AUDIO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before audio_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to audio_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help audio

% Last Modified by GUIDE v2.5 23-Jun-2018 03:25:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @audio_OpeningFcn, ...
                   'gui_OutputFcn',  @audio_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before audio is made visible.
function audio_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to audio (see VARARGIN)

% Choose default command line output for audio
handles.output = hObject;
[a1,a2]=audioread('test.wav');
 b=audioplayer(a1,a2);
count=0;
setappdata(handles.figure1,'b',b);
setappdata(handles.figure1,'count',count);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes audio wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = audio_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
b=getappdata(handles.figure1,'b');
set(b,'SampleRate',0.4*get(b,'SampleRate'));
 play(b);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
b=getappdata(handles.figure1,'b');
count=getappdata(handles.figure1,'count');
count=count+1;
setappdata(handles.figure1,'count',count);
if mod(count,2)==1
    pause(b);
else
    resume(b);
end 

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
b=getappdata(handles.figure1,'b');
reset=0;
if get(b,'CurrentSample')<=0.5*get(b,'SampleRate')
    reset=0;
else
    reset=get(b,'CurrentSample')-(0.5*get(b,'SampleRate'));
end 
stop(b);
play(b,reset);
    
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
b=getappdata(handles.figure1,'b');
set(b,'SampleRate',1.1*get(b,'SampleRate'));
setappdata(handles.figure1,'b',b);
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
b=getappdata(handles.figure1,'b');
set(b,'SampleRate',get(b,'SampleRate')/1.1);
setappdata(handles.figure1,'b',b);
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

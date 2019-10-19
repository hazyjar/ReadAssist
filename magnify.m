function varargout = magnify(varargin)
% MAGNIFY MATLAB code for magnify.fig
%      MAGNIFY, by itself, creates a new MAGNIFY or raises the existing
%      singleton*.
%
%      H = MAGNIFY returns the handle to a new MAGNIFY or the handle to
%      the existing singleton*.
%
%      MAGNIFY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAGNIFY.M with the given input arguments.
%
%      MAGNIFY('Property','Value',...) creates a new MAGNIFY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before magnify_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to magnify_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help magnify

% Last Modified by GUIDE v2.5 17-Jul-2018 18:23:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @magnify_OpeningFcn, ...
                   'gui_OutputFcn',  @magnify_OutputFcn, ...
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


% --- Executes just before magnify is made visible.
function magnify_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to magnify (see VARARGIN)

% Choose default command line output for magnify
handles.output = hObject;
c =webcam('IPEVO Ziggi-HD Plus') ;
l=string(c.AvailableResolutions);
c.resolution=l(length(l));
frame = snapshot(c);
im = image(handles.axes1, zeros(size(frame), 'uint8'));
preview(c, im)
setappdata(handles.figure1, 'cam', c);
camzoom(2);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes magnify wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = magnify_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%im = image(handles.axes1, zeros(size(frame(270:810,480:1440)), 'uint8'));
%preview(c, im)
%setappdata(handles.figure1, 'cam', c);
camzoom(2/3);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
camzoom(1.5);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);
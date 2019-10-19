function varargout = narrate(varargin)
% EXAMPLE1 MATLAB code for example1.fig
%      EXAMPLE1, by itself, creates a new EXAMPLE1 or raises the existing
%      singleton*.
%
%      H = EXAMPLE1 returns the handle to a new EXAMPLE1 or the handle to
%      the existing singleton*.
%
%      EXAMPLE1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXAMPLE1.M with the given input arguments.
%
%      EXAMPLE1('Property','Value',...) creates a new EXAMPLE1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before example1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to example1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help example1

% Last Modified by GUIDE v2.5 08-Jun-2018 23:06:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @example1_OpeningFcn, ...
                   'gui_OutputFcn',  @example1_OutputFcn, ...
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


% --- Executes just before example1 is made visible.
function example1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to example1 (see VARARGIN)

% Choose default command line output for example1
handles.output = hObject;
c =webcam('IPEVO Ziggi-HD Plus') ;
l=string(c.AvailableResolutions);
c.resolution=l(length(l));
frame = snapshot(c);
im = image(handles.axes1, zeros(size(frame), 'uint8'));

preview(c, im)
setappdata(handles.figure1, 'cam', c);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes example1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = example1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
c=getappdata(handles.figure1,'cam');
v=strfind(c.resolution,'x');
s1=extractBetween(c.resolution,1,v-1);
s2=extractBetween(c.resolution,v+1,length(c.resolution));
width=str2num(char(s1));
height=str2num(char(s2));

 uhexist=false;
            lhexist=false;
            k=0;
            narrate=0;
            while uhexist==false || lhexist==false
                uhexist=false;
                lhexist=false;
            %img=snapshot(webcam);
            im=snapshot(c);
            k=k+1;
            narrate=narrate+1;
%             pause(0.5);
            %imshow(im,'Parent',app.UIAxes);
            img=rgb2gray(im);
            img1=wiener2(img,[75 75]);
            bw=edge(img1,'zerocross',0.005);
            %imshow(bw);
            count=0;
            line=0;
            flag=0;
            start=0;
            i=1;
            
            
            
            while i<=height
            %      disp('loop1');
                j=1;
                while j<=width
            %          disp('loop2');
            %          fprintf('i= %d, j= %d\n',i,j);
                    if bw(i,j)==true 
            %              fprintf('i= %d, j= %d\n',i,j); 
                        if bw(i+1,j-1)==true 
                            i=i+1;
                            j=1;
            %                  disp('changed');
                        else
                            line=i;
                            start=j;
            %                 disp('found');
                            flag=1;
                            break
                        end 
                    else
                        j=j+1;
                    end
                   
                    
                end
                if flag==1
                    break
                else    
                    i=i+1;
                end    
            end
             ul=[line start];
            %  disp(start);
            j=start;
            while j<=width-3
                if line==1
                    if (bw(line,j+1)==true)
                        count=count+1;
                    elseif bw(line+1,j+1)==true
                        line=line+1;
                        count=count+1;
                        
                    elseif bw(line+2,j+2)==true
                        line=line+2;
                        count=count+2;
                    elseif bw(line+1,j+2)==true
                        line=line+1;
                        count=count+2;
                    elseif bw(line,j+2)==true
                        count=count+2;    
                    elseif bw(line+1,j+3)==true
                        line=line+1;
                        count=count+3;
                    elseif bw(line+2,j+3)==true
                        line=line+2;
                        count=count+3;    
                    elseif bw(line+3,j+3)==true
                        line=line+3;
                        count=count+3;
                    else
                        count=count+1;
                        break
            
                    end 
                elseif line==height
                    if (bw(line,j+1)==true)
                        count=count+1;
                    elseif bw(line-1,j+1)==true
                        line=line-1;
                        count=count+1;
                    elseif bw(line-1,j+2)==true
                        line=line-1;
                        count=count+2;
                    elseif bw(line-2,j+2)==true
                        line=line-2;
                        count=count+2;
                    elseif bw(line-1,j+3)==true
                        line=line-1;
                        count=count+3;
                    elseif bw(line-2,j+3)==true
                        line=line-2;
                        count=count+3;    
                    elseif bw(line-3,j+3)==true
                        line=line-3;
                        count=count+3;    
                    else
                        count=count+1;
                        break
            
                    end 
                    elseif line==2
                     if (bw(line,j+1)==true)
                        count=count+1;
                    elseif bw(line+1,j+1)==true
                        line=line+1;
                        count=count+1;
                    elseif bw(line-1,j+1)==true
                        line=line-1;
                        count=count+1;
                    elseif bw(line+2,j+2)==true
                        line=line+2;
                        count=count+2;
              
                    elseif bw(line+1,j+2)==true
                        line=line+1;
                        count=count+2;
                    elseif bw(line-1,j+2)==true
                        line=line-1;
                        count=count+2;
                    elseif bw(line+1,j+3)==true
                        line=line+1;
                        count=count+3;
                    elseif bw(line-1,j+3)==true
                        line=line-1;
                        count=count+3;
                    elseif bw(line+2,j+3)==true
                        line=line+2;
                        count=count+3;
                    elseif bw(line+3,j+3)==true
                        line=line+3;
                        count=count+3;
                     end
                   elseif line==3
                     if (bw(line,j+1)==true)
                        count=count+1;
                    elseif bw(line+1,j+1)==true
                        line=line+1;
                        count=count+1;
                    elseif bw(line-1,j+1)==true
                        line=line-1;
                        count=count+1;
                    elseif bw(line+2,j+2)==true
                        line=line+2;
                        count=count+2;
                    elseif bw(line-2,j+2)==true
                        line=line-2;
                        count=count+2;
                    elseif bw(line+1,j+2)==true
                        line=line+1;
                        count=count+2;
                    elseif bw(line-1,j+2)==true
                        line=line-1;
                        count=count+2;
                    elseif bw(line+1,j+3)==true
                        line=line+1;
                        count=count+3;
                    elseif bw(line-1,j+3)==true
                        line=line-1;
                        count=count+3;
                    elseif bw(line+2,j+3)==true
                        line=line+2;
                        count=count+3;
                    elseif bw(line-2,j+3)==true
                        line=line-2;
                        count=count+3;    
                    elseif bw(line+3,j+3)==true
                        line=line+3;
                        count=count+3;
                     end
                  elseif line==height-1
                     if (bw(line,j+1)==true)
                        count=count+1;
                    elseif bw(line+1,j+1)==true
                        line=line+1;
                        count=count+1;
                    elseif bw(line-1,j+1)==true
                        line=line-1;
                        count=count+1;
                    
                    elseif bw(line-2,j+2)==true
                        line=line-2;
                        count=count+2;
                    elseif bw(line+1,j+2)==true
                        line=line+1;
                        count=count+2;
                    elseif bw(line-1,j+2)==true
                        line=line-1;
                        count=count+2;
                    elseif bw(line+1,j+3)==true
                        line=line+1;
                        count=count+3;
                    elseif bw(line-1,j+3)==true
                        line=line-1;
                        count=count+3;
                   
                    elseif bw(line-2,j+3)==true
                        line=line-2;
                        count=count+3;    
                    
                    elseif bw(line-3,j+3)==true
                        line=line-3;
                        count=count+3;
                     end
                 elseif line==height-2
                     if (bw(line,j+1)==true)
                        count=count+1;
                    elseif bw(line+1,j+1)==true
                        line=line+1;
                        count=count+1;
                    elseif bw(line-1,j+1)==true
                        line=line-1;
                        count=count+1;
                    elseif bw(line+2,j+2)==true
                        line=line+2;
                        count=count+2;
                    elseif bw(line-2,j+2)==true
                        line=line-2;
                        count=count+2;
                    elseif bw(line+1,j+2)==true
                        line=line+1;
                        count=count+2;
                    elseif bw(line-1,j+2)==true
                        line=line-1;
                        count=count+2;
                    elseif bw(line+1,j+3)==true
                        line=line+1;
                        count=count+3;
                    elseif bw(line-1,j+3)==true
                        line=line-1;
                        count=count+3;
                    elseif bw(line+2,j+3)==true
                        line=line+2;
                        count=count+3;
                    elseif bw(line-2,j+3)==true
                        line=line-2;
                        count=count+3;    
                   
                    elseif bw(line-3,j+3)==true
                        line=line-3;
                        count=count+3;
                     end
                elseif line~=0
                     if (bw(line,j+1)==true)
                        count=count+1;
                    elseif bw(line+1,j+1)==true
                        line=line+1;
                        count=count+1;
                    elseif bw(line-1,j+1)==true
                        line=line-1;
                        count=count+1;
                    elseif bw(line+2,j+2)==true
                        line=line+2;
                        count=count+2;
                    elseif bw(line-2,j+2)==true
                        line=line-2;
                        count=count+2;
                    elseif bw(line+1,j+2)==true
                        line=line+1;
                        count=count+2;
                    elseif bw(line-1,j+2)==true
                        line=line-1;
                        count=count+2;
                    elseif bw(line+1,j+3)==true
                        line=line+1;
                        count=count+3;
                    elseif bw(line-1,j+3)==true
                        line=line-1;
                        count=count+3;
                    elseif bw(line+2,j+3)==true
                        line=line+2;
                        count=count+3;
                    elseif bw(line-2,j+3)==true
                        line=line-2;
                        count=count+3;    
                    elseif bw(line+3,j+3)==true
                        line=line+3;
                        count=count+3;
                    elseif bw(line-3,j+3)==true
                        line=line-3;
                        count=count+3;    
                     else
                        count=count+1;
                        break
            
                     end 
                end
                j=j+1;
                    
            end
            ur=[line j];
            if count>(width*.3)
               % disp(count);
              %  disp('Upper Edge Detected');
                uhexist=true;
            end
            
             count1=0;
             line1=0;
             start1=0;
             flag1=0;
             i=height;
            
             while i>=1
                  j=1;
                 while j<=width
                     %disp('in');
            %          if j==800
            %              fprintf('changed and j= %d\n',j); 
            %          end
                     if bw(i,j)==true 
            %              fprintf('i= %d, j= %d\n',i,j); 
                         if bw(i-1,j-1)==true 
                             i=i-1;
                             j=1;
            %                  fprintf('i change= %d, j= %d\n',i,j); 
            %                  disp('changed');
                         else
                             line1=i;
                             start1=j;
                             flag1=1;
            %                  disp('found');
                             break
                         end 
                     else
                         j=j+1;
                     end 
                 end
                 if flag1==1
                    break
                else    
                    i=i-1;
                end 
             end
            %    disp(line1);
            %    disp(start1);
            ll=[line1 start1];
             j=start1;
             while j<=width-3
                if line1==1
                    if (bw(line1,j+1)==true)
                        count1=count1+1;
                    elseif bw(line1+1,j+1)==true
                        line1=line1+1;
                        count1=count1+1;
                        
                    elseif bw(line1+2,j+2)==true
                        line1=line1+2;
                        count1=count1+2;
                    elseif bw(line1+1,j+2)==true
                        line1=line1+1;
                        count1=count1+2;
                    elseif bw(line1,j+2)==true
                        count1=count1+2;    
                    elseif bw(line1+1,j+3)==true
                        line1=line1+1;
                        count1=count1+3;
                    elseif bw(line1+2,j+3)==true
                        line1=line1+2;
                        count1=count1+3;    
                    elseif bw(line1+3,j+3)==true
                        line1=line1+3;
                        count1=count1+3;
                    else
                        count1=count1+1;
                        break
            
                    end 
                elseif line1==height
                    if (bw(line1,j+1)==true)
                        count1=count1+1;
                    elseif bw(line1-1,j+1)==true
                        line1=line1-1;
                        count1=count1+1;
                    elseif bw(line1-1,j+2)==true
                        line1=line1-1;
                        count1=count1+2;
                    elseif bw(line1-2,j+2)==true
                        line1=line1-2;
                        count1=count1+2;
                    elseif bw(line1-1,j+3)==true
                        line1=line1-1;
                        count1=count1+3;
                    elseif bw(line1-2,j+3)==true
                        line1=line1-2;
                        count1=count1+3;    
                    elseif bw(line1-3,j+3)==true
                        line1=line1-3;
                        count1=count1+3;    
                    else
                        count1=count1+1;
                        break
            
                    end 
                    elseif line1==2
                     if (bw(line1,j+1)==true)
                        count1=count1+1;
                    elseif bw(line1+1,j+1)==true
                        line1=line1+1;
                        count1=count1+1;
                    elseif bw(line1-1,j+1)==true
                        line1=line1-1;
                        count1=count1+1;
                    elseif bw(line1+2,j+2)==true
                        line1=line1+2;
                        count1=count1+2;
              
                    elseif bw(line1+1,j+2)==true
                        line1=line1+1;
                        count1=count1+2;
                    elseif bw(line1-1,j+2)==true
                        line1=line1-1;
                        count1=count1+2;
                    elseif bw(line1+1,j+3)==true
                        line1=line1+1;
                        count1=count1+3;
                    elseif bw(line1-1,j+3)==true
                        line1=line1-1;
                        count1=count1+3;
                    elseif bw(line1+2,j+3)==true
                        line1=line1+2;
                        count1=count1+3;
                    elseif bw(line1+3,j+3)==true
                        line1=line1+3;
                        count1=count1+3;
                     end
                   elseif line1==3
                     if (bw(line1,j+1)==true)
                        count1=count1+1;
                    elseif bw(line1+1,j+1)==true
                        line1=line1+1;
                        count1=count1+1;
                    elseif bw(line1-1,j+1)==true
                        line1=line1-1;
                        count1=count1+1;
                    elseif bw(line1+2,j+2)==true
                        line1=line1+2;
                        count1=count1+2;
                    elseif bw(line1-2,j+2)==true
                        line1=line1-2;
                        count1=count1+2;
                    elseif bw(line1+1,j+2)==true
                        line1=line1+1;
                        count1=count1+2;
                    elseif bw(line1-1,j+2)==true
                        line1=line1-1;
                        count1=count1+2;
                    elseif bw(line1+1,j+3)==true
                        line1=line1+1;
                        count1=count1+3;
                    elseif bw(line1-1,j+3)==true
                        line1=line1-1;
                        count1=count1+3;
                    elseif bw(line1+2,j+3)==true
                        line1=line1+2;
                        count1=count1+3;
                    elseif bw(line1-2,j+3)==true
                        line1=line1-2;
                        count1=count1+3;    
                    elseif bw(line1+3,j+3)==true
                        line1=line1+3;
                        count1=count1+3;
                     end
                  elseif line1==height-1
                     if (bw(line1,j+1)==true)
                        count1=count1+1;
                    elseif bw(line1+1,j+1)==true
                        line1=line1+1;
                        count1=count1+1;
                    elseif bw(line1-1,j+1)==true
                        line1=line1-1;
                        count1=count1+1;
                    
                    elseif bw(line1-2,j+2)==true
                        line1=line1-2;
                        count1=count1+2;
                    elseif bw(line1+1,j+2)==true
                        line1=line1+1;
                        count1=count1+2;
                    elseif bw(line1-1,j+2)==true
                        line1=line1-1;
                        count1=count1+2;
                    elseif bw(line1+1,j+3)==true
                        line1=line1+1;
                        count1=count1+3;
                    elseif bw(line1-1,j+3)==true
                        line1=line1-1;
                        count1=count1+3;
                   
                    elseif bw(line1-2,j+3)==true
                        line1=line1-2;
                        count1=count1+3;    
                    
                    elseif bw(line1-3,j+3)==true
                        line1=line1-3;
                        count1=count1+3;
                     end
                 elseif line1==height-2
                     if (bw(line1,j+1)==true)
                        count1=count1+1;
                    elseif bw(line1+1,j+1)==true
                        line1=line1+1;
                        count1=count1+1;
                    elseif bw(line1-1,j+1)==true
                        line1=line1-1;
                        count1=count1+1;
                    elseif bw(line1+2,j+2)==true
                        line1=line1+2;
                        count1=count1+2;
                    elseif bw(line1-2,j+2)==true
                        line1=line1-2;
                        count1=count1+2;
                    elseif bw(line1+1,j+2)==true
                        line1=line1+1;
                        count1=count1+2;
                    elseif bw(line1-1,j+2)==true
                        line1=line1-1;
                        count1=count1+2;
                    elseif bw(line1+1,j+3)==true
                        line1=line1+1;
                        count1=count1+3;
                    elseif bw(line1-1,j+3)==true
                        line1=line1-1;
                        count1=count1+3;
                    elseif bw(line1+2,j+3)==true
                        line1=line1+2;
                        count1=count1+3;
                    elseif bw(line1-2,j+3)==true
                        line1=line1-2;
                        count1=count1+3;    
                   
                    elseif bw(line1-3,j+3)==true
                        line1=line1-3;
                        count1=count1+3;
                     end
                elseif line1~=0
                     if (bw(line1,j+1)==true)
                        count1=count1+1;
                    elseif bw(line1+1,j+1)==true
                        line1=line1+1;
                        count1=count1+1;
                    elseif bw(line1-1,j+1)==true
                        line1=line1-1;
                        count1=count1+1;
                    elseif bw(line1+2,j+2)==true
                        line1=line1+2;
                        count1=count1+2;
                    elseif bw(line1-2,j+2)==true
                        line1=line1-2;
                        count1=count1+2;
                    elseif bw(line1+1,j+2)==true
                        line1=line1+1;
                        count1=count1+2;
                    elseif bw(line1-1,j+2)==true
                        line1=line1-1;
                        count1=count1+2;
                    elseif bw(line1+1,j+3)==true
                        line1=line1+1;
                        count1=count1+3;
                    elseif bw(line1-1,j+3)==true
                        line1=line1-1;
                        count1=count1+3;
                    elseif bw(line1+2,j+3)==true
                        line1=line1+2;
                        count1=count1+3;
                    elseif bw(line1-2,j+3)==true
                        line1=line1-2;
                        count1=count1+3;    
                    elseif bw(line1+3,j+3)==true
                        line1=line1+3;
                        count1=count1+3;
                    elseif bw(line1-3,j+3)==true
                        line1=line1-3;
                        count1=count1+3;    
                     else
                        count1=count1+1;
                        break
            
                     end 
                end
                 j=j+1;
                     
             end
              lr=[line1 j];
            %  disp('count1=');
            %  disp(count1);
             if count1>(width*.3)
               %  disp(count1);
                % disp('Lower Edge Detected');
               % app.DirectionEditField.Value='Lower Edge Detected';
                 lhexist=true;
             end
            
             uhexiststring='';
             lhexiststring='';
             if uhexist==true
                 uhexiststring='true';
             else
                 uhexiststring='false';
             end 
             if lhexist==true
                 lhexiststring='true';
             else
                 lhexiststring='false';
             end 
              set(handles.text3,'String', int2str(k)+" "+int2str(count)+" "+uhexiststring+" "+int2str(count1)+" "+lhexiststring);
             if uhexist==false && lhexist==false
                % disp('NO DOCUMENT DETECTED! PLEASE ENTER A DOCUMENT.');
                set(handles.text2,'String', 'NO DOCUMENT DETECTED! PLEASE ENTER A DOCUMENT.');
                if(mod(narrate,10)==0)
                    tts('NO DOCUMENT DETECTED! PLEASE ENTER A DOCUMENT.');
                end
                %narrate=narrate+1;
                 %app.DirectionEditField.Value='NO DOCUMENT DETECTED! PLEASE ENTER A DOCUMENT.';
             elseif uhexist==true && lhexist==false
                % disp('Slide the document up.');
                set(handles.text2, 'String', 'Slide the document up.');
                if(mod(narrate,10)==0)
                    tts('Slide the document up.');
                end
               % narrate=narrate+1;
                %app.DirectionEditField.Value='Slide the document up.';
             elseif uhexist==false && lhexist==true
                % disp('Slide the document down.');
                set(handles.text2, 'String', 'Slide the document down.');
                if(mod(narrate,10)==0)
                    tts('Slide the document down.');
                end
                %narrate=narrate+1;
                % app.DirectionEditField.Value='Slide the document down.';
             else
                 uh=-atan((ur(1)-ul(1))/(ur(2)-ul(2)))*(180/3.14);
                  lh=-atan((lr(1)-ll(1))/(lr(2)-ll(2)))*(180/3.14);
                  if -atan((ul(1)-ll(1))/(ul(2)-ll(2)))*(180/3.14)>0
                    lv=-atan((ul(1)-ll(1))/(ul(2)-ll(2)))*(180/3.14)-90;
                  else
                      lv=-atan((ul(1)-ll(1))/(ul(2)-ll(2)))*(180/3.14)+90;
                  end 
                  if -atan((ur(1)-lr(1))/(ur(2)-lr(2)))*(180/3.14)>0
                    rv=-atan((ur(1)-lr(1))/(ur(2)-lr(2)))*(180/3.14)-90;
                  else
                      rv=-atan((ur(1)-lr(1))/(ur(2)-lr(2)))*(180/3.14)+90;
                  end 
                  %Icorrected = imtophat(img, strel('disk', 15));
                  %BW1 = imbinarize(Icorrected);
                  %marker = imerode(Icorrected, strel('line',10,0));
                  %Iclean = imreconstruct(marker, Icorrected);
                  %BW2 = imbinarize(Iclean);
                  %txt=ocr(BW2);
                  set(handles.text2, 'String', 'Document Detected');
                  tts('Document Detected');
                  j=imresize(img,2);
                  txt=ocr(j)
                  word=txt.Words;
                  
                  wordBBox=txt.WordBoundingBoxes(:,:);
                  iname=insertObjectAnnotation(im,'rectangle',wordBBox,word);
                  %imshow(iname);
                  %disp(txt.Text);
                  au=tts(txt.Text);
                  %aud=getaudiodata(au);
                  filename='test.wav';
                  audiowrite(filename,au,44100);
                  %f=fopen('test.wav','wt');
                  %fprintf(f,txt.Text);
                  %fclose(f);
                  %winopen a.doc;
                  audio;
                  break;
                  
                   
                %  app.DirectionEditField.Value='Document Detected';
              %  disp('Upper Edge Angle');
               %  disp(uh);
              %   disp('Lower Edge Angle');
              %   disp(lh);
              %   disp('Left Edge Angle');
              %   disp(lv);
              %   disp('Right Edge Angle');
              %   disp(rv);
             end
             if k>30
                 uh=-atan((ur(1)-ul(1))/(ur(2)-ul(2)))*(180/3.14);
                  lh=-atan((lr(1)-ll(1))/(lr(2)-ll(2)))*(180/3.14);
                  if -atan((ul(1)-ll(1))/(ul(2)-ll(2)))*(180/3.14)>0
                    lv=-atan((ul(1)-ll(1))/(ul(2)-ll(2)))*(180/3.14)-90;
                  else
                      lv=-atan((ul(1)-ll(1))/(ul(2)-ll(2)))*(180/3.14)+90;
                  end 
                  if -atan((ur(1)-lr(1))/(ur(2)-lr(2)))*(180/3.14)>0
                    rv=-atan((ur(1)-lr(1))/(ur(2)-lr(2)))*(180/3.14)-90;
                  else
                      rv=-atan((ur(1)-lr(1))/(ur(2)-lr(2)))*(180/3.14)+90;
                  end 
                  %Icorrected = imtophat(img, strel('disk', 15));
                  %BW1 = imbinarize(Icorrected);
                  %marker = imerode(Icorrected, strel('line',10,0));
                  %Iclean = imreconstruct(marker, Icorrected);
                  %BW2 = imbinarize(Iclean);
                  %txt=ocr(BW2);
                  set(handles.text2, 'String', 'Document Detected');
                  tts('Document Detected');
                  j=imresize(img,2);
                  txt=ocr(j)
                  word=txt.Words;
                  
                  wordBBox=txt.WordBoundingBoxes(:,:);
                  iname=insertObjectAnnotation(im,'rectangle',wordBBox,word);
                  %imshow(iname);
                  %disp(txt.Text);
                  au=tts(txt.Text);
                  %aud=getaudiodata(au);
                  filename='test.wav';
                  audiowrite(filename,au,44100);
                  %f=fopen('test.wav','wt');
                  %fprintf(f,txt.Text);
                  %fclose(f);
                  %winopen a.doc;
                  audio;
                  break;
                  
                  
                   
                %  app.DirectionEditField.Value='Document Detected';
              %  disp('Upper Edge Angle');
               %  disp(uh);
              %   disp('Lower Edge Angle');
              %   disp(lh);
              %   disp('Left Edge Angle');
              %   disp(lv);
              %   disp('Right Edge Angle');
              %   disp(rv);
             end
                    %pause(0.1);
            end
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
delete(handles.figure1);
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function varargout = shootingMethod_v1(varargin)
% SHOOTINGMETHOD_V1 MATLAB code for shootingMethod_v1.fig
%      SHOOTINGMETHOD_V1, by itself, creates a new SHOOTINGMETHOD_V1 or raises the existing
%      singleton*.
%
%      H = SHOOTINGMETHOD_V1 returns the handle to a new SHOOTINGMETHOD_V1 or the handle to
%      the existing singleton*.
%
%      SHOOTINGMETHOD_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOOTINGMETHOD_V1.M with the given input arguments.
%
%      SHOOTINGMETHOD_V1('Property','Value',...) creates a new SHOOTINGMETHOD_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before shootingMethod_v1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to shootingMethod_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help shootingMethod_v1

% Last Modified by GUIDE v2.5 16-Feb-2015 10:54:43

%% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @shootingMethod_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @shootingMethod_v1_OutputFcn, ...
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


%% --- Executes just before shootingMethod_v1 is made visible.
function shootingMethod_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to shootingMethod_v1 (see VARARGIN)
    
    

% Choose default command line output for shootingMethod_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes shootingMethod_v1 wait for user response (see UIRESUME)
% uiwait(handles.Shooting_Method);
    set(handles.radiobutton_parallelepiped, 'Value', 0);
    set(handles.radiobutton_sphere, 'Value', 0);
    set(handles.radiobutton_discrete, 'Value', 0);
    set(handles.radiobutton_cont, 'Value', 1);
    set(handles.uipanel_discr, 'Visible', 'off');
    set(handles.uipanel_cont, 'Visible', 'on');

% --- Outputs from this function are returned to the command line.


function varargout = shootingMethod_v1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% Executes on button press in pushbutton_start.
function pushbutton_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   
%this stuff need in each case
    
  type = get(handles.radiobutton_discrete, 'Value');
  % type maybe discrete/maybe contn
  
  tag = 0;
    switch get(get(handles.uipanel_set,'SelectedObject'),'Tag')
        case 'radiobutton_sphere',         tag = 1;
        case 'radiobutton_parallelepiped', tag = 2;
        case 'radiobutton_inequality',     tag = 3;
    end 
    
    if (tag == 3 )
        warning ('Not working in current version.');
    else
        if (tag == 1)
            radius = str2double(get(handles.edit_sphereradius, 'String'));
            center = str2num(get(handles.edit_spherecenter, 'String'));
            box_alpha = [];
            box_beta = [];
    
            if (isnan(radius))
                errordlg ('Radius of sphere is NaN.')
            end
            if (isempty(center))
                errordlg ('Center of sphere is empty.')
            end
        
        elseif (tag == 2)
            
            box_alpha = str2num(get(handles.edit_boxalpha, 'String'));
            box_beta = str2num(get(handles.edit_boxbeta, 'String'));
            radius = NaN;
            center = [];
 
            
        if (isempty(box_alpha) || isempty(box_beta))
           errordlg ('Box is empty.')
        end

      end
    end
    
  if (type == 1)
    dimension = str2double(get(handles.edit_dimension, 'String'));
    iter_numbers = str2double(get(handles.edit_iterations, 'String'));
    alpha = alignalpha(str2num(get(handles.edit_alpha, 'String')), iter_numbers);   
    v0 = str2num(get(handles.edit_v0, 'String'));
    %this stuff need in some case       
    selectF = get(handles.listbox_functional, 'Value')
    
    if (~isnan(dimension) && size(v0, 2) ~= dimension/2)
        warning('===== Size of v0 must be %d.', dimension/2);
    end
    
    v0 = v0';
    
    
    % partial gradient by param - 'w'
    % dimension of this partial gradient - dimension/2
    graddim = dimension/2;
  
        
        %%
          %% MAYBE NEED ADD PRECHECK FOR V0 - V0 in W or not? 
        %%
        w0 = str2num(get(handles.edit_wdist, 'String'));
        if (size(w0, 2) ~= graddim)
          warning ('size w0 must be %d', graddim);
        end  
        vk = shootingmethod(tag, graddim, v0, iter_numbers, alpha, radius, center, box_alpha, box_beta, selectF, w0);                                 
    end

  
  
  %% Type cont
  if (type == 0)
      %% ??
      
      dimension = 2;
      graddim = 1;
      set(handles.edit_dimension, 'String', num2str(dimension));
      %% 
      
      T = str2num(get(handles.edit_timevect, 'String'));
      v0 = get(handles.edit_cont_v0, 'String');
      
      left = T(1);
      right = T(end);
      step = abs(abs(T(2)) - abs(T(1)));
      N = round((right - left)/step + 1);
      
      v0_i = [];
      for i = 1 : 1 : N
       t = step*(i-1);
       v0_i(i) = eval(v0);    
      end
      
      
      w0 = get(handles.edit_cont_w0, 'String');
      w0_i = [];
      for i = 1 : 1 : N
       t = step*(i-1);
       w0_i(i) = eval(w0);    
      end
      
    
      iter_numbers = str2num(get(handles.edit_cont_iter, 'String'))
      alpha = str2double(get(handles.edit_cont_alpha, 'String'));
      
      vkc = shootingmethodcontinuous(v0_i, w0_i, iter_numbers, T, alpha, tag, radius, center, box_alpha, box_beta);
  end
    
%% Edit dimension 
function edit_dimension_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dimension as text
%        str2double(get(hObject,'String')) returns contents of edit_dimension as a double
    
    dimension = str2double((get(hObject,'String')));
    if (isnan(dimension))
      dimension = 0.0;
    else
        dimension = uint16(dimension);
    end
   
    set(handles.edit_dimension, 'String', num2str(dimension));


% --- Executes during object creation, after setting all properties.
function edit_dimension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
    


%% Edit alpha
function edit_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% __________________________________________________________________________<<<<
%_________________________________________________HERE WOULD BE SET PRECISION
% 

% Hints: get(hObject,'String') returns contents of edit_alpha as text
%        str2double(get(hObject,'String')) returns contents of edit_alpha as a double

    alpha = str2num(get(hObject,'String'));
    if (isnan(alpha))
      alpha = 0.0;
    end
    
    set(handles.edit_alpha, 'String', num2str(alpha));

% --- Executes during object creation, after setting all properties.
function edit_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Edit v0
function edit_v0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_v0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_v0 as text
%        str2double(get(hObject,'String')) returns contents of edit_v0 as a double

    v0 = str2num(get(hObject,'String'));
    dimension = str2double(get(handles.edit_dimension, 'String'));
    if(~isnan(dimension))
        if (size(v0, 2) ~= dimension/2)
            warning off backtrace
            warning('===== Size  v0 must be %d. =====\n\n', dimension/2)
        end
    end

% --- Executes during object creation, after setting all properties.
function edit_v0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_v0 (see GCBO) eventdata  reserved - to be
% defined in a future version of MATLAB handles    empty - handles not
% created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





%% --- Downstairs code for Menu Callback's


% --------------------------------------------------------------------
function Menu_open_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    saved_file_name = uigetfile('*.mat','Open file');
    
    if ~isequal(saved_file_name,0)
        
        saved_file = load(fullfile('example', saved_file_name));
       
        set (handles.edit_dimension,  'String', int2str(saved_file.dimension));
        set (handles.edit_alpha,      'String', num2str(saved_file.alpha));
        set (handles.edit_v0,         'String', num2str(saved_file.v0));
        set (handles.edit_iterations, 'String', int2str(saved_file.num_iter));
        
        tag = saved_file.tag;
        
        if strcmp( tag, 'radiobutton_sphere')
            set(handles.radiobutton_sphere,'Value', 1);
        elseif strcmp( tag, 'radiobutton_parallelepiped')
            set(handles.radiobutton_parallelepiped,'Value', 1);
        elseif strcmp( tag, 'radiobutton_inequality')
            set(handles.radiobutton_inequality, 'Value', 1);
        end
        
    end
    
    
    fprintf('Load file %s \n\n', saved_file_name);


% --------------------------------------------------------------------
function Menu_Save_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    alpha      = str2double (get(handles.edit_alpha, 'String'));
    v0         = str2num (get(handles.edit_v0, 'String'));
    dimension  = str2double (get(handles.edit_dimension, 'String'));
    num_iter   = str2double (get(handles.edit_iterations, 'String'));
    
    tag       = get(get(handles.uipanel_set,'SelectedObject'),'Tag');
    
    uisave({'dimension', 'alpha', 'v0', 'num_iter', 'tag'}, 'task');
    fprintf('Save file \n\n');
        
    
 %% Stuff for different set's
function edit_boxalpha_Callback(hObject, eventdata, handles)
% hObject    handle to edit_boxalpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_boxalpha as text
%        str2double(get(hObject,'String')) returns contents of edit_boxalpha as a double


% --- Executes during object creation, after setting all properties.
function edit_boxalpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_boxalpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_boxbeta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_boxbeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_boxbeta as text
%        str2double(get(hObject,'String')) returns contents of edit_boxbeta as a double


% --- Executes during object creation, after setting all properties.
function edit_boxbeta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_boxbeta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_spherecenter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_spherecenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_spherecenter as text
%        str2double(get(hObject,'String')) returns contents of edit_spherecenter as a double


% --- Executes during object creation, after setting all properties.
function edit_spherecenter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_spherecenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sphereradius_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sphereradius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sphereradius as text
%        str2double(get(hObject,'String')) returns contents of edit_sphereradius as a double


% --- Executes during object creation, after setting all properties.
function edit_sphereradius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sphereradius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- Executes during object creation, after setting all properties.
function uipanel_set_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
        


% --- Executes when selected object is changed in uipanel_set.
function uipanel_set_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_set 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

    dimension = str2double(get(handles.edit_dimension, 'String'));
    type = get(handles.radiobutton_discrete, 'Value')
    
    if (type == 1)
      if (~isnan(dimension))
        if(eventdata.NewValue == handles.radiobutton_parallelepiped)
            fprintf('Select parallelepiped \n\n');
            [alpha, beta] = getboxproperties(dimension/2);
            
            set(handles.edit_boxalpha, 'String', num2str(alpha));
            set(handles.edit_boxbeta, 'String', num2str(beta));
            
        end
    
        if(eventdata.NewValue == handles.radiobutton_sphere)
            fprintf('Select sphere\n\n');
            [center, radius] = getsphereproperties(dimension/2);
            
            set(handles.edit_spherecenter, 'String', center);
            set(handles.edit_sphereradius, 'String', radius);
            
        end
      else
        warning('Select the dimension.');
      end
    elseif type == 0
        if(eventdata.NewValue == handles.radiobutton_parallelepiped)
            fprintf('Select parallelepiped \n\n');
            [alpha, beta] = getboxproperties(1);
            
            set(handles.edit_boxalpha, 'String', num2str(alpha));
            set(handles.edit_boxbeta, 'String', num2str(beta));
            
        end
    
        if(eventdata.NewValue == handles.radiobutton_sphere)
            fprintf('Select sphere\n\n');
            [center, radius] = getsphereproperties(1);
            
            set(handles.edit_spherecenter, 'String', center);
            set(handles.edit_sphereradius, 'String', radius);
            
        end
    
    end
    
    
    
    
    
    
%% Close callback
function Menu_Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    fprintf('===== Exit =====\n\n');
    clear; close all force; 



function edit_iterations_Callback(hObject, eventdata, handles)
% hObject    handle to edit_iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_iterations as text
%        str2double(get(hObject,'String')) returns contents of edit_iterations as a double

    iterations = str2double(get(hObject,'String'));
    if (isnan(iterations))
        iterations = 1;
    elseif(iterations < 0)
        iterations = 1;
    end
    set(hObject, 'String', num2str(iterations));


% --- Executes during object creation, after setting all properties.
function edit_iterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_iterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_disturbedmatrix.
function pushbutton_disturbedmatrix_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_disturbedmatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    dimension = str2double(get(handles.edit_dimension, 'String'));
    graddim = dimension/2;
    
    if ~isnan(graddim) && exist('basicmatrixfile.m', 'file')
        disturbedmatrixgui(graddim)
    else
        warning('Dimension is NaN or doesn''t exist basicmatrixfile.m');
    end
        
%%
% --- Executes on selection change in listbox_functional.
function listbox_functional_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_functional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_functional contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_functional
   global selectF;
   selectF = get(hObject,'Value');
   dimension = str2double(get(handles.edit_dimension, 'String'));
   graddim = dimension/2;
   if ~isnan(graddim) && (selectF ~= 4)
     basicmatrix(graddim, selectF);
   elseif selectF == 4
      warning('===== custom functional, look for partionalgradcustom.m =====');
   else
       warning('===== dimension is NaN =====');
   end


% --- Executes during object creation, after setting all properties.
function listbox_functional_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_functional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_wdist_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wdist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wdist as text
%        str2double(get(hObject,'String')) returns contents of edit_wdist as a double

    w0 = str2double(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function edit_wdist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wdist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Menu_Help_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  
  fprintf('Please OPEN IN pdf reader help.pdf \n')



% --------------------------------------------------------------------
function Menu_About_Callback(hObject, eventdata, handles)
% hObject    handle to Menu_About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  fprintf('Autor: Polikarpov Andrey\n December 2014\n email: pandreym@gmail.com \n')



function edit_cont_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cont_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cont_alpha as text
%        str2double(get(hObject,'String')) returns contents of edit_cont_alpha as a double


% --- Executes during object creation, after setting all properties.
function edit_cont_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cont_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cont_iter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cont_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cont_iter as text
%        str2double(get(hObject,'String')) returns contents of edit_cont_iter as a double


% --- Executes during object creation, after setting all properties.
function edit_cont_iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cont_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cont_v0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cont_v0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cont_v0 as text
%        str2double(get(hObject,'String')) returns contents of edit_cont_v0 as a double


% --- Executes during object creation, after setting all properties.
function edit_cont_v0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cont_v0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanel_type.
function uipanel_type_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_type 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
        if(eventdata.NewValue == handles.radiobutton_discrete)
            set(handles.uipanel_discr, 'Visible', 'on')
            set(handles.uipanel_cont, 'Visible', 'off')
        end
    
        if(eventdata.NewValue == handles.radiobutton_cont)
            set(handles.uipanel_discr, 'Visible', 'off')
            set(handles.uipanel_cont, 'Visible', 'on')
        end
  



function edit_timevect_Callback(hObject, eventdata, handles)
% hObject    handle to edit_timevect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_timevect as text
%        str2double(get(hObject,'String')) returns contents of edit_timevect as a double


% --- Executes during object creation, after setting all properties.
function edit_timevect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_timevect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dimension_cont_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dimension_cont (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dimension_cont as text
%        str2double(get(hObject,'String')) returns contents of edit_dimension_cont as a double


% --- Executes during object creation, after setting all properties.
function edit_dimension_cont_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dimension_cont (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cont_w0_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cont_w0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cont_w0 as text
%        str2double(get(hObject,'String')) returns contents of edit_cont_w0 as a double


% --- Executes during object creation, after setting all properties.
function edit_cont_w0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cont_w0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

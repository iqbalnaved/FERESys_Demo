% This function generates the input form to entry the basic user
% informations. After entering the user informations it takes the user to
% the preview window where, he/she takes snapshot from webcam and then
% detects face. The program encodes the detected face using 40 different
% Gabor phase representations at 8 oreintations and 5 scales
% (orient_mu_scale_v) and stores the gabor representations along with the
% basic user informations in a mat file called 'facedata.mat' as a single row.
function datainputform()

    figure('Name', 'Face Recognition System', 'Menubar', 'None'); 
    start_btn = uicontrol('String', 'New', 'Callback', @start_Callback, 'Position', [20 20 100 20]);  
    stop_btn = uicontrol('String', 'Pause', 'Callback', @stop_Callback, 'Position', [120 20 100 20], 'Enable', 'off');  
    snapshot_btn = uicontrol('String', 'Detect Face', 'Callback', @Take_Snapshot_Callback, 'Position', [220 20 100 20], 'Enable', 'off');  
    save_btn = uicontrol('String', 'Save', 'Callback', @save_Callback, 'Position', [320 20 100 20], 'Enable', 'off');  
    edit_btn = uicontrol('String', 'Edit', 'Callback', @edit_Callback, 'Position', [420 20 100 20], 'Enable', 'off');  
    
    function start_Callback(source, eventdata)
        set(stop_btn, 'Enable', 'off');
        set(snapshot_btn, 'Enable', 'off');
        set(save_btn, 'Enable', 'off');
        set(edit_btn, 'Enable', 'off');

        h.fig = figure('Name', 'Data Entry Form', 'Menubar', 'None', 'OuterPosition', [400 180 500 500]);
        set(h.fig,'CloseRequestFcn',@cancel_Callback); % close all window if pressed X from window manager.
        left = 20; bottom = 450; width = 50; height= 20;
        horzdist = 50; vertdist = 30;
        uicontrol(h.fig, 'Style', 'text', 'String', 'Name', 'Position', [left bottom width height]);  
        h.nameEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom width*4 height]);  
        uicontrol(h.fig, 'Style', 'text', 'String', 'ID', 'Position', [left bottom-vertdist width height]);  
        h.idEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-vertdist width+horzdist height]);  
        uicontrol(h.fig, 'Style', 'text', 'String', 'Date of birth', 'Position', [left bottom-2*vertdist width height+10]);  
        
        days = cell(1,31);
        for i = 1:31
            days{i} = num2str(i);
        end
        months = cell(1,12);
        for i = 1:12
            months{i} = num2str(i);
        end       
        datetime = fix(clock);
        years = cell(1,110);
        x = datetime(1)-100:datetime(1);
        for i = 1:length(x)
            years{i} = num2str(x(i));
        end
        
        h.dayPopup = uicontrol(h.fig, 'Style', 'popupmenu', 'String', days, 'Position', [left+horzdist bottom-2*vertdist width height]);  % Position left bottom width height
        h.monthPopup = uicontrol(h.fig, 'Style', 'popupmenu', 'String', months, 'Position', [left+2*horzdist bottom-2*vertdist width height]);  
        h.yearPopup = uicontrol(h.fig, 'Style', 'popupmenu', 'String', years, 'Position', [left+3*horzdist bottom-2*vertdist width height]);          
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'Occupation', 'Position', [left bottom-3*vertdist width height]);  
        h.occEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-3*vertdist width+horzdist height]);  
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'Fathers/Husbands Name', 'Position', [left bottom-4*vertdist width height]);  
        h.fatherHusbandEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-4*vertdist width*4 height]);  
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'Present Address', 'Position', [left bottom-5*vertdist width height]);  
        h.presentAddrEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-5*vertdist-20 width*4 height*2]);  
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'Permanent Address', 'Position', [left bottom-6*vertdist-40 width height+20]);  
        h.permAddrEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-6*vertdist-40 width*4 height*2]);  

        uicontrol(h.fig, 'Style', 'text', 'String', 'Tel No.', 'Position', [left bottom-7*vertdist-40 width height]);  
        h.telEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-7*vertdist-40 width+horzdist height]);  
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'Email', 'Position', [left bottom-8*vertdist-40 width height]);  
        h.emailEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-8*vertdist-40 width*4 height]);  

        h.cancelBtn = uicontrol('Style', 'pushbutton', 'String', 'Cancel', 'Position', [left+horzdist+10 bottom-10*vertdist-40 width height]);          
        set(h.cancelBtn,'Callback', @cancel_Callback);
        
        h.nextBtn = uicontrol('Style', 'pushbutton', 'String', 'Next', 'Position', [left bottom-10*vertdist-40 width height]);  
        set(h.nextBtn, 'Callback', {@next_Callback, h}); % create callback function after creating the object.
        
    end

    function next_Callback(source, eventdata, h)
        set(h.nextBtn, 'Enable', 'off');
        set(h.cancelBtn, 'Enable', 'off');
        
        assignin('base', 'name', get(h.nameEditText, 'string'));
        assignin('base', 'id', get(h.idEditText, 'string'));
        assignin('base', 'occupation', get(h.occEditText, 'string'));
        assignin('base', 'fatherOrHusbandsName', get(h.fatherHusbandEditText, 'string'));
        assignin('base', 'present_addr', get(h.presentAddrEditText, 'string'));
        assignin('base', 'perm_addr', get(h.permAddrEditText, 'string'));
        assignin('base', 'tel', get(h.telEditText, 'string'));
        assignin('base', 'email', get(h.emailEditText, 'string'));        
        
        day = get(h.dayPopup, 'Value');
        month = get(h.monthPopup, 'Value');
        yearIndx = get(h.yearPopup, 'Value');
        
        assignin('base', 'day', day);
        assignin('base', 'month', month);
        assignin('base', 'yearIndx', yearIndx);
        
        datetime = fix(clock);        
        year = datetime(1) - (100 - yearIndx + 1);
        assignin('base', 'dob', [ num2str(day) '-' num2str(month) '-' num2str(year) ]);
        delete(gcf);
        
        obj = videoinput('winvideo', 1);
        vidRes = get(obj, 'VideoResolution'); 
        nBands = get(obj, 'NumberOfBands'); 
        hImage = image( zeros(vidRes(2), vidRes(1), nBands) ); 
        axis off; % Remove axis ticks and numbers
        % base workspace is the workspace that is seen from the MATLAB command
        % line (when not in the debugger).
        assignin('base', 'obj', obj); 
        assignin('base', 'hImage', hImage);
        preview(obj, hImage);
        set(stop_btn, 'Enable', 'on');        
        set(edit_btn, 'Enable', 'on');                
    end

    function cancel_Callback(source, eventdata)
       selection = questdlg('Are you sure?', 'Confirm', 'Yes','No','Yes'); 
       switch selection, 
          case 'Yes',
              % deletes all figures whose handles are not hidden              
              delete(get(0,'Children')); 
          case 'No'
            return 
       end        
    end
    
    function stop_Callback(source, eventdata)
        obj = evalin('base', 'obj');
        stoppreview(obj);
        set(snapshot_btn, 'Enable', 'on'); 
    end

    function Take_Snapshot_Callback(source, eventdata)
        I = FaceDetectCrop(getimage(imgcf));
        if(isempty(I))
            msgbox('Detection failed. Please try again.');
            obj = evalin('base', 'obj');
            hImage = evalin('base', 'hImage');
            preview(obj, hImage);            
        else
            assignin('base', 'I', I);
            set(save_btn, 'Enable', 'on');
        end
    end

    function save_Callback(source, eventdata)
        name = evalin('base', 'name');
        id = evalin('base', 'id');
        occupation = evalin('base', 'occupation');
        dateOfBirth = evalin('base', 'dob');
        fatherOrHusbandsName = evalin('base', 'fatherOrHusbandsName');
        presentAddr = evalin('base', 'present_addr');
        permAddr = evalin('base', 'perm_addr');
        tel = evalin('base', 'tel');
        email = evalin('base', 'email');        
        I = evalin('base', 'I');
        
        isfound = 0;
        files = dir('data\'); % mat file is assumed to be in the current directory with the codes        
        for i = 3:length(files)-2
            if(strcmp(files(i).name, [id '.mat']) == 1) % check if the matfile already exist in the directory
                isfound = 1;
                msgbox('duplicate entry');
                break;
            end
        end
                
        if(isfound == 0)
            LH_Pha = encoding(I, id, 'phase');    % LH_Pha 40x(64x(1x256))

            % cell2mat converts LH{k} from 64x(1x256)cell-array to 1x16384 matrix
            data = {id, I, name, occupation, dateOfBirth, fatherOrHusbandsName, presentAddr, permAddr, tel, email, ...
                cell2mat(LH_Pha{1}), cell2mat(LH_Pha{2}), cell2mat(LH_Pha{3}), cell2mat(LH_Pha{4}), cell2mat(LH_Pha{5}), ...
                cell2mat(LH_Pha{6}), cell2mat(LH_Pha{7}), cell2mat(LH_Pha{8}), cell2mat(LH_Pha{9}), cell2mat(LH_Pha{10}), ... 
                cell2mat(LH_Pha{11}), cell2mat(LH_Pha{12}), cell2mat(LH_Pha{13}), cell2mat(LH_Pha{14}), cell2mat(LH_Pha{15}), ...
                cell2mat(LH_Pha{16}), cell2mat(LH_Pha{17}), cell2mat(LH_Pha{18}), cell2mat(LH_Pha{19}), cell2mat(LH_Pha{20}), ...
                cell2mat(LH_Pha{21}), cell2mat(LH_Pha{22}), cell2mat(LH_Pha{23}), cell2mat(LH_Pha{24}), cell2mat(LH_Pha{25}), ...
                cell2mat(LH_Pha{26}), cell2mat(LH_Pha{27}), cell2mat(LH_Pha{28}), cell2mat(LH_Pha{29}), cell2mat(LH_Pha{30}), ...
                cell2mat(LH_Pha{31}), cell2mat(LH_Pha{32}), cell2mat(LH_Pha{33}), cell2mat(LH_Pha{34}), cell2mat(LH_Pha{35}), ...
                cell2mat(LH_Pha{36}), cell2mat(LH_Pha{37}), cell2mat(LH_Pha{38}), cell2mat(LH_Pha{39}), cell2mat(LH_Pha{40}) 
            }; 

            save(['data\' id], 'data');            
            msgbox('Saved.');
        end
    end

    function edit_Callback(source, eventdata)
        set(start_btn, 'Enable', 'off');
        set(stop_btn, 'Enable', 'off');
        set(snapshot_btn, 'Enable', 'off');
        set(save_btn, 'Enable', 'off');

        name = evalin('base', 'name');
        id = evalin('base', 'id');
        occupation = evalin('base', 'occupation');
        fatherOrHusbandsName = evalin('base', 'fatherOrHusbandsName');
        presentAddr = evalin('base', 'present_addr');
        permAddr = evalin('base', 'perm_addr');
        tel = evalin('base', 'tel');
        email = evalin('base', 'email');        
        day = evalin('base', 'day');        
        month = evalin('base', 'month');        
        yearIndx = evalin('base', 'yearIndx');        

        h.fig = figure('Name', 'Data Entry Form', 'Menubar', 'None', 'OuterPosition', [400 180 500 500]);
        set(h.fig,'CloseRequestFcn',@cancel_Callback); % close all window if pressed X from window manager.
        left = 20; bottom = 450; width = 50; height= 20;
        horzdist = 50; vertdist = 30;
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'Name', 'Position', [left bottom width height]);  
        h.nameEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom width*4 height]);  
        set(h.nameEditText, 'string', name);
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'ID', 'Position', [left bottom-vertdist width height]);  
        h.idEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-vertdist width+horzdist height]);  
        set(h.idEditText, 'string', id);
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'Date of birth', 'Position', [left bottom-2*vertdist width height+10]);  
        
        days = cell(1,31);
        for i = 1:31
            days{i} = num2str(i);
        end
        months = cell(1,12);
        for i = 1:12
            months{i} = num2str(i);
        end       
        datetime = fix(clock);
        years = cell(1,110);
        x = datetime(1)-100:datetime(1);
        for i = 1:length(x)
            years{i} = num2str(x(i));
        end
        
        h.dayPopup = uicontrol(h.fig, 'Style', 'popupmenu', 'String', days, 'Position', [left+horzdist bottom-2*vertdist width height]);  % Position left bottom width height
        set(h.dayPopup, 'Value', day);
        h.monthPopup = uicontrol(h.fig, 'Style', 'popupmenu', 'String', months, 'Position', [left+2*horzdist bottom-2*vertdist width height]);  
        set(h.monthPopup, 'Value', month);
        h.yearPopup = uicontrol(h.fig, 'Style', 'popupmenu', 'String', years, 'Position', [left+3*horzdist bottom-2*vertdist width height]);          
        set(h.yearPopup, 'Value', yearIndx);
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'Occupation', 'Position', [left bottom-3*vertdist width height]);  
        h.occEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-3*vertdist width+horzdist height]);  
        set(h.occEditText, 'string', occupation);
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'Fathers/Husbands Name', 'Position', [left bottom-4*vertdist width height]);  
        h.fatherHusbandEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-4*vertdist width*4 height]);  
        set(h.fatherHusbandEditText, 'string', fatherOrHusbandsName);
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'Present Address', 'Position', [left bottom-5*vertdist width height]);  
        h.presentAddrEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-5*vertdist-20 width*4 height*2]);  
        set(h.presentAddrEditText, 'string', presentAddr);
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'Permanent Address', 'Position', [left bottom-6*vertdist-40 width height+20]);  
        h.permAddrEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-6*vertdist-40 width*4 height*2]);  
        set(h.permAddrEditText, 'string', permAddr);
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'Tel No.', 'Position', [left bottom-7*vertdist-40 width height]);  
        h.telEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-7*vertdist-40 width+horzdist height]);  
        set(h.telEditText, 'string', tel);
        
        uicontrol(h.fig, 'Style', 'text', 'String', 'Email', 'Position', [left bottom-8*vertdist-40 width height]);  
        h.emailEditText = uicontrol(h.fig,'Style', 'edit', 'Position', [left+horzdist bottom-8*vertdist-40 width*4 height]);  
        set(h.emailEditText, 'string', email);

        h.cancelBtn = uicontrol('Style', 'pushbutton', 'String', 'Cancel', 'Position', [left+horzdist+10 bottom-10*vertdist-40 width height]);          
        set(h.cancelBtn,'Callback', 'delete(gcf)');
        
        h.nextBtn = uicontrol('Style', 'pushbutton', 'String', 'Submit', 'Position', [left bottom-10*vertdist-40 width height]);  
        set(h.nextBtn, 'Callback', {@next_Callback, h}); % create callback function after creating the object.
        
    end


end    
    
     

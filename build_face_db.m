clear;clc;
path = 'E:\Face Recognition\Gabor_Phase_Project\db\gallery100\';
files = dir(path);

for i = 3:length(files)
    fileName = files(i).name;
    id = fileName(1:5);
    I = imread([path fileName]);
    
    name = ['test_' num2str(i-2) '_name'];
    occupation = ['test_' num2str(i-2) '_occupation'];
    dateOfBirth = ['test_' num2str(i-2) '_dob'];
    fatherOrHusbandsName = ['test_' num2str(i-2) '_fatherOrHusbandName'];
    presentAddr = ['test_' num2str(i-2) '_presentaddr'];
    permAddr = ['test_' num2str(i-2) '_permaddr'];
    tel = ['test_' num2str(i-2) '_tel'];
    email = ['test_' num2str(i-2) '_email'];
    
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


    save(['data\' id],  'data');            

    display(['saved ' id]);

end

msgbox('complete!');
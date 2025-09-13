%{
1. Tên chủ đề: Huffman coding
2. Lĩnh vực: Xử lí ảnh số - Nén hình ảnh
3. Nội dung đề tài: 
    - Input: Nhập vào 1 chuỗi kí tự và xác suất của từng kí tự
    - Output: Tìm Lavg; Entropy và hiệu suất tương ứng
%}
clc; clear; close all;

% ==========================
% Nhập vào symbol và xác suất
% ==========================
% Ví dụ: 4 ký hiệu với xác suất tương ứng
sym  = {'A','B','C','D'};
prob = [0.4 0.3 0.2 0.1];

% ==========================
% Tạo cây Huffman
% ==========================
dict = huffmandict(sym, prob); % sinh bảng mã Huffman
disp('Bảng mã Huffman:');
disp(dict);

% ==========================
% Tính Lavg
% ==========================
% Lavg = sum(prob(i) * length(code_i))
Lavg = 0;
for i = 1:length(sym)
    codeword = dict{i,2};    % mã nhị phân
    Lavg = Lavg + prob(i) * length(codeword);
end

% ==========================
% Tính Entropy
% ==========================
Entropy = -sum(prob .* log2(prob));

% ==========================
% Hiển thị kết quả
% ==========================
fprintf('Chiều dài trung bình Lavg = %.4f bits/symbol\n', Lavg);
fprintf('Entropy = %.4f bits/symbol\n', Entropy);
fprintf('Hiệu suất = %.2f %%\n', (Entropy/Lavg)*100);


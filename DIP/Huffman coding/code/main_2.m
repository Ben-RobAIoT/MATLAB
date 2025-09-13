% Tự xây dựng thư viện Huffman

% Xóa nói chung (Thường khai báo đầu tiên để xóa toàn bộ - làm sạch workspace)
clc; clear; close all;

% ==========================
% Nhập symbols và xác suất
% ==========================
sym  = {'A','B','C','D'}; % danh sách ký hiệu (cell array)
prob = [0.4 0.3 0.2 0.1]; % xác suất xuất hiện của từng ký hiệu

% ==========================
% Tạo node ban đầu (mỗi symbol là cell)
% ==========================
for i = 1:numel(sym)
    nodes(i).symbol = {sym{i}};  % <-- đảm bảo là cell
    nodes(i).prob   = prob(i);
    nodes(i).left   = [];
    nodes(i).right  = [];
end

% ==========================
% Xây cây Huffman
% ==========================
while numel(nodes) > 1
    % Sắp xếp theo xác suất tăng dần
    [~, idx] = sort([nodes.prob]);
    nodes = nodes(idx);

    % Lấy 2 node có prob nhỏ nhất
    leftNode = nodes(1);
    rightNode = nodes(2);

    % Tạo node cha
    newNode.symbol = [leftNode.symbol rightNode.symbol];
    newNode.prob   = leftNode.prob + rightNode.prob;
    newNode.left   = leftNode;
    newNode.right  = rightNode;

    % Cập nhật list node
    nodes(1:2) = [];
    nodes(end+1) = newNode;
end

% ==========================
% Hàm đệ quy sinh mã Huffman
% ==========================
codes = containers.Map; % key=symbol, value=code

function traverse(node, prefix, codes)
    if isempty(node.left) && isempty(node.right)
        % Node lá
        codes(node.symbol{1}) = prefix;
    else
        if ~isempty(node.left)
            traverse(node.left, [prefix '0'], codes);
        end
        if ~isempty(node.right)
            traverse(node.right, [prefix '1'], codes);
        end
    end
end

% Gọi đệ quy
traverse(nodes, '', codes);

% ==========================
% Tính Lavg và Entropy
% ==========================
Lavg = 0;
for i = 1:numel(sym)
    codeword = codes(sym{i});
    Lavg = Lavg + prob(i) * length(codeword);
end

Entropy = -sum(prob .* log2(prob));

% ==========================
% Kết quả
% ==========================
disp('--- Mã Huffman ---');
for i = 1:numel(sym)
    fprintf('%s : %s\n', sym{i}, codes(sym{i}));
end
fprintf('Lavg = %.4f bits/symbol\n', Lavg);
fprintf('Entropy = %.4f bits/symbol\n', Entropy);
fprintf('Hiệu suất = %.2f %%\n', (Entropy/Lavg)*100);


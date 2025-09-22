# Biến đổi Affine và Đánh giá Sai số trên Ảnh Bàn Cờ

## 1. Giới thiệu
Trong xử lý ảnh số, **biến đổi affine** là một phép biến đổi hình học cơ bản bao gồm xoay, co giãn, tịnh tiến và shear.  
Dự án này minh họa quá trình:
- Tạo ảnh bàn cờ nhân tạo.
- Thực hiện biến đổi affine (xoay + co giãn).
- Áp dụng phép biến đổi nghịch đảo.
- Tính sai số giữa ảnh gốc và ảnh khôi phục.

Ảnh bàn cờ được lựa chọn vì có cấu trúc rõ ràng, độ tương phản cao, rất thích hợp để quan sát sự biến dạng và sai số.

---

## 2. Các bước thực hiện

### Bước 1: Tạo ảnh bàn cờ gốc (f)
- Tạo ảnh bàn cờ 8×8, mỗi ô có kích thước 50 pixel.  
- Ảnh có kích thước 400×400 pixel, với 2 màu trắng đen xen kẽ.

### Bước 2: Xây dựng ma trận biến đổi affine (T)
- Xoay ảnh 30° ngược chiều kim đồng hồ.  
- Co giãn với tỉ lệ 0.75 theo trục X và 1.25 theo trục Y.  
- Ma trận T = S × R (Scale × Rotation).

### Bước 3: Biến đổi ảnh f → f1
- Áp dụng `imwarp` với T.  
- Kết quả: ảnh f1 bị biến dạng.

### Bước 4: Biến đổi ngược f1 → f2
- Tính ma trận nghịch đảo T⁻¹.  
- Áp dụng `imwarp` để thu được ảnh f2 (khôi phục gần ảnh gốc).

### Bước 5: Tính ảnh sai số (f3 = f – f2)
- Chuẩn hóa kích thước 2 ảnh trước khi trừ.  
- Ảnh sai số hiển thị sự khác biệt: vùng tối = sai số nhỏ, vùng sáng = sai số lớn.

### Bước 6: Hiển thị kết quả
- f: ảnh gốc.  
- f1: ảnh sau biến đổi affine.  
- f2: ảnh sau biến đổi nghịch đảo.  
- f3: ảnh sai số.  

---

## 3. Code MATLAB

```matlab
clc; clear; close all;

% Bước 1: Tạo ảnh bàn cờ 8x8
n = 50;
f = checkerboard(n,4,4) > 0.5;
f = double(f);

% Bước 2: Ma trận biến đổi affine
theta = 30*pi/180;
R = [cos(theta) -sin(theta) 0;
     sin(theta)  cos(theta) 0;
     0 0 1];
S = [0.75 0 0;
     0 1.25 0;
     0 0 1];
T = S * R;

% Bước 3: Biến đổi ảnh f -> f1
tform = affine2d(T);
f1 = imwarp(f, tform);

% Bước 4: Biến đổi ngược f1 -> f2
T_inv = inv(T);
tform_inv = affine2d(T_inv);
f2 = imwarp(f1, tform_inv);

% Bước 5: Sai số f3 = f - f2
[m1,n1] = size(f);
[m2,n2] = size(f2);
M = max(m1,m2); N = max(n1,n2);
F  = zeros(M,N); F2 = zeros(M,N);
F(1:m1,1:n1) = f;
F2(1:m2,1:n2) = f2;
f3 = F - F2;

% Bước 6: Hiển thị kết quả
figure;
subplot(2,2,1), imshow(f), title('f: Ảnh gốc');
subplot(2,2,2), imshow(f1), title('f1: Sau biến đổi T');
subplot(2,2,3), imshow(f2), title('f2: Sau biến đổi T^{-1}');
subplot(2,2,4), imshow(f3,[]), title('f3: Sai số (f - f2)');
```
## 4. Ý nghĩa các bước
- Ảnh bàn cờ: mẫu thử chuẩn để dễ dàng quan sát sai số.
- Biến đổi affine: mô phỏng các biến dạng ảnh thường gặp (camera nghiêng, ảnh bị méo).
- Biến đổi nghịch đảo: kiểm chứng khả năng phục hồi thông tin.
- Ảnh sai số: trực quan hóa vùng ảnh bị mất hoặc khác biệt do nội suy.

## 5. Ứng dụng thực tế
- Xử lý ảnh và thị giác máy tính: hiệu chỉnh hình học, chuẩn hóa ảnh trước khi nhận dạng.
- Robot và điều khiển: biến đổi tọa độ giữa camera và robot.
- Y tế: đăng ký ảnh (image registration) trong CT, MRI.
- Đồ họa và truyền thông: hiệu ứng xoay, co giãn trong chỉnh sửa ảnh, game, AR/VR.

## 6. Kết luận
- Dự án cho thấy:
- Biến đổi affine có thể khôi phục gần đúng ảnh gốc.
- Sai số không thể tránh do nội suy và mất dữ liệu.
- Phương pháp này có ý nghĩa lớn trong xử lý ảnh, thị giác máy và nhiều lĩnh vực kỹ thuật.

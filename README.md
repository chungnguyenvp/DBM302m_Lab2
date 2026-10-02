# DBM302m_Lab2

Tài liệu thực hành môn DBM302m.

## Lab 3

Toàn bộ Lab 3 nằm trong thư mục [Lab3](Lab3/). Bốn phần dưới đây thuộc **một bài Lab 3**.

| Phần | Nội dung | Thư mục code và dữ liệu |
| --- | --- | --- |
| 3.1 | Pattern Discovery in Data Mining | [Lab 3.1](Lab3/Lab%203.1/) |
| 3.2 | Pattern Evaluation | [Lab 3.2](Lab3/Lab%203.2/) |
| 3.3 | Mining Sequential Patterns | [Lab 3.3](Lab3/Lab%203.3/) |
| 3.4 | Mining Quality Phrases | [Lab 3.4](Lab3/Lab%203.4/) |

Thư mục `Lab3/` chứa 4 file PowerPoint hướng dẫn. Mỗi thư mục con chứa code mẫu Python (`.py`), R (`.R`) và dữ liệu CSV tương ứng. File `frequent_patterns.csv` có sẵn trong phần 3.3 cũng được giữ nguyên.

Đây là tài liệu và code mẫu của bài lab. Khi làm bài, cần chạy chương trình, đánh giá và giải thích kết quả theo yêu cầu trong slide.

### Notebook tổng hợp

Mở [Lab3_Tong_Hop.ipynb](Lab3/Lab3_Tong_Hop.ipynb) để học và chạy toàn bộ bài lab trong một notebook. Nội dung được sắp xếp theo Apriori, PrefixSpan, K-Means và PMI, nối phần khám phá với đánh giá ngay trong từng chương. Notebook có giải thích bằng tiếng Việt, các bước code ngắn, bảng kết quả, 4 biểu đồ, báo cáo Markdown và phụ lục nguyên văn đủ 8 file Python. Kết quả chạy trên dữ liệu mẫu đã được lưu sẵn.

Nhóm thực hiện gồm **Nguyễn Đức Chung, Đỗ Công Huy và Nguyễn Thăng Long**.

1. Tải hoặc clone repo để có đầy đủ notebook và CSV.
2. Mở notebook bằng Jupyter hoặc VS Code và chọn kernel Python.
3. Chọn **Restart Kernel → Run All**. Cell đầu tự cài các thư viện còn thiếu nếu có kết nối Internet.
4. Bổ sung mã sinh viên và lớp ở đầu notebook. Khi đổi dữ liệu hoặc tham số, chạy lại toàn bộ để cập nhật kết quả và chỉnh số liệu, nhận xét trong báo cáo Markdown cho phù hợp. Báo cáo hiện ghi lần chạy mẫu với tham số mặc định.

Notebook dùng lại kết quả 3.1 để đánh giá ở 3.2; áp dụng PrefixSpan cho chuỗi sản phẩm của 3.3 và PMI cho review của 3.4. Các bảng và hình được xuất vào `Lab3/results_notebook/` khi chạy. Phần kiểm tra bigram liền nhau và mẫu tuần tự đóng được ghi rõ là nội dung bổ sung. Phụ lục code gốc nằm trong Markdown để đối chiếu và không chạy lặp khi chọn Run All.

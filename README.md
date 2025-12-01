# 🖥️ Check CPU Usage for All KVM VPS (Virtualizor / Proxmox / Libvirt)

Script giúp kiểm tra mức sử dụng CPU **thực tế** của tất cả VPS KVM trên máy chủ.
Kết quả được tính theo **% tổng số vCPU của từng VPS**, giống như cách Virtualizor hiển thị.

Ví dụ:
- VPS 4 core đang dùng 27% tổng CPU → hiển thị **27%**
- VPS 4 core ăn full → hiển thị **100%**
- Không còn hiện 200–400% như `%CPU` của Linux.

---

## 🚀 Tính năng
- Lấy danh sách toàn bộ VPS đang chạy (`virsh list`)
- Tự động lấy số vCPU của mỗi VPS (CPU(s) từ `dominfo`)
- Phát hiện PID tiến trình `qemu-kvm` / `qemu-system`
- Tính %CPU trên tổng core → max 100%
- Hiển thị dạng bảng đẹp, dễ đọc
- Chạy được trên:
  - CentOS / AlmaLinux / Rocky Linux
  - Ubuntu / Debian (có libvirt)

---

## 📥 Cài đặt & Chạy nhanh

### **Cách 1 — Tải trực tiếp script từ GitHub**
```bash
cd /root
curl -O https://raw.githubusercontent.com/khiembui-dev/check-cpu-server/main/checkcpu.sh
chmod +x checkcpu.sh
./checkcpu.sh

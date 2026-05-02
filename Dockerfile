# المرحلة الأولى: استخراج ملفات Repocket
FROM repocket/repocket:latest as repocket_builder
WORKDIR /app

# المرحلة الثانية: بناء الصورة النهائية
FROM node:20-alpine

# تثبيت Supervisor و wget و curl و tar و libcap (لـ bitpingd)
RUN apk add --no-cache supervisor wget curl tar libcap bash

# إنشاء مجلدات العمل
WORKDIR /app

# تثبيت Bitpingd
# تنزيل سكريبت التثبيت الرسمي لـ Bitpingd وتشغيله
RUN curl -L https://bitping.com/install.sh -o install_bitpingd.sh && \
    chmod +x install_bitpingd.sh && \
    ./install_bitpingd.sh

# نسخ ملفات Repocket من المرحلة الأولى
COPY --from=repocket_builder /app/dist /app/repocket

# نسخ ملف إعدادات Supervisor
COPY supervisord.conf /etc/supervisord.conf

# تعريف المتغيرات البيئية المطلوبة
ENV BITPING_EMAIL=""
ENV BITPING_PASSWORD=""
ENV RP_EMAIL=""
ENV RP_API_KEY=""

# نقطة الدخول لتشغيل Supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]

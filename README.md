

2.
erfile: ملف بناء صورة Docker الموحدة التي تحتوي على كلتا الخدمتين.

3.
supervisord.conf: ملف إعدادات supervisord لإدارة تشغيل الخدمتين داخل الحاوية.

4.
.env.example: نموذج لملف المتغيرات البيئية (يجب تعبئته ببياناتك).

5.
README.md: هذا الدليل.

خطوات التشغيل محلياً (باستخدام Docker):

1.
تجهيز ملف الإعدادات:
قم بنسخ ملف .env.example إلى ملف جديد باسم .env:

Bash


cp .env.example .env





2.
إدخال بياناتك:
افتح ملف .env وقم بتغيير القيم الافتراضية ببيانات حساباتك:

•
لـ Bitping: BITPING_EMAIL و BITPING_PASSWORD.

•
لـ Repocket: RP_EMAIL و RP_API_KEY.



3.
بناء صورة Docker:
توجه إلى المجلد الذي يحتوي على Dockerfile وقم ببناء الصورة:

Bash


docker build -t bitping-repocket-combined .





4.
تشغيل الحاوية:
قم بتشغيل الحاوية مع تمرير المتغيرات البيئية من ملف .env:

Bash


docker run -d --name bitping-repocket --env-file ./.env bitping-repocket-combined





النشر على Railway:

للنشر على Railway، ستحتاج إلى ربط مستودع GitHub الخاص بك بـ Railway. ستقوم Railway تلقائياً باكتشاف Dockerfile وبناء الصورة وتشغيلها.

1.
تأكد من رفع الملفات إلى GitHub:
تأكد من أن ملفات Dockerfile و supervisord.conf و README.md و .env.example مرفوعة إلى مستودع GitHub الخاص بك.
تذكر: لا ترفع ملف .env الذي يحتوي على بياناتك الحساسة!

2.
إنشاء مشروع جديد على Railway:

•
اذهب إلى Railway وسجل الدخول.

•
أنشئ مشروعاً جديداً (New Project).

•
اختر Deploy from GitHub Repo وقم بربط المستودع الذي يحتوي على هذه الملفات.



3.
إعداد المتغيرات البيئية في Railway:
بعد أن يقوم Railway باكتشاف المستودع، سيبدأ في محاولة البناء. قبل أن يكتمل البناء بنجاح، ستحتاج إلى إضافة المتغيرات البيئية:

ملاحظة: يجب أن تكون أسماء المتغيرات مطابقة تماماً لما هو موجود في supervisord.conf (مثل BITPING_EMAIL وليس BITPING_EMAIL).

•
اذهب إلى إعدادات الخدمة في Railway (التي تم إنشاؤها من المستودع).

•
اذهب إلى تبويب Variables.

•
أضف المتغيرات التالية مع قيمها الصحيحة:

•
BITPING_EMAIL

•
BITPING_PASSWORD

•
RP_EMAIL

•
RP_API_KEY





4.
مراقبة النشر:
راقب سجلات النشر (Deploy Logs) في Railway للتأكد من أن الخدمتين بدأتا العمل بنجاح. إذا كانت هناك أي أخطاء، فستظهر هناك.

ملاحظات هامة:

•
تم إعداد supervisord لضمان بقاء كلتا الخدمتين قيد التشغيل وإعادة تشغيلهما تلقائياً في حال توقفهما.

•
تأكد من أن جميع المتغيرات البيئية قد تم إعدادها بشكل صحيح في Railway قبل محاولة النشر.


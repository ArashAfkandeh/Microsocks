<div style="text-align: right;">
    <a href="/README.en.md"><img src="https://flagicons.lipis.dev/flags/4x3/gb.svg" alt="English" width="20"/> English</a> | 
    <a href="/README.md"><img src="https://flagicons.lipis.dev/flags/4x3/ir.svg" alt="فارسی" width="20"/> فارسی</a>
</div>
<br><br>

# نصب آسان پراکسی Microsocks

این پروژه با یک دستور پراکسی SOCKS5 مایکروساکس را بر روی سیستم لینوکس شما نصب می‌کند.

## پیش‌نیازها

- یک سیستم لینوکس با دسترسی `sudo`.
- مدیر بسته `apt` (مورد استفاده در توزیع‌های مبتنی بر دبیان/اوبونتو).

## نصب

دستور زیر را برای نصب تعاملی اجرا کنید:

```bash
bash <(curl -sSL https://raw.githubusercontent.com/ArashAfkandeh/Microsocks/main/install.sh)
```

مقادیر زیر به ترتیب از شما پرسیده می‌شود:
- **شماره پورت (ضروری):** پورتی که پراکسی SOCKS5 روی آن گوش می‌دهد (مثلاً `1080`).
- **نام کاربری (اختیاری):** اگر می‌خواهید پراکسی خود را با نام کاربری ایمن کنید، آن را در اینجا وارد کنید. برای رد شدن، Enter را فشار دهید.
- **رمز عبور (اختیاری):** اگر نام کاربری ارائه کرده‌اید، رمز عبور آن را وارد کنید.

**یا می‌توانید از آرگوما‌های ورودی استفاده کنید:**

بدون احراز هویت:
```bash
bash <(curl -sSL https://raw.githubusercontent.com/ArashAfkandeh/Microsocks/main/install.sh) '1080'
```

با احراز هویت:
```bash
bash <(curl -sSL https://raw.githubusercontent.com/ArashAfkandeh/Microsocks/main/install.sh) '1080' 'admin' '12345'
```

- **نکته:** مقدار آرگومان اول (پورت `PORT`) ضروری است، واگرنه به حالت تعاملی پاس داده می‌شوید.

## استفاده

پس از نصب اسکریپت، جزئیات پراکسی SOCKS5 اینگونه نمایش داده می‌دهد:

<div style="display: flex; justify-content: center;">
    <img src="https://github.com/ArashAfkandeh/Microsocks/blob/main/Preview.jpg" alt="Preview" style="width: 400px; height: auto; border-radius: 10px;">
</div>

- **آدرس IP:** آدرس IP عمومی سرور شما.
- **پورت:** پورتی که در حین نصب مشخص کرده‌اید.
- **نام کاربری (در صورت تنظیم):** نام کاربری که پیکربندی کرده‌اید.
- **رمز عبور (در صورت تنظیم):** رمز عبوری که پیکربندی کرده‌اید.

می‌توانید برنامه‌های خود (مانند مرورگرهای وب، برنامه‌های پیام‌رسان) را با این جزئیات برای استفاده از پراکسی SOCKS5 پیکربندی کنید.

## حذف نصب

برای حذف کامل پراکسی `microsocks` و پیکربندی آن، دستور زیر را در ترمینال خود اجرا کنید:

```bash
bash <(curl -sSL https://raw.githubusercontent.com/ArashAfkandeh/Microsocks/main/uninstall.sh)
```


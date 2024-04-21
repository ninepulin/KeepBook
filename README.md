วิธีใช้งาน KeepBook 

ข้อ 1: ดาวน์โหลดและติดตั้ง Project

โดยสามารถ โหลด ได้จาก https://github.com/ninepulin/Keepbook
เปิดโฟลเดอร์ Project ในโปรแกรม Visual Studio Code (VSCode)

ข้อ 2: ติดตั้ง Dependencies

คลิกขวาที่ไฟล์ pubspec.yaml แล้วเลือก Open Internal Command
ในหน้าต่าง Terminal ที่ปรากฏขึ้น พิมพ์คำสั่ง flutter pub get
รอให้ Dependencies ทั้งหมดถูกติดตั้ง

ข้อ 3: รัน Project

คลิกไฟล์ main.dart
เปิด Emulator หรือเชื่อมต่อกับอุปกรณ์ Android จริง
เลือกอุปกรณ์ Android ที่ต้องการรัน Project บนหน้าต่าง Emulator Manager
คลิกปุ่ม Start Debug บนขวาบนของหน้าต่าง VSCode

ข้อ 4: การใช้งาน

โดยหน้าเเรกจะเป็นหน้าในการ Login ส่วนขวาล่างจะมีปุ่ม Create Account เพื่อใช้ในการสร้างรหัส โดย ให้ ใส่ Username,Email,Passwordเเละ Phone number
โดยจะใช้ Email เเละ Password ในการ Login
หลังจากเข้ามาเเล้วก็จะเจอหน้าที่ใช้ในการเลือกซื้อสินค้าโดยสามารถ เลือกซื้อหนังสือได้ โดยเมื่อ กด buy จะไป หน้า ยืนยัน เเละเมื่อกด Confirm Purchase ก็จะทำ การ เพิ่มหนังสือไปที่ Bookshelf
ในส่วนของหน้า SearchPage กดที่ รูป เเว่นขยายขวาบน จะพาไปยังหน้า ค้น หาซึ่งจะสามารถ กด เพื่อดูได้ว่าใน App ของเรานั้นมี หนังสืออะไรบ้าง 
หน้า Setting รูปคน ขวาล่าง จะพาไปหน้า Setting ซึ่ง จะสามารถ ไป ยัง Bookshelf หรอ ใช้ในการ Log out ได้
หน้าที่ใช้ในการอ่านเนื้อหายังไม่สมบูรณ์ จึงไม่สามารถดึงเนื้อหาจาก firebase มาเเสดงได้ 

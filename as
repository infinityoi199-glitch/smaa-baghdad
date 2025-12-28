<!DOCTYPE html>
<html lang="ar">
<head>
<meta charset="UTF-8">
<title>سما بغداد</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body{font-family:Tahoma;direction:rtl;background:#f3f3f3;padding:15px}
.box{background:#fff;padding:15px;border-radius:8px;max-width:420px;margin:auto}
input,textarea,button{width:100%;padding:10px;margin:6px 0}
button{background:#0a4;color:#fff;border:none;border-radius:5px}
</style>
</head>

<body>
<div class="box">
<h2>سما بغداد</h2>

<input id="shop" placeholder="اسم المحل">
<input id="phone" placeholder="رقم الهاتف">
<textarea id="note" placeholder="ملاحظات"></textarea>

<button onclick="getLocation()">📍 أخذ الموقع</button>
<div id="loc">الموقع: غير محدد</div>

<button onclick="printPDF()">📄 إنشاء PDF</button>
</div>

<script>
let locationText="غير محدد";

function getLocation(){
 navigator.geolocation.getCurrentPosition(p=>{
  locationText=p.coords.latitude+","+p.coords.longitude;
  loc.innerText="الموقع: "+locationText;
 });
}

function printPDF(){
 let w=window.open("");
 w.document.write(`
 <h2>سما بغداد</h2>
 <p>اسم المحل: ${shop.value}</p>
 <p>الهاتف: ${phone.value}</p>
 <p>التاريخ: ${new Date().toLocaleString()}</p>
 <p>الموقع: ${locationText}</p>
 <p>ملاحظات:<br>${note.value}</p>
 `);
 w.print();
}
</script>
</body>
</html>

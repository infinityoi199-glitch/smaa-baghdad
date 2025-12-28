<!DOCTYPE html>
<html lang="ar">
<head>
<meta charset="UTF-8">
<title>سما بغداد</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- مكتبة PDF -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

<style>
body{
 font-family:Tahoma;
 direction:rtl;
 background:#f2f2f2;
 padding:15px
}
.box{
 background:#fff;
 padding:15px;
 border-radius:8px;
 max-width:420px;
 margin:auto;
 box-shadow:0 0 10px #ccc
}
h2{text-align:center;color:#0a4}
input,textarea,button{
 width:100%;
 padding:10px;
 margin:6px 0;
 font-size:15px
}
button{
 background:#0a4;
 color:#fff;
 border:none;
 border-radius:5px
}
.info{font-size:13px;color:#444}
</style>
</head>

<body>

<div class="box">
<h2>سما بغداد</h2>

<input id="shop" placeholder="اسم المحل">
<input id="phone" placeholder="رقم الهاتف">
<textarea id="note" placeholder="ملاحظات"></textarea>

<button onclick="getLocation()">📍 أخذ الموقع</button>
<div id="loc" class="info">الموقع: غير محدد</div>

<button onclick="savePDF()">📄 حفظ PDF</button>
<div id="msg" class="info"></div>
</div>

<!-- محتوى PDF المخفي -->
<div id="pdfContent" style="display:none">
<h2>سما بغداد</h2>
<p><b>اسم المحل:</b> <span id="pShop"></span></p>
<p><b>رقم الهاتف:</b> <span id="pPhone"></span></p>
<p><b>تاريخ الزيارة:</b> <span id="pDate"></span></p>
<p><b>الموقع:</b> <span id="pLocation"></span></p>
<p><b>رابط الخريطة:</b><br><span id="pMap"></span></p>
<p><b>ملاحظات:</b><br><span id="pNote"></span></p>
</div>

<script>
let locationText="";
let mapLink="";

function getLocation(){
 if(!navigator.geolocation){
  loc.innerText="الموقع غير مدعوم";
  return;
 }
 loc.innerText="⏳ جارٍ تحديد الموقع...";
 navigator.geolocation.getCurrentPosition(
  p=>{
   locationText = p.coords.latitude + "," + p.coords.longitude;
   mapLink = "https://maps.google.com/?q=" + locationText;
   loc.innerText="📍 الموقع محفوظ";
  },
  e=>{
   loc.innerText="❌ لم يتم السماح بالموقع";
  }
 );
}

function savePDF(){
 if(!shop.value || !phone.value){
  msg.innerText="يرجى إدخال اسم المحل ورقم الهاتف";
  return;
 }
 if(!locationText){
  msg.innerText="يرجى أخذ الموقع أولًا";
  return;
 }

 pShop.innerText = shop.value;
 pPhone.innerText = phone.value;
 pDate.innerText = new Date().toLocaleString();
 pLocation.innerText = locationText;
 pMap.innerText = mapLink;
 pNote.innerText = note.value;

 html2pdf()
  .from(document.getElementById("pdfContent"))
  .set({
    margin: 10,
    filename: "زيارة-سما-بغداد.pdf",
    html2canvas: { scale: 2 },
    jsPDF: { orientation: 'portrait', unit: 'mm', format: 'a4' }
  })
  .save();
}
</script>

</body>
</html>

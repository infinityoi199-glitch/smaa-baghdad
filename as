<!DOCTYPE html>
<html lang="ar">
<head>
<meta charset="UTF-8">
<title>سما بغداد</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
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

<button onclick="addPhoto()">📸 إضافة صورة</button>
<div id="photos" class="info"></div>

<button onclick="savePDF()">📄 حفظ PDF</button>
<div id="msg" class="info"></div>
</div>

<script>
let locationText="غير محدد";
let photoCount=0;

function getLocation(){
 if(!navigator.geolocation){
  loc.innerText="الموقع غير مدعوم";
  return;
 }
 navigator.geolocation.getCurrentPosition(
  p=>{
   locationText = p.coords.latitude + "," + p.coords.longitude;
   loc.innerText="الموقع: "+locationText;
  },
  e=>{
   loc.innerText="لم يتم السماح بالموقع";
  }
 );
}

function addPhoto(){
 let i=document.createElement("input");
 i.type="file";
 i.accept="image/*";*

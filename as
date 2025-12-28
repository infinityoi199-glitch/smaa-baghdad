<!DOCTYPE html>
<html lang="ar">
<head>
<meta charset="UTF-8">
<title>سما بغداد - إدارة الزيارات</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
<style>
body{font-family:Tahoma;direction:rtl;background:#f2f4f7;padding:15px}
.container{max-width:430px;margin:auto;background:#fff;padding:20px;border-radius:10px;box-shadow:0 5px 15px rgba(0,0,0,.15)}
h2{text-align:center;color:#0a7}
input,textarea,button{width:100%;padding:12px;margin:6px 0;border-radius:6px;font-size:15px}
button{background:#0a7;color:#fff;border:none}
.small{font-size:13px;color:#555}
.visit{border-bottom:1px solid #ddd;padding:8px 0}
</style>
</head>
<body>

<div class="container">
<h2>سما بغداد</h2>

<input id="shop" placeholder="اسم المحل">
<input id="phone" placeholder="رقم الهاتف">
<textarea id="notes" placeholder="ملاحظات"></textarea>

<button onclick="getLocation()">📍 أخذ الموقع</button>
<button onclick="addImage()">📸 إضافة صورة</button>

<label class="small">
<input type="checkbox" id="savePdf" checked> حفظ ملف PDF
</label>

<button onclick="saveVisit()">💾 حفظ الزيارة</button>

<div id="status" class="small"></div>
<hr>
<h3>📂 الزيارات المحفوظة</h3>
<div id="list"></div>
</div>

<!-- PDF -->
<div id="pdf" style="display:none">
<h3>سما بغداد</h3>
<p><b>اسم المحل:</b> <span id="pShop"></span></p>
<p><b>الهاتف:</b> <span id="pPhone"></span></p>
<p><b>تاريخ الزيارة:</b> <span id="pDate"></span></p>
<p><b>الموقع:</b> <span id="pLocation"></span></p>
<p><b>ملاحظات:</b> <span id="pNotes"></span></p>
</div>

<script>
let locationLink="",images=[];

function getLocation(){
 navigator.geolocation.getCurrentPosition(p=>{
  locationLink=`https://maps.google.com/?q=${p.coords.latitude},${p.coords.longitude}`;
  status.innerText="📍 تم تحديد الموقع";
 });
}

function addImage(){
 let i=document.createElement("input");
 i.type="file"; i.accept="image/*";
 i.onchange=e=>images.push(URL.createObjectURL(e.target.files[0]));
 i.click();
}

function saveVisit(){
 let date=new Date().toLocaleString();
 let data={shop:shop.value,phone:phone.value,notes:notes.value,location:locationLink,date:date};
 localStorage.setItem(Date.now(),JSON.stringify(data));
 if(savePdf.checked) makePDF(data);
 loadVisits();
 status.innerText="✅ تم حفظ الزيارة";
}

function makePDF(d){
 pShop.innerText=d.shop;
 pPhone.innerText=d.phone;
 pDate.innerText=d.date;
 pLocation.innerText=d.location;
 pNotes.innerText=d.notes;
 html2pdf().from(pdf).save("زيارة-"+Date.now()+".pdf");
}

function loadVisits(){
 list.innerHTML="";
 Object.keys(localStorage).forEach(k=>{
  let v=JSON.parse(localStorage[k]);
  list.innerHTML+=`
   <div class="visit">
    <b>${v.shop}</b><br>
    📞 <a href="tel:${v.phone}">${v.phone}</a><br>
    🕒 ${v.date}
   </div>`;
 });
}
loadVisits();
</script>

</body>
</html>

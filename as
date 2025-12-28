<script>
let locationText="";
let locationReady=false;
let photoCount=0;

function getLocation(){
 if(!navigator.geolocation){
  loc.innerText="الموقع غير مدعوم";
  return;
 }
 loc.innerText="⏳ جارٍ تحديد الموقع...";
 navigator.geolocation.getCurrentPosition(
  p=>{
   locationText =
    p.coords.latitude + "," + p.coords.longitude;
   loc.innerText="📍 الموقع محفوظ";
   locationReady=true;
  },
  e=>{
   loc.innerText="❌ لم يتم السماح بالموقع";
  }
 );
}

function addPhoto(){
 let i=document.createElement("input");
 i.type="file";
 i.accept="image/*";
 i.onchange=()=>{
  photoCount++;
  photos.innerText="عدد الصور المضافة: "+photoCount;
 };
 i.click();
}

function savePDF(){
 if(!shop.value || !phone.value){
  msg.innerText="يرجى إدخال اسم المحل ورقم الهاتف";
  return;
 }

 if(!locationReady){
  msg.innerText="⚠️ يرجى أخذ الموقع أولًا قبل حفظ PDF";
  return;
 }

 let date=new Date().toLocaleString();
 let mapLink="https://maps.google.com/?q="+locationText;

 let w=window.open("");
 w.document.write(`
 <html>
 <head><title>زيارة - سما بغداد</title></head>
 <body style="font-family:Tahoma;direction:rtl">
 <h2>سما بغداد</h2>
 <p><b>اسم المحل:</b> ${shop.value}</p>
 <p><b>رقم الهاتف:</b> ${phone.value}</p>
 <p><b>تاريخ الزيارة:</b> ${date}</p>
 <p><b>الموقع:</b> ${locationText}</p>
 <p><b>رابط الخريطة:</b><br>
 <a href="${mapLink}">${mapLink}</a></p>
 <p><b>ملاحظات:</b><br>${note.value}</p>
 </body>
 </html>
 `);
 w.document.close();
 w.focus();
 w.print();
}
</script>

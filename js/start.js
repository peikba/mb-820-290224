var controlAddIn, nameDiv, phoneDiv, emailDiv;
controlAddIn = $("#controlAddIn");
nameDiv = $("<div />", { id: "nameDiv" });
phoneDiv = $("<div />", { id: "phoneDiv" });
emailDiv = $("<div />", { id: "emailDiv" }); 

controlAddIn.append(nameDiv);
controlAddIn.append(phoneDiv);
controlAddIn.append(emailDiv);

function GetCustomerInfo(custInfo) {
    nameDiv.html("Name: " + custInfo.name);
    phoneDiv.html("Phone: " + custInfo.phone);
    emailDiv.html("E-mail: " + custInfo.email);
}
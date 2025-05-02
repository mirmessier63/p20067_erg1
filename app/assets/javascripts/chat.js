document.querySelector(".openChatBtn").addEventListener("click", openForm);

function openForm() {
    if (document.querySelector(".openChat").style.display === "") {
        document.querySelector(".openChat").style.display = "block"
    } else if (document.querySelector(".openChat").style.display === "none") {
        document.querySelector(".openChat").style.display = "block"
    }else if (document.querySelector(".openChat").style.display === "block") {
        document.querySelector(".openChat").style.display = "none"
    }
}

function newConversation() {
    const existingChats = document.getElementById("existingChats");
    existingChats.style.display = "none";
    const newChat = document.getElementById("newChat");
    newChat.style.display = "block";
}

function startConversation() {
    const chatName = document.getElementById("chatName").value;

    const selectedContactList = document.querySelectorAll("input[type=checkbox]:checked");
    let selected = Array.from(selectedContactList).map(x => x.name);

    let json = {};

    json["chatName"] = chatName;
    json["participants"] = {};
    json["message"] = {};

    for (let i = 0; i < selected.length; i++) {
        json["participants"][i] = selected[i];
    }
    const xhttp = new XMLHttpRequest();

    xhttp.open('POST', "/create_conversation", true);
    xhttp.setRequestHeader('Content-type', 'application/json; charset=UTF-8');

    if (chatName !== "" && selected.length > 0) {
        goToChatScreen(xhttp, json, chatName);
    }

}

function goToChatScreen(xhttp, json, chatName) {
    const selectScreen = document.getElementById("newChat");
    selectScreen.style.display = "none";
    const chatScreen = document.getElementById("chatScreen");
    chatScreen.style.display = "block";
    const createTextContainer = document.getElementById("createTextContainer");
    createTextContainer.style.display = "block";

    document.getElementById("chatNameText").textContent = chatName;

    document.querySelector(".createButton").addEventListener("click", function() {
        createAndSendChat(xhttp, json)
    });
}

function createAndSendChat(xhttp, json) {
    json["message"] = document.getElementById("createText").value;
    let s = JSON.stringify(json);

    xhttp.send(s);
    xhttp.onload = function () {
        location.reload()
    }
}

function getChat(chat_id) {
    const existingChats = document.getElementById("existingChats");
    existingChats.style.display = "none";
    const chatScreen = document.getElementById("chatScreen");
    chatScreen.style.display = "block";
    const messagesContainer = document.getElementById("messagesContainer");
    messagesContainer.style.display = "block";
    const backButton = document.getElementById("backButton");
    backButton.style.display = "block";
    const sendContainer = document.getElementById("sendContainer");
    sendContainer.style.display = "block";
    const refreshButton = document.getElementById("refreshButton");
    refreshButton.style.display = "block";

    document.getElementById("chatId").value = chat_id;

    refreshChat(chat_id);

    document.querySelector(".backButton").addEventListener("click", function() {
        backFromChat()
    });

    document.querySelector(".refreshButton").addEventListener("click", function() {
        refreshChat(chat_id)
    });
}

function refreshChat(chat_id) {
    document.getElementById("messagesContainer").innerHTML = "";
    const xhttp = new XMLHttpRequest();
    xhttp.open('POST', "/get_chat", true);
    xhttp.setRequestHeader('Content-type', 'application/json; charset=UTF-8');
    let json = {};
    json["chat_id"] = chat_id;

    let s = JSON.stringify(json);

    let response = {};
    xhttp.send(s);

    xhttp.onload = function () {
        response = JSON.parse(xhttp.responseText);
        let containerText = "";
        for (let r in response) {
            containerText = containerText.concat("From ");
            containerText = containerText.concat(response[r]["sender_email"]);
            containerText = containerText.concat(":");
            containerText = containerText.concat("<br>");
            containerText = containerText.concat(response[r]["message"]);
            containerText = containerText.concat("<br>")
        }
        containerText = containerText.concat("<br>")
        document.getElementById("messagesContainer").innerHTML = containerText;
    }


}

function sendMessage() {
    const xhttp = new XMLHttpRequest();
    xhttp.open('POST', "/send_message", true);
    xhttp.setRequestHeader('Content-type', 'application/json; charset=UTF-8');

    const text = document.getElementById("text").value;

    let json = {};
    json["chat_id"] = document.getElementById("chatId").value;
    json["message"] = text;

    let s = JSON.stringify(json);

    xhttp.send(s);

    refreshChat(document.getElementById("chatId").value);
}

function backFromChat() {
    const existingChats = document.getElementById("existingChats");
    existingChats.style.display = "block";
    const chatScreen = document.getElementById("chatScreen");
    chatScreen.style.display = "none";
    const messagesContainer = document.getElementById("messagesContainer");
    messagesContainer.style.display = "none";
    const backButton = document.getElementById("backButton");
    backButton.style.display = "none";
    const refreshButton = document.getElementById("refreshButton");
    refreshButton.style.display = "none";

}
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<html>
<head>
    <style type="text/css">
        <%@include file="/WEB-INF/css/style.css" %>
    </style>
    <style type="text/css">
        <%@include file="/WEB-INF/css/navbar.css" %>
    </style>
    <title>TelegramBot</title>
</head>
<body>
<div class="nav">
    <input type="checkbox" id="nav-check">
    <div class="nav-header">
        <div class="nav-title">
            TelegramBot - Andrew Kaznacheev
        </div>
    </div>
    <div class="nav-btn">
        <label for="nav-check">
            <span></span>
            <span></span>
            <span></span>
        </label>
    </div>

    <div class="nav-links">
        <a href="https://github.com/AquliaX" target="_blank">Github</a>
        <a href="https://in.linkedin.com/in/aquliax" target="_blank">LinkedIn</a>
        <a href="${pageContext.request.contextPath}/api/towns" target="_blank">Configure the bot</a>
    </div>
</div>
<button id="butt" class="button button1" onclick="showDiv()">Start BOT</button>
<div id='bodybox'>
    <div id='chatborder'>
        <p id="chatlog7" class="chatlog">&nbsp;</p>
        <p id="chatlog6" class="chatlog">&nbsp;</p>
        <p id="chatlog5" class="chatlog">&nbsp;</p>
        <p id="chatlog4" class="chatlog">&nbsp;</p>
        <p id="chatlog3" class="chatlog">&nbsp;</p>
        <p id="chatlog2" class="chatlog">&nbsp;</p>
        <p id="chatlog1" class="chatlog">&nbsp;</p>
        <input type="text" name="chat" id="chatbox"
               placeholder="Hi! Type here the name of the city to tell you about"
               onfocus="placeHolder()">
    </div>
</div>
<script>
    function showDiv() {
        document.getElementById('butt').style.display = "none";
        document.getElementById('bodybox').style.display = "block";
    }

    var townsName = [];
    <c:forEach items="${townsList}" var="townsListItem">
    townsName.push('${townsListItem.name}');
    </c:forEach>
    console.log(townsName)

    var townsInfo = [];
    <c:forEach items="${townsList}" var="townsListItem">
    townsInfo.push('${townsListItem.info}');
    </c:forEach>
    console.log(townsInfo)

    var messages = [], //array that hold the record of each string in chat
        lastUserMessage = "", //keeps track of the most recent input string from the user
        botMessage = "", //var keeps track of what the chatbot is going to say
        botName = 'TelegramBot', //name of the chatbot
        talking = true; //when false the speach function doesn't work

    //edit this function to change what the chatbot says
    function chatbotResponse() {
        talking = true;
        botMessage = "Извини, не понимаю тебя. Напиши !commands чтобы узнать, что я умею."; //the default message

        for (let i = 0; i < townsName.length; ++i) {
            if (lastUserMessage === townsName[i]) {
                var msg = townsInfo[i];
                botMessage = msg;
                break;
            }
        }
        if (lastUserMessage === '!commands') {
            botMessage = 'Команды : !towns, !hi, !name.'
        }
        if (lastUserMessage === '!towns') {
            botMessage = 'Список доступных городов: ';
            for (let i = 0; i < townsName.length; ++i) {
                botMessage +=', '+ townsName[i] ;
            }
            botMessage += '. Чтобы узнать подробнее о городе, напиши мне его название.'
        }
        if (lastUserMessage === '!hi') {
            const hi = ['hi', 'привет', 'hello']
            botMessage = hi[Math.floor(Math.random() * (hi.length))];
            ;
        }
        if (lastUserMessage === '!name') {
            botMessage = 'Меня зовут ' + botName;
        }
    }

    //this runs each time enter is pressed.
    //It controls the overall input and output
    function newEntry() {
        //if the message from the user isn't empty then run
        if (document.getElementById("chatbox").value != "") {
            //pulls the value from the chatbox ands sets it to lastUserMessage
            lastUserMessage = document.getElementById("chatbox").value;
            //sets the chat box to be clear
            document.getElementById("chatbox").value = "";
            //adds the value of the chatbox to the array messages
            messages.push(lastUserMessage);
            //Speech(lastUserMessage);  //says what the user typed outloud
            //sets the variable botMessage in response to lastUserMessage
            chatbotResponse();
            //add the chatbot's name and message to the array messages
            messages.push("<b>" + botName + ":</b> " + botMessage);
            // says the message using the text to speech function written below
            Speech(botMessage);
            //outputs the last few array elements of messages to html
            for (var i = 1; i < 8; i++) {
                if (messages[messages.length - i])
                    document.getElementById("chatlog" + i).innerHTML = messages[messages.length - i];
            }
        }
    }

    function Speech(say) {
        if ('speechSynthesis' in window && talking) {
            var utterance = new SpeechSynthesisUtterance(say);
            speechSynthesis.speak(utterance);
        }
    }

    document.onkeypress = keyPress;

    //if the key pressed is 'enter' runs the function newEntry()
    function keyPress(e) {
        var x = e || window.event;
        var key = (x.keyCode || x.which);
        if (key == 13 || key == 3) {
            //runs this function when enter is pressed
            newEntry();
        }
        if (key == 38) {
            console.log('hi')
            //document.getElementById("chatbox").value = lastUserMessage;
        }
    }

    //clears the placeholder text ion the chatbox
    //this function is set to run when the users brings focus to the chatbox, by clicking on it
    function placeHolder() {
        document.getElementById("chatbox").placeholder = "";
    }
</script>

</body>
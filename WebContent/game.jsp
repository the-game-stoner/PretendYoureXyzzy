<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.google.inject.Injector" %>
<%@ page import="com.google.inject.Key" %>
<%@ page import="com.google.inject.TypeLiteral" %>
<%@ page import="net.socialgamer.cah.StartupUtils" %>
<%@ page import="net.socialgamer.cah.CahModule.*" %>
<%
ServletContext servletContext = pageContext.getServletContext();
Injector injector = (Injector) servletContext.getAttribute(StartupUtils.INJECTOR);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terrible People</title>
    <script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/jquery-migrate-1.2.1.js"></script>
    <script src="js/jquery.cookie.js"></script>
    <script src="js/jquery.json.js"></script>
    <script src="js/QTransform.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/cah.js"></script>
    <script src="js/cah.config.js"></script>
    <script src="js/cah.constants.js"></script>
    <script src="js/cah.log.js"></script>
    <script src="js/cah.gamelist.js"></script>
    <script src="js/cah.card.js"></script>
    <script src="js/cah.cardset.js"></script>
    <script src="js/cah.game.js"></script>
    <script src="js/cah.preferences.js"></script>
    <script src="js/cah.longpoll.js"></script>
    <script src="js/cah.longpoll.handlers.js"></script>
    <script src="js/cah.ajax.js"></script>
    <script src="js/cah.ajax.builder.js"></script>
    <script src="js/cah.ajax.handlers.js"></script>
    <script src="js/cah.app.js"></script>
    <link rel="stylesheet" href="cah.css">
    <link rel="stylesheet" href="jquery-ui.min.css">
</head>
<body id="gamebody">

    <div id="welcome" class="welcome-container">
        <h1>Terrible People</h1>
        <h3>A party game for The-Circle community.</h3>
        
        <div id="nickbox" class="nickbox">
            <label for="nickname">🎭 Your Nickname</label>
            <input type="text" id="nickname" maxlength="30" placeholder="Enter nickname...">
            
            <label for="idcode">🔐 Optional ID Code</label>
            <input type="password" id="idcode" maxlength="100" placeholder="Optional code...">
            
            <span id="nickbox_error" class="error"></span>
            <div style="margin-top: 20px;">
                <input type="button" class="btn-primary" id="nicknameconfirm" value="🎮 Enter Game">
            </div>
        </div>
    </div>

    <div id="main_container" class="hide">
        <div id="canvass">
            <div id="menubar">
                <div id="menubar_left">
                    <input type="button" id="refresh_games" value="Refresh">
                    <input type="button" id="create_game" value="Create Game">
                    <input type="button" id="leave_game" class="hide" value="Leave Game">
                </div>
                <div id="menubar_right">
                    Timer: <span id="current_timer">0</span>s
                    <input type="button" id="logout" value="Log out">
                </div>
            </div>

            <div id="main">
                <div id="game_list"></div>
                <div id="main_holder"></div>
            </div>

            <div id="bottom">
                <div id="info_area"></div>
                <div id="tabs">
                    <ul id="tabs_list">
                        <li><a href="#tab-global">Global Chat</a></li>
                        <li><a href="#tab-preferences">Prefs</a></li>
                    </ul>
                    <div id="tab-global">
                        <div class="log" id="log_global"></div>
                        <div class="chat-input-wrapper">
                            <input type="text" class="chat" id="chat_global" placeholder="Chat here...">
                            <input type="button" class="chat_submit" id="chat_submit_global" value="Send">
                        </div>
                    </div>
                    <div id="tab-preferences">
                        <p>User preferences will load here.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div style="display:none;">
        <div id="gamelist_lobby_template">
            <div class="gamelist_lobby">
                <span class="gamelist_lobby_host"></span>
                <span class="gamelist_lobby_players"></span>
                <input type="button" class="gamelist_lobby_join" value="Join">
            </div>
        </div>

        <div id="black_up_template">
            <div class="card blackcard">
                <span class="card_text"></span>
                <div class="logo_text">Terrible People</div>
            </div>
        </div>

        <div id="white_up_template">
            <div class="card whitecard">
                <span class="card_text"></span>
                <div class="logo_text">Terrible People</div>
            </div>
        </div>

        <div id="game_template">
            <div class="game">
                <div class="game_message"></div>
                <div class="game_black_card"></div>
                <div class="game_hand"><div class="game_hand_cards"></div></div>
                <input type="button" class="confirm_card" value="Confirm Selection">
            </div>
        </div>

        <div id="scorecard_template">
            <div class="scorecard">
                <span class="scorecard_player"></span>: <span class="scorecard_score">0</span>
            </div>
        </div>
    </div>

    <div id="aria-notifications" style="position:absolute; left:-9999px;" role="alert"></div>
</body>
</html>

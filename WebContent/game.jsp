<%--
Copyright (c) 2012-2020, Andy Janata | Modified for Terrible People (The-Circle)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.google.inject.Injector, com.google.inject.Key, com.google.inject.TypeLiteral" %>
<%@ page import="javax.servlet.http.HttpSession, net.socialgamer.cah.RequestWrapper, net.socialgamer.cah.StartupUtils" %>
<%@ page import="net.socialgamer.cah.data.GameOptions, net.socialgamer.cah.CahModule, net.socialgamer.cah.CahModule.*" %>
<%
    HttpSession hSession = request.getSession(true);
    ServletContext servletContext = pageContext.getServletContext();
    Injector injector = (Injector) servletContext.getAttribute(StartupUtils.INJECTOR);
    boolean allowBlankCards = injector.getInstance(Key.get(new TypeLiteral<Boolean>(){}, AllowBlankCards.class));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Terrible People — The-Circle</title>
    
    <link rel="stylesheet" type="text/css" href="cah.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="jquery-ui.min.css" media="screen" />

    <style>
        /* Force-Fixing the layout conflicts */
        #gamebody {
            background-attachment: fixed !important;
            overflow: auto !important; /* Original engine needs scroll */
        }

        /* Prevent your .card class from breaking the game's placement */
        .card {
            position: relative !important;
            float: left !important;
            margin: 5px !important;
        }

        /* Fix the Login Screen appearance using your variables */
        #welcome {
            width: 80%;
            max-width: 600px;
            margin: 50px auto !important;
            float: none !important; /* Kill the original float */
            padding: 20px;
            background: var(--circle-panel2);
            border: 1px solid var(--circle-border);
            border-radius: var(--circle-radius);
            text-align: center;
        }

        #nickbox {
            display: block !important;
            margin: 20px auto !important;
            padding: 15px;
            text-align: left;
        }

        #nickbox input[type="text"] {
            width: 100%;
            box-sizing: border-box;
            padding: 10px;
            margin: 10px 0;
            background: var(--circle-panel);
            color: white;
            border: 1px solid var(--circle-border);
        }

        /* Fix the Game Canvas height so it doesn't overlap the bottom chat */
        #canvas {
            height: calc(100vh - 160px) !important;
            overflow: auto !important;
        }

        /* Re-aligning the Game Board */
        .game_left_side { width: 210px !important; float: left !important; }
        .game_right_side { margin-left: 220px !important; display: block !important; }
        .game_hand { clear: both !important; padding-top: 20px !important; }
    </style>

    <script type="text/javascript" src="js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="js/jquery-migrate-1.2.1.js"></script>
    <script type="text/javascript" src="js/jquery.cookie.js"></script>
    <script type="text/javascript" src="js/jquery.json.js"></script>
    <script type="text/javascript" src="js/QTransform.js"></script>
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/cah.js"></script>
    <script type="text/javascript" src="js/cah.config.js"></script>
    <script type="text/javascript" src="js/cah.constants.js"></script>
    <script type="text/javascript" src="js/cah.log.js"></script>
    <script type="text/javascript" src="js/cah.gamelist.js"></script>
    <script type="text/javascript" src="js/cah.card.js"></script>
    <script type="text/javascript" src="js/cah.cardset.js"></script>
    <script type="text/javascript" src="js/cah.game.js"></script>
    <script type="text/javascript" src="js/cah.preferences.js"></script>
    <script type="text/javascript" src="js/cah.longpoll.js"></script>
    <script type="text/javascript" src="js/cah.longpoll.handlers.js"></script>
    <script type="text/javascript" src="js/cah.ajax.js"></script>
    <script type="text/javascript" src="js/cah.ajax.builder.js"></script>
    <script type="text/javascript" src="js/cah.ajax.handlers.js"></script>
    <script type="text/javascript" src="js/cah.app.js"></script>
</head>

<body id="gamebody">

<div id="welcome">
    <h1>🎉 Terrible People</h1>
    <h3>A party game for The-Circle community</h3>
    
    <div id="nickbox">
        <label for="nickname">🎭 Your Nickname:</label>
        <input type="text" id="nickname" maxlength="30" placeholder="FunnyGuy" />
        
        <input type="password" id="idcode" maxlength="100" disabled="disabled" class="hide" />
        
        <div style="text-align:center;">
            <input type="button" class="btn-primary" id="nicknameconfirm" value="Set Nickname & Enter" />
        </div>
        <span id="nickbox_error" class="error"></span>
    </div>

    <p class="footer-text">
        Inspired by Cards Against Humanity.<br />
        <a href="privacy.html">Privacy Policy</a>
    </p>
</div>

<div id="canvas" class="hide">
    <div id="menubar">
        <div id="menubar_left">
            <input type="button" id="refresh_games" class="hide" value="Refresh Games" />
            <input type="button" id="create_game" class="hide" value="Create Game" />
            <input type="text" id="filter_games" class="hide" placeholder="Filter" />
            <input type="button" id="leave_game" class="hide" value="Leave Game" />
            <input type="button" id="start_game" class="hide" value="Start Game" />
        </div>
        <div id="menubar_right">
            Timer: <span id="current_timer">0</span>s
            <input type="button" id="view_cards" value="View Cards" onclick="window.open('viewcards.jsp', 'viewcards');" />
            <input type="button" id="logout" value="Log out" />
        </div>
    </div>
    <div id="main">
        <div id="game_list" class="hide"></div>
        <div id="main_holder"></div>
    </div>
</div>

<div id="bottom" class="hide">
    <div id="info_area"></div>
    <div id="tabs">
        <ul>
            <li><a href="#tab-preferences">Preferences</a></li>
            <li><a href="#tab-gamelist-filters">Filters</a></li>
            <li><a href="#tab-global">Global Chat</a></li>
        </ul>
        <div id="tab-preferences">
            <input type="button" value="Save" onclick="cah.Preferences.save();" />
            <label><input type="checkbox" id="hide_connect_quit" /> Hide events</label>
            <textarea id="ignore_list" style="width:180px; height:60px;"></textarea>
        </div>
        <div id="tab-gamelist-filters">
            <fieldset><legend>Card set filters</legend>
                <select id="cardsets_banned" multiple="multiple"></select>
                <select id="cardsets_neutral" multiple="multiple"></select>
                <select id="cardsets_required" multiple="multiple"></select>
            </fieldset>
        </div>
        <div id="tab-global">
            <div class="log"></div>
            <input type="text" class="chat" maxlength="200" />
            <input type="button" class="chat_submit" value="Chat" />
        </div>
    </div>
</div>

<div class="hide">
    <div id="gamelist_lobby_template" class="gamelist_lobby">
        <div class="gamelist_lobby_left">
            <h3><span class="gamelist_lobby_host"></span>'s Game (<span class="gamelist_lobby_player_count"></span>/<span class="gamelist_lobby_max_players"></span>)</h3>
            <div><strong>Players:</strong> <span class="gamelist_lobby_players"></span></div>
        </div>
        <div class="gamelist_lobby_right">
            <input type="button" class="gamelist_lobby_join" value="Join" />
        </div>
    </div>

    <div id="black_up_template" class="card blackcard">
        <span class="card_text"></span>
        <div class="logo"><div class="logo_text">Terrible People</div></div>
        <div class="card_metadata"><div class="pick hide">PICK <div class="card_number"></div></div></div>
    </div>

    <div id="white_up_template" class="card whitecard">
        <span class="card_text"></span>
        <div class="logo"><div class="logo_text">Terrible People</div></div>
    </div>

    <div id="game_template" class="game">
        <div class="game_top">
            <input type="button" class="game_show_options" value="Game Options" />
            <div class="game_message">Waiting...</div>
        </div>
        <div class="game_board_container" style="width:100%; height:450px;">
            <div class="game_left_side">
                <div class="game_black_card"></div>
                <input type="button" class="confirm_card" value="Confirm Selection" />
            </div>
            <div class="game_options"></div>
            <div class="game_right_side hide">
                <div class="game_white_cards game_right_side_cards"></div>
            </div>
        </div>
        <div class="game_hand">
            <div class="game_hand_cards"></div>
        </div>
    </div>

    <div id="scoreboard_template" class="scoreboard"></div>
    <div id="scorecard_template" class="scorecard">
        <span class="scorecard_player"></span>: <span class="scorecard_score">0</span> pts
    </div>

    <div class="game_options" id="game_options_template">
        <fieldset>
            <legend>Options</legend>
            Score: <select id="score_limit_template" class="score_limit">
                <% for (int i = injector.getInstance(Key.get(Integer.class, MinScoreLimit.class)); i <= injector.getInstance(Key.get(Integer.class, MaxScoreLimit.class)); i++) { %>
                    <option <%=(i == injector.getInstance(Key.get(Integer.class, DefaultScoreLimit.class))) ? "selected" : "" %> value="<%=i%>"><%=i%></option>
                <% } %>
            </select>
            Players: <select id="player_limit_template" class="player_limit">
                <% for (int i = injector.getInstance(Key.get(Integer.class, MinPlayerLimit.class)); i <= injector.getInstance(Key.get(Integer.class, MaxPlayerLimit.class)); i++) { %>
                    <option <%= i == injector.getInstance(Key.get(Integer.class, DefaultPlayerLimit.class)) ? "selected" : "" %> value="<%=i%>"><%=i%></option>
                <% } %>
            </select>
            <div class="card_sets"><span class="base_card_sets"></span><span class="extra_card_sets"></span></div>
        </fieldset>
    </div>
</div>
</body>
</html>

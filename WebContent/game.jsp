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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover" />
    <title>Terrible People | The-Circle</title>
    <link rel="icon" href="/favicon.png" type="image/png" />
    
    <link rel="stylesheet" type="text/css" href="jquery-ui.min.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="cah.css" media="screen" />
    
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

<!-- WELCOME SCREEN -->
<div id="welcome">
    <h1>🎉 Terrible People</h1>
    <h3>A party game for The-Circle community</h3>
    
    <div id="nickbox">
        <label for="nickname">🎭 Nickname</label>
        <input type="text" id="nickname" maxlength="30" placeholder="Enter your name" />
        <input type="password" id="idcode" maxlength="100" disabled="disabled" class="hide" />
        <div>
            <input type="button" id="nicknameconfirm" value="Enter Game →" />
        </div>
        <span id="nickbox_error" class="error"></span>
    </div>
    
    <p class="footer-text">
        <a href="privacy.html">Privacy</a> • 
        <a href="https://github.com/the-game-stoner/Terrible-People">Source</a>
    </p>
</div>

<!-- MAIN GAME INTERFACE -->
<div id="canvas" class="hide">
    <div id="menubar">
        <div id="menubar_left">
            <input type="button" id="refresh_games" class="hide" value="Refresh Games" />
            <input type="button" id="create_game" class="hide" value="Create Game" />
            <input type="text" id="filter_games" class="hide" placeholder="Filter games" />
            <input type="button" id="leave_game" class="hide" value="Leave Game" />
            <input type="button" id="start_game" class="hide" value="Start Game" />
            <input type="button" id="stop_game" class="hide" value="Stop Game" />
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

<!-- BOTTOM SECTION: SCOREBOARD + CHAT -->
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
            <input type="button" value="Revert" onclick="cah.Preferences.load();" />
            <label><input type="checkbox" id="hide_connect_quit" /> Hide connect/quit events</label>
            <br/>
            <label>Chat ignore list:</label>
            <textarea id="ignore_list" rows="4" cols="30"></textarea>
            <br/>
            <label><input type="checkbox" id="no_persistent_id" /> Opt out of card tracking</label>
        </div>
        <div id="tab-gamelist-filters">
            <fieldset>
                <legend>Card set filters</legend>
                <select id="cardsets_banned" multiple></select>
                <select id="cardsets_neutral" multiple></select>
                <select id="cardsets_required" multiple></select>
            </fieldset>
        </div>
        <div id="tab-global">
            <div class="log"></div>
            <input type="text" class="chat" maxlength="200" placeholder="Type message..." />
            <input type="button" class="chat_submit" value="Chat" />
        </div>
    </div>
</div>

<!-- TEMPLATES (keep these exactly as they were - they work) -->
<div class="hide">
    <div id="gamelist_lobby_template" class="gamelist_lobby">
        <div class="gamelist_lobby_left">
            <h3><span class="gamelist_lobby_host"></span>'s Game (<span class="gamelist_lobby_player_count"></span>/<span class="gamelist_lobby_max_players"></span>, <span class="gamelist_lobby_spectator_count"></span>/<span class="gamelist_lobby_max_spectators"></span>)</h3>
            <div><strong>Players:</strong> <span class="gamelist_lobby_players"></span></div>
            <div><strong>Spectators:</strong> <span class="gamelist_lobby_spectators"></span></div>
            <div><strong>Goal:</strong> <span class="gamelist_lobby_goal"></span></div>
            <div><strong>Cards:</strong> <span class="gamelist_lobby_cardset"></span></div>
        </div>
        <div class="gamelist_lobby_right">
            <input type="button" class="gamelist_lobby_join" value="Join" />
            <input type="button" class="gamelist_lobby_spectate" value="Spectate" />
        </div>
    </div>

    <div id="black_up_template" class="card blackcard">
        <span class="card_text"></span>
        <div class="logo">
            <div class="logo_1 logo_element"></div>
            <div class="logo_2 logo_element"></div>
            <div class="logo_3 logo_element watermark_container"><span class="watermark"></span></div>
            <div class="logo_text">Terrible People</div>
        </div>
        <div class="card_metadata">
            <div class="draw hide">DRAW <div class="card_number"></div></div>
            <div class="pick hide">PICK <div class="card_number"></div></div>
        </div>
    </div>

    <div id="black_down_template" class="card blackcard"></div>
    <div id="white_up_template" class="card whitecard">
        <span class="card_text"></span>
        <div class="logo">
            <div class="logo_1 logo_element"></div>
            <div class="logo_2 logo_element"></div>
            <div class="logo_3 logo_element watermark_container"><span class="watermark"></span></div>
            <div class="logo_text">Terrible People</div>
        </div>
    </div>
    <div id="white_down_template" class="card whitecard"></div>

    <div id="game_template" class="game">
        <div class="game_top">
            <input type="button" class="game_show_last_round game_menu_bar" value="Show Last Round" disabled />
            <input type="button" class="game_show_options game_menu_bar" value="Game Options" />
            <label class="game_menu_bar checkbox"><input type="checkbox" class="game_animate_cards" checked /> Animate Cards</label>
            <div class="game_message">Waiting for server...</div>
        </div>
        <div class="game_main_box">
            <div class="game_left_side">
                <div class="game_black_card_wrapper">
                    <span>The black card for <span class="game_black_card_round_indicator">this round is</span>:</span>
                    <div class="game_black_card"></div>
                </div>
                <input type="button" class="confirm_card" value="Confirm Selection" />
            </div>
            <div class="game_options"></div>
            <div class="game_right_side hide">
                <div class="game_right_side_box game_white_card_wrapper">
                    <span>White cards played this round:</span>
                    <div class="game_white_cards game_right_side_cards"></div>
                </div>
                <div class="game_right_side_box game_last_round hide">
                    Previous round won by <span class="game_last_round_winner"></span>
                    <div class="game_last_round_cards game_right_side_cards"></div>
                </div>
            </div>
        </div>
        <div class="game_hand">
            <div class="game_hand_filter hide"><span class="game_hand_filter_text"></span></div>
            <span class="your_hand">Your Hand</span>
            <div class="game_hand_cards"></div>
        </div>
    </div>

    <div id="scoreboard_template" class="scoreboard">
        <div class="game_message">Scoreboard</div>
    </div>
    
    <div id="scorecard_template" class="scorecard">
        <span class="scorecard_player"></span>
        <span class="scorecard_points"><span class="scorecard_score">0</span> <span class="scorecard_point_title">pts</span></span>
        <span class="scorecard_status"></span>
    </div>

    <div class="game_options" id="game_options_template">
        <fieldset>
            <legend>Game Options</legend>
            <label>Score limit:</label>
            <select id="score_limit_template" class="score_limit">
                <% for (int i = injector.getInstance(Key.get(Integer.class, MinScoreLimit.class)); i <= injector.getInstance(Key.get(Integer.class, MaxScoreLimit.class)); i++) { %>
                    <option <%= (i == injector.getInstance(Key.get(Integer.class, DefaultScoreLimit.class))) ? "selected" : "" %> value="<%=i%>"><%=i%></option>
                <% } %>
            </select>
            <br/>
            <label>Player limit:</label>
            <select id="player_limit_template" class="player_limit">
                <% for (int i = injector.getInstance(Key.get(Integer.class, MinPlayerLimit.class)); i <= injector.getInstance(Key.get(Integer.class, MaxPlayerLimit.class)); i++) { %>
                    <option <%= i == injector.getInstance(Key.get(Integer.class, DefaultPlayerLimit.class)) ? "selected" : "" %> value="<%=i%>"><%=i%></option>
                <% } %>
            </select>
            <br/>
            <label>Spectator limit:</label>
            <select id="spectator_limit_template" class="spectator_limit">
                <% for (int i = injector.getInstance(Key.get(Integer.class, MinSpectatorLimit.class)); i <= injector.getInstance(Key.get(Integer.class, MaxSpectatorLimit.class)); i++) { %>
                    <option <%= i == injector.getInstance(Key.get(Integer.class, DefaultSpectatorLimit.class)) ? "selected" : "" %> value="<%=i%>"><%=i%></option>
                <% } %>
            </select>
            <br/>
            <label>Idle timer:</label>
            <select id="timer_multiplier_template" class="timer_multiplier">
                <option value="0.25x">0.25x</option><option value="0.5x">0.5x</option>
                <option value="0.75x">0.75x</option><option selected value="1x">1x</option>
                <option value="1.25x">1.25x</option><option value="1.5x">1.5x</option>
                <option value="1.75x">1.75x</option><option value="2x">2x</option>
                <option value="2.5x">2.5x</option><option value="3x">3x</option>
                <option value="4x">4x</option><option value="5x">5x</option>
                <option value="10x">10x</option><option value="Unlimited">Unlimited</option>
            </select>
            <div class="card_sets">
                <span class="base_card_sets"></span>
                <span class="extra_card_sets"></span>
            </div>
            <% if (allowBlankCards) { %>
                <br/>
                <label>Include <select id="blanks_limit_template" class="blanks_limit">
                    <% for (int i = injector.getInstance(Key.get(Integer.class, MinBlankCardLimit.class)); i <= injector.getInstance(Key.get(Integer.class, MaxBlankCardLimit.class)); i++) { %>
                        <option <%= i == injector.getInstance(Key.get(Integer.class, DefaultBlankCardLimit.class)) ? "selected" : "" %> value="<%=i%>"><%=i%></option>
                    <% } %>
                </select> blank cards</label>
            <% } %>
            <br/>
            <label>Password:</label>
            <input type="text" id="game_password_template" class="game_password" />
        </fieldset>
    </div>
</div>

<div style="position:absolute; left:-99999px" role="alert" id="aria-notifications"></div>
</body>
</html>

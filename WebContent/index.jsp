<?xml version="1.0" encoding="UTF-8" ?>
<%--
Copyright (c) 2012-2018, Andy Janata
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted
provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions
  and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of
  conditions and the following disclaimer in the documentation and/or other materials provided
  with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--%>
<%--
Index page - cleaned and modernized for The-Circle theme.

@author Andy Janata (ajanata@socialgamer.net)
@modified for The-Circle community
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=yes" />
<title>Terrible People — A party game for The-Circle community</title>
<link rel="stylesheet" type="text/css" href="cah.css" media="screen" />
<style>
  /* Additional inline tweaks for welcome page */
  .welcome-container {
    animation: fadeIn 0.6s ease-out;
  }
  
  @keyframes fadeIn {
    from {
      opacity: 0;
      transform: translateY(20px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
  
  .info-box {
    transition: all 0.2s ease;
  }
  
  .info-box:hover {
    border-color: var(--circle-accent);
    transform: translateX(4px);
  }
  
  details.info-box summary {
    transition: color 0.2s ease;
  }
  
  .btn-primary {
    animation: pulse 2s infinite;
  }
  
  @keyframes pulse {
    0%, 100% {
      box-shadow: 0 0 0 0 rgba(9, 255, 3, 0.4);
    }
    50% {
      box-shadow: 0 0 0 8px rgba(9, 255, 3, 0);
    }
  }
  
  .btn-primary:hover {
    animation: none;
  }
</style>
</head>
<body>

<div class="welcome-container">
  <h1>
    Terrible <dfn style="border-bottom: 1px dotted var(--circle-accent)"
    title="Party game for The-Circle community">People</dfn>
  </h1>
  <h3>A party game for The-Circle community.</h3>

  <!-- Privacy notice - streamlined -->
  <div class="info-box">
    <p>
      🔒 Your IP address is logged for security and debugging. Gameplay results are logged 
      anonymously. No personal information is tied to your username.
    </p>
  </div>

  <!-- Quick start guide - new addition -->
  <div class="info-box" style="background: var(--circle-accent-soft); border-color: var(--circle-accent);">
    <p style="margin: 0; font-weight: bold;">✨ Quick Start:</p>
    <ol style="margin: 0.5rem 0 0 1.25rem; padding: 0;">
      <li>Enter a nickname</li>
      <li>Join an existing game or create your own</li>
      <li>Wait for the Card Czar to start the round</li>
      <li>Pick the funniest white card to win Awesome Points!</li>
    </ol>
  </div>

  <!-- Game info - condensed -->
  <details class="info-box" open>
    <summary><strong>📖 About the Game</strong></summary>
    <ul>
      <li><strong>Players:</strong> 3-20 players recommended</li>
      <li><strong>Game length:</strong> 15-45 minutes depending on score limit</li>
      <li><strong>Cards:</strong> Official Cards Against Humanity deck + community packs</li>
      <li><strong>Mobile friendly:</strong> Works on phones, tablets, and desktops</li>
    </ul>
  </details>

  <!-- Tips - collapsed by default -->
  <details class="info-box">
    <summary><strong>💡 Tips & Known Issues</strong></summary>
    <ul>
      <li><strong>Don't open the game in multiple tabs</strong> — it breaks real-time updates.</li>
      <li><strong>Refresh if something looks wrong</strong> — the game will recover your state.</li>
      <li><strong>Resize window if cards overlap</strong> — the layout adjusts dynamically.</li>
      <li>Works best in Chrome, Firefox, Safari, and Edge.</li>
    </ul>
  </details>

  <!-- Call to action -->
  <div class="button-container">
    <input type="button" class="btn-primary" value="🎮 Take me to the game!"
      onclick="window.location='game.jsp';" />
  </div>

  <!-- Footer -->
  <p class="footer-text">
    Terrible People is a party game for The-Circle community, inspired by Cards Against Humanity.
    This web version is not endorsed by Cards Against Humanity, LLC.
    <br />
    <a href="https://github.com/the-game-stoner/Terrible-People">Source code</a> • 
    <a href="license.html">License</a> • 
    <a href="privacy.html">Privacy</a>
  </p>
</div>

</body>
</html>

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
Index page - warm and welcoming for The-Circle community.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Terrible People — Let's play!</title>
<link rel="stylesheet" type="text/css" href="cah.css" />
<style>
  .welcome-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 2rem 1.5rem;
    animation: fadeIn 0.6s ease-out;
  }
  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
  }
  .info-box {
    background: var(--circle-panel);
    border: 1px solid var(--circle-border);
    border-radius: var(--circle-radius);
    padding: 1.25rem 1.5rem;
    margin-bottom: 1.25rem;
    transition: all 0.2s ease;
  }
  .info-box:hover {
    border-color: var(--circle-accent);
    transform: translateX(4px);
  }
  .how-to-play {
    background: var(--circle-accent-soft);
    border-left: 4px solid var(--circle-accent);
  }
  .how-to-play ol {
    margin: 0.5rem 0 0 1.25rem;
    padding: 0;
  }
  .how-to-play li {
    margin: 0.5rem 0;
    line-height: 1.4;
  }
  .privacy-note {
    font-size: 0.85rem;
    color: var(--circle-muted);
    text-align: center;
    margin: 1rem 0;
  }
  .btn-primary {
    background: var(--circle-accent);
    border: none;
    border-radius: 40px;
    padding: 14px 36px;
    font-size: 1.2rem;
    font-weight: bold;
    color: #000;
    cursor: pointer;
    transition: all 0.2s ease;
    animation: pulse 2s infinite;
  }
  .btn-primary:hover {
    animation: none;
    background: #0cdd00;
    transform: scale(1.02);
  }
  @keyframes pulse {
    0%, 100% { box-shadow: 0 0 0 0 rgba(9, 255, 3, 0.4); }
    50% { box-shadow: 0 0 0 10px rgba(9, 255, 3, 0); }
  }
  .footer-text {
    font-size: 11px;
    text-align: center;
    margin-top: 2rem;
    border-top: 1px solid var(--circle-border);
    padding-top: 1.5rem;
    color: var(--circle-muted);
  }
  .footer-text a {
    color: var(--circle-accent);
  }
</style>
</head>
<body>

<div class="welcome-container">
  <h1>🎉 Terrible <dfn title="Party game for The-Circle community">People</dfn></h1>
  <h3>A party game for The-Circle community — get ready to laugh!</h3>

  <!-- HOW TO PLAY - friendly and clear -->
  <div class="info-box how-to-play">
    <p style="margin: 0 0 0.5rem 0; font-weight: bold; font-size: 1.1rem;">🎲 How to Play</p>
    <ol>
      <li><strong>Pick a nickname</strong> — anything goes!</li>
      <li><strong>Join or create a game</strong> — play with friends or the community</li>
      <li><strong>Get your cards</strong> — one player is the "Card Czar" each round</li>
      <li><strong>Play your funniest white card</strong> to match the black card prompt</li>
      <li><strong>The Czar picks the winner</strong> — that player gets an Awesome Point!</li>
      <li><strong>First to reach the score limit wins!</strong> 🏆</li>
    </ol>
    <p style="margin: 0.75rem 0 0 0; font-size: 0.9rem;">💡 <strong>Pro tip:</strong> The funniest or most creative answer usually wins. Be terrible!</p>
  </div>

  <!-- PRIVACY - short and sweet -->
  <div class="privacy-note">
    🔒 IPs logged for security only — gameplay stats are anonymous. <a href="privacy.html" style="color: var(--circle-accent);">Learn more</a>
  </div>

  <!-- BUTTON -->
  <div style="text-align: center; margin: 1.5rem 0;">
    <input type="button" class="btn-primary" value="🎮 Let's Play →"
      onclick="window.location='game.jsp';" />
  </div>

  <!-- FOOTER -->
  <p class="footer-text">
    Terrible People is a party game for The-Circle community, inspired by Cards Against Humanity.
    <br />
    <a href="https://github.com/the-game-stoner/Terrible-People">Source code</a> • 
    <a href="license.html">License</a>
  </p>
</div>

</body>
</html>

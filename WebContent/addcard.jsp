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
Administration tools.

@author Andy Janata (ajanata@socialgamer.net)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.google.inject.Injector" %>
<%@ page import="com.google.inject.Key" %>
<%@ page import="com.google.inject.TypeLiteral" %>
<%@ page import="net.socialgamer.cah.CahModule.Admins" %>
<%@ page import="net.socialgamer.cah.HibernateUtil" %>
<%@ page import="net.socialgamer.cah.StartupUtils" %>
<%@ page import="net.socialgamer.cah.db.PyxBlackCard" %>
<%@ page import="net.socialgamer.cah.db.PyxWhiteCard" %>
<%@ page import="net.socialgamer.cah.RequestWrapper" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.Transaction" %>
<%@ page import="java.util.Set" %>
<%
RequestWrapper wrapper = new RequestWrapper(request);
ServletContext servletContext = pageContext.getServletContext();
Injector injector = (Injector) servletContext.getAttribute(StartupUtils.INJECTOR);
Set<String> admins = injector.getInstance(Key.get(new TypeLiteral<Set<String>>(){}, Admins.class));
if (!admins.contains(wrapper.getRemoteAddr())) {
  response.sendError(403, "Access is restricted to known hosts");
  return;
}

final String watermark = request.getParameter("watermark") != null ? request.getParameter("watermark") : "";

String error = "";
String status = "";
String field = "";
final String color = request.getParameter("color");
if (color != null) {
  if ("black".equals(color)) {
    final String text = request.getParameter("text");
    final String pick_s = request.getParameter("pick");
    final String draw_s = request.getParameter("draw");
    
    if (text == null || "".equals(text) || pick_s == null || "".equals(pick_s) || draw_s == null ||
        "".equals(draw_s)) {
      error = "You didn't specify something.";
    } else {
      int pick = 0;
      int draw = 0;
      try {
        pick = Integer.parseInt(pick_s);
        draw = Integer.parseInt(draw_s);
      } catch (NumberFormatException e) {
        error = "Something isn't a number.";
      }
      if (0 == pick) {
        error += " Pick can't be 0.";
      } else {
        final Session s = HibernateUtil.instance.sessionFactory.openSession();
        final Transaction transaction = s.beginTransaction();
        transaction.begin();
        final PyxBlackCard card = new PyxBlackCard();
        card.setText(text);
        card.setPick(pick);
        card.setDraw(draw);
        card.setWatermark(watermark);
        s.save(card);
        transaction.commit();
        s.close();
        status = "Saved '" + text + "'.";
        field = "black";
      }
    }
  } else if ("white".equals(color)) {
    final String text = request.getParameter("text");
    
    if (text == null || "".equals(text)) {
      error = "You didn't specify something.";
    } else {
      final Session s = HibernateUtil.instance.sessionFactory.openSession();
      final Transaction transaction = s.beginTransaction();
      transaction.begin();
      final PyxWhiteCard card = new PyxWhiteCard();
      card.setText(text);
      card.setWatermark(watermark);
      s.save(card);
      transaction.commit();
      s.close();
      status = "Saved '" + text + "'.";
      field = "white";
    }
  }
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
<title>Terrible People - Add Cards</title>
<style type="text/css">
  body {
    background: #070a0f;
    color: rgba(255, 255, 255, 0.92);
    font-family: ui-sans-serif, system-ui, sans-serif;
    padding: 20px;
    max-width: 800px;
    margin: 0 auto;
  }
  h1 {
    font-size: 1.5rem;
    letter-spacing: -0.02em;
    margin-top: 30px;
  }
  a {
    color: #09ff03;
    text-decoration: none;
  }
  a:hover {
    text-decoration: underline;
  }
  .back-link {
    display: inline-block;
    margin-bottom: 20px;
  }
  form {
    background: rgba(255, 255, 255, 0.06);
    border: 1px solid rgba(255, 255, 255, 0.12);
    border-radius: 18px;
    padding: 20px;
    margin-bottom: 30px;
  }
  label {
    display: inline-block;
    width: 80px;
    font-weight: bold;
  }
  input[type="text"] {
    background: rgba(255, 255, 255, 0.04);
    border: 1px solid rgba(255, 255, 255, 0.12);
    border-radius: 12px;
    padding: 8px 12px;
    color: rgba(255, 255, 255, 0.92);
    font-size: 14px;
    width: 500px;
    margin-bottom: 10px;
  }
  input[type="text"]:focus {
    outline: none;
    border-color: #09ff03;
  }
  input[type="submit"] {
    background: #09ff03;
    border: none;
    border-radius: 40px;
    padding: 10px 24px;
    font-size: 14px;
    font-weight: bold;
    color: #000;
    cursor: pointer;
    margin-top: 10px;
  }
  input[type="submit"]:hover {
    background: #0cdd00;
  }
  .error {
    color: #ff4444;
  }
  .success {
    color: #09ff03;
  }
</style>
</head>
<body>

<a href="game.jsp" class="back-link">&larr; Back to Game</a>

<h1>Terrible People - Add Cards</h1>

<p>Convention is to use four underscores for the blanks on black cards.</p>

<div class="error"><%= error %></div>
<div class="success"><%= status %></div>

<h2>Black Card</h2>
<form method="post" action="addcard.jsp">
<input type="hidden" name="color" value="black" />
<label for="black_text">Card Text</label>
<input type="text" id="black_text" name="text" size="150" />
<br/>
<label for="pick">Pick</label>
<input type="text" id="pick" name="pick" size="3" value="1" />
<br/>
<label for="draw">Draw</label>
<input type="text" id="draw" name="draw" size="3" value="0" />
<br/>
<label for="watermark_b">Watermark</label>
<input type="text" id="watermark_b" name="watermark" size="3" maxlength="5" value="<%= watermark %>" />
<br/>
<input type="submit" value="Add Black Card" />
</form>

<h2>White Card</h2>
<form method="post" action="addcard.jsp">
<input type="hidden" name="color" value="white" />
<label for="white_text">Card Text</label>
<input type="text" id="white_text" name="text" size="150" />
<br/>
<label for="watermark_w">Watermark</label>
<input type="text" id="watermark_w" name="watermark" size="3" maxlength="5" value="<%= watermark %>" />
<br/>
<input type="submit" value="Add White Card" />
</form>

<script type="text/javascript">
var field = '<%= field %>';
if ('' != field) {
  document.getElementById(field + '_text').focus();
}
</script>
</body>
</html>

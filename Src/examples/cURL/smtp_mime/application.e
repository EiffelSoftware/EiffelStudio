note
	description: "[
		cURL https://curl.haxx.se/libcurl/c/smtp-mail.html
		For original C version, please see:	https://curl.haxx.se/libcurl/c/smtp-mime.html
		This is a simple example showing how to send mime mail using libcurl's SMTP capabilities
	]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=cURL smtp mime example", "src=https://curl.haxx.se/libcurl/c/smtp-mime.html", "protocol=uri"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- Run application, showing how to send e-mails with mime using cURL SMTP.
		local
			l_result: INTEGER
			l_from: STRING
			l_to: STRING
			l_cc: STRING
			recipients: POINTER
			headers: POINTER
			slists: POINTER
			curl_externals: CURL_EXTERNALS
			l_message: STRING
			mime: POINTER
			alt: POINTER
			part: POINTER
		do
			io.put_string ("Eiffel cURL SMTP example showing how to send e-mails with mime.")
			io.put_new_line
			print ("%NLibCurl Version:" + (create {CURL_OPT_CONSTANTS}).libcurl_version.out)

				-- add the from email.
			l_from := "sender@example.org"
			l_to := "addressee@example.net"
			l_cc := "info@example.org"
			create l_message.make_from_string (message)
			l_message.replace_substring_all ("$TO", l_to)
			l_message.replace_substring_all ("$CC", l_cc)
			l_message.replace_substring_all ("$FROM", l_from)
			if curl_easy.is_dynamic_library_exists then
				curl_handle := curl_easy.init

					-- This is the URL for your mailserver "smtp://mail.example.com"
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, "smtp://127.0.0.1")

					-- Note that this option isn't strictly required, omitting it will result
					-- in libcurl sending the MAIL FROM command with empty sender data. All
					-- autoresponses should have an empty reverse-path, and should be directed
					-- to the address in the reverse-path which triggered them. Otherwise,
					-- they could cause an endless loop. See RFC 5321 Section 4.5.5 for more
					-- details.
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_mail_from, l_from)

					-- Add two recipients, in this particular case they correspond to the
					-- To: and Cc: addressees in the header, but they could be any kind of
					-- * recipient.

				create curl_externals
				recipients := curl_externals.slist_append (recipients, l_to)
				recipients := curl_externals.slist_append (recipients, l_cc)
				curl_easy.setopt_slist (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_mail_rcpt, recipients)

					-- Build and set the message header list.
				headers := curl_externals.slist_append (headers, "Date: Tue, 22 Aug 2017 14:08:43 +0100")
				headers := curl_externals.slist_append (headers, "To: " + l_to)
				headers := curl_externals.slist_append (headers, "From: " + l_from + "(Example User)")
				headers := curl_externals.slist_append (headers, "CC: " + l_cc + "(Another Example User)")
				headers := curl_externals.slist_append (headers, "Message-ID: <dcd7cb36-11db-487a-9f3a-e652a9458efd@rfcpedant.example.org>")
				headers := curl_externals.slist_append (headers, "Subject: example sending a MIME-formatted message")
				curl_easy.setopt_slist (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httpheader, headers)

					-- Build the mime message.
				mime := curl_externals.curl_mime_init (curl_handle)

					-- The inline part is an alterative proposing the html and the text versions of the e-mail.
				alt := curl_externals.curl_mime_init (curl_handle)

					-- HTML message.
				part := curl_externals.curl_mime_addpart (alt)
				l_result := curl_externals.curl_mime_data (part, inline_html, {CURL_OPT_CONSTANTS}.curl_zero_terminated)
				check
					valid: l_result = {CURL_CODES}.curle_ok
				end
				l_result := curl_externals.curl_mime_type (part, "text/html")
				check
					valid: l_result = {CURL_CODES}.curle_ok
				end

					-- Text message
				part := curl_externals.curl_mime_addpart (alt)
				l_result := curl_externals.curl_mime_data (part, inline_text, {CURL_OPT_CONSTANTS}.curl_zero_terminated)
				l_result := curl_externals.curl_mime_type (part, "text/html")
				check
					valid: l_result = {CURL_CODES}.curle_ok
				end

					-- Create the inline part.
				part := curl_externals.curl_mime_addpart (mime)
				l_result := curl_externals.curl_mime_subparts (part, alt)
				check
					valid: l_result = {CURL_CODES}.curle_ok
				end
				l_result := curl_externals.curl_mime_type (part, "multipart/alternative")
				check
					valid: l_result = {CURL_CODES}.curle_ok
				end
				slists := curl_externals.slist_append (default_pointer, "Content-Disposition: inline")
				l_result := curl_externals.curl_mime_headers (part, slists, 1)
				check
					valid: l_result = {CURL_CODES}.curle_ok
				end

					-- Add the current source program as an attachment

				part := curl_externals.curl_mime_addpart (mime)
				l_result := curl_externals.curl_mime_filedata (part, "application.e")
				curl_easy.setopt_mime (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_mimepost, mime)
				l_result := curl_easy.perform (curl_handle)
				if l_result = {CURL_CODES}.curle_ok then
					print ("%NSMTP sent ok")
				else
					print ("Error: cURL Error[" + l_result.out + "]")
				end
				curl_externals.slist_free_all (recipients)
				curl_externals.slist_free_all (headers)
				curl_externals.curl_mime_free (mime)
					-- Always cleanup
				curl_easy.cleanup (curl_handle)
			else
				io.error.put_string ("cURL library not found!")
				io.error.put_new_line
			end
		end

feature {NONE} -- Implementation

	curl_easy: CURL_EASY_EXTERNALS
			-- cURL easy externals.
		once
			create Result
		end

	curl_handle: POINTER
			-- cURL handle.

	header_text: STRING = "[
					Date: Tue, 22 Aug 2017 14:08:43 +0100
					To:  $TO
					From:  $FROM (Example User)
					Cc:  $CC (Another example User)
					Message-ID: <dcd7cb36-11db-487a-9f3a-e652a9458efd@rfcpedant.example.org>
					Subject: example sending a MIME-formatted message
		]"

	message: STRING = "[
			Date: Mon, 29 Nov 2010 21:54:29 +1100
			To:  $TO
			From:  $FROM (Example User)
			Cc: $CC (Another example User)
			Subject: SMTP example message
			
			The body of the message starts here
			
			It could be a lot of lines, could be MIME encoded, whatever.
			Check RFC5322.
		]"

	inline_html: STRING = "[
			 	<html><body>
			 	<p>This is the inline <b>HTML</b> message of the e-mail.</p>
				<br />
			 	<p>It could be a lot of HTML data that would be displayed by e-mail viewers able to handle HTML.</p>
			 	</body></html>
		]"

	inline_text2: STRING = "[
			This is the inline text message of the e-mail.
			
			It could be a lot of lines that would be displayed in an e-mail 
			viewer that is not able to handle HTML
		]"

	inline_text: STRING = "[
			<!doctype html>
			<html>
			  <head>
			    <meta name="viewport" content="width=device-width" />
			    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			    <title>Simple Transactional Email</title>
			    <style>
			      /* -------------------------------------
			          GLOBAL RESETS
			      ------------------------------------- */
			      img {
			        border: none;
			        -ms-interpolation-mode: bicubic;
			        max-width: 100%; }
			      body {
			        background-color: #f6f6f6;
			        font-family: sans-serif;
			        -webkit-font-smoothing: antialiased;
			        font-size: 14px;
			        line-height: 1.4;
			        margin: 0;
			        padding: 0;
			        -ms-text-size-adjust: 100%;
			        -webkit-text-size-adjust: 100%; }
			      table {
			        border-collapse: separate;
			        mso-table-lspace: 0pt;
			        mso-table-rspace: 0pt;
			        width: 100%; }
			        table td {
			          font-family: sans-serif;
			          font-size: 14px;
			          vertical-align: top; }
			      /* -------------------------------------
			          BODY & CONTAINER
			      ------------------------------------- */
			      .body {
			        background-color: #f6f6f6;
			        width: 100%; }
			      /* Set a max-width, and make it display as block so it will automatically stretch to that width, but will also shrink down on a phone or something */
			      .container {
			        display: block;
			        Margin: 0 auto !important;
			        /* makes it centered */
			        max-width: 580px;
			        padding: 10px;
			        width: 580px; }
			      /* This should also be a block element, so that it will fill 100% of the .container */
			      .content {
			        box-sizing: border-box;
			        display: block;
			        Margin: 0 auto;
			        max-width: 580px;
			        padding: 10px; }
			      /* -------------------------------------
			          HEADER, FOOTER, MAIN
			      ------------------------------------- */
			      .main {
			        background: #ffffff;
			        border-radius: 3px;
			        width: 100%; }
			      .wrapper {
			        box-sizing: border-box;
			        padding: 20px; }
			      .content-block {
			        padding-bottom: 10px;
			        padding-top: 10px;
			      }
			      .footer {
			        clear: both;
			        Margin-top: 10px;
			        text-align: center;
			        width: 100%; }
			        .footer td,
			        .footer p,
			        .footer span,
			        .footer a {
			          color: #999999;
			          font-size: 12px;
			          text-align: center; }
			      /* -------------------------------------
			          TYPOGRAPHY
			      ------------------------------------- */
			      h1,
			      h2,
			      h3,
			      h4 {
			        color: #000000;
			        font-family: sans-serif;
			        font-weight: 400;
			        line-height: 1.4;
			        margin: 0;
			        Margin-bottom: 30px; }
			      h1 {
			        font-size: 35px;
			        font-weight: 300;
			        text-align: center;
			        text-transform: capitalize; }
			      p,
			      ul,
			      ol {
			        font-family: sans-serif;
			        font-size: 14px;
			        font-weight: normal;
			        margin: 0;
			        Margin-bottom: 15px; }
			        p li,
			        ul li,
			        ol li {
			          list-style-position: inside;
			          margin-left: 5px; }
			      a {
			        color: #3498db;
			        text-decoration: underline; }
			      /* -------------------------------------
			          BUTTONS
			      ------------------------------------- */
			      .btn {
			        box-sizing: border-box;
			        width: 100%; }
			        .btn > tbody > tr > td {
			          padding-bottom: 15px; }
			        .btn table {
			          width: auto; }
			        .btn table td {
			          background-color: #ffffff;
			          border-radius: 5px;
			          text-align: center; }
			        .btn a {
			          background-color: #ffffff;
			          border: solid 1px #3498db;
			          border-radius: 5px;
			          box-sizing: border-box;
			          color: #3498db;
			          cursor: pointer;
			          display: inline-block;
			          font-size: 14px;
			          font-weight: bold;
			          margin: 0;
			          padding: 12px 25px;
			          text-decoration: none;
			          text-transform: capitalize; }
			      .btn-primary table td {
			        background-color: #3498db; }
			      .btn-primary a {
			        background-color: #3498db;
			        border-color: #3498db;
			        color: #ffffff; }
			      /* -------------------------------------
			          OTHER STYLES THAT MIGHT BE USEFUL
			      ------------------------------------- */
			      .last {
			        margin-bottom: 0; }
			      .first {
			        margin-top: 0; }
			      .align-center {
			        text-align: center; }
			      .align-right {
			        text-align: right; }
			      .align-left {
			        text-align: left; }
			      .clear {
			        clear: both; }
			      .mt0 {
			        margin-top: 0; }
			      .mb0 {
			        margin-bottom: 0; }
			      .preheader {
			        color: transparent;
			        display: none;
			        height: 0;
			        max-height: 0;
			        max-width: 0;
			        opacity: 0;
			        overflow: hidden;
			        mso-hide: all;
			        visibility: hidden;
			        width: 0; }
			      .powered-by a {
			        text-decoration: none; }
			      hr {
			        border: 0;
			        border-bottom: 1px solid #f6f6f6;
			        Margin: 20px 0; }
			      /* -------------------------------------
			          RESPONSIVE AND MOBILE FRIENDLY STYLES
			      ------------------------------------- */
			      @media only screen and (max-width: 620px) {
			        table[class=body] h1 {
			          font-size: 28px !important;
			          margin-bottom: 10px !important; }
			        table[class=body] p,
			        table[class=body] ul,
			        table[class=body] ol,
			        table[class=body] td,
			        table[class=body] span,
			        table[class=body] a {
			          font-size: 16px !important; }
			        table[class=body] .wrapper,
			        table[class=body] .article {
			          padding: 10px !important; }
			        table[class=body] .content {
			          padding: 0 !important; }
			        table[class=body] .container {
			          padding: 0 !important;
			          width: 100% !important; }
			        table[class=body] .main {
			          border-left-width: 0 !important;
			          border-radius: 0 !important;
			          border-right-width: 0 !important; }
			        table[class=body] .btn table {
			          width: 100% !important; }
			        table[class=body] .btn a {
			          width: 100% !important; }
			        table[class=body] .img-responsive {
			          height: auto !important;
			          max-width: 100% !important;
			          width: auto !important; }}
			      /* -------------------------------------
			          PRESERVE THESE STYLES IN THE HEAD
			      ------------------------------------- */
			      @media all {
			        .ExternalClass {
			          width: 100%; }
			        .ExternalClass,
			        .ExternalClass p,
			        .ExternalClass span,
			        .ExternalClass font,
			        .ExternalClass td,
			        .ExternalClass div {
			          line-height: 100%; }
			        .apple-link a {
			          color: inherit !important;
			          font-family: inherit !important;
			          font-size: inherit !important;
			          font-weight: inherit !important;
			          line-height: inherit !important;
			          text-decoration: none !important; }
			        .btn-primary table td:hover {
			          background-color: #34495e !important; }
			        .btn-primary a:hover {
			          background-color: #34495e !important;
			          border-color: #34495e !important; } }
			    </style>
			  </head>
			  <body class="">
			    <table border="0" cellpadding="0" cellspacing="0" class="body">
			      <tr>
			        <td>&nbsp;</td>
			        <td class="container">
			          <div class="content">
			
			            <!-- START CENTERED WHITE CONTAINER -->
			            <span class="preheader">This is preheader text. Some clients will show this text as a preview.</span>
			            <table class="main">
			
			              <!-- START MAIN CONTENT AREA -->
			              <tr>
			                <td class="wrapper">
			                  <table border="0" cellpadding="0" cellspacing="0">
			                    <tr>
			                      <td>
			                        <p>Hi there,</p>
			                        <p>Sometimes you just want to send a simple HTML email with a simple design and clear call to action. This is it.</p>
			                        <table border="0" cellpadding="0" cellspacing="0" class="btn btn-primary">
			                          <tbody>
			                            <tr>
			                              <td align="left">
			                                <table border="0" cellpadding="0" cellspacing="0">
			                                  <tbody>
			                                    <tr>
			                                      <td> <a href="http://htmlemail.io" target="_blank">Call To Action</a> </td>
			                                    </tr>
			                                  </tbody>
			                                </table>
			                              </td>
			                            </tr>
			                          </tbody>
			                        </table>
			                        <p>This is a really simple email template. Its sole purpose is to get the recipient to click the button with no distractions.</p>
			                        <p>Good luck! Hope it works.</p>
			                      </td>
			                    </tr>
			                  </table>
			                </td>
			              </tr>
			
			            <!-- END MAIN CONTENT AREA -->
			            </table>
			
			            <!-- START FOOTER -->
			            <div class="footer">
			              <table border="0" cellpadding="0" cellspacing="0">
			                <tr>
			                  <td class="content-block">
			                    <span class="apple-link">Company Inc, 3 Abbey Road, San Francisco CA 94102</span>
			                    <br> Don't like these emails? <a href="http://i.imgur.com/CScmqnj.gif">Unsubscribe</a>.
			                  </td>
			                </tr>
			                <tr>
			                  <td class="content-block powered-by">
			                    Powered by <a href="http://htmlemail.io">HTMLemail</a>.
			                  </td>
			                </tr>
			              </table>
			            </div>
			            <!-- END FOOTER -->
			
			          <!-- END CENTERED WHITE CONTAINER -->
			          </div>
			        </td>
			        <td>&nbsp;</td>
			      </tr>
			    </table>
			  </body>
			</html>
		]"

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
		Eiffel Software
		356 Storke Road, Goleta, CA 93117 USA
		Telephone 805-685-1006, Fax 805-685-6869
		Website http://www.eiffel.com
		Customer support http://support.eiffel.com
	]"

end

indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Mail.SmtpMail"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_SMTP_MAIL

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_smtp_server: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Web.Mail.SmtpMail"
		alias
			"get_SmtpServer"
		end

feature -- Element Change

	frozen set_smtp_server (value: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Web.Mail.SmtpMail"
		alias
			"set_SmtpServer"
		end

feature -- Basic Operations

	frozen send (message: WEB_MAIL_MESSAGE) is
		external
			"IL static signature (System.Web.Mail.MailMessage): System.Void use System.Web.Mail.SmtpMail"
		alias
			"Send"
		end

	frozen send_string (from_: SYSTEM_STRING; to: SYSTEM_STRING; subject: SYSTEM_STRING; message_text: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.String, System.String, System.String): System.Void use System.Web.Mail.SmtpMail"
		alias
			"Send"
		end

end -- class WEB_SMTP_MAIL

indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Mail.SmtpMail"

external class
	SYSTEM_WEB_MAIL_SMTPMAIL

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Mail.SmtpMail"
		end

feature -- Access

	frozen get_smtp_server: STRING is
		external
			"IL static signature (): System.String use System.Web.Mail.SmtpMail"
		alias
			"get_SmtpServer"
		end

feature -- Element Change

	frozen set_smtp_server (value: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Web.Mail.SmtpMail"
		alias
			"set_SmtpServer"
		end

feature -- Basic Operations

	frozen send (message: SYSTEM_WEB_MAIL_MAILMESSAGE) is
		external
			"IL static signature (System.Web.Mail.MailMessage): System.Void use System.Web.Mail.SmtpMail"
		alias
			"Send"
		end

	frozen send_string (from_: STRING; to: STRING; subject: STRING; message_text: STRING) is
		external
			"IL static signature (System.String, System.String, System.String, System.String): System.Void use System.Web.Mail.SmtpMail"
		alias
			"Send"
		end

end -- class SYSTEM_WEB_MAIL_SMTPMAIL

indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Mail.MailMessage"

external class
	SYSTEM_WEB_MAIL_MAILMESSAGE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Mail.MailMessage"
		end

feature -- Access

	frozen get_body_encoding: SYSTEM_TEXT_ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.Web.Mail.MailMessage"
		alias
			"get_BodyEncoding"
		end

	frozen get_body_format: SYSTEM_WEB_MAIL_MAILFORMAT is
		external
			"IL signature (): System.Web.Mail.MailFormat use System.Web.Mail.MailMessage"
		alias
			"get_BodyFormat"
		end

	frozen get_priority: SYSTEM_WEB_MAIL_MAILPRIORITY is
		external
			"IL signature (): System.Web.Mail.MailPriority use System.Web.Mail.MailMessage"
		alias
			"get_Priority"
		end

	frozen get_url_content_base: STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_UrlContentBase"
		end

	frozen get_from: STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_From"
		end

	frozen get_body: STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_Body"
		end

	frozen get_bcc: STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_Bcc"
		end

	frozen get_url_content_location: STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_UrlContentLocation"
		end

	frozen get_to: STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_To"
		end

	frozen get_attachments: SYSTEM_COLLECTIONS_ILIST is
		external
			"IL signature (): System.Collections.IList use System.Web.Mail.MailMessage"
		alias
			"get_Attachments"
		end

	frozen get_cc: STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_Cc"
		end

	frozen get_subject: STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_Subject"
		end

	frozen get_headers: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Web.Mail.MailMessage"
		alias
			"get_Headers"
		end

feature -- Element Change

	frozen set_body_format (value: SYSTEM_WEB_MAIL_MAILFORMAT) is
		external
			"IL signature (System.Web.Mail.MailFormat): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_BodyFormat"
		end

	frozen set_url_content_base (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_UrlContentBase"
		end

	frozen set_priority (value: SYSTEM_WEB_MAIL_MAILPRIORITY) is
		external
			"IL signature (System.Web.Mail.MailPriority): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_Priority"
		end

	frozen set_bcc (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_Bcc"
		end

	frozen set_subject (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_Subject"
		end

	frozen set_to (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_To"
		end

	frozen set_url_content_location (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_UrlContentLocation"
		end

	frozen set_body (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_Body"
		end

	frozen set_body_encoding (value: SYSTEM_TEXT_ENCODING) is
		external
			"IL signature (System.Text.Encoding): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_BodyEncoding"
		end

	frozen set_cc (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_Cc"
		end

	frozen set_from (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_From"
		end

end -- class SYSTEM_WEB_MAIL_MAILMESSAGE

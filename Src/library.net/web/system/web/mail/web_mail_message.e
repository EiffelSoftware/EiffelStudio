indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Mail.MailMessage"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_MAIL_MESSAGE

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Mail.MailMessage"
		end

feature -- Access

	frozen get_body_encoding: ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.Web.Mail.MailMessage"
		alias
			"get_BodyEncoding"
		end

	frozen get_body_format: WEB_MAIL_FORMAT is
		external
			"IL signature (): System.Web.Mail.MailFormat use System.Web.Mail.MailMessage"
		alias
			"get_BodyFormat"
		end

	frozen get_priority: WEB_MAIL_PRIORITY is
		external
			"IL signature (): System.Web.Mail.MailPriority use System.Web.Mail.MailMessage"
		alias
			"get_Priority"
		end

	frozen get_url_content_base: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_UrlContentBase"
		end

	frozen get_from: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_From"
		end

	frozen get_body: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_Body"
		end

	frozen get_bcc: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_Bcc"
		end

	frozen get_url_content_location: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_UrlContentLocation"
		end

	frozen get_to: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_To"
		end

	frozen get_attachments: ILIST is
		external
			"IL signature (): System.Collections.IList use System.Web.Mail.MailMessage"
		alias
			"get_Attachments"
		end

	frozen get_cc: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_Cc"
		end

	frozen get_subject: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailMessage"
		alias
			"get_Subject"
		end

	frozen get_headers: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Web.Mail.MailMessage"
		alias
			"get_Headers"
		end

feature -- Element Change

	frozen set_body_format (value: WEB_MAIL_FORMAT) is
		external
			"IL signature (System.Web.Mail.MailFormat): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_BodyFormat"
		end

	frozen set_url_content_base (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_UrlContentBase"
		end

	frozen set_priority (value: WEB_MAIL_PRIORITY) is
		external
			"IL signature (System.Web.Mail.MailPriority): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_Priority"
		end

	frozen set_bcc (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_Bcc"
		end

	frozen set_subject (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_Subject"
		end

	frozen set_to (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_To"
		end

	frozen set_url_content_location (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_UrlContentLocation"
		end

	frozen set_body (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_Body"
		end

	frozen set_body_encoding (value: ENCODING) is
		external
			"IL signature (System.Text.Encoding): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_BodyEncoding"
		end

	frozen set_cc (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_Cc"
		end

	frozen set_from (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.Mail.MailMessage"
		alias
			"set_From"
		end

end -- class WEB_MAIL_MESSAGE

indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Mail.MailAttachment"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_MAIL_ATTACHMENT

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (filename: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Web.Mail.MailAttachment"
		end

	frozen make_1 (filename: SYSTEM_STRING; encoding: WEB_MAIL_ENCODING) is
		external
			"IL creator signature (System.String, System.Web.Mail.MailEncoding) use System.Web.Mail.MailAttachment"
		end

feature -- Access

	frozen get_encoding: WEB_MAIL_ENCODING is
		external
			"IL signature (): System.Web.Mail.MailEncoding use System.Web.Mail.MailAttachment"
		alias
			"get_Encoding"
		end

	frozen get_filename: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailAttachment"
		alias
			"get_Filename"
		end

end -- class WEB_MAIL_ATTACHMENT

indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Mail.MailAttachment"

external class
	SYSTEM_WEB_MAIL_MAILATTACHMENT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (filename: STRING) is
		external
			"IL creator signature (System.String) use System.Web.Mail.MailAttachment"
		end

	frozen make_1 (filename: STRING; encoding: SYSTEM_WEB_MAIL_MAILENCODING) is
		external
			"IL creator signature (System.String, System.Web.Mail.MailEncoding) use System.Web.Mail.MailAttachment"
		end

feature -- Access

	frozen get_encoding: SYSTEM_WEB_MAIL_MAILENCODING is
		external
			"IL signature (): System.Web.Mail.MailEncoding use System.Web.Mail.MailAttachment"
		alias
			"get_Encoding"
		end

	frozen get_filename: STRING is
		external
			"IL signature (): System.String use System.Web.Mail.MailAttachment"
		alias
			"get_Filename"
		end

end -- class SYSTEM_WEB_MAIL_MAILATTACHMENT

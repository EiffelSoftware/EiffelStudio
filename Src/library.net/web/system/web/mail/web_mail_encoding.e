indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Mail.MailEncoding"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_MAIL_ENCODING

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen base64: WEB_MAIL_ENCODING is
		external
			"IL enum signature :System.Web.Mail.MailEncoding use System.Web.Mail.MailEncoding"
		alias
			"1"
		end

	frozen uuencode: WEB_MAIL_ENCODING is
		external
			"IL enum signature :System.Web.Mail.MailEncoding use System.Web.Mail.MailEncoding"
		alias
			"0"
		end

end -- class WEB_MAIL_ENCODING

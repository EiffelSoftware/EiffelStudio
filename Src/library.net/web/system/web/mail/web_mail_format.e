indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Mail.MailFormat"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_MAIL_FORMAT

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen html: WEB_MAIL_FORMAT is
		external
			"IL enum signature :System.Web.Mail.MailFormat use System.Web.Mail.MailFormat"
		alias
			"1"
		end

	frozen text: WEB_MAIL_FORMAT is
		external
			"IL enum signature :System.Web.Mail.MailFormat use System.Web.Mail.MailFormat"
		alias
			"0"
		end

end -- class WEB_MAIL_FORMAT

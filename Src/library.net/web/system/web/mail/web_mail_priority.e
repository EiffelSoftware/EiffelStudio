indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Mail.MailPriority"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	WEB_MAIL_PRIORITY

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen high: WEB_MAIL_PRIORITY is
		external
			"IL enum signature :System.Web.Mail.MailPriority use System.Web.Mail.MailPriority"
		alias
			"2"
		end

	frozen normal: WEB_MAIL_PRIORITY is
		external
			"IL enum signature :System.Web.Mail.MailPriority use System.Web.Mail.MailPriority"
		alias
			"0"
		end

	frozen low: WEB_MAIL_PRIORITY is
		external
			"IL enum signature :System.Web.Mail.MailPriority use System.Web.Mail.MailPriority"
		alias
			"1"
		end

end -- class WEB_MAIL_PRIORITY

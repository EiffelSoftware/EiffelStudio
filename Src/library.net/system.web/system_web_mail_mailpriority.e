indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Mail.MailPriority"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_MAIL_MAILPRIORITY

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen high: SYSTEM_WEB_MAIL_MAILPRIORITY is
		external
			"IL enum signature :System.Web.Mail.MailPriority use System.Web.Mail.MailPriority"
		alias
			"2"
		end

	frozen normal: SYSTEM_WEB_MAIL_MAILPRIORITY is
		external
			"IL enum signature :System.Web.Mail.MailPriority use System.Web.Mail.MailPriority"
		alias
			"0"
		end

	frozen low: SYSTEM_WEB_MAIL_MAILPRIORITY is
		external
			"IL enum signature :System.Web.Mail.MailPriority use System.Web.Mail.MailPriority"
		alias
			"1"
		end

end -- class SYSTEM_WEB_MAIL_MAILPRIORITY

indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Mail.MailFormat"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_MAIL_MAILFORMAT

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

	frozen html: SYSTEM_WEB_MAIL_MAILFORMAT is
		external
			"IL enum signature :System.Web.Mail.MailFormat use System.Web.Mail.MailFormat"
		alias
			"1"
		end

	frozen text: SYSTEM_WEB_MAIL_MAILFORMAT is
		external
			"IL enum signature :System.Web.Mail.MailFormat use System.Web.Mail.MailFormat"
		alias
			"0"
		end

end -- class SYSTEM_WEB_MAIL_MAILFORMAT

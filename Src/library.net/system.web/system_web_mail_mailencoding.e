indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Mail.MailEncoding"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_MAIL_MAILENCODING

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

	frozen base64: SYSTEM_WEB_MAIL_MAILENCODING is
		external
			"IL enum signature :System.Web.Mail.MailEncoding use System.Web.Mail.MailEncoding"
		alias
			"1"
		end

	frozen uuencode: SYSTEM_WEB_MAIL_MAILENCODING is
		external
			"IL enum signature :System.Web.Mail.MailEncoding use System.Web.Mail.MailEncoding"
		alias
			"0"
		end

end -- class SYSTEM_WEB_MAIL_MAILENCODING

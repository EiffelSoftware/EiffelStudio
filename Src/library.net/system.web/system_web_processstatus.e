indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.ProcessStatus"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WEB_PROCESSSTATUS

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

	frozen shutting_down: SYSTEM_WEB_PROCESSSTATUS is
		external
			"IL enum signature :System.Web.ProcessStatus use System.Web.ProcessStatus"
		alias
			"2"
		end

	frozen shut_down: SYSTEM_WEB_PROCESSSTATUS is
		external
			"IL enum signature :System.Web.ProcessStatus use System.Web.ProcessStatus"
		alias
			"3"
		end

	frozen terminated: SYSTEM_WEB_PROCESSSTATUS is
		external
			"IL enum signature :System.Web.ProcessStatus use System.Web.ProcessStatus"
		alias
			"4"
		end

	frozen alive: SYSTEM_WEB_PROCESSSTATUS is
		external
			"IL enum signature :System.Web.ProcessStatus use System.Web.ProcessStatus"
		alias
			"1"
		end

end -- class SYSTEM_WEB_PROCESSSTATUS

indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.ProcessWindowStyle"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DIAGNOSTICS_PROCESSWINDOWSTYLE

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

	frozen hidden: SYSTEM_DIAGNOSTICS_PROCESSWINDOWSTYLE is
		external
			"IL enum signature :System.Diagnostics.ProcessWindowStyle use System.Diagnostics.ProcessWindowStyle"
		alias
			"1"
		end

	frozen maximized: SYSTEM_DIAGNOSTICS_PROCESSWINDOWSTYLE is
		external
			"IL enum signature :System.Diagnostics.ProcessWindowStyle use System.Diagnostics.ProcessWindowStyle"
		alias
			"3"
		end

	frozen normal: SYSTEM_DIAGNOSTICS_PROCESSWINDOWSTYLE is
		external
			"IL enum signature :System.Diagnostics.ProcessWindowStyle use System.Diagnostics.ProcessWindowStyle"
		alias
			"0"
		end

	frozen minimized: SYSTEM_DIAGNOSTICS_PROCESSWINDOWSTYLE is
		external
			"IL enum signature :System.Diagnostics.ProcessWindowStyle use System.Diagnostics.ProcessWindowStyle"
		alias
			"2"
		end

end -- class SYSTEM_DIAGNOSTICS_PROCESSWINDOWSTYLE

indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.SafeExeTypeAttribute"

frozen external class
	SYSTEM_SAFEEXETYPEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_safeexetypeattribute

feature {NONE} -- Initialization

	frozen make_safeexetypeattribute (apptype: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.SafeExeTypeAttribute"
		end

feature -- Access

	frozen gui: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.SafeExeTypeAttribute"
		alias
			"Gui"
		end

	frozen console: INTEGER is
		external
			"IL static_field signature :System.Int32 use System.SafeExeTypeAttribute"
		alias
			"Console"
		end

	frozen get_value: INTEGER is
		external
			"IL signature (): System.Int32 use System.SafeExeTypeAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_SAFEEXETYPEATTRIBUTE

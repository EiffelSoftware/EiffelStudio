indexing
	Generator: "Eiffel Emitter 2.6b2"
	external_name: "ArgParser+SwitchStatus"
	enum_type: "INTEGER"

frozen expanded external class
	SWITCHSTATUS_IN_ARGPARSER

inherit
	SYSTEM_ENUM
	SYSTEM_ICOMPARABLE
		rename
			equals as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			equals as equals_object
		end

feature -- Access

	frozen no_error: SWITCHSTATUS_IN_ARGPARSER is
		external
			"IL enum signature :ArgParser+SwitchStatus use ArgParser+SwitchStatus"
		alias
			"0"
		end

	frozen error: SWITCHSTATUS_IN_ARGPARSER is
		external
			"IL enum signature :ArgParser+SwitchStatus use ArgParser+SwitchStatus"
		alias
			"1"
		end

	frozen value__: INTEGER is
		external
			"IL field signature :System.Int32 use ArgParser+SwitchStatus"
		alias
			"value__"
		end

	frozen show_usage: SWITCHSTATUS_IN_ARGPARSER is
		external
			"IL enum signature :ArgParser+SwitchStatus use ArgParser+SwitchStatus"
		alias
			"2"
		end

end -- class SWITCHSTATUS_IN_ARGPARSER

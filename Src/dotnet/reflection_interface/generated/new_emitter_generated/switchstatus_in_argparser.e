indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ArgParser+SwitchStatus"
	assembly: "ISE.Reflection.Emitter", "1.0.0.62252", "neutral", "30914072a1caac"
	enum_type: "INTEGER"

frozen expanded external class
	SWITCHSTATUS_IN_ARGPARSER

inherit
	ENUM
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

	frozen show_usage: SWITCHSTATUS_IN_ARGPARSER is
		external
			"IL enum signature :ArgParser+SwitchStatus use ArgParser+SwitchStatus"
		alias
			"2"
		end

end -- class SWITCHSTATUS_IN_ARGPARSER

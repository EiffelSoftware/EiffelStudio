indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Diagnostics.ConditionalAttribute"

frozen external class
	SYSTEM_DIAGNOSTICS_CONDITIONALATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_conditionalattribute

feature {NONE} -- Initialization

	frozen make_conditionalattribute (condition_string: STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.ConditionalAttribute"
		end

feature -- Access

	frozen get_condition_string: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.ConditionalAttribute"
		alias
			"get_ConditionString"
		end

end -- class SYSTEM_DIAGNOSTICS_CONDITIONALATTRIBUTE

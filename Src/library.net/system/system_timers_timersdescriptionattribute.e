indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Timers.TimersDescriptionAttribute"

external class
	SYSTEM_TIMERS_TIMERSDESCRIPTIONATTRIBUTE

inherit
	SYSTEM_COMPONENTMODEL_DESCRIPTIONATTRIBUTE
		redefine
			get_description
		end

create
	make_timersdescriptionattribute

feature {NONE} -- Initialization

	frozen make_timersdescriptionattribute (description: STRING) is
		external
			"IL creator signature (System.String) use System.Timers.TimersDescriptionAttribute"
		end

feature -- Access

	get_description: STRING is
		external
			"IL signature (): System.String use System.Timers.TimersDescriptionAttribute"
		alias
			"get_Description"
		end

end -- class SYSTEM_TIMERS_TIMERSDESCRIPTIONATTRIBUTE

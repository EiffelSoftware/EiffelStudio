indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.WarningException"

external class
	SYSTEM_COMPONENTMODEL_WARNINGEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_warningexception,
	make_warningexception_2,
	make_warningexception_1

feature {NONE} -- Initialization

	frozen make_warningexception (message: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.WarningException"
		end

	frozen make_warningexception_2 (message: STRING; help_url: STRING; help_topic: STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.ComponentModel.WarningException"
		end

	frozen make_warningexception_1 (message: STRING; help_url: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ComponentModel.WarningException"
		end

feature -- Access

	frozen get_help_url: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.WarningException"
		alias
			"get_HelpUrl"
		end

	frozen get_help_topic: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.WarningException"
		alias
			"get_HelpTopic"
		end

end -- class SYSTEM_COMPONENTMODEL_WARNINGEXCEPTION

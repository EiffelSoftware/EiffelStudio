indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Resources.NeutralResourcesLanguageAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	NEUTRAL_RESOURCES_LANGUAGE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_neutral_resources_language_attribute

feature {NONE} -- Initialization

	frozen make_neutral_resources_language_attribute (culture_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Resources.NeutralResourcesLanguageAttribute"
		end

feature -- Access

	frozen get_culture_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Resources.NeutralResourcesLanguageAttribute"
		alias
			"get_CultureName"
		end

end -- class NEUTRAL_RESOURCES_LANGUAGE_ATTRIBUTE

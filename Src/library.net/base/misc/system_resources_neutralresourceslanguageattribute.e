indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Resources.NeutralResourcesLanguageAttribute"

frozen external class
	SYSTEM_RESOURCES_NEUTRALRESOURCESLANGUAGEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_neutralresourceslanguageattribute

feature {NONE} -- Initialization

	frozen make_neutralresourceslanguageattribute (culture_name: STRING) is
		external
			"IL creator signature (System.String) use System.Resources.NeutralResourcesLanguageAttribute"
		end

feature -- Access

	frozen get_culture_name: STRING is
		external
			"IL signature (): System.String use System.Resources.NeutralResourcesLanguageAttribute"
		alias
			"get_CultureName"
		end

end -- class SYSTEM_RESOURCES_NEUTRALRESOURCESLANGUAGEATTRIBUTE

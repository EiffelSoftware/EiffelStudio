indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Configuration.ClientTargetSectionHandler"

external class
	SYSTEM_WEB_CONFIGURATION_CLIENTTARGETSECTIONHANDLER

inherit
	SYSTEM_CONFIGURATION_NAMEVALUESECTIONHANDLER
		redefine
			get_value_attribute_name,
			get_key_attribute_name
		end
	SYSTEM_CONFIGURATION_ICONFIGURATIONSECTIONHANDLER

create
	make_clienttargetsectionhandler

feature {NONE} -- Initialization

	frozen make_clienttargetsectionhandler is
		external
			"IL creator use System.Web.Configuration.ClientTargetSectionHandler"
		end

feature {NONE} -- Implementation

	get_value_attribute_name: STRING is
		external
			"IL signature (): System.String use System.Web.Configuration.ClientTargetSectionHandler"
		alias
			"get_ValueAttributeName"
		end

	get_key_attribute_name: STRING is
		external
			"IL signature (): System.String use System.Web.Configuration.ClientTargetSectionHandler"
		alias
			"get_KeyAttributeName"
		end

end -- class SYSTEM_WEB_CONFIGURATION_CLIENTTARGETSECTIONHANDLER

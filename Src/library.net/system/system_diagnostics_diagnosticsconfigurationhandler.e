indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.DiagnosticsConfigurationHandler"

external class
	SYSTEM_DIAGNOSTICS_DIAGNOSTICSCONFIGURATIONHANDLER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_CONFIGURATION_ICONFIGURATIONSECTIONHANDLER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Diagnostics.DiagnosticsConfigurationHandler"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.DiagnosticsConfigurationHandler"
		alias
			"GetHashCode"
		end

	Create_ (parent: ANY; config_context: ANY; section: SYSTEM_XML_XMLNODE): ANY is
		external
			"IL signature (System.Object, System.Object, System.Xml.XmlNode): System.Object use System.Diagnostics.DiagnosticsConfigurationHandler"
		alias
			"Create"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.DiagnosticsConfigurationHandler"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Diagnostics.DiagnosticsConfigurationHandler"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Diagnostics.DiagnosticsConfigurationHandler"
		alias
			"Finalize"
		end

end -- class SYSTEM_DIAGNOSTICS_DIAGNOSTICSCONFIGURATIONHANDLER

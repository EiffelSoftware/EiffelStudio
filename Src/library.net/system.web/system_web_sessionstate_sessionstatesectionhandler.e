indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.SessionState.SessionStateSectionHandler"

external class
	SYSTEM_WEB_SESSIONSTATE_SESSIONSTATESECTIONHANDLER

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
			"IL creator use System.Web.SessionState.SessionStateSectionHandler"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.SessionState.SessionStateSectionHandler"
		alias
			"GetHashCode"
		end

	frozen Create_ (parent: ANY; context_object: ANY; section: SYSTEM_XML_XMLNODE): ANY is
		external
			"IL signature (System.Object, System.Object, System.Xml.XmlNode): System.Object use System.Web.SessionState.SessionStateSectionHandler"
		alias
			"Create"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.SessionState.SessionStateSectionHandler"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.SessionState.SessionStateSectionHandler"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.SessionState.SessionStateSectionHandler"
		alias
			"Finalize"
		end

end -- class SYSTEM_WEB_SESSIONSTATE_SESSIONSTATESECTIONHANDLER

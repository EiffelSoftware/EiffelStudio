indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IHelpService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IHELP_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	create_local_context (context_type: SYSTEM_DLL_HELP_CONTEXT_TYPE): SYSTEM_DLL_IHELP_SERVICE is
		external
			"IL deferred signature (System.ComponentModel.Design.HelpContextType): System.ComponentModel.Design.IHelpService use System.ComponentModel.Design.IHelpService"
		alias
			"CreateLocalContext"
		end

	remove_local_context (local_context: SYSTEM_DLL_IHELP_SERVICE) is
		external
			"IL deferred signature (System.ComponentModel.Design.IHelpService): System.Void use System.ComponentModel.Design.IHelpService"
		alias
			"RemoveLocalContext"
		end

	remove_context_attribute (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use System.ComponentModel.Design.IHelpService"
		alias
			"RemoveContextAttribute"
		end

	show_help_from_keyword (help_keyword: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.ComponentModel.Design.IHelpService"
		alias
			"ShowHelpFromKeyword"
		end

	add_context_attribute (name: SYSTEM_STRING; value: SYSTEM_STRING; keyword_type: SYSTEM_DLL_HELP_KEYWORD_TYPE) is
		external
			"IL deferred signature (System.String, System.String, System.ComponentModel.Design.HelpKeywordType): System.Void use System.ComponentModel.Design.IHelpService"
		alias
			"AddContextAttribute"
		end

	show_help_from_url (help_url: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.ComponentModel.Design.IHelpService"
		alias
			"ShowHelpFromUrl"
		end

	clear_context_attributes is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.Design.IHelpService"
		alias
			"ClearContextAttributes"
		end

end -- class SYSTEM_DLL_IHELP_SERVICE

indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IHelpService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IHELPSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	create_local_context (context_type: SYSTEM_COMPONENTMODEL_DESIGN_HELPCONTEXTTYPE): SYSTEM_COMPONENTMODEL_DESIGN_IHELPSERVICE is
		external
			"IL deferred signature (System.ComponentModel.Design.HelpContextType): System.ComponentModel.Design.IHelpService use System.ComponentModel.Design.IHelpService"
		alias
			"CreateLocalContext"
		end

	remove_local_context (local_context: SYSTEM_COMPONENTMODEL_DESIGN_IHELPSERVICE) is
		external
			"IL deferred signature (System.ComponentModel.Design.IHelpService): System.Void use System.ComponentModel.Design.IHelpService"
		alias
			"RemoveLocalContext"
		end

	remove_context_attribute (name: STRING; value: STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use System.ComponentModel.Design.IHelpService"
		alias
			"RemoveContextAttribute"
		end

	show_help_from_keyword (help_keyword: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.ComponentModel.Design.IHelpService"
		alias
			"ShowHelpFromKeyword"
		end

	add_context_attribute (name: STRING; value: STRING; keyword_type: SYSTEM_COMPONENTMODEL_DESIGN_HELPKEYWORDTYPE) is
		external
			"IL deferred signature (System.String, System.String, System.ComponentModel.Design.HelpKeywordType): System.Void use System.ComponentModel.Design.IHelpService"
		alias
			"AddContextAttribute"
		end

	show_help_from_url (help_url: STRING) is
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

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IHELPSERVICE

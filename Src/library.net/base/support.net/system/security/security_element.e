indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.SecurityElement"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SECURITY_ELEMENT

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (tag: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Security.SecurityElement"
		end

	frozen make_1 (tag: SYSTEM_STRING; text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Security.SecurityElement"
		end

feature -- Access

	frozen get_tag: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.SecurityElement"
		alias
			"get_Tag"
		end

	frozen get_children: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Security.SecurityElement"
		alias
			"get_Children"
		end

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.SecurityElement"
		alias
			"get_Text"
		end

	frozen get_attributes: HASHTABLE is
		external
			"IL signature (): System.Collections.Hashtable use System.Security.SecurityElement"
		alias
			"get_Attributes"
		end

feature -- Element Change

	frozen set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.SecurityElement"
		alias
			"set_Text"
		end

	frozen set_children (value: ARRAY_LIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use System.Security.SecurityElement"
		alias
			"set_Children"
		end

	frozen set_attributes (value: HASHTABLE) is
		external
			"IL signature (System.Collections.Hashtable): System.Void use System.Security.SecurityElement"
		alias
			"set_Attributes"
		end

	frozen set_tag (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.SecurityElement"
		alias
			"set_Tag"
		end

feature -- Basic Operations

	frozen is_valid_tag (tag: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Security.SecurityElement"
		alias
			"IsValidTag"
		end

	frozen search_for_text_of_tag (tag: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Security.SecurityElement"
		alias
			"SearchForTextOfTag"
		end

	frozen search_for_child_by_tag (tag: SYSTEM_STRING): SECURITY_ELEMENT is
		external
			"IL signature (System.String): System.Security.SecurityElement use System.Security.SecurityElement"
		alias
			"SearchForChildByTag"
		end

	frozen attribute (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Security.SecurityElement"
		alias
			"Attribute"
		end

	frozen is_valid_text (text: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Security.SecurityElement"
		alias
			"IsValidText"
		end

	frozen equal_ (other: SECURITY_ELEMENT): BOOLEAN is
		external
			"IL signature (System.Security.SecurityElement): System.Boolean use System.Security.SecurityElement"
		alias
			"Equal"
		end

	frozen add_attribute (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Security.SecurityElement"
		alias
			"AddAttribute"
		end

	frozen is_valid_attribute_name (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Security.SecurityElement"
		alias
			"IsValidAttributeName"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.SecurityElement"
		alias
			"ToString"
		end

	frozen escape (str: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Security.SecurityElement"
		alias
			"Escape"
		end

	frozen is_valid_attribute_value (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Security.SecurityElement"
		alias
			"IsValidAttributeValue"
		end

	frozen add_child (child: SECURITY_ELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.SecurityElement"
		alias
			"AddChild"
		end

end -- class SECURITY_ELEMENT

indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Security.SecurityElement"

frozen external class
	SYSTEM_SECURITY_SECURITYELEMENT

inherit
	ANY
		redefine
			to_string
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (tag: STRING) is
		external
			"IL creator signature (System.String) use System.Security.SecurityElement"
		end

	frozen make_1 (tag: STRING; text: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Security.SecurityElement"
		end

feature -- Access

	frozen get_tag: STRING is
		external
			"IL signature (): System.String use System.Security.SecurityElement"
		alias
			"get_Tag"
		end

	frozen get_children: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Security.SecurityElement"
		alias
			"get_Children"
		end

	frozen get_text: STRING is
		external
			"IL signature (): System.String use System.Security.SecurityElement"
		alias
			"get_Text"
		end

	frozen get_attributes: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL signature (): System.Collections.Hashtable use System.Security.SecurityElement"
		alias
			"get_Attributes"
		end

feature -- Element Change

	frozen set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.SecurityElement"
		alias
			"set_Text"
		end

	frozen set_children (value: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use System.Security.SecurityElement"
		alias
			"set_Children"
		end

	frozen set_attributes (value: SYSTEM_COLLECTIONS_HASHTABLE) is
		external
			"IL signature (System.Collections.Hashtable): System.Void use System.Security.SecurityElement"
		alias
			"set_Attributes"
		end

	frozen set_tag (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Security.SecurityElement"
		alias
			"set_Tag"
		end

feature -- Basic Operations

	frozen is_valid_tag (tag: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Security.SecurityElement"
		alias
			"IsValidTag"
		end

	frozen search_for_text_of_tag (tag: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Security.SecurityElement"
		alias
			"SearchForTextOfTag"
		end

	frozen search_for_child_by_tag (tag: STRING): SYSTEM_SECURITY_SECURITYELEMENT is
		external
			"IL signature (System.String): System.Security.SecurityElement use System.Security.SecurityElement"
		alias
			"SearchForChildByTag"
		end

	frozen attribute (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Security.SecurityElement"
		alias
			"Attribute"
		end

	frozen is_valid_text (text: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Security.SecurityElement"
		alias
			"IsValidText"
		end

	frozen add_attribute (name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Security.SecurityElement"
		alias
			"AddAttribute"
		end

	frozen equal (other: SYSTEM_SECURITY_SECURITYELEMENT): BOOLEAN is
		external
			"IL signature (System.Security.SecurityElement): System.Boolean use System.Security.SecurityElement"
		alias
			"Equal"
		end

	frozen is_valid_attribute_name (name: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Security.SecurityElement"
		alias
			"IsValidAttributeName"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Security.SecurityElement"
		alias
			"ToString"
		end

	frozen escape (str: STRING): STRING is
		external
			"IL static signature (System.String): System.String use System.Security.SecurityElement"
		alias
			"Escape"
		end

	frozen is_valid_attribute_value (value: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Security.SecurityElement"
		alias
			"IsValidAttributeValue"
		end

	frozen add_child (child: SYSTEM_SECURITY_SECURITYELEMENT) is
		external
			"IL signature (System.Security.SecurityElement): System.Void use System.Security.SecurityElement"
		alias
			"AddChild"
		end

end -- class SYSTEM_SECURITY_SECURITYELEMENT

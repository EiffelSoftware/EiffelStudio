indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ParenthesizePropertyNameAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_PARENTHESIZEPROPERTYNAMEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals_object
		end

create
	make_parenthesizepropertynameattribute,
	make_parenthesizepropertynameattribute_1

feature {NONE} -- Initialization

	frozen make_parenthesizepropertynameattribute is
		external
			"IL creator use System.ComponentModel.ParenthesizePropertyNameAttribute"
		end

	frozen make_parenthesizepropertynameattribute_1 (need_parenthesis: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.ParenthesizePropertyNameAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_PARENTHESIZEPROPERTYNAMEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ParenthesizePropertyNameAttribute use System.ComponentModel.ParenthesizePropertyNameAttribute"
		alias
			"Default"
		end

	frozen get_need_parenthesis: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ParenthesizePropertyNameAttribute"
		alias
			"get_NeedParenthesis"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ParenthesizePropertyNameAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ParenthesizePropertyNameAttribute"
		alias
			"GetHashCode"
		end

	equals_object (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ParenthesizePropertyNameAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_PARENTHESIZEPROPERTYNAMEATTRIBUTE

indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.InheritanceAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_INHERITANCEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal,
			to_string
		end

create
	make_inheritanceattribute,
	make_inheritanceattribute_1

feature {NONE} -- Initialization

	frozen make_inheritanceattribute is
		external
			"IL creator use System.ComponentModel.InheritanceAttribute"
		end

	frozen make_inheritanceattribute_1 (inheritance_level: SYSTEM_COMPONENTMODEL_INHERITANCELEVEL) is
		external
			"IL creator signature (System.ComponentModel.InheritanceLevel) use System.ComponentModel.InheritanceAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_INHERITANCEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.InheritanceAttribute use System.ComponentModel.InheritanceAttribute"
		alias
			"Default"
		end

	frozen not_inherited: SYSTEM_COMPONENTMODEL_INHERITANCEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.InheritanceAttribute use System.ComponentModel.InheritanceAttribute"
		alias
			"NotInherited"
		end

	frozen get_inheritance_level: SYSTEM_COMPONENTMODEL_INHERITANCELEVEL is
		external
			"IL signature (): System.ComponentModel.InheritanceLevel use System.ComponentModel.InheritanceAttribute"
		alias
			"get_InheritanceLevel"
		end

	frozen inherited_read_only: SYSTEM_COMPONENTMODEL_INHERITANCEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.InheritanceAttribute use System.ComponentModel.InheritanceAttribute"
		alias
			"InheritedReadOnly"
		end

	frozen inherited: SYSTEM_COMPONENTMODEL_INHERITANCEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.InheritanceAttribute use System.ComponentModel.InheritanceAttribute"
		alias
			"Inherited"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.InheritanceAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.InheritanceAttribute"
		alias
			"GetHashCode"
		end

	is_equal (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.InheritanceAttribute"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.InheritanceAttribute"
		alias
			"ToString"
		end

end -- class SYSTEM_COMPONENTMODEL_INHERITANCEATTRIBUTE

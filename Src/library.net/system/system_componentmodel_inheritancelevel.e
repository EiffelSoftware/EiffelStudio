indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.InheritanceLevel"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_COMPONENTMODEL_INHERITANCELEVEL

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen inherited_read_only: SYSTEM_COMPONENTMODEL_INHERITANCELEVEL is
		external
			"IL enum signature :System.ComponentModel.InheritanceLevel use System.ComponentModel.InheritanceLevel"
		alias
			"2"
		end

	frozen not_inherited: SYSTEM_COMPONENTMODEL_INHERITANCELEVEL is
		external
			"IL enum signature :System.ComponentModel.InheritanceLevel use System.ComponentModel.InheritanceLevel"
		alias
			"3"
		end

	frozen inherited: SYSTEM_COMPONENTMODEL_INHERITANCELEVEL is
		external
			"IL enum signature :System.ComponentModel.InheritanceLevel use System.ComponentModel.InheritanceLevel"
		alias
			"1"
		end

end -- class SYSTEM_COMPONENTMODEL_INHERITANCELEVEL

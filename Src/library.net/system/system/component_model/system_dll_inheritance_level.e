indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.InheritanceLevel"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_INHERITANCE_LEVEL

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen inherited_read_only: SYSTEM_DLL_INHERITANCE_LEVEL is
		external
			"IL enum signature :System.ComponentModel.InheritanceLevel use System.ComponentModel.InheritanceLevel"
		alias
			"2"
		end

	frozen not_inherited: SYSTEM_DLL_INHERITANCE_LEVEL is
		external
			"IL enum signature :System.ComponentModel.InheritanceLevel use System.ComponentModel.InheritanceLevel"
		alias
			"3"
		end

	frozen inherited: SYSTEM_DLL_INHERITANCE_LEVEL is
		external
			"IL enum signature :System.ComponentModel.InheritanceLevel use System.ComponentModel.InheritanceLevel"
		alias
			"1"
		end

end -- class SYSTEM_DLL_INHERITANCE_LEVEL

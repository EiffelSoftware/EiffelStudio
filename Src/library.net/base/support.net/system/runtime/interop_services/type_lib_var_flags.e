indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.TypeLibVarFlags"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	TYPE_LIB_VAR_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen freplaceable: TYPE_LIB_VAR_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarFlags"
		alias
			"2048"
		end

	frozen frestricted: TYPE_LIB_VAR_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarFlags"
		alias
			"128"
		end

	frozen fread_only: TYPE_LIB_VAR_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarFlags"
		alias
			"1"
		end

	frozen fhidden: TYPE_LIB_VAR_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarFlags"
		alias
			"64"
		end

	frozen fsource: TYPE_LIB_VAR_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarFlags"
		alias
			"2"
		end

	frozen fdefault_bind: TYPE_LIB_VAR_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarFlags"
		alias
			"32"
		end

	frozen fdefault_collelem: TYPE_LIB_VAR_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarFlags"
		alias
			"256"
		end

	frozen fdisplay_bind: TYPE_LIB_VAR_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarFlags"
		alias
			"16"
		end

	frozen frequest_edit: TYPE_LIB_VAR_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarFlags"
		alias
			"8"
		end

	frozen fnon_browsable: TYPE_LIB_VAR_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarFlags"
		alias
			"1024"
		end

	frozen fbindable: TYPE_LIB_VAR_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarFlags"
		alias
			"4"
		end

	frozen fimmediate_bind: TYPE_LIB_VAR_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarFlags"
		alias
			"4096"
		end

	frozen fui_default: TYPE_LIB_VAR_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.TypeLibVarFlags use System.Runtime.InteropServices.TypeLibVarFlags"
		alias
			"512"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class TYPE_LIB_VAR_FLAGS

indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.BindingFlags"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	BINDING_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen get_field: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"1024"
		end

	frozen optional_param_binding: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"262144"
		end

	frozen ignore_case: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"1"
		end

	frozen public: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"16"
		end

	frozen ignore_return: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"16777216"
		end

	frozen put_ref_disp_property: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"32768"
		end

	frozen static: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"8"
		end

	frozen get_property: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"4096"
		end

	frozen set_field: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"2048"
		end

	frozen invoke_method: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"256"
		end

	frozen flatten_hierarchy: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"64"
		end

	frozen declared_only: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"2"
		end

	frozen instance: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"4"
		end

	frozen exact_binding: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"65536"
		end

	frozen default_: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"0"
		end

	frozen non_public: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"32"
		end

	frozen set_property: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"8192"
		end

	frozen create_instance: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"512"
		end

	frozen suppress_change_type: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"131072"
		end

	frozen put_disp_property: BINDING_FLAGS is
		external
			"IL enum signature :System.Reflection.BindingFlags use System.Reflection.BindingFlags"
		alias
			"16384"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class BINDING_FLAGS

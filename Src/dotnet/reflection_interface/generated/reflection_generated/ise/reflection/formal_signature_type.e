indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "FORMAL_SIGNATURE_TYPE"

deferred external class
	FORMAL_SIGNATURE_TYPE

inherit
	SIGNATURE_TYPE_INTERFACE
	SIGNATURE_TYPE

feature -- Basic Operations

	a_set_generic_parameter_index (generic_parameter_index2: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use FORMAL_SIGNATURE_TYPE"
		alias
			"_set_generic_parameter_index"
		end

	generic_parameter_index: INTEGER is
		external
			"IL deferred signature (): System.Int32 use FORMAL_SIGNATURE_TYPE"
		alias
			"generic_parameter_index"
		end

	set_generic_parameter_index (an_index: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use FORMAL_SIGNATURE_TYPE"
		alias
			"set_generic_parameter_index"
		end

end -- class FORMAL_SIGNATURE_TYPE

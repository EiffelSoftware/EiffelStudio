indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.GenericDerivation"
	assembly: "ISE.Reflection.EiffelComponents", "0.0.0.0", "neutral", "e0f9d13739fa815f"

external class
	ISE_REFLECTION_GENERICDERIVATION

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.GenericDerivation"
		end

feature -- Access

	get_generic_types: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use ISE.Reflection.GenericDerivation"
		alias
			"get_GenericTypes"
		end

	frozen a_internal_generic_types: ARRAY [ANY] is
		external
			"IL field signature :System.Object[] use ISE.Reflection.GenericDerivation"
		alias
			"_internal_GenericTypes"
		end

feature -- Basic Operations

	add_derivation_type (a_type: ISE_REFLECTION_SIGNATURETYPE) is
		external
			"IL signature (ISE.Reflection.SignatureType): System.Void use ISE.Reflection.GenericDerivation"
		alias
			"AddDerivationType"
		end

	frozen a_invariant (current_object: ISE_REFLECTION_GENERICDERIVATION) is
		external
			"IL static signature (ISE.Reflection.GenericDerivation): System.Void use ISE.Reflection.GenericDerivation"
		alias
			"_invariant"
		end

	make (derivation_count: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use ISE.Reflection.GenericDerivation"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_GENERICDERIVATION

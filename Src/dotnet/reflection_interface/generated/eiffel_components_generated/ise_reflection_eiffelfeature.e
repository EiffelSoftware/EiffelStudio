indexing
	Generator: "Eiffel Emitter 2.6b2"
	external_name: "ISE.Reflection.EiffelFeature"
external class
	ISE_REFLECTION_EIFFELFEATURE

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.EiffelFeature"
		end

feature -- Access

	frozen eiffel_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelFeature"
		alias
			"EiffelName"
		end

	frozen is_field: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsField"
		end

	frozen is_creation_routine: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsCreationRoutine"
		end

	frozen is_enum_literal: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsEnumLiteral"
		end

	frozen arguments: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelFeature"
		alias
			"Arguments"
		end

	frozen is_prefix: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsPrefix"
		end

	frozen new_slot: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"NewSlot"
		end

	frozen postconditions: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelFeature"
		alias
			"Postconditions"
		end

	frozen comments: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelFeature"
		alias
			"Comments"
		end

	frozen external_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelFeature"
		alias
			"ExternalName"
		end

	frozen is_method: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsMethod"
		end

	frozen modified: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"Modified"
		end

	frozen is_frozen: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsFrozen"
		end

	frozen return_type: ISE_REFLECTION_SIGNATURETYPE is
		external
			"IL field signature :ISE.Reflection.SignatureType use ISE.Reflection.EiffelFeature"
		alias
			"ReturnType"
		end

	frozen is_infix: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsInfix"
		end

	frozen preconditions: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelFeature"
		alias
			"Preconditions"
		end

	frozen is_static: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsStatic"
		end

	frozen is_abstract: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsAbstract"
		end

feature -- Basic Operations

	set_external_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetExternalName"
		end

	set_infix (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetInfix"
		end

	set_abstract (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetAbstract"
		end

	add_precondition (a_tag: STRING; a_text: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"AddPrecondition"
		end

	set_method (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetMethod"
		end

	set_return_type (a_type: ISE_REFLECTION_SIGNATURETYPE) is
		external
			"IL signature (ISE.Reflection.SignatureType): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetReturnType"
		end

	set_field (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetField"
		end

	set_creation_routine (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetCreationRoutine"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"_invariant"
		end

	add_argument (an_argument: ISE_REFLECTION_NAMEDSIGNATURETYPE) is
		external
			"IL signature (ISE.Reflection.NamedSignatureType): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"AddArgument"
		end

	set_new_slot is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetNewSlot"
		end

	set_prefix (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetPrefix"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"Make"
		end

	argument_from_info (info: SYSTEM_REFLECTION_PARAMETERINFO): ARRAY [STRING] is
		external
			"IL signature (System.Reflection.ParameterInfo): System.String[] use ISE.Reflection.EiffelFeature"
		alias
			"ArgumentFromInfo"
		end

	add_postcondition (a_tag: STRING; a_text: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"AddPostcondition"
		end

	add_comment (a_comment: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"AddComment"
		end

	set_frozen (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetFrozen"
		end

	set_modified is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetModified"
		end

	set_eiffel_name (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetEiffelName"
		end

	set_enum_literal is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetEnumLiteral"
		end

	set_static (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetStatic"
		end

end -- class ISE_REFLECTION_EIFFELFEATURE

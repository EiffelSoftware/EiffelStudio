indexing
	Generator: "Eiffel Emitter 2.3b"
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

	frozen Arguments: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelFeature"
		alias
			"Arguments"
		end

	frozen EiffelName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelFeature"
		alias
			"EiffelName"
		end

	frozen IsCreationRoutine: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsCreationRoutine"
		end

	frozen Comments: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelFeature"
		alias
			"Comments"
		end

	frozen IsInfix: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsInfix"
		end

	frozen IsAbstract: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsAbstract"
		end

	frozen postcondition: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"postcondition"
		end

	frozen ExternalName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelFeature"
		alias
			"ExternalName"
		end

	frozen ReturnType: ISE_REFLECTION_SIGNATURETYPE is
		external
			"IL field signature :ISE.Reflection.SignatureType use ISE.Reflection.EiffelFeature"
		alias
			"ReturnType"
		end

	frozen IsField: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsField"
		end

	frozen IsPrefix: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsPrefix"
		end

	frozen IsFrozen: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsFrozen"
		end

	frozen IsStatic: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsStatic"
		end

	frozen Preconditions: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelFeature"
		alias
			"Preconditions"
		end

	frozen IsMethod: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsMethod"
		end

	frozen Postconditions: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelFeature"
		alias
			"Postconditions"
		end

feature -- Basic Operations

	AddPostcondition (a_tag: STRING; a_text: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"AddPostcondition"
		end

	AddPrecondition (a_tag: STRING; a_text: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"AddPrecondition"
		end

	SetField (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetField"
		end

	SetMethod (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetMethod"
		end

	SetCreationRoutine (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetCreationRoutine"
		end

	AddComment (a_comment: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"AddComment"
		end

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"Make"
		end

	AddArgument (an_argument: ISE_REFLECTION_NAMEDSIGNATURETYPE) is
		external
			"IL signature (ISE.Reflection.NamedSignatureType): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"AddArgument"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"_invariant"
		end

	SetStatic (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetStatic"
		end

	ArgumentFromInfo (info: SYSTEM_REFLECTION_PARAMETERINFO): ARRAY [STRING] is
		external
			"IL signature (System.Reflection.ParameterInfo): System.String[] use ISE.Reflection.EiffelFeature"
		alias
			"ArgumentFromInfo"
		end

	SetAbstract (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetAbstract"
		end

	SetFrozen (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetFrozen"
		end

	set_postcondition (a_postcondition: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"set_postcondition"
		end

	SetEiffelName (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetEiffelName"
		end

	SetReturnType (a_type: ISE_REFLECTION_SIGNATURETYPE) is
		external
			"IL signature (ISE.Reflection.SignatureType): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetReturnType"
		end

	SetInfix (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetInfix"
		end

	SetPrefix (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetPrefix"
		end

	SetExternalName (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetExternalName"
		end

end -- class ISE_REFLECTION_EIFFELFEATURE

indexing
	Generator: "Eiffel Emitter beta 2"
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

	frozen isprefix: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsPrefix"
		end

	frozen arguments: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelFeature"
		alias
			"Arguments"
		end

	frozen returntypefullname: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelFeature"
		alias
			"ReturnTypeFullName"
		end

	frozen preconditions: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelFeature"
		alias
			"Preconditions"
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

	frozen isfrozen: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsFrozen"
		end

	frozen isinfix: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsInfix"
		end

	frozen ismethod: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsMethod"
		end

	frozen isstatic: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsStatic"
		end

	frozen isfield: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsField"
		end

	frozen postcondition: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"postcondition"
		end

	frozen iscreationroutine: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsCreationRoutine"
		end

	frozen eiffelname: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelFeature"
		alias
			"EiffelName"
		end

	frozen dotnetname: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelFeature"
		alias
			"DotNetName"
		end

	frozen returntype: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelFeature"
		alias
			"ReturnType"
		end

	frozen isabstract: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.EiffelFeature"
		alias
			"IsAbstract"
		end

feature -- Basic Operations

	addprecondition (a_tag: STRING; a_text: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"AddPrecondition"
		end

	setfrozen (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetFrozen"
		end

	addargument (an_eiffel_name: STRING; a_dot_net_name: STRING; a_type: STRING; a_type_full_name: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"AddArgument"
		end

	setcreationroutine (a_value: BOOLEAN) is
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

	addcomment (a_comment: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"AddComment"
		end

	setprefix (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetPrefix"
		end

	setreturntypefullname (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetReturnTypeFullName"
		end

	argumentfrominfo (info: SYSTEM_REFLECTION_PARAMETERINFO): ARRAY [STRING] is
		external
			"IL signature (System.Reflection.ParameterInfo): System.String[] use ISE.Reflection.EiffelFeature"
		alias
			"ArgumentFromInfo"
		end

	setabstract (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetAbstract"
		end

	set_postcondition (a_postcondition: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"set_postcondition"
		end

	setdotnetname (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetDotNetName"
		end

	seteiffelname (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetEiffelName"
		end

	setmethod (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetMethod"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"Make"
		end

	addpostcondition (a_tag: STRING; a_text: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"AddPostcondition"
		end

	setfield (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetField"
		end

	setreturntype (a_type: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetReturnType"
		end

	setstatic (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetStatic"
		end

	setinfix (a_value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use ISE.Reflection.EiffelFeature"
		alias
			"SetInfix"
		end

end -- class ISE_REFLECTION_EIFFELFEATURE

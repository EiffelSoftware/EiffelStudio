indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.EIFFEL_COMPONENTS"

external class
	IMPLEMENTATION_EIFFEL_COMPONENTS

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	EIFFEL_COMPONENTS

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.EIFFEL_COMPONENTS"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_undefine_clause: UNDEFINE_CLAUSE is
		external
			"IL field signature :UNDEFINE_CLAUSE use Implementation.EIFFEL_COMPONENTS"
		alias
			"$$undefine_clause"
		end

	frozen ec_illegal_36_ec_illegal_36_redefine_clause: REDEFINE_CLAUSE is
		external
			"IL field signature :REDEFINE_CLAUSE use Implementation.EIFFEL_COMPONENTS"
		alias
			"$$redefine_clause"
		end

	frozen ec_illegal_36_ec_illegal_36_rename_clause: RENAME_CLAUSE is
		external
			"IL field signature :RENAME_CLAUSE use Implementation.EIFFEL_COMPONENTS"
		alias
			"$$rename_clause"
		end

	frozen ec_illegal_36_ec_illegal_36_select_clause: SELECT_CLAUSE is
		external
			"IL field signature :SELECT_CLAUSE use Implementation.EIFFEL_COMPONENTS"
		alias
			"$$select_clause"
		end

	frozen ec_illegal_36_ec_illegal_36_assembly_factory: EIFFEL_ASSEMBLY_FACTORY is
		external
			"IL field signature :EIFFEL_ASSEMBLY_FACTORY use Implementation.EIFFEL_COMPONENTS"
		alias
			"$$assembly_factory"
		end

	frozen ec_illegal_36_ec_illegal_36_formal_named_signature_type: FORMAL_NAMED_SIGNATURE_TYPE is
		external
			"IL field signature :FORMAL_NAMED_SIGNATURE_TYPE use Implementation.EIFFEL_COMPONENTS"
		alias
			"$$formal_named_signature_type"
		end

	frozen ec_illegal_36_ec_illegal_36_eiffel_class: EIFFEL_CLASS is
		external
			"IL field signature :EIFFEL_CLASS use Implementation.EIFFEL_COMPONENTS"
		alias
			"$$eiffel_class"
		end

	frozen ec_illegal_36_ec_illegal_36_named_signature_type: NAMED_SIGNATURE_TYPE is
		external
			"IL field signature :NAMED_SIGNATURE_TYPE use Implementation.EIFFEL_COMPONENTS"
		alias
			"$$named_signature_type"
		end

	frozen ec_illegal_36_ec_illegal_36_export_clause: EXPORT_CLAUSE is
		external
			"IL field signature :EXPORT_CLAUSE use Implementation.EIFFEL_COMPONENTS"
		alias
			"$$export_clause"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.EIFFEL_COMPONENTS"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_COMPONENTS"
		alias
			"deep_clone"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_COMPONENTS"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_COMPONENTS"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.EIFFEL_COMPONENTS"
		alias
			"operating_environment"
		end

	a_set_assembly_factory (assembly_factory2: EIFFEL_ASSEMBLY_FACTORY) is
		external
			"IL signature (EIFFEL_ASSEMBLY_FACTORY): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"_set_assembly_factory"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_COMPONENTS"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_COMPONENTS"
		alias
			"is_equal"
		end

	a_set_undefine_clause (undefine_clause2: UNDEFINE_CLAUSE) is
		external
			"IL signature (UNDEFINE_CLAUSE): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"_set_undefine_clause"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_COMPONENTS"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_COMPONENTS"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_COMPONENTS"
		alias
			"generator"
		end

	a_set_formal_named_signature_type (formal_named_signature_type2: FORMAL_NAMED_SIGNATURE_TYPE) is
		external
			"IL signature (FORMAL_NAMED_SIGNATURE_TYPE): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"_set_formal_named_signature_type"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"internal_copy"
		end

	a_set_rename_clause (rename_clause2: RENAME_CLAUSE) is
		external
			"IL signature (RENAME_CLAUSE): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"_set_rename_clause"
		end

	eiffel_class: EIFFEL_CLASS is
		external
			"IL signature (): EIFFEL_CLASS use Implementation.EIFFEL_COMPONENTS"
		alias
			"eiffel_class"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_COMPONENTS"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_COMPONENTS"
		alias
			"equal"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_COMPONENTS"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_COMPONENTS"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"default_rescue"
		end

	a_set_named_signature_type (named_signature_type2: NAMED_SIGNATURE_TYPE) is
		external
			"IL signature (NAMED_SIGNATURE_TYPE): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"_set_named_signature_type"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.EIFFEL_COMPONENTS"
		alias
			"default_pointer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.EIFFEL_COMPONENTS"
		alias
			"ToString"
		end

	formal_named_signature_type: FORMAL_NAMED_SIGNATURE_TYPE is
		external
			"IL signature (): FORMAL_NAMED_SIGNATURE_TYPE use Implementation.EIFFEL_COMPONENTS"
		alias
			"formal_named_signature_type"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.EIFFEL_COMPONENTS"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.EIFFEL_COMPONENTS"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.EIFFEL_COMPONENTS"
		alias
			"Equals"
		end

	a_set_eiffel_class (eiffel_class2: EIFFEL_CLASS) is
		external
			"IL signature (EIFFEL_CLASS): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"_set_eiffel_class"
		end

	a_set_redefine_clause (redefine_clause2: REDEFINE_CLAUSE) is
		external
			"IL signature (REDEFINE_CLAUSE): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"_set_redefine_clause"
		end

	undefine_clause: UNDEFINE_CLAUSE is
		external
			"IL signature (): UNDEFINE_CLAUSE use Implementation.EIFFEL_COMPONENTS"
		alias
			"undefine_clause"
		end

	named_signature_type: NAMED_SIGNATURE_TYPE is
		external
			"IL signature (): NAMED_SIGNATURE_TYPE use Implementation.EIFFEL_COMPONENTS"
		alias
			"named_signature_type"
		end

	assembly_factory: EIFFEL_ASSEMBLY_FACTORY is
		external
			"IL signature (): EIFFEL_ASSEMBLY_FACTORY use Implementation.EIFFEL_COMPONENTS"
		alias
			"assembly_factory"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.EIFFEL_COMPONENTS"
		alias
			"generating_type"
		end

	a_set_select_clause (select_clause2: SELECT_CLAUSE) is
		external
			"IL signature (SELECT_CLAUSE): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"_set_select_clause"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: EIFFEL_COMPONENTS) is
		external
			"IL static signature (EIFFEL_COMPONENTS): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"$$make"
		end

	a_set_export_clause (export_clause2: EXPORT_CLAUSE) is
		external
			"IL signature (EXPORT_CLAUSE): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"_set_export_clause"
		end

	export_clause: EXPORT_CLAUSE is
		external
			"IL signature (): EXPORT_CLAUSE use Implementation.EIFFEL_COMPONENTS"
		alias
			"export_clause"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.EIFFEL_COMPONENTS"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.EIFFEL_COMPONENTS"
		alias
			"clone"
		end

	rename_clause: RENAME_CLAUSE is
		external
			"IL signature (): RENAME_CLAUSE use Implementation.EIFFEL_COMPONENTS"
		alias
			"rename_clause"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.EIFFEL_COMPONENTS"
		alias
			"conforms_to"
		end

	select_clause: SELECT_CLAUSE is
		external
			"IL signature (): SELECT_CLAUSE use Implementation.EIFFEL_COMPONENTS"
		alias
			"select_clause"
		end

	redefine_clause: REDEFINE_CLAUSE is
		external
			"IL signature (): REDEFINE_CLAUSE use Implementation.EIFFEL_COMPONENTS"
		alias
			"redefine_clause"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"make"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.EIFFEL_COMPONENTS"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_EIFFEL_COMPONENTS

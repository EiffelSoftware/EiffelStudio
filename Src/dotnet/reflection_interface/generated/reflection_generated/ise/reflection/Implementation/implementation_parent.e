indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.PARENT"

external class
	IMPLEMENTATION_PARENT

inherit
	PARENT
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use Implementation.PARENT"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_undefine_clauses: LINKED_LIST_ANY is
		external
			"IL field signature :LINKED_LIST_ANY use Implementation.PARENT"
		alias
			"$$undefine_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_select_clauses: LINKED_LIST_ANY is
		external
			"IL field signature :LINKED_LIST_ANY use Implementation.PARENT"
		alias
			"$$select_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_name: STRING is
		external
			"IL field signature :STRING use Implementation.PARENT"
		alias
			"$$name"
		end

	frozen ec_illegal_36_ec_illegal_36_implementation: PARENT_IMP is
		external
			"IL field signature :PARENT_IMP use Implementation.PARENT"
		alias
			"$$implementation"
		end

	frozen ec_illegal_36_ec_illegal_36_rename_clauses: LINKED_LIST_ANY is
		external
			"IL field signature :LINKED_LIST_ANY use Implementation.PARENT"
		alias
			"$$rename_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_redefine_clauses: LINKED_LIST_ANY is
		external
			"IL field signature :LINKED_LIST_ANY use Implementation.PARENT"
		alias
			"$$redefine_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_export_clauses: LINKED_LIST_ANY is
		external
			"IL field signature :LINKED_LIST_ANY use Implementation.PARENT"
		alias
			"$$export_clauses"
		end

feature -- Basic Operations

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.PARENT"
		alias
			"operating_environment"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.PARENT"
		alias
			"____class_name"
		end

	set_name (a_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.PARENT"
		alias
			"set_name"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.PARENT"
		alias
			"default_create"
		end

	frozen ec_illegal_36_ec_illegal_36_set_redefine_clauses (current_: PARENT; a_list: LINKED_LIST_ANY) is
		external
			"IL static signature (PARENT, LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"$$set_redefine_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_add_export_clause (current_: PARENT; a_clause: EXPORT_CLAUSE) is
		external
			"IL static signature (PARENT, EXPORT_CLAUSE): System.Void use Implementation.PARENT"
		alias
			"$$add_export_clause"
		end

	frozen ec_illegal_36_ec_illegal_36_set_select_clauses (current_: PARENT; a_list: LINKED_LIST_ANY) is
		external
			"IL static signature (PARENT, LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"$$set_select_clauses"
		end

	export_clauses: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.PARENT"
		alias
			"export_clauses"
		end

	a_set_redefine_clauses (redefine_clauses2: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"_set_redefine_clauses"
		end

	a_set_rename_clauses (rename_clauses2: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"_set_rename_clauses"
		end

	add_undefine_clause (a_clause: UNDEFINE_CLAUSE) is
		external
			"IL signature (UNDEFINE_CLAUSE): System.Void use Implementation.PARENT"
		alias
			"add_undefine_clause"
		end

	name: STRING is
		external
			"IL signature (): STRING use Implementation.PARENT"
		alias
			"name"
		end

	frozen ec_illegal_36_ec_illegal_36_add_select_clause (current_: PARENT; a_clause: SELECT_CLAUSE) is
		external
			"IL static signature (PARENT, SELECT_CLAUSE): System.Void use Implementation.PARENT"
		alias
			"$$add_select_clause"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PARENT"
		alias
			"copy"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.PARENT"
		alias
			"generating_type"
		end

	make (a_name: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.PARENT"
		alias
			"make"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.PARENT"
		alias
			"out"
		end

	make_implementation (a_name: STRING; imp: PARENT_IMP) is
		external
			"IL signature (STRING, PARENT_IMP): System.Void use Implementation.PARENT"
		alias
			"make_implementation"
		end

	undefine_clauses: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.PARENT"
		alias
			"undefine_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: PARENT; a_name: STRING) is
		external
			"IL static signature (PARENT, STRING): System.Void use Implementation.PARENT"
		alias
			"$$make"
		end

	frozen ec_illegal_36_ec_illegal_36_set_undefine_clauses (current_: PARENT; a_list: LINKED_LIST_ANY) is
		external
			"IL static signature (PARENT, LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"$$set_undefine_clauses"
		end

	select_clauses: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.PARENT"
		alias
			"select_clauses"
		end

	add_redefine_clause (a_clause: REDEFINE_CLAUSE) is
		external
			"IL signature (REDEFINE_CLAUSE): System.Void use Implementation.PARENT"
		alias
			"add_redefine_clause"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PARENT"
		alias
			"conforms_to"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.PARENT"
		alias
			"io"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PARENT"
		alias
			"GetHashCode"
		end

	set_export_clauses (a_list: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"set_export_clauses"
		end

	a_set_name (name2: STRING) is
		external
			"IL signature (STRING): System.Void use Implementation.PARENT"
		alias
			"_set_name"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.PARENT"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_add_rename_clause (current_: PARENT; a_clause: RENAME_CLAUSE) is
		external
			"IL static signature (PARENT, RENAME_CLAUSE): System.Void use Implementation.PARENT"
		alias
			"$$add_rename_clause"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.PARENT"
		alias
			"default"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PARENT"
		alias
			"same_type"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.PARENT"
		alias
			"do_nothing"
		end

	set_rename_clauses (a_list: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"set_rename_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_set_name (current_: PARENT; a_name: STRING) is
		external
			"IL static signature (PARENT, STRING): System.Void use Implementation.PARENT"
		alias
			"$$set_name"
		end

	frozen ec_illegal_36_ec_illegal_36_make_implementation (current_: PARENT; a_name: STRING; imp: PARENT_IMP) is
		external
			"IL static signature (PARENT, STRING, PARENT_IMP): System.Void use Implementation.PARENT"
		alias
			"$$make_implementation"
		end

	add_export_clause (a_clause: EXPORT_CLAUSE) is
		external
			"IL signature (EXPORT_CLAUSE): System.Void use Implementation.PARENT"
		alias
			"add_export_clause"
		end

	set_undefine_clauses (a_list: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"set_undefine_clauses"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PARENT"
		alias
			"standard_is_equal"
		end

	a_set_implementation (implementation2: PARENT_IMP) is
		external
			"IL signature (PARENT_IMP): System.Void use Implementation.PARENT"
		alias
			"_set_implementation"
		end

	rename_clauses: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.PARENT"
		alias
			"rename_clauses"
		end

	add_select_clause (a_clause: SELECT_CLAUSE) is
		external
			"IL signature (SELECT_CLAUSE): System.Void use Implementation.PARENT"
		alias
			"add_select_clause"
		end

	a_set_select_clauses (select_clauses2: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"_set_select_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_add_redefine_clause (current_: PARENT; a_clause: REDEFINE_CLAUSE) is
		external
			"IL static signature (PARENT, REDEFINE_CLAUSE): System.Void use Implementation.PARENT"
		alias
			"$$add_redefine_clause"
		end

	a_set_export_clauses (export_clauses2: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"_set_export_clauses"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PARENT"
		alias
			"is_equal"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PARENT"
		alias
			"standard_copy"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PARENT"
		alias
			"print"
		end

	frozen ec_illegal_36_ec_illegal_36_add_undefine_clause (current_: PARENT; a_clause: UNDEFINE_CLAUSE) is
		external
			"IL static signature (PARENT, UNDEFINE_CLAUSE): System.Void use Implementation.PARENT"
		alias
			"$$add_undefine_clause"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PARENT"
		alias
			"equal"
		end

	set_select_clauses (a_list: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"set_select_clauses"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PARENT"
		alias
			"clone"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PARENT"
		alias
			"standard_equal"
		end

	redefine_clauses: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.PARENT"
		alias
			"redefine_clauses"
		end

	a_set_undefine_clauses (undefine_clauses2: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"_set_undefine_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_set_rename_clauses (current_: PARENT; a_list: LINKED_LIST_ANY) is
		external
			"IL static signature (PARENT, LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"$$set_rename_clauses"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.PARENT"
		alias
			"Equals"
		end

	add_rename_clause (a_clause: RENAME_CLAUSE) is
		external
			"IL signature (RENAME_CLAUSE): System.Void use Implementation.PARENT"
		alias
			"add_rename_clause"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PARENT"
		alias
			"deep_equal"
		end

	set_redefine_clauses (a_list: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"set_redefine_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_set_export_clauses (current_: PARENT; a_list: LINKED_LIST_ANY) is
		external
			"IL static signature (PARENT, LINKED_LIST_ANY): System.Void use Implementation.PARENT"
		alias
			"$$set_export_clauses"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PARENT"
		alias
			"standard_clone"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.PARENT"
		alias
			"default_rescue"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.PARENT"
		alias
			"internal_clone"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.PARENT"
		alias
			"generator"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PARENT"
		alias
			"deep_clone"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PARENT"
		alias
			"internal_copy"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.PARENT"
		alias
			"default_pointer"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.PARENT"
		alias
			"ToString"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PARENT"
		alias
			"deep_copy"
		end

	implementation: PARENT_IMP is
		external
			"IL signature (): PARENT_IMP use Implementation.PARENT"
		alias
			"implementation"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.PARENT"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_PARENT

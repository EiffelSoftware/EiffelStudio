indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.PARENT_IMP"

external class
	IMPLEMENTATION_PARENT_IMP

inherit
	PARENT_IMP
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
			"IL creator use Implementation.PARENT_IMP"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_converter: GLOBAL_CONVERSATION_ANY is
		external
			"IL field signature :GLOBAL_CONVERSATION_ANY use Implementation.PARENT_IMP"
		alias
			"$$converter"
		end

	frozen ec_illegal_36_ec_illegal_36_class_interface: PARENT is
		external
			"IL field signature :PARENT use Implementation.PARENT_IMP"
		alias
			"$$class_interface"
		end

feature -- Basic Operations

	export_clauses: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use Implementation.PARENT_IMP"
		alias
			"export_clauses"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PARENT_IMP"
		alias
			"deep_clone"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.PARENT_IMP"
		alias
			"GetHashCode"
		end

	add_rename_clause (a_clause: RENAME_CLAUSE) is
		external
			"IL signature (RENAME_CLAUSE): System.Void use Implementation.PARENT_IMP"
		alias
			"add_rename_clause"
		end

	frozen ec_illegal_36_ec_illegal_36_add_redefine_clause (current_: PARENT_IMP; a_clause: REDEFINE_CLAUSE) is
		external
			"IL static signature (PARENT_IMP, REDEFINE_CLAUSE): System.Void use Implementation.PARENT_IMP"
		alias
			"$$add_redefine_clause"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.PARENT_IMP"
		alias
			"tagged_out"
		end

	frozen ec_illegal_36_ec_illegal_36_set_interface (current_: PARENT_IMP; i: PARENT) is
		external
			"IL static signature (PARENT_IMP, PARENT): System.Void use Implementation.PARENT_IMP"
		alias
			"$$set_interface"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.PARENT_IMP"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.PARENT_IMP"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PARENT_IMP"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PARENT_IMP"
		alias
			"is_equal"
		end

	frozen ec_illegal_36_ec_illegal_36_set_name (current_: PARENT_IMP; a_name: SYSTEM_STRING) is
		external
			"IL static signature (PARENT_IMP, System.String): System.Void use Implementation.PARENT_IMP"
		alias
			"$$set_name"
		end

	add_select_clause (a_clause: SELECT_CLAUSE) is
		external
			"IL signature (SELECT_CLAUSE): System.Void use Implementation.PARENT_IMP"
		alias
			"add_select_clause"
		end

	name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.PARENT_IMP"
		alias
			"name"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PARENT_IMP"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PARENT_IMP"
		alias
			"same_type"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.PARENT_IMP"
		alias
			"generator"
		end

	frozen ec_illegal_36_ec_illegal_36_set_undefine_clauses (current_: PARENT_IMP; a_list: ARRAY_LIST) is
		external
			"IL static signature (PARENT_IMP, System.Collections.ArrayList): System.Void use Implementation.PARENT_IMP"
		alias
			"$$set_undefine_clauses"
		end

	set_redefine_clauses (a_list: ARRAY_LIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use Implementation.PARENT_IMP"
		alias
			"set_redefine_clauses"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PARENT_IMP"
		alias
			"internal_copy"
		end

	add_undefine_clause (a_clause: UNDEFINE_CLAUSE) is
		external
			"IL signature (UNDEFINE_CLAUSE): System.Void use Implementation.PARENT_IMP"
		alias
			"add_undefine_clause"
		end

	set_select_clauses (a_list: ARRAY_LIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use Implementation.PARENT_IMP"
		alias
			"set_select_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_add_undefine_clause (current_: PARENT_IMP; a_clause: UNDEFINE_CLAUSE) is
		external
			"IL static signature (PARENT_IMP, UNDEFINE_CLAUSE): System.Void use Implementation.PARENT_IMP"
		alias
			"$$add_undefine_clause"
		end

	frozen ec_illegal_36_ec_illegal_36_set_select_clauses (current_: PARENT_IMP; a_list: ARRAY_LIST) is
		external
			"IL static signature (PARENT_IMP, System.Collections.ArrayList): System.Void use Implementation.PARENT_IMP"
		alias
			"$$set_select_clauses"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PARENT_IMP"
		alias
			"standard_clone"
		end

	frozen ec_illegal_36_ec_illegal_36_name (current_: PARENT_IMP): SYSTEM_STRING is
		external
			"IL static signature (PARENT_IMP): System.String use Implementation.PARENT_IMP"
		alias
			"$$name"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PARENT_IMP"
		alias
			"equal"
		end

	frozen ec_illegal_36_ec_illegal_36_set_redefine_clauses (current_: PARENT_IMP; a_list: ARRAY_LIST) is
		external
			"IL static signature (PARENT_IMP, System.Collections.ArrayList): System.Void use Implementation.PARENT_IMP"
		alias
			"$$set_redefine_clauses"
		end

	a_set_class_interface (class_interface2: PARENT) is
		external
			"IL signature (PARENT): System.Void use Implementation.PARENT_IMP"
		alias
			"_set_class_interface"
		end

	frozen ec_illegal_36_ec_illegal_36_set_export_clauses (current_: PARENT_IMP; a_list: ARRAY_LIST) is
		external
			"IL static signature (PARENT_IMP, System.Collections.ArrayList): System.Void use Implementation.PARENT_IMP"
		alias
			"$$set_export_clauses"
		end

	add_redefine_clause (a_clause: REDEFINE_CLAUSE) is
		external
			"IL signature (REDEFINE_CLAUSE): System.Void use Implementation.PARENT_IMP"
		alias
			"add_redefine_clause"
		end

	set_name (a_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use Implementation.PARENT_IMP"
		alias
			"set_name"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.PARENT_IMP"
		alias
			"____class_name"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.PARENT_IMP"
		alias
			"do_nothing"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.PARENT_IMP"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.PARENT_IMP"
		alias
			"default_rescue"
		end

	make (a_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use Implementation.PARENT_IMP"
		alias
			"make"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.PARENT_IMP"
		alias
			"default_pointer"
		end

	frozen ec_illegal_36_ec_illegal_36_add_rename_clause (current_: PARENT_IMP; a_clause: RENAME_CLAUSE) is
		external
			"IL static signature (PARENT_IMP, RENAME_CLAUSE): System.Void use Implementation.PARENT_IMP"
		alias
			"$$add_rename_clause"
		end

	rename_clauses: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use Implementation.PARENT_IMP"
		alias
			"rename_clauses"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PARENT_IMP"
		alias
			"standard_copy"
		end

	set_interface (i: PARENT) is
		external
			"IL signature (PARENT): System.Void use Implementation.PARENT_IMP"
		alias
			"set_interface"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.PARENT_IMP"
		alias
			"ToString"
		end

	frozen ec_illegal_36_ec_illegal_36_add_export_clause (current_: PARENT_IMP; a_clause: EXPORT_CLAUSE) is
		external
			"IL static signature (PARENT_IMP, EXPORT_CLAUSE): System.Void use Implementation.PARENT_IMP"
		alias
			"$$add_export_clause"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.PARENT_IMP"
		alias
			"default"
		end

	undefine_clauses: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use Implementation.PARENT_IMP"
		alias
			"undefine_clauses"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.PARENT_IMP"
		alias
			"deep_equal"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.PARENT_IMP"
		alias
			"Equals"
		end

	frozen ec_illegal_36_ec_illegal_36_add_select_clause (current_: PARENT_IMP; a_clause: SELECT_CLAUSE) is
		external
			"IL static signature (PARENT_IMP, SELECT_CLAUSE): System.Void use Implementation.PARENT_IMP"
		alias
			"$$add_select_clause"
		end

	set_rename_clauses (a_list: ARRAY_LIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use Implementation.PARENT_IMP"
		alias
			"set_rename_clauses"
		end

	set_undefine_clauses (a_list: ARRAY_LIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use Implementation.PARENT_IMP"
		alias
			"set_undefine_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_redefine_clauses (current_: PARENT_IMP): ARRAY_LIST is
		external
			"IL static signature (PARENT_IMP): System.Collections.ArrayList use Implementation.PARENT_IMP"
		alias
			"$$redefine_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_rename_clauses (current_: PARENT_IMP): ARRAY_LIST is
		external
			"IL static signature (PARENT_IMP): System.Collections.ArrayList use Implementation.PARENT_IMP"
		alias
			"$$rename_clauses"
		end

	frozen ec_illegal_36_ec_illegal_36_export_clauses (current_: PARENT_IMP): ARRAY_LIST is
		external
			"IL static signature (PARENT_IMP): System.Collections.ArrayList use Implementation.PARENT_IMP"
		alias
			"$$export_clauses"
		end

	redefine_clauses: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use Implementation.PARENT_IMP"
		alias
			"redefine_clauses"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.PARENT_IMP"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: PARENT_IMP; a_name: SYSTEM_STRING) is
		external
			"IL static signature (PARENT_IMP, System.String): System.Void use Implementation.PARENT_IMP"
		alias
			"$$make"
		end

	a_set_converter (converter2: GLOBAL_CONVERSATION_ANY) is
		external
			"IL signature (GLOBAL_CONVERSATION_ANY): System.Void use Implementation.PARENT_IMP"
		alias
			"_set_converter"
		end

	select_clauses: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use Implementation.PARENT_IMP"
		alias
			"select_clauses"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.PARENT_IMP"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.PARENT_IMP"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.PARENT_IMP"
		alias
			"clone"
		end

	frozen ec_illegal_36_ec_illegal_36_select_clauses (current_: PARENT_IMP): ARRAY_LIST is
		external
			"IL static signature (PARENT_IMP): System.Collections.ArrayList use Implementation.PARENT_IMP"
		alias
			"$$select_clauses"
		end

	add_export_clause (a_clause: EXPORT_CLAUSE) is
		external
			"IL signature (EXPORT_CLAUSE): System.Void use Implementation.PARENT_IMP"
		alias
			"add_export_clause"
		end

	class_interface: PARENT is
		external
			"IL signature (): PARENT use Implementation.PARENT_IMP"
		alias
			"class_interface"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PARENT_IMP"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PARENT_IMP"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.PARENT_IMP"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_undefine_clauses (current_: PARENT_IMP): ARRAY_LIST is
		external
			"IL static signature (PARENT_IMP): System.Collections.ArrayList use Implementation.PARENT_IMP"
		alias
			"$$undefine_clauses"
		end

	set_export_clauses (a_list: ARRAY_LIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use Implementation.PARENT_IMP"
		alias
			"set_export_clauses"
		end

	converter: GLOBAL_CONVERSATION_ANY is
		external
			"IL signature (): GLOBAL_CONVERSATION_ANY use Implementation.PARENT_IMP"
		alias
			"converter"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.PARENT_IMP"
		alias
			"print"
		end

	frozen ec_illegal_36_ec_illegal_36_set_rename_clauses (current_: PARENT_IMP; a_list: ARRAY_LIST) is
		external
			"IL static signature (PARENT_IMP, System.Collections.ArrayList): System.Void use Implementation.PARENT_IMP"
		alias
			"$$set_rename_clauses"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.PARENT_IMP"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_PARENT_IMP

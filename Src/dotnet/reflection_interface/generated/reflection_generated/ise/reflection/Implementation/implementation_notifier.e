indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "Implementation.NOTIFIER"

external class
	IMPLEMENTATION_NOTIFIER

inherit
	NOTIFIER
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
			"IL creator use Implementation.NOTIFIER"
		end

feature -- Access

	frozen ec_illegal_36_ec_illegal_36_add_observers: LINKED_LIST_ANY is
		external
			"IL field signature :LINKED_LIST_ANY use Implementation.NOTIFIER"
		alias
			"$$add_observers"
		end

	frozen ec_illegal_36_ec_illegal_36_remove_observers: LINKED_LIST_ANY is
		external
			"IL field signature :LINKED_LIST_ANY use Implementation.NOTIFIER"
		alias
			"$$remove_observers"
		end

	frozen ec_illegal_36_ec_illegal_36_replace_observers: LINKED_LIST_ANY is
		external
			"IL field signature :LINKED_LIST_ANY use Implementation.NOTIFIER"
		alias
			"$$replace_observers"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use Implementation.NOTIFIER"
		alias
			"GetHashCode"
		end

	deep_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.NOTIFIER"
		alias
			"deep_clone"
		end

	do_nothing is
		external
			"IL signature (): System.Void use Implementation.NOTIFIER"
		alias
			"do_nothing"
		end

	tagged_out: STRING is
		external
			"IL signature (): STRING use Implementation.NOTIFIER"
		alias
			"tagged_out"
		end

	internal_clone: ANY is
		external
			"IL signature (): ANY use Implementation.NOTIFIER"
		alias
			"internal_clone"
		end

	operating_environment: OPERATING_ENVIRONMENT is
		external
			"IL signature (): OPERATING_ENVIRONMENT use Implementation.NOTIFIER"
		alias
			"operating_environment"
		end

	standard_is_equal (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.NOTIFIER"
		alias
			"standard_is_equal"
		end

	is_equal_ (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.NOTIFIER"
		alias
			"is_equal"
		end

	replace_observers: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.NOTIFIER"
		alias
			"replace_observers"
		end

	notify_replace is
		external
			"IL signature (): System.Void use Implementation.NOTIFIER"
		alias
			"notify_replace"
		end

	standard_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.NOTIFIER"
		alias
			"standard_equal"
		end

	same_type (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.NOTIFIER"
		alias
			"same_type"
		end

	add_observers: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.NOTIFIER"
		alias
			"add_observers"
		end

	generator: STRING is
		external
			"IL signature (): STRING use Implementation.NOTIFIER"
		alias
			"generator"
		end

	a_set_remove_observers (remove_observers2: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.NOTIFIER"
		alias
			"_set_remove_observers"
		end

	internal_copy (o: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.NOTIFIER"
		alias
			"internal_copy"
		end

	notify_remove (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): System.Void use Implementation.NOTIFIER"
		alias
			"notify_remove"
		end

	frozen ec_illegal_36_ec_illegal_36_notify_remove (current_: NOTIFIER; an_assembly_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL static signature (NOTIFIER, ASSEMBLY_DESCRIPTOR): System.Void use Implementation.NOTIFIER"
		alias
			"$$notify_remove"
		end

	standard_clone (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.NOTIFIER"
		alias
			"standard_clone"
		end

	equal_ (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.NOTIFIER"
		alias
			"equal"
		end

	notify_add (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL signature (ASSEMBLY_DESCRIPTOR): System.Void use Implementation.NOTIFIER"
		alias
			"notify_add"
		end

	frozen ec_illegal_36_ec_illegal_36_notify_replace (current_: NOTIFIER) is
		external
			"IL static signature (NOTIFIER): System.Void use Implementation.NOTIFIER"
		alias
			"$$notify_replace"
		end

	frozen ec_illegal_36_ec_illegal_36_notify_add (current_: NOTIFIER; an_assembly_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL static signature (NOTIFIER, ASSEMBLY_DESCRIPTOR): System.Void use Implementation.NOTIFIER"
		alias
			"$$notify_add"
		end

	frozen a____class_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.NOTIFIER"
		alias
			"____class_name"
		end

	out_: STRING is
		external
			"IL signature (): STRING use Implementation.NOTIFIER"
		alias
			"out"
		end

	default_rescue is
		external
			"IL signature (): System.Void use Implementation.NOTIFIER"
		alias
			"default_rescue"
		end

	make is
		external
			"IL signature (): System.Void use Implementation.NOTIFIER"
		alias
			"make"
		end

	default_pointer: POINTER is
		external
			"IL signature (): System.IntPtr use Implementation.NOTIFIER"
		alias
			"default_pointer"
		end

	add_addition_observer (an_observer: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.NOTIFIER"
		alias
			"add_addition_observer"
		end

	standard_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.NOTIFIER"
		alias
			"standard_copy"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use Implementation.NOTIFIER"
		alias
			"ToString"
		end

	default_: ANY is
		external
			"IL signature (): ANY use Implementation.NOTIFIER"
		alias
			"default"
		end

	deep_equal (some: ANY; other: ANY): BOOLEAN is
		external
			"IL signature (ANY, ANY): System.Boolean use Implementation.NOTIFIER"
		alias
			"deep_equal"
		end

	a_set_add_observers (add_observers2: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.NOTIFIER"
		alias
			"_set_add_observers"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use Implementation.NOTIFIER"
		alias
			"Equals"
		end

	a_set_replace_observers (replace_observers2: LINKED_LIST_ANY) is
		external
			"IL signature (LINKED_LIST_ANY): System.Void use Implementation.NOTIFIER"
		alias
			"_set_replace_observers"
		end

	frozen ec_illegal_36_ec_illegal_36_add_addition_observer (current_: NOTIFIER; an_observer: PROCEDURE_ANY_ANY) is
		external
			"IL static signature (NOTIFIER, PROCEDURE_ANY_ANY): System.Void use Implementation.NOTIFIER"
		alias
			"$$add_addition_observer"
		end

	frozen ec_illegal_36_ec_illegal_36_add_remove_observer (current_: NOTIFIER; an_observer: PROCEDURE_ANY_ANY) is
		external
			"IL static signature (NOTIFIER, PROCEDURE_ANY_ANY): System.Void use Implementation.NOTIFIER"
		alias
			"$$add_remove_observer"
		end

	generating_type: STRING is
		external
			"IL signature (): STRING use Implementation.NOTIFIER"
		alias
			"generating_type"
		end

	frozen ec_illegal_36_ec_illegal_36_add_replace_observer (current_: NOTIFIER; an_observer: PROCEDURE_ANY_ANY) is
		external
			"IL static signature (NOTIFIER, PROCEDURE_ANY_ANY): System.Void use Implementation.NOTIFIER"
		alias
			"$$add_replace_observer"
		end

	default_create_ is
		external
			"IL signature (): System.Void use Implementation.NOTIFIER"
		alias
			"default_create"
		end

	io: STD_FILES is
		external
			"IL signature (): STD_FILES use Implementation.NOTIFIER"
		alias
			"io"
		end

	clone_ (other: ANY): ANY is
		external
			"IL signature (ANY): ANY use Implementation.NOTIFIER"
		alias
			"clone"
		end

	add_remove_observer (an_observer: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.NOTIFIER"
		alias
			"add_remove_observer"
		end

	remove_observers: LINKED_LIST_ANY is
		external
			"IL signature (): LINKED_LIST_ANY use Implementation.NOTIFIER"
		alias
			"remove_observers"
		end

	deep_copy (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.NOTIFIER"
		alias
			"deep_copy"
		end

	copy_ (other: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.NOTIFIER"
		alias
			"copy"
		end

	conforms_to (other: ANY): BOOLEAN is
		external
			"IL signature (ANY): System.Boolean use Implementation.NOTIFIER"
		alias
			"conforms_to"
		end

	frozen ec_illegal_36_ec_illegal_36_make (current_: NOTIFIER) is
		external
			"IL static signature (NOTIFIER): System.Void use Implementation.NOTIFIER"
		alias
			"$$make"
		end

	add_replace_observer (an_observer: PROCEDURE_ANY_ANY) is
		external
			"IL signature (PROCEDURE_ANY_ANY): System.Void use Implementation.NOTIFIER"
		alias
			"add_replace_observer"
		end

	print (some: ANY) is
		external
			"IL signature (ANY): System.Void use Implementation.NOTIFIER"
		alias
			"print"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use Implementation.NOTIFIER"
		alias
			"Finalize"
		end

end -- class IMPLEMENTATION_NOTIFIER

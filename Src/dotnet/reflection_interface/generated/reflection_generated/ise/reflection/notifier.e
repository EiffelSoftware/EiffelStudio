indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "NOTIFIER"

deferred external class
	NOTIFIER

feature -- Basic Operations

	add_replace_observer (an_observer: PROCEDURE_ANY_ANY) is
		external
			"IL deferred signature (PROCEDURE_ANY_ANY): System.Void use NOTIFIER"
		alias
			"add_replace_observer"
		end

	a_set_remove_observers (remove_observers2: LINKED_LIST_ANY) is
		external
			"IL deferred signature (LINKED_LIST_ANY): System.Void use NOTIFIER"
		alias
			"_set_remove_observers"
		end

	add_remove_observer (an_observer: PROCEDURE_ANY_ANY) is
		external
			"IL deferred signature (PROCEDURE_ANY_ANY): System.Void use NOTIFIER"
		alias
			"add_remove_observer"
		end

	remove_observers: LINKED_LIST_ANY is
		external
			"IL deferred signature (): LINKED_LIST_ANY use NOTIFIER"
		alias
			"remove_observers"
		end

	add_addition_observer (an_observer: PROCEDURE_ANY_ANY) is
		external
			"IL deferred signature (PROCEDURE_ANY_ANY): System.Void use NOTIFIER"
		alias
			"add_addition_observer"
		end

	notify_remove (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): System.Void use NOTIFIER"
		alias
			"notify_remove"
		end

	replace_observers: LINKED_LIST_ANY is
		external
			"IL deferred signature (): LINKED_LIST_ANY use NOTIFIER"
		alias
			"replace_observers"
		end

	a_set_replace_observers (replace_observers2: LINKED_LIST_ANY) is
		external
			"IL deferred signature (LINKED_LIST_ANY): System.Void use NOTIFIER"
		alias
			"_set_replace_observers"
		end

	make is
		external
			"IL deferred signature (): System.Void use NOTIFIER"
		alias
			"make"
		end

	notify_add (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): System.Void use NOTIFIER"
		alias
			"notify_add"
		end

	add_observers: LINKED_LIST_ANY is
		external
			"IL deferred signature (): LINKED_LIST_ANY use NOTIFIER"
		alias
			"add_observers"
		end

	a_set_add_observers (add_observers2: LINKED_LIST_ANY) is
		external
			"IL deferred signature (LINKED_LIST_ANY): System.Void use NOTIFIER"
		alias
			"_set_add_observers"
		end

	notify_replace is
		external
			"IL deferred signature (): System.Void use NOTIFIER"
		alias
			"notify_replace"
		end

end -- class NOTIFIER

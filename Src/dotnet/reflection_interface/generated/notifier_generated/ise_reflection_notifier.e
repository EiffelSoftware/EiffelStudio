indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.Notifier"
	assembly: "ISE.Reflection.EiffelAssemblyCacheNotifier", "0.0.0.0", "neutral", "3a8ce9be7fa5624b"

external class
	ISE_REFLECTION_NOTIFIER

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.Notifier"
		end

feature -- Access

	get_add_observers: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.Notifier"
		alias
			"get_AddObservers"
		end

	get_remove_observers: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.Notifier"
		alias
			"get_RemoveObservers"
		end

	get_replace_observers: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use ISE.Reflection.Notifier"
		alias
			"get_ReplaceObservers"
		end

	frozen a_internal_add_observers: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.Notifier"
		alias
			"_internal_AddObservers"
		end

	frozen a_internal_remove_observers: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.Notifier"
		alias
			"_internal_RemoveObservers"
		end

	frozen a_internal_replace_observers: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.Notifier"
		alias
			"_internal_ReplaceObservers"
		end

feature -- Basic Operations

	add_replace_observer (an_observer: SYSTEM_DELEGATE) is
		external
			"IL signature (System.Delegate): System.Void use ISE.Reflection.Notifier"
		alias
			"AddReplaceObserver"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.Notifier"
		alias
			"Make"
		end

	add_addition_observer (an_observer: SYSTEM_DELEGATE) is
		external
			"IL signature (System.Delegate): System.Void use ISE.Reflection.Notifier"
		alias
			"AddAdditionObserver"
		end

	notify_remove (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.Notifier"
		alias
			"NotifyRemove"
		end

	notify_add (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.Notifier"
		alias
			"NotifyAdd"
		end

	frozen a_invariant (current_object: ISE_REFLECTION_NOTIFIER) is
		external
			"IL static signature (ISE.Reflection.Notifier): System.Void use ISE.Reflection.Notifier"
		alias
			"_invariant"
		end

	add_remove_observer (an_observer: SYSTEM_DELEGATE) is
		external
			"IL signature (System.Delegate): System.Void use ISE.Reflection.Notifier"
		alias
			"AddRemoveObserver"
		end

	notify_replace is
		external
			"IL signature (): System.Void use ISE.Reflection.Notifier"
		alias
			"NotifyReplace"
		end

end -- class ISE_REFLECTION_NOTIFIER

indexing
	Generator: "Eiffel Emitter 2.4b2"
	external_name: "ISE.Reflection.Notifier"

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

	frozen RemoveObservers: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.Notifier"
		alias
			"RemoveObservers"
		end

	frozen AddObservers: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.Notifier"
		alias
			"AddObservers"
		end

	frozen ReplaceObservers: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.Notifier"
		alias
			"ReplaceObservers"
		end

feature -- Basic Operations

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.Notifier"
		alias
			"Make"
		end

	AddReplaceObserver (an_observer: SYSTEM_DELEGATE) is
		external
			"IL signature (System.Delegate): System.Void use ISE.Reflection.Notifier"
		alias
			"AddReplaceObserver"
		end

	NotifyAdd (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.Notifier"
		alias
			"NotifyAdd"
		end

	AddRemoveObserver (an_observer: SYSTEM_DELEGATE) is
		external
			"IL signature (System.Delegate): System.Void use ISE.Reflection.Notifier"
		alias
			"AddRemoveObserver"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.Notifier"
		alias
			"_invariant"
		end

	NotifyReplace is
		external
			"IL signature (): System.Void use ISE.Reflection.Notifier"
		alias
			"NotifyReplace"
		end

	NotifyRemove (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.Notifier"
		alias
			"NotifyRemove"
		end

	AddAdditionObserver (an_observer: SYSTEM_DELEGATE) is
		external
			"IL signature (System.Delegate): System.Void use ISE.Reflection.Notifier"
		alias
			"AddAdditionObserver"
		end

end -- class ISE_REFLECTION_NOTIFIER

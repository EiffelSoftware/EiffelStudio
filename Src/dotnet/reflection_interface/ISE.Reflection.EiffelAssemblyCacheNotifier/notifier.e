indexing
	description: "Reflection notifier"
	external_name: "ISE.Reflection.Notifier"

class
	NOTIFIER

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize `add_observers' and `remove_observers'."
			external_name: "Make"
		do
			create add_observers.make
			create remove_observers.make
			create replace_observers.make
		ensure
			non_void_observers: add_observers /= Void
			non_void_observers: remove_observers /= Void
			non_void_replace_observers: replace_observers /= Void
		end

feature -- Access

	add_observers: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [SYSTEM_DELEGATE]
		indexing
			description: "Observers called when an assembly is added to the database"
			external_name: "AddObservers"
		end

	remove_observers: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [SYSTEM_DELEGATE]
		indexing
			description: "Observers called when an assembly is removed from the database"
			external_name: "RemoveObservers"
		end

	replace_observers: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [SYSTEM_DELEGATE]
		indexing
			description: "Observers called when a type is replaced in the database"
			external_name: "ReplaceObservers"
		end
		
feature -- Status Setting

	add_addition_observer (an_observer: SYSTEM_DELEGATE) is
		indexing
			description: "Add `an_observer' to `add_observers'."
			external_name: "AddAdditionObserver"
		require
			non_void_observer: an_observer /= Void
		local
			added: INTEGER
		do
			added := add_observers.Add (an_observer)
		ensure
			observer_added: add_observers.Contains (an_observer)
		end

	add_remove_observer (an_observer: SYSTEM_DELEGATE) is
		indexing
			description: "Add `an_observer' to `remove_observers'."
			external_name: "AddRemoveObserver"
		require
			non_void_observer: an_observer /= Void
		local
			added: INTEGER
		do
			added := remove_observers.Add (an_observer)
		ensure
			observer_added: remove_observers.Contains (an_observer)
		end

	add_replace_observer (an_observer: SYSTEM_DELEGATE) is
		indexing
			description: "Add `an_observer' to `replace_observers'."
			external_name: "AddReplaceObserver"
		require
			non_void_observer: an_observer /= Void
		local
			added: INTEGER
		do
			added := replace_observers.Add (an_observer)
		ensure
			observer_added: replace_observers.Contains (an_observer)
		end
		
feature -- Basic Operations

	notify_add (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		indexing
			description: "Notify that assembly corresponding to `an_assembly_descriptor' has been added to the database."
			external_name: "NotifyAdd"
		require
			non_void_observers: add_observers /= Void
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		local
			i: INTEGER
			an_observer: SYSTEM_EVENTHANDLER
			arguments: SYSTEM_EVENTARGS
		do	
			create arguments.make
			from
			until
				i = add_observers.Count
			loop
				an_observer ?= add_observers.Item (i)
				if an_observer /= Void then
					an_observer.invoke (an_observer, arguments)
				end
				i := i + 1
			end
		end

	notify_remove (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		indexing
			description: "Notify that assembly corresponding to `an_assembly_descriptor' has been removed from the database."
			external_name: "NotifyRemove"
		require
			non_void_observers: remove_observers /= Void
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		local
			i: INTEGER
			an_observer: SYSTEM_EVENTHANDLER
			arguments: SYSTEM_EVENTARGS
		do	
			create arguments.make
			from
			until
				i = remove_observers.Count
			loop
				an_observer ?= remove_observers.Item (i)
				if an_observer /= Void then
					an_observer.invoke (an_observer, arguments)
				end
				i := i + 1
			end
		end

	notify_replace is
		indexing
			description: "Notify that a type has been replaced."
			external_name: "NotifyReplace"
		require
			non_void_observers: replace_observers /= Void
		local
			i: INTEGER
			an_observer: SYSTEM_EVENTHANDLER
			arguments: SYSTEM_EVENTARGS
		do	
			create arguments.make
			from
			until
				i = replace_observers.Count
			loop
				an_observer ?= replace_observers.Item (i)
				if an_observer /= Void then
					an_observer.invoke (an_observer, arguments)
				end
				i := i + 1
			end
		end
		
invariant
	non_void_add_observers: add_observers /= Void
	non_void_remove_observers: remove_observers /= Void
	non_void_replace_observers: replace_observers /= Void
	
end -- class NOTIFIER
indexing
	description: "Reflection notifier"
	external_name: "ISE.Reflection.Notifier"

class
	NOTIFIER

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		indexing
			external_name: "Make"
		do
			create add_observers.make
			create remove_observers.make
		ensure
			non_void_observers: add_observers /= Void
			non_void_observers: remove_observers /= Void
		end

feature -- Access

	add_observers: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Observers called when a type is added to the database or an assembly is removed from the database.
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [SYSTEM_DELEGATE]
		indexing
			external_name: "AddObservers"
		end

	remove_observers: SYSTEM_COLLECTIONS_ARRAYLIST
			-- Observers called when a type is added to the database or an assembly is removed from the database.
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [SYSTEM_DELEGATE]
		indexing
			external_name: "RemoveObservers"
		end
		
feature -- Status Setting

	add_addition_observer (an_observer: SYSTEM_DELEGATE) is
			-- Add `an_observer' to `add_observers'.
		indexing
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
			-- Add `an_observer' to `remove_observers'.
		indexing
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
		
feature -- Basic Operations

	notify_add (an_assembly_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
			-- Notify that assembly corresponding to `an_assembly_descriptor' has been added to the database.
		indexing
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
			-- Notify that assembly corresponding to `an_assembly_descriptor' has been removed from the database.
		indexing
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

invariant
	non_void_add_observers: add_observers /= Void
	non_void_remove_observers: remove_observers /= Void
	
end -- class NOTIFIER
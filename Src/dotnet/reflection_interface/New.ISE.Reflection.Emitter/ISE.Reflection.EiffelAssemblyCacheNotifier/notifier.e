indexing
	description: "Reflection notifier"

class
	NOTIFIER

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize `add_observers' and `remove_observers'."
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

	add_observers: LINKED_LIST [PROCEDURE[ANY, TUPLE]]
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [SYSTEM_DELEGATE]
		indexing
			description: "Observers called when an assembly is added to the database"
		end

	remove_observers:  LINKED_LIST [PROCEDURE[ANY, TUPLE]] 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [SYSTEM_DELEGATE]
		indexing
			description: "Observers called when an assembly is removed from the database"
		end

	replace_observers: LINKED_LIST [PROCEDURE[ANY, TUPLE]] 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [SYSTEM_DELEGATE]
		indexing
			description: "Observers called when a type is replaced in the database"
		end
		
feature -- Status Setting

	add_addition_observer (an_observer: PROCEDURE[ANY, TUPLE]) is
		indexing
			description: "Add `an_observer' to `add_observers'."
		require
			non_void_observer: an_observer /= Void
		do
			add_observers.extend (an_observer)
		ensure
			observer_added: add_observers.has (an_observer)
		end

	add_remove_observer (an_observer: PROCEDURE[ANY, TUPLE]) is
		indexing
			description: "Add `an_observer' to `remove_observers'."
		require
			non_void_observer: an_observer /= Void
		do
			remove_observers.extend (an_observer)
		ensure
			observer_added: remove_observers.has (an_observer)
		end

	add_replace_observer (an_observer: PROCEDURE[ANY, TUPLE]) is
		indexing
			description: "Add `an_observer' to `replace_observers'."
		require
			non_void_observer: an_observer /= Void
		do
			replace_observers.extend (an_observer)
		ensure
			observer_added: replace_observers.has (an_observer)
		end
		
feature -- Basic Operations

	notify_add (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR) is
		indexing
			description: "Notify that assembly corresponding to `an_assembly_descriptor' has been added to the database."
		require
			non_void_observers: add_observers /= Void
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		local
			i: INTEGER
			an_observer: PROCEDURE[ANY, TUPLE]
			arguments: EVENT_ARGS
		do	
			create arguments.make
			from
			until
				i = add_observers.count
			loop
				an_observer ?= add_observers.i_th (i)
				if an_observer /= Void then
					an_observer.apply
				end
				i := i + 1
			end
		end

	notify_remove (an_assembly_descriptor: ASSEMBLY_DESCRIPTOR) is
		indexing
			description: "Notify that assembly corresponding to `an_assembly_descriptor' has been removed from the database."
		require
			non_void_observers: remove_observers /= Void
			non_void_assembly_descriptor: an_assembly_descriptor /= Void
		local
			i: INTEGER
			an_observer: PROCEDURE[ANY, TUPLE]
			arguments: EVENT_ARGS
		do	
			create arguments.make
			from
			until
				i = remove_observers.count
			loop
				an_observer ?= remove_observers.i_th (i)
				if an_observer /= Void then
					an_observer.apply
				end
				i := i + 1
			end
		end

	notify_replace is
		indexing
			description: "Notify that a type has been replaced."
		require
			non_void_observers: replace_observers /= Void
		local
			i: INTEGER
			an_observer: PROCEDURE[ANY, TUPLE]
			arguments: EVENT_ARGS
		do	
			create arguments.make
			from
			until
				i = replace_observers.count
			loop
				an_observer ?= replace_observers.i_th (i)
				if an_observer /= Void then
					an_observer.apply
				end
				i := i + 1
			end
		end
		
invariant
	non_void_add_observers: add_observers /= Void
	non_void_remove_observers: remove_observers /= Void
	non_void_replace_observers: replace_observers /= Void
	
end -- class NOTIFIER
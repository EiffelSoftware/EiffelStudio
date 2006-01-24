indexing
	description: "Objects that build the list of local variables and arguments"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_LOCAL_ENTITIES_FINDER

feature -- Access

	found_names: LINKED_LIST [STRING] is
			-- List of found entity names.
		deferred
		ensure
			found_names_not_void: Result /= Void
		end

	found_locals_list: EIFFEL_LIST [TYPE_DEC_AS] is
			-- List of found locals for current routine
		deferred
		end

	has_return_type: BOOLEAN is
			-- Does feature have a return type?
		deferred
		end

feature -- Reset

	reset is
			-- Reset.
		deferred
		end

end -- class EB_LOCAL_ENTITIES_FINDER

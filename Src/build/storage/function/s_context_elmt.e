indexing
	description: "Class used to store context element."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class S_CONTEXT_ELMT

inherit
	SHARED_STORAGE_INFO

creation
	make

feature 
	make (other: CONTEXT) is
		do
			identifier := other.identifier
			--full_name := clone (other.full_name)
		end

feature {NONE} -- Attributes

	identifier: INTEGER

feature -- Access

	full_name: STRING

	context: CONTEXT is
		do
			Result := context_table.item (identifier)
			debug ("STORER_CHECK")
				if Result = Void then
					io.error.putstring ("Could not retrieve context id: ")
					io.error.putint (identifier)
					io.error.new_line
				end
			end
		end

	find_context: CONTEXT is
		local
			found: BOOLEAN
		do
			from
				context_table.start
			until
				context_table.off or found
			loop
				Result := context_table.item_for_iteration
				if full_name.is_equal (Result.full_name) then
					found := True
				else
					Result := Void
				end
				context_table.forth
			end
		end

end -- class S_CONTEXT_ELMT


note
	date: "$Date$"
	revision: "$Revision$"

class
	IV_HAVOC

inherit

	IV_STATEMENT

inherit {NONE}

	IV_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8)
			-- Initialize havoc with `a_name'.
		require
			a_name_valid: is_valid_name (a_name)
		do
			create names.make
			names.extend (a_name.twin)
		ensure
			a_name_added: names.first ~ a_name
		end

feature -- Access

	names: LINKED_LIST [READABLE_STRING_8]
			-- Names of entities.

feature -- Element changed

	add_name (a_name: READABLE_STRING_8)
			-- Add `a_name' to `names'.
		require
			a_name_valid: is_valid_name (a_name)
		do
			names.extend (a_name)
		ensure
			a_name_added: names.last ~ a_name
		end

feature -- Visitor

	process (a_visitor: IV_STATEMENT_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_havoc (Current)
		end

invariant
	names_attached: attached names
	names_valid: across names as i all is_valid_name (i.item) end

end

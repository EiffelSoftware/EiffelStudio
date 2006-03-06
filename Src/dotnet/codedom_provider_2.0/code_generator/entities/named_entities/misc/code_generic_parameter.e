indexing
	description: "Generic paramter"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_GENERIC_PARAMETER
	
inherit
	CODE_NAMED_ENTITY

create
	make

feature {NONE} -- Initialization

	make (a_name: like name) is
			-- Set `name' with `a_name', initialize instance.
		require
			attached_name: a_name /= Void
		do
			name := a_name
			create {ARRAYED_LIST [CODE_TYPE_REFERENCE]} constraints.make (4)
		end
	
feature -- Access

	has_creation_constraint: BOOLEAN
			-- Does type include creation constraint

	constraints: LIST [CODE_TYPE_REFERENCE]
			-- Constraints

feature -- Element Settings

	set_creation_constraint (a_bool: BOOLEAN) is
			-- Set `has_creation_constraint' with `a_bool'.
		do
			has_creation_constraint := a_bool
		ensure
			has_creation_constraint = a_bool
		end

	add_constraint (a_constraint: CODE_TYPE_REFERENCE) is
			-- Add `a_constraint' to `constraints'.
		require
			attached_contraint: a_constraint /= Void
		do
			constraints.extend (a_constraint)
		ensure
			added: constraints.count = old constraints.count and constraints.i_th (constraints.count) = a_constraint
		end

feature -- Code generation

	code: STRING is
			-- Eiffel code of the entity
		do
			create Result.make (128)
			Result.append (name)
			if not constraints.is_empty then
				Result.append (" -> ")
				constraints.start
				if constraints.count = 1 then
					Result.append (constraints.item.eiffel_name)
				else
					from
						Result.append ("{")
						Result.append (constraints.item.eiffel_name)
						constraints.forth
					until
						constraints.after
					loop
						Result.append (", ")
						Result.append (constraints.item.eiffel_name)
						constraints.forth
					end
					Result.append ("}")
				end
				if has_creation_constraint then
					Result.append (" create make end")
				end
			end
		end

end -- class CODE_GENERIC_PARAMETER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
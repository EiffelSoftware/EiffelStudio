indexing
	description: "Allows creating identifiers from given base that are unique in given set"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_UNIQUE_IDENTIFIER_FACTORY

feature -- Access

	unique_identifier (a_base: STRING; a_comparer: FUNCTION [ANY, TUPLE [STRING], BOOLEAN]): STRING is
			-- Unique identifier in `a_list' from `a_base'
			--| An identifier is considered unique if applying `a_comparer' to it returns `False'
		require
			non_void_base: a_base /= Void
			non_void_comparer: a_comparer /= Void
			valid_comparer: a_comparer.valid_operands ([a_base]) and a_comparer.callable
		local
			i: INTEGER
		do
			if a_comparer.item ([a_base]) then
				create Result.make (a_base.count + 2)
				Result.append (a_base)
				Result.append ("_2")
				from
					i := 3
				until
					not a_comparer.item ([Result])
				loop
					Result.keep_head (Result.last_index_of ('_', Result.count))
					Result.append_integer (i)
					i := i + 1
				end
			else
				Result := a_base.twin
			end
		ensure
			is_unique: not a_comparer.item ([Result])
		end
		
end -- class WIZARD_UNIQUE_IDENTIFIER_FACTORY

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

indexing
	description: "Eiffel rename inheritance clause"
	date: "$$"
	revision: "$$"	

class
	ECD_RENAME_CLAUSE

inherit
	ECD_INHERITANCE_CLAUSE
		redefine
			ready
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- | Call `Precursor {ECD_INHERITANCE_CLAUSE}'.

			-- Initialize `new_name'.
		do
			default_create
			create new_name.make_empty
		ensure then
			non_void_new_name: new_name /= Void
		end
		
feature -- Access

	new_name: STRING
			-- New feature name
			
	code: STRING is
			-- Result := "`old_name' as `new_name'".
			-- Eiffel code of rename clause
		do
			create Result.make (120)
			Result.append (name)
			Result.append (dictionary.Space)
			Result.append (dictionary.As_keyword)
			Result.append (dictionary.Space)
			Result.append (new_name)
		end

feature -- Status Report

	ready: BOOLEAN is
			-- Is rename clause ready to be generated?
		do
			Result := Precursor {ECD_INHERITANCE_CLAUSE} and new_name /= Void and not new_name.is_empty
		end

feature -- Status Setting

	set_new_name (a_name: like new_name) is
			-- Set `new_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			new_name := a_name
		ensure
			new_name_set: new_name = a_name
		end
		
invariant
	non_void_new_name: new_name /= Void
	
end -- class ECD_RENAME_CLAUSE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------	
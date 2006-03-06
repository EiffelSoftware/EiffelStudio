indexing
	description: "Line pragma"

class
	CODE_LINE_PRAGMA

inherit
	CODE_ENTITY

create
	make

feature {NONE} -- Initialization

	make (a_pragma: SYSTEM_DLL_CODE_LINE_PRAGMA) is
			-- Initialize with `a_pragma'.
		require
			attached_pragma: a_pragma /= Void
		do
			pragma := a_pragma
		ensure
			set: pragma = a_pragma
		end

feature -- Access

	code: STRING is
			-- Eiffel code of the entity
		do
			if (pragma.file_name = Void) or else (pragma.file_name.length = 0) then
				Result := "--#line default"
			else
				create Result.make (260)
				Result.append ("--#line ")
				Result.append (pragma.line_number.out)
				Result.append (" %"")
				Result.append (pragma.file_name)
				Result.append ("%"")
				Result.append (Line_return)
			end
		end

feature {NONE} -- Implementation

	pragma: SYSTEM_DLL_CODE_LINE_PRAGMA
			-- Pragam

end -- class CODE_LINE_PRAGMA

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
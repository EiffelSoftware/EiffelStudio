indexing
	description:	"Codedom referenced assemblies."
	date:			"$Date$"
	revision:		"$Revision$"

class
	CODE_SHARED_REFERENCED_ASSEMBLIES

inherit
	CODE_CONFIGURATION
		export
			{NONE} all
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

feature -- Access

	Referenced_assemblies: CODE_REFERENCES_LIST is
			-- List of assemblies used by codeDOM
		once
			create Result.make (16)
		ensure
			non_void_result: Result /= Void
		end		

	Default_assemblies: ARRAY [STRING] is
			-- Default assemblies added with `add_default_assemblies'
		once
			Result := <<"mscorlib.dll", "system.dll", "system.xml.dll">>
		end
	
feature -- Status Setting

	add_default_assemblies is
			-- Add mscorlib, system and system.xml if not already in list.
		local
			i, l_count: INTEGER
			l_assembly: STRING
		do
			from
				l_count := Default_assemblies.count
				i := 1
			until
				i > l_count
			loop
				l_assembly := Default_assemblies.item (i)
				if not Referenced_assemblies.has_file (l_assembly) then
					Referenced_assemblies.extend_file (l_assembly)
				end
				i := i + 1
			end
		end
		
	reset is
			-- Reset content of `Referenced_assemblies'.
		do
			Referenced_assemblies.wipe_out
			Referenced_assemblies.extend_file ("mscorlib.dll")
		end

invariant
	non_void_default_assemblies: Default_assemblies /= Void
	non_void_referenced_assemblies: Referenced_assemblies /= Void

end -- Class CODE_SHARED_REFERENCED_ASSEMBLIES

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
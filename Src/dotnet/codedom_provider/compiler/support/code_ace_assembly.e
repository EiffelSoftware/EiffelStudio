indexing
	description: "ACE assembly declaration"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ACE_ASSEMBLY

inherit
	CODE_NAMED_ENTITY

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_path: like path; a_prefix: like assembly_prefix) is
			-- Initialize instance
		require
			non_void_name: a_name /= Void
			non_void_path: a_path /= Void
		do
			name := a_name
			path := a_path
			assembly_prefix := a_prefix
		ensure
			name_set: name = a_name
			path_set: path = a_path
			prefix_set: assembly_prefix = a_prefix
		end

feature -- Access

	assembly_prefix: STRING
			-- Assembly prefix

	path: STRING
			-- Assembly path

	code: STRING is
			-- LACE code
		do
			create Result.make (256)
			Result.append_character ('"')
			Result.append (name)
			Result.append ("%":%T%"")
			Result.append (path)
			Result.append_character ('"')
			if assembly_prefix /= Void and then not assembly_prefix.is_empty then
				Result.append ("%N%T%Tprefix%N%T%T%T")
				Result.append (assembly_prefix)
				Result.append ("%N%T%Tend")
			end
		end
		
invariant
	non_void_path: path /= Void

end -- class CODE_ACE_ASSEMBLY

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
indexing
	description: "Eiffel external type"
	date: "$$"
	revision: "$$"	

class
	CODE_EXTERNAL_TYPE
	
inherit
	CODE_TYPE
		rename
			make as code_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_type: CODE_TYPE_REFERENCE) is
			-- Initialize instance with arguments.
		require
			non_void_type: a_type /= Void
			valid_type: a_type.dotnet_type /= Void
		do
			code_make (a_type)
			dotnet_type := a_type.dotnet_type
			create assembly.make (dotnet_type.assembly)
		end
		
feature -- Access

	code: STRING is
			-- Type source code
		do
			Result := eiffel_name
		end

	assembly: CODE_REFERENCED_ASSEMBLY
			-- Assembly to which type belongs to

	dotnet_type: TYPE
			-- type associated to `name'

invariant
	non_void_type: dotnet_type /= Void
	non_void_assembly: assembly /= Void

end -- class CODE_EXTERNAL_CLASS

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
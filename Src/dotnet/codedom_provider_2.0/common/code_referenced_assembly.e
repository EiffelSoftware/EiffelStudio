indexing
	description:	"Codedom referenced assembly."
	date:			"$Date$"
	revision:		"$Revision$"

class
	CODE_REFERENCED_ASSEMBLY

inherit
	CODE_CONFIGURATION
		rename
			assembly_prefix as config_assembly_prefix
		export
			{NONE} all
		end
create 
	make,
	make_with_prefix
		
feature {NONE} -- Initialization

	make (an_assembly: ASSEMBLY) is
			-- Initialization.
			-- Set `assembly' with `an_assembly'.
		require
			non_void_an_assembly: an_assembly /= Void
		local
			l_name: STRING
			l_index: INTEGER
		do
			assembly := an_assembly
			l_name := assembly.location
			l_index := l_name.last_index_of ('\', l_name.count)
			if l_index > 0 then
				l_name.keep_tail (l_name.count - l_index)
			end
			assembly_prefix := config_assembly_prefix (l_name)
		ensure
			assembly_prefix_set: assembly_prefix /= Void
			assembly_set: assembly = an_assembly
		end

	make_with_prefix (an_assembly: ASSEMBLY; a_prefix: STRING) is
			-- Initialization.
			-- Set `assembly' with `an_assembly'.
			-- Set `assembly_prefix' with `a_prefix'.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_prefix: a_prefix /= Void
		do
			assembly := an_assembly
			assembly_prefix := a_prefix
		ensure
			assembly_prefix_set: assembly_prefix = a_prefix
			assembly_set: assembly = an_assembly
		end


feature -- Access

	assembly_prefix: STRING
			-- prefix used for assembly.
			
	assembly: ASSEMBLY
			-- actual assembly.

	cluster_name: STRING is
			-- Cluster name for assembly
		do
			Result := assembly.to_string
		ensure
			non_void_cluster_name: Result /= Void
		end

invariant
	non_void_assembly_prefix: assembly_prefix /= Void
	non_void_assembly: assembly /= Void

end -- Class CODE_REFERENCED_ASSEMBLY

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
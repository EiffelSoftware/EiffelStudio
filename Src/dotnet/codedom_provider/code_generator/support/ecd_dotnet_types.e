indexing
	description: ".NET type lookup class. Cache result for better performance."
	date: "$Date$"
	revision: "$Revision$"

class
	ECD_DOTNET_TYPES

inherit
	ECD_SHARED_CODE_GENERATOR_CONTEXT
		export
			{NONE} all
		end

feature -- Access

	dotnet_type (a_dotnet_type_name: STRING): TYPE is
 			-- {TYPE} instance corresponding to `a_dotnet_type_name'.
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
		local
			l_assembly: ASSEMBLY
			l_ref_ass: ECD_REFERENCED_ASSEMBLIES
		do
			if not Resolver.is_generated_type (a_dotnet_type_name) then
				if Known_dotnet_types.contains_key (a_dotnet_type_name) then
					Result ?= Known_dotnet_types.item (a_dotnet_type_name)
				else
					create l_ref_ass
					from
						l_ref_ass.Referenced_assemblies.start
						Result := Void
					until
						l_ref_ass.Referenced_assemblies.after or Result /= Void
					loop
						l_assembly := l_ref_ass.Referenced_assemblies.item.assembly
						if l_assembly /= Void then
							Result := l_assembly.get_type_string (a_dotnet_type_name.to_cil)
						end
						l_ref_ass.Referenced_assemblies.forth
					end

					check
						non_void_result: Result /= Void
					end
					if Result /= Void then
						Known_dotnet_types.set_item (a_dotnet_type_name, Result)
					end
				end
			end
		end

feature {NONE} -- Implementation

	Known_dotnet_types: HASHTABLE is
			-- HASH_TABLE [TYPE, STRING]
			-- Known dotnet types
			-- Cache for `dotnet_type' feature
		once
			create Result.make_from_capacity (150)
		ensure
			non_void_result: Result /= Void
		end

end -- class ECD_DOTNET_TYPES

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
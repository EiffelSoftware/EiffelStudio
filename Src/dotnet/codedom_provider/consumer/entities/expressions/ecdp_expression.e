indexing 
	description: "Common parent to source code generators for expressions"
	date: "$$"
	revision: "$$"

deferred class
	ECDP_EXPRESSION

inherit
	ECDP_ENTITY
	
	ECDP_SHARED_DATA
		export
			{NONE} all
		end
		
feature -- Status Repport

	type: TYPE is
			-- Type of expression
		deferred
		end

feature {NONE} -- Implementation

	known_type (a_type_name: STRING): TYPE is
			-- Known type with name `a_type_name' if any
		require
			non_void_type_name: a_type_name /= Void
			not_empty_type_name: not a_type_name.is_empty
		do
			Result ?= known_types.item (a_type_name)
		end

	add_known_type (a_type: TYPE; a_type_name: STRING) is
			-- Add `a_type' to `known_types'.
		require
			non_void_type: type /= Void
			non_void_type_name: a_type_name /= Void
			not_empty_type_name: not a_type_name.is_empty
		do
			known_types.add (a_type_name, a_type)
		ensure
			a_type_set: known_types.contains_key (a_type_name)
		end	
	
	referenced_type_from_name (a_name: STRING): TYPE is
			-- Lookup type `a_name' in references and cache
			-- Result if any
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			l_assemblies: LINKED_LIST [ECDP_REFERENCED_ASSEMBLY]
		do
			Result := known_type (a_name)
			if Result = Void then
				from
					l_assemblies := Ace_file.Referenced_assemblies
					l_assemblies.start
				until
					l_assemblies.after or Result /= Void
				loop
					Result := l_assemblies.item.assembly.get_type (a_name)
					l_assemblies.forth
				end
				if Result /= Void then
					add_known_type (Result, a_name)
				end
			end
		ensure
			cached_if_found: Result /= Void implies known_types.contains_key (a_name)
		end
		
feature {NONE} -- Implementation

	known_types: HASHTABLE is
			-- HASH_TABLE [TYPE, STRING]
			-- Known dotnet types
		once
			create Result.make_from_capacity (150)
		ensure
			non_void_result: Result /= Void
		end

end -- class ECDP_EXPRESSION

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
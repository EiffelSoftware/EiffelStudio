indexing
	description: "Eiffel representation of CodeDOM compile unit"
	date: "$$"
	revision: "$$"

class
	CODE_COMPILE_UNIT

inherit
	CODE_ENTITY

	CODE_GENERATION_CONTEXT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `namespaces' and `referenced_assemblies'.
		do
			create namespaces.make (8)
		ensure
			ready: ready
		end

feature -- Access

	namespaces: ARRAYED_LIST [CODE_NAMESPACE]
			-- Namespaces in the compile unit

	code: STRING is
			-- | Loop on `namespaces'
			-- | Add/Update all types found in Namespace in `generated_types'
			-- | Call `namespace' on each item.

			-- Eiffel code of compile unit
		local
			l_types: LIST [CODE_GENERATED_TYPE]
		do	
				-- Reset indent.
			indent_string.wipe_out
			from
				namespaces.start
			until
				namespaces.after
			loop
				l_types := namespaces.item.types
				from
					l_types.start
				until
					l_types.after
				loop
					Resolver.update_generated_type (l_types.item)
					l_types.forth
				end

				if Result = Void then
					Result := namespaces.item.code
				else
					Result.append (namespaces.item.code)
				end
				namespaces.forth
			end
		end

feature -- Status Report

	ready: BOOLEAN is 	
			-- Is compile unit ready to be generated?
		do
			Result := namespaces /= Void
		end

feature -- Basic Operations

	add_namespace (a_namespace: CODE_NAMESPACE) is
			-- Add `a_namespace' to `namespaces'.
		require
			non_void_namespace: a_namespace /= Void
		do
			if not namespaces.has (a_namespace) then
				namespaces.extend (a_namespace)
			end
		ensure
			namespace_added: namespaces.has (a_namespace)
		end

invariant
	non_void_namespaces: namespaces /= Void

end -- class CODE_COMPILE_UNIT

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
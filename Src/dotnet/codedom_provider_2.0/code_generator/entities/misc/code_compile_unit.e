indexing
	description: "Eiffel representation of CodeDOM compile unit"
	date: "$$"
	revision: "$$"

class
	CODE_COMPILE_UNIT

inherit
	CODE_ENTITY

create
	make

feature {NONE} -- Initialization

	make (a_namespaces: like namespaces) is
			-- Initialize `namespaces'
		require
			non_void_namespaces: a_namespaces /= Void
		do
			namespaces := a_namespaces
		ensure
			namespaces_set: namespaces = a_namespaces
		end

feature -- Access

	namespaces: LIST [CODE_NAMESPACE]
			-- Namespaces in the compile unit

	code: STRING is
			-- | Loop on `namespaces'
			-- | Call `code' on each item.

			-- Eiffel code of compile unit
		do	
				-- Reset indent.
			indent_string.wipe_out
			from
				namespaces.start
				if not namespaces.after then
					Result := namespaces.item.code
					namespaces.forth
				end
			until
				namespaces.after
			loop
				Result.append (namespaces.item.code)
				namespaces.forth
			end
		end

invariant
	non_void_namespaces: namespaces /= Void

end -- class CODE_COMPILE_UNIT

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
indexing 
	description: "Eiffel representation of a namespace"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_NAMESPACE

inherit
	CODE_NAMED_ENTITY
	
	CODE_SHARED_CLASS_SEPARATOR
		export
			{NONE} all
		end

	CODE_SHARED_IMPORTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: like name) is
			-- | Call Precursor {CODE_NAMED_ENTITY}
			-- | Initialize `imports' and `types'.

			-- Initialize attributes.
		do
			create {ARRAYED_LIST [CODE_GENERATED_TYPE]} types.make (128)
			set_name (a_name)
		ensure
			non_void_imports: imports /= Void
			non_void_types: types /= Void
			name_set: name = a_name
		end

feature -- Access

	types: LIST [CODE_GENERATED_TYPE]
			-- Namespace types

	code: STRING is
			-- | Loop on `types': call `type.code' on each item.
			-- Eiffel code for a namespace
		local
			l_type: CODE_GENERATED_TYPE
		do
			from
				types.start
				create Result.make (8192)
			until
				types.after
			loop
				l_type := types.item
				if l_type /= Void then
					Result.append (l_type.code)
					Result.append (Class_separator)
				end
				types.forth
			end
		end

feature {CODE_EIFFEL_FACTORY} -- Basic Operations

	add_import (an_import: STRING) is
			-- Add `an_import' to `imports'.
		require
			non_void_import: an_import /= Void
			in_code_analysis: current_state = Code_analysis
		do
			if not imports.has (an_import) then
				imports.extend (an_import)
			end
		ensure
			an_import_added: imports.has (an_import)
		end

	add_type (a_type: CODE_GENERATED_TYPE) is
			-- Add `a_type' to `types'.
		require
			non_void_type: a_type /= Void
			in_code_analysis: current_state = Code_analysis
		do
			if not types.has (a_type) then
				types.extend (a_type)
			end
		ensure
			a_type_added: types.has (a_type)
		end

invariant 
	non_void_imports: imports /= Void
	non_void_types: types /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class CODE_NAMESPACE

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

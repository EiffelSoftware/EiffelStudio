indexing 
	description: "Source code generator for array indexer expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"

class
	CODE_ARRAY_INDEXER_EXPRESSION

inherit
	CODE_EXPRESSION

	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: CODE_EXPRESSION; a_indices: LIST [CODE_EXPRESSION]) is
			-- Initialize `target_object' and `indices'.
		require
			non_void_target: a_target /= Void
			non_void_indices: a_indices /= Void
		do
			target := a_target
			indices := a_indices
		ensure
			target_set: target = a_target
			indices_set: indices = a_indices
		end
		
feature -- Access

	target: CODE_EXPRESSION
			-- Array indexer target object
	
	indices: LIST [CODE_EXPRESSION]
			-- Array indexer indices

	code: STRING is
			-- | Result := "`target_object'.item (`indices')"
			-- Eiffel code of array indexer expression
		do
			create Result.make (120)
			Result.append (target.code)
			Result.append (".item (")
			from
				indices.start
				if not indices.after then
					Result.append (indices.item.code)
					indices.forth
				end
			until
				indices.after
			loop
				Result.append (", ")
				Result.append (indices.item.code)
				indices.forth
			end
			Result.append_character (')')
		end
		
feature -- Status Report
		
	type: CODE_TYPE_REFERENCE is
			-- Type
		local
			l_type: SYSTEM_TYPE
		do
			l_type := target.type.dotnet_type
			if l_type /= Void then
				Result := Type_reference_factory.type_reference_from_type (l_type.get_element_type)
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_type, [target.type.name])
			end
		end

invariant
	non_void_indices: indices /= Void
	non_void_target: target /= Void
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class CODE_ARRAY_INDEXER_EXPRESSION

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
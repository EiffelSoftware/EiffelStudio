indexing
	description: "Type with its renaming in a constraint list of a formal generic parameter declaration."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTRAINING_TYPE_AS

inherit
	AST_EIFFEL

create {AST_FACTORY}
	make

feature{NONE} -- Initialization

	make (a_type: like type; a_renaming: like renaming; a_end_of_renaming: like end_of_renaming) is
			-- Initialize instance.
		require
			a_type_not_void: a_type /= Void
		do
			type := a_type
			renaming := a_renaming
			end_of_renaming := a_end_of_renaming
		ensure
			type_set: type = a_type
			renaming_set: renaming = a_renaming
			end_of_renaming_set: end_of_renaming = a_end_of_renaming
		end

feature -- Setters

	set_type (a_type: like type)
			-- Set `type' to `a_type'.
		require
			a_type_not_void: a_type /= Void
		do
			type := a_type
		ensure
			type_set: type = a_type
		end

feature -- Access

	type: TYPE_AS
			-- Constraining type

	renaming: RENAME_CLAUSE_AS
			-- Renaming applied to feature of type `type'

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_constraining_type_as (Current)
		end

feature -- Roundtrip

	end_of_renaming: KEYWORD_AS
			-- Keyword for end of rename list

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := type.first_token (a_list)
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if end_of_renaming /= Void then
				Result := end_of_renaming.last_token (a_list)
			elseif renaming /= Void then
				Result := renaming.last_token (a_list)
			else
				Result := type.last_token (a_list)
			end
		end

feature --Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object?
		do
			Result := equivalent (type, other.type) and equivalent (renaming, other.renaming)
		end

invariant
	type_not_void: type /= Void

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

end

indexing
	description: "AST representation of a once routines."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ONCE_AS

inherit
	INTERNAL_AS
		redefine
			process, is_once
		end

create
	make

feature{NONE} -- Initialization

	make (c: like compound; l_as: KEYWORD_AS) is
			-- Create new DO AST node.
		do
			initialize (c)
			once_keyword := l_as
		ensure
			once_keyword_set: once_keyword = l_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_once_as (Current)
		end

feature -- Roundtrip

	once_keyword: KEYWORD_AS
			-- Keyword "once" associated with this structure

feature -- Properties

	is_once: BOOLEAN is True
			-- Is the current routine body a once one ?

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				if compound /= Void then
					Result := compound.first_token (a_list)
				else
					Result := Void
				end
			else
				Result := once_keyword.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if compound /= Void then
				Result := compound.last_token (a_list)
			elseif a_list = Void then
					-- Non-roundtrip mode
				Result := Void
			else
				Result := once_keyword.last_token (a_list)
			end
		end

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

end -- class ONCE_AS

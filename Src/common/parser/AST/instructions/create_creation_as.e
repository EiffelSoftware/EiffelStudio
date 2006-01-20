indexing
	description: "Object that represents a creation structure (using keyword create)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_CREATION_AS

inherit
	CREATION_AS
		redefine
			process
		end

create
	make

feature{NONE} -- Initialization

	make (tp: like type; tg: like target; c: like call; k_as: like create_keyword) is
			-- Create new CREATE_CREATION AST node.
		do
			initialize (tp, tg, c)
			create_keyword := k_as
		ensure
			create_keyword_set: create_keyword = k_as
		end

feature -- Roundtrip

	create_keyword: KEYWORD_AS
			-- Keyword "create" associated with this structure

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_create_creation_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				if type /= Void then
					Result := type.first_token (a_list)
				else
					Result := target.first_token (a_list)
				end
			else
				Result := create_keyword.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if call /= Void then
				Result := call.last_token (a_list)
			else
				Result := target.last_token (a_list)
			end
		end

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

end

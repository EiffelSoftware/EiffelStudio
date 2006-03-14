indexing
	description: "Object that stores 3 AST nodes for alias"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALIAS_TRIPLE

create
	make

feature{NONE} -- Initialization

	make (k_as: like alias_keyword; n_as: like alias_name; c_as: like convert_keyword) is
			-- Create new ALIAS_TRIPLE sturcture.
		do
			alias_keyword := k_as
			alias_name := n_as
			convert_keyword := c_as
		ensure
			alias_keyword_set: alias_keyword = k_as
			alias_name_set: alias_name = n_as
			convert_keyword_set: convert_keyword = c_as
		end

feature -- Access

	alias_keyword: KEYWORD_AS
			-- Keyword "alias"

	convert_keyword: KEYWORD_AS
			-- Keyword "convert"

	alias_name: STRING_AS;

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

indexing
	description: "Class which encapsulates primary key information for a table recieved from ODBS SqlPrimaryKeys() function."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ODBC_FOREIGN_KEY_RESULT

create
	make

feature -- Initialization

	make is
			-- Initialize.
		do
			create pktable_cat.make (10)
			create pktable_schem.make (10)
			create pktable_name.make (10)
			create pkcolumn_name.make (10)
			create fktable_cat.make (10)
			create fktable_schem.make (10)
			create fktable_name.make (10)
			create fkcolumn_name.make (10)
		end

feature -- Implementation

	pktable_cat: STRING

	pktable_schem: STRING

	pktable_name: STRING

	pkcolumn_name: STRING
	
	fktable_cat: STRING

	fktable_schem: STRING

	fktable_name: STRING

	fkcolumn_name: STRING
	
	key_seq: INTEGER
	
	update_rule: INTEGER;
	
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

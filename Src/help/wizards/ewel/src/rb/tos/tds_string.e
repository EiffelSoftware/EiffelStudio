indexing
	description: "String item representation in the tds_stringtable"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_STRING

creation
	make

feature -- Initialization

	make is
		do
			!! text_id
		end

feature	-- Access
	
	text_id: TDS_ID
			-- Id of the stringtable item.

	text: STRING
			-- Text of the stringtable item.


feature -- Element change

	set_id (a_id: STRING) is
			-- Set properly `a_id' to the current object.
		require
			a_id_exists: a_id /= Void and then a_id.count > 0
		do
			if (a_id.is_integer) then
				text_id.set_number_id (a_id.to_integer)
			else
				text_id.set_name_id (a_id)
			end
		end

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		require
			a_text_exists: a_text /= Void and then a_text.count > 0
		do
			text := clone (a_text)
		ensure
			text_set: text.is_equal (a_text)
		end

feature -- Code generation

	display is
		do
			text_id.display
			io.putstring (" : ")
			io.putstring (text)
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
		do
			text_id.generate_resource_file (a_resource_file)
			a_resource_file.putstring (", ")
			a_resource_file.putstring (text)
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
end -- class TDS_STRING


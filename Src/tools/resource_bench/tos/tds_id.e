indexing
	description: "resource ID representation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_ID

inherit
	TDS_DEFINE_TABLE

feature -- Access

	number_id: INTEGER
			-- Number Id of the resource.

	name_id: STRING
			-- Name Id of the resource

	is_number: BOOLEAN
			-- Is the ID a number?

	has_number: BOOLEAN
			-- Does the ID have a number?

	has_name: BOOLEAN
			-- Does the ID have a name?

feature -- Element change

	set_number_id (a_id: INTEGER) is
			-- Set `number_id' to `a_id'.
		do
			number_id := a_id
			is_number := true
			has_number := true
		ensure
			number_id_set: number_id = a_id
			is_number_set: is_number
			has_number_set: has_number
		end

	set_name_id (a_id: STRING) is
			-- Set `name_id' to `a_id'.
		require
			a_id_exists: a_id /= Void and then a_id.count > 0
		do
			name_id := a_id.twin
			is_number := false
			has_name := true
		ensure
			name_id_set: name_id.is_equal (a_id)
			is_number_set: not is_number
		end

	set_id (a_id: STRING) is
			-- Set properly `a_id' to the current object.
		require
			a_id_exists: a_id /= Void and then a_id.count > 0
		do
			if (a_id.is_integer) then
				set_number_id (a_id.to_integer)
			else
				set_name_id (a_id)
			end
		end

feature -- Conversion

	to_constant_style: STRING is
			-- Convert the `name_id' to a eiffel constant format if exists (ie like "Constant")
			-- Otherwise put the `number_id'.
		local
			first_character: STRING
		do
			if (not has_name) then
				Result := number_id.out
			else
				Result := to_variable_style

				first_character := Result.substring (1,1)
				first_character.to_upper

				Result.remove (1)
				Result.prepend_string (first_character)

				if define_table.has (name_id) then
					Result.append ("_constant")
				end
			end
		end

	to_variable_style: STRING is
			-- Convert the `name_id' to a eiffel variable format (ie like "variable").
		require
			name_id_exists: name_id /= Void and then name_id.count > 0
		do
			Result := name_id.as_lower
		end

	to_class_style (a_standard_class_name: STRING): STRING is
			-- Convert the `name_id' or `number_id' to a eiffel class format (ie like "CLASS").
		require
			a_standard_class_name_exists: a_standard_class_name /= Void and then a_standard_class_name.count > 0
		local
			temp: INTEGER
		do
			if has_name then
				Result := name_id.as_upper
			else
				Result := a_standard_class_name.twin
				Result.append ("_")
				if number_id < 0 then
					temp := -number_id
					Result.append ("minus_")
					Result.append (temp.out)
				else
					Result.append (number_id.out)
				end	
			end
		end

feature -- Code generation

	display is
		do
			if (is_number) then
				io.putint (number_id)
			else
				io.putstring (name_id)
			end
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
		do
			if (is_number) then
				a_resource_file.putint (number_id)
			else
				a_resource_file.putstring (name_id)
			end
		end

	generate_tree_view (a_tree_view: WEL_TREE_VIEW; a_parent: POINTER) is
			-- Generate `a_tree_view' control from the tds memory structure.
		require
			a_tree_view_not_void: a_tree_view /= Void
       		local
			tvis: WEL_TREE_VIEW_INSERT_STRUCT
			tv_item: WEL_TREE_VIEW_ITEM
		do
			!! tvis.make
			tvis.set_sort
			tvis.set_parent (a_parent)
			!! tv_item.make

			if (is_number) then
				tv_item.set_text (number_id.out)
			else
				tv_item.set_text (name_id)
			end

			tvis.set_tree_view_item (tv_item)
			a_tree_view.insert_item (tvis)
		end

	generate_wel_code (a_text_file: PLAIN_TEXT_FILE) is
			-- Generate the eiffel code in `a_text_file'
		require
			a_text_file_exists: a_text_file.exists
		do
			if (is_number) then
				a_text_file.putint (number_id)
			else
				a_text_file.putstring (name_id.as_upper)
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
end -- class TDS_ID


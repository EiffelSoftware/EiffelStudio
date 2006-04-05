indexing
	description: "Combobox statement representation in the tds"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_COMBOBOX_STATEMENT

inherit
	TDS_CONTROL_STATEMENT

	TDS_CONTROL_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature -- Initialization

	finish_control_setup is
		local
			cbs_dropdown: TDS_STYLE
			cbs_dropdownlist: TDS_STYLE
		do
			!! cbs_dropdown.make
			cbs_dropdown.set_style ("CBS_DROPDOWN")
			
			!! cbs_dropdownlist.make
			cbs_dropdownlist.set_style ("CBS_DROPDOWNLIST")

			if style.is_almost_present (cbs_dropdownlist) then
				set_wel_class_name ("WEL_DROP_DOWN_LIST_COMBO_BOX")
			elseif style.is_almost_present (cbs_dropdown) then
				set_wel_class_name ("WEL_DROP_DOWN_COMBO_BOX")
			else
				set_wel_class_name ("WEL_SIMPLE_COMBO_BOX")
			end

			set_variable_name ("combobox")
			set_type (C_combobox)
		end

feature -- Code Generation

	display is
		do
			from 
				start
			until
				after

			loop
				io.putstring ("%NCOMBOBOX ")

				io.putstring (" ")
				item.id.display

				io.putstring (" ")
				io.putint (item.x)

				io.putstring (" ")
				io.putint (item.y)

				io.putstring (" ")
				io.putint (item.width)

				io.putstring (" ")
				io.putint (item.height)

				if (item.style /= Void) then
					item.style.display
				end

				if (item.exstyle /= Void) then
					item.exstyle.display
				end

				forth
			end
		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		do
			from 
				start
			until
				after

			loop
				a_resource_file.putstring ("%N%TCOMBOBOX ")

			--	a_resource_file.putstring (item.text)

			--	a_resource_file.putstring (", ")
				item.id.generate_resource_file (a_resource_file)

				a_resource_file.putstring (", ")
				a_resource_file.putint (item.x)

				a_resource_file.putstring (", ")
				a_resource_file.putint (item.y)

				a_resource_file.putstring (", ")
				a_resource_file.putint (item.width)

				a_resource_file.putstring (", ")
				a_resource_file.putint (item.height)

				if (item.style /= Void) then
					a_resource_file.putstring (", ")
					item.style.generate_resource_file (a_resource_file)
				end

				if (item.exstyle /= Void) then
					a_resource_file.putstring (", ")
					item.exstyle.generate_resource_file (a_resource_file)
				end

				forth
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
end -- class TDS_COMBOBOX_STATEMENT


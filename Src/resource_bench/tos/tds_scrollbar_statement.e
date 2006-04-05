indexing
	description: "Scrollbar statement representation in the tds"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_SCROLLBAR_STATEMENT

inherit
	TDS_CONTROL_STATEMENT

	TDS_CONTROL_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, copy
		end

creation
	make

feature	-- Initialization

	finish_control_setup is
		do
			set_variable_name ("scrollbar")
			set_wel_class_name ("WEL_SCROLL_BAR")
			set_type (C_scrollbar)
		end

feature -- Code generation

	display is
		do
			from 
				start
			until
				after

			loop
				io.new_line
				io.putstring ("SCROLLBAR ")

				io.putstring (item.text)

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

	generate_resource_file (resource_file: PLAIN_TEXT_FILE) is
			-- generate the resource script file from the tds memory structure
		do
			from 
				start
			until
				after

			loop
				resource_file.putstring ("%N%TSCROLLBAR ")

				resource_file.putstring (item.text)

				resource_file.putstring (", ")
				item.id.generate_resource_file (resource_file)

				resource_file.putstring (", ")
				resource_file.putint (item.x)

				resource_file.putstring (", ")
				resource_file.putint (item.y)

				resource_file.putstring (", ")
				resource_file.putint (item.width)

				resource_file.putstring (", ")
				resource_file.putint (item.height)

				if (item.style /= Void) then
					resource_file.putstring (", ")
					item.style.generate_resource_file (resource_file)
				end

				if (item.exstyle /= Void) then
					resource_file.putstring (", ")
					item.exstyle.generate_resource_file (resource_file)
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
end -- class TDS_SCROLLBAR_STATEMENT


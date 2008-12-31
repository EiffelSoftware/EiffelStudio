note
	description: "Constants used by the tds"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_CONSTANTS

feature

	Normal: INTEGER = 1

	Dialog_x: INTEGER = 2
	Dialog_y: INTEGER = 3
	Dialog_width: INTEGER = 4
	Dialog_height: INTEGER = 5

	Option_characteristic: INTEGER = 6
	Option_language: INTEGER = 7
	Option_version: INTEGER = 8
	Option_caption: INTEGER = 9
	Option_class: INTEGER = 10
	Option_exstyle: INTEGER = 11
	Option_font_size: INTEGER = 12
	Option_font_type: INTEGER = 13
	Option_font_weight: INTEGER = 14
	Option_font_italic: INTEGER = 15
	Option_menu: INTEGER = 16
	Option_style: INTEGER = 17
	
	Control_type: INTEGER = 18
	Control_text: INTEGER = 19
	Control_id: INTEGER = 20
	Control_x: INTEGER = 21
	Control_y: INTEGER = 22
	Control_width: INTEGER = 23
	Control_height: INTEGER = 24
	Control_style: INTEGER = 25
	Control_exstyle: INTEGER = 26

	Generic_Control_text: INTEGER = 27
	Generic_Control_id: INTEGER = 28
	Generic_Control_class: INTEGER = 29
	Generic_Control_style: INTEGER = 30
	Generic_Control_x: INTEGER = 31
	Generic_Control_y: INTEGER = 32
	Generic_Control_width: INTEGER = 33
	Generic_Control_height: INTEGER = 34
	Generic_Control_exstyle: INTEGER = 35

	Stringtable_id: INTEGER = 36
	Stringtable_text: INTEGER = 37

	Menu_text: INTEGER = 38
	Menu_command: INTEGER = 39
	Menu_flags: INTEGER = 40

	Accelerators_event: INTEGER = 41
	Accelerators_id: INTEGER = 42
	Accelerators_type: INTEGER = 43
	Accelerators_options: INTEGER = 44
	
	Toolbar_width: INTEGER = 45
	Toolbar_height: INTEGER = 46;

note
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
end -- class TDS_CONSTANTS


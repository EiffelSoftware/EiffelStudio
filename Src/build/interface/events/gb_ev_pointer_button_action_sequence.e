note
	description: "Objects that represent EV_POINTER_BUTTON_ACTION_SEQUENCE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_POINTER_BUTTON_ACTION_SEQUENCE
	
inherit
	GB_EV_ACTION_SEQUENCE

feature -- Access

	argument_types: ARRAYED_LIST [STRING]
			-- All argument types of action sequence represented by `Current'.
		once
			create Result.make (0)
			Result.extend ("INTEGER")
			Result.extend ("INTEGER")
			Result.extend ("INTEGER")
			Result.extend ("DOUBLE")
			Result.extend ("DOUBLE")
			Result.extend ("DOUBLE")
			Result.extend ("INTEGER")
			Result.extend ("INTEGER")
		end
	
	argument_names: ARRAYED_LIST [STRING]
			-- All argument names of action sequence represented by `Current'.
		once
			create Result.make (0)
			Result.extend ("a_x")
			Result.extend ("a_y")
			Result.extend ("a_button")
			Result.extend ("a_x_tilt")
			Result.extend ("a_y_tilt")
			Result.extend ("a_pressure")
			Result.extend ("a_screen_x")
			Result.extend ("a_screen_y")
		end
		
	display_agent (name: STRING; string_handler: ORDERED_STRING_HANDLER): PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]
			-- `Result' is agent which will display all arguments passed to an 
			-- action sequence represented by `Current', using name `name' and
			-- outputs to `textable'.
		require
			string_handler_not_void: string_handler /= Void
			name_not_void_or_empty: name /= Void and not name.is_empty
		do
			Result := agent internal_display_agent (?, ?, ?, ?, ?, ?, ?, ?, name, string_handler)
		ensure
			Result_not_void: Result /= Void
		end
		
feature {NONE} -- Implementation

	internal_display_agent (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE width, height: INTEGER; name: STRING; string_handler: ORDERED_STRING_HANDLER)
			-- Display all other arguments of `Current' on `string_handler', prepended
			-- with `name' fired.
		do
			string_handler.record_string (name + " fired.%Nx : " + x.out + " y : " + y.out + " button : " + button.out +
				" x_tilt : " + x_tilt.out + " y_tilt : " + y_tilt.out + " pressure : " + pressure.out + " width : " + width.out + " height : " + height.out)
		end

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


end -- class GB_EV_POINTER_BUTTON_ACTION_SEQUENCE
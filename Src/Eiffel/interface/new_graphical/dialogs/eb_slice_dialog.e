indexing

	description:	
		"Window to enter special object bounds for inspection."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EB_SLICE_DIALOG 

inherit

	EV_COMMAND
		undefine
			default_create
		end
--	ASCII
--		rename
--			star as ascii_star,
--			dot as ascii_dot,
--			plus as ascii_plus
--		end
	EV_DIALOG

--	WINDOW_ATTRIBUTES

	SHARED_PLATFORM_CONSTANTS
		undefine
			default_create
		end

	NEW_EB_CONSTANTS
		undefine
			default_create
		end

create

	make_default
	
feature -- Initialization

	make_default (cmd: EB_SLICE_COMMAND) is
			-- Create a special object slice window.
		local
			bounds_box: EV_HORIZONTAL_BOX
			ok_button, apply_button, cancel_button: EV_BUTTON
			from_label, to_label: EV_LABEL
			sp_capacity: INTEGER
		do
			default_create
			set_title (Interface_names.t_Slice_w)

			create bounds_box
			extend (bounds_box)

			create from_label.make_with_text ("From: ")
			bounds_box.extend (from_label)
			from_label.align_text_right
			create from_field
			bounds_box.extend (bounds_box)
			create to_label.make_with_text ("To: ")
			bounds_box.extend (to_label)
			to_label.align_text_right
			create to_field
			bounds_box.extend (to_field)

			create ok_button.make_with_text (Interface_names.b_Ok)
			extend (ok_button)
			create apply_button.make_with_text (Interface_names.b_Apply)
			extend (apply_button)
			create cancel_button.make_with_text (Interface_names.b_Cancel)
			extend (cancel_button)

			ok_button.select_actions.extend (agent execute (ok_it))
			apply_button.select_actions.extend (agent execute (apply_it))
			cancel_button.select_actions.extend (agent execute (cancel_it))
			associated_command := cmd
--			set_composite_attributes (Current)

				-- Popup the slice window, with the capacity of the last
				-- special object displayed in that window if any.

			last_lower := associated_command.sp_lower
			last_upper := associated_command.sp_upper
			sp_capacity := associated_command.sp_capacity - 1
			if sp_capacity < 0 then
					-- The associated text_window never displayed
					-- a special object.
				from_field.set_text ("")
				to_field.set_text ("")
			else
				from_field.set_text ("0")
				to_field.set_text (sp_capacity.out)
					-- To be changed when the display will start from 1,
					-- like everywhere in Eiffel. 
			end
			show
		end

feature {NONE} -- Properties

	ok_it: ANY is
			-- Argument for the command
		once
			create Result
		end

	apply_it: ANY is
			-- Argument for the command
		once
			create Result
		end

	cancel_it: ANY is
			-- Argument for the command
		once
			create Result
		end

	associated_command: EB_SLICE_COMMAND

	from_field, to_field: EV_TEXT_FIELD

	last_lower, last_upper: INTEGER

feature {NONE} -- Implementation

	execute (argument: ANY) is
		local
			sp_lower, sp_upper: INTEGER
			lower_string, upper_string: STRING
        do
			if argument = cancel_it then
				sp_lower := last_lower
				sp_upper := last_upper
			else
				lower_string := clone (from_field.text)
				lower_string.left_adjust
				lower_string.right_adjust
				if lower_string.is_integer then
					sp_lower := lower_string.to_integer
				else
					sp_lower := -1
				end	
				upper_string := clone (to_field.text)
				upper_string.left_adjust
				upper_string.right_adjust
				if upper_string.is_integer then
					sp_upper := upper_string.to_integer
				else
					sp_upper := -1
				end	
			end
			if 
				sp_lower /= associated_command.sp_lower or
				sp_upper /= associated_command.sp_upper
			then
				associated_command.set_sp_bounds (sp_lower, sp_upper)
				associated_command.execute (associated_command.callback)
			end
			if argument /= apply_it then
				destroy
			end
		end

invariant

--	from_field_exists: from_field /= Void
--	to_field_exists: to_field /= Void

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

end -- class EB_SLICE_DIALOG

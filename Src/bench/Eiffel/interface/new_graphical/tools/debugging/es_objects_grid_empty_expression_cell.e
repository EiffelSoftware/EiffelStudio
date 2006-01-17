indexing
	description : "Objects that represent an expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_OBJECTS_GRID_EMPTY_EXPRESSION_CELL

inherit
	EV_GRID_EDITABLE_ITEM
		redefine
			activate_action, deactivate, make_with_text,
			initialize_actions
		end

create
	make_with_text

feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
		do
			empty_text := a_text
			Precursor (empty_text)
			create apply_actions
		end
		
	empty_text: STRING
		
feature -- Query

	use_text: STRING

	activate_with_string (a_text: STRING) is
		do
			use_text := a_text
			activate
		end

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		do
			if use_text /= Void then
				set_text (use_text)
			else
				remove_text
			end
			Precursor (popup_window)
		end

	deactivate is
		do
			Precursor
			if not user_cancelled_activation and then not text.is_empty then
				apply_actions.call ([text])
			end
			set_text (empty_text)
		end
		
	apply_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Action to perform when applying the changes

	initialize_actions is
		do
			Precursor
			if use_text /= Void then
				text_field.set_caret_position (use_text.count + 1)
			end
			use_text := Void
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

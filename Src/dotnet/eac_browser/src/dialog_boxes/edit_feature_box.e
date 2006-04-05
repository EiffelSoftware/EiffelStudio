indexing
	description: "Dialog box that appire when the user want to edit a feature in the edit_area"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EDIT_FEATURE_BOX

inherit
	EV_WINDOW
		redefine
			initialize, is_in_default_state
		end

create
	default_create

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_WINDOW}
			
				-- Create all widgets.
			create l_feature
			
				-- Build_widget_structure.
			extend (l_feature)

				--Connect events.
			l_feature.key_press_actions.extend (agent on_key_pressed (?))
		end

feature {NONE} -- Basic Operations

	feature_name_changed is
			-- feature name changed and validated.
			-- Call emitter to validate the change.
		local
			new_feature_name: STRING
		do
			new_feature_name := l_feature.text
			destroy
		end

feature -- Status Setting

	set_feature (a_feature_name: STRING) is
			-- Set `l_feature' with `a_feature_name'.
		require
			non_void_a_feature_name: a_feature_name /= Void
			not_empty_a_feature_name: not a_feature_name.is_empty
		do
			l_feature.set_text (a_feature_name)
			l_feature.set_caret_position (1);
			l_feature.select_all;
			show_actions.extend (agent focus)
		ensure
			l_feature_set: l_feature.text.is_equal (a_feature_name)
		end


feature -- Basic Operations

	focus is
			-- Set focus on `l_feature'.
			-- Add agent on `focus_out_actions' to destroy window.
		do
			l_feature.set_focus
			l_feature.focus_out_actions.extend (agent destroy)
		end


feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	l_feature: EV_TEXT_FIELD
	
	on_key_pressed (a_key: EV_KEY) is
			-- prossed a_key.
		require
			non_void_a_key: a_key /= Void
		local
			key_constant: EV_KEY_CONSTANTS
		do
			create key_constant
			if a_key.code = key_constant.key_enter then
				feature_name_changed
			elseif a_key.code = key_constant.key_tab or else 
				   a_key.code = key_constant.key_escape or else
				   a_key.code = key_constant.Key_up or else
				   a_key.code = key_constant.Key_down
			then
				destroy
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


end -- class EDIT_FEATURE_BOX

note
	description: "Command to add a feature setter."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMPOSER_ADD_SETTER_COMMAND

inherit
	EB_COMPOSER_COMMAND_I
		redefine
			new_sd_toolbar_item,
			is_tooltext_important,
			tooltext,
			initialize
		end

	EB_SHARED_MANAGERS

create
	make

feature {NONE} -- Initialization

	initialize
		local
			l_shortcut: SHORTCUT_PREFERENCE
			acc: EV_ACCELERATOR
		do
			Precursor
			l_shortcut := composer_shortcut ("add_setter")
			if l_shortcut = Void then
					-- Default
				l_shortcut := composer_custom_shortcut ("add_setter", False, False, False, "s")
			end
			create acc.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			acc.actions.extend (agent execute)
			register_composer_and_then_accelerator (acc)
		end

feature -- Status

	is_tooltext_important: BOOLEAN
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := True
		end

feature -- Access

	description: STRING_GENERAL
			-- What is printed in the customize dialog.
		do
			Result := interface_names.f_composer_add_setter
		end

	tooltip: STRING_GENERAL
			-- Pop-up help on buttons.
		do
			Result := description
		end

	tooltext: STRING_GENERAL
			-- Text for toolbar button
		do
			Result := interface_names.b_composer_add_setter
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new toolbar button for `Current'.
		do
			Result := Precursor {EB_COMPOSER_COMMAND_I} (display_text)
			Result.drop_actions.extend (agent drop_feature (?))
			Result.drop_actions.set_veto_pebble_function (agent can_drop)
		end

	menu_name: STRING_GENERAL
			-- Menu entry corresponding to `Current'.
		do
			Result := tooltext
		end

	pixmap: EV_PIXMAP
			-- Icon for `Current'.
		do
			Result := pixmaps.icon_pixmaps.general_add_icon -- FIXME 2024-05-21
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_add_icon_buffer -- FIXME 2024-05-21
		end

	Name: STRING = "COMPOSER_feature_setter_adder"
			-- Name of `Current' to identify it.

feature -- Events

	drop (s: ANY)
		do
			if attached {FEATURE_STONE} s as fs then
				drop_feature (fs)
			end
		end

	drop_feature (fs: FEATURE_STONE)
			-- Process feature stone.
		do
			process_feature_stone (fs, False)
		end

	can_drop (a_stone: ANY): BOOLEAN
			-- Can `a_stone' be dropped onto current?
		do
			Result := attached {FEATURE_STONE} a_stone as l_feat_stone and then
					l_feat_stone.is_valid and then
					attached l_feat_stone.e_feature as efeat and then efeat.is_attribute and then
					l_feat_stone.is_storable
		end

	process_feature_stone (fs: FEATURE_STONE; is_batch: BOOLEAN)
			-- Process feature stone.
		local
			feature_i: FEATURE_I
			l_setter_name: detachable READABLE_STRING_32
			pre_inc, post_inc: BOOLEAN
			dlg: ES_COMPOSER_ADD_FEATURE_SETTER_DIALOG
			cont: BOOLEAN
		do
			if fs.e_class /= Void then
				feature_i := fs.e_class.feature_of_feature_id (fs.e_feature.feature_id)
			end
			if
				feature_i /= Void and then
				fs.e_feature.associated_class.class_id = feature_i.written_in
			then
				if is_batch then
					pre_inc := True
					post_inc := True
					cont := True
				else
					create dlg.make_with_feature (feature_i)
					dlg.show_on_active_window
					if dlg.is_validated then
					cont := True
						l_setter_name := dlg.setter_name
						pre_inc := dlg.include_preconditions
						post_inc := dlg.include_postconditions
					end
				end
				if
					cont and then
					attached manager.feature_setter_adder as act
				then
					act.set_feature (feature_i)
					act.set_setter_name (l_setter_name)
					act.preconditions_included := pre_inc
					act.postconditions_included := post_inc

					manager.execute_composer (act)
				end
			else
				prompts.show_error_prompt (warning_messages.w_feature_not_written_in_class, Void, Void)
			end
		end

feature -- Execution

	batch_execute
		do
			if attached feature_stone as fs then
				process_feature_stone (fs, True)
			else
				prompts.show_info_prompt (warning_messages.w_Select_feature_to_add_setter, window_manager.last_focused_development_window.window, Void)
			end
		end

	execute
		do
			if attached feature_stone as fs then
				process_feature_stone (fs, False)
			else
				prompts.show_info_prompt (warning_messages.w_Select_feature_to_add_setter, window_manager.last_focused_development_window.window, Void)
			end
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end


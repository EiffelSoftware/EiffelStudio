note
	description: "Command to remove a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMPOSER_FEATURE_REMOVER_COMMAND

inherit
	EB_COMPOSER_COMMAND_I
		redefine
			new_sd_toolbar_item,
			tooltext,
			is_tooltext_important
		end

	EB_SHARED_MANAGERS

create
	make

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
			Result := interface_names.f_composer_remove_feature
		end

	tooltip: STRING_GENERAL
			-- Pop-up help on buttons.
		do
			Result := description
		end

	tooltext: STRING_GENERAL
			-- Text for toolbar button
		do
			Result := interface_names.b_composer_remove_feature
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
			Result := pixmaps.icon_pixmaps.general_remove_icon -- FIXME 2024-05-21
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_remove_icon_buffer -- FIXME 2024-05-21
		end

	Name: STRING = "COMPOSER_feature_remover"
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
		local
			feature_i: FEATURE_I
			develop_window: EB_DEVELOPMENT_WINDOW
		do
			if fs.e_class /= Void then
				feature_i := fs.e_class.feature_of_feature_id (fs.e_feature.feature_id)
			end
			if
				feature_i /= Void and then
				fs.e_feature.associated_class.class_id = feature_i.written_in and then
				attached feature_i.written_class as c
			then
				develop_window := window_manager.last_focused_development_window
				develop_window.commands.new_tab_cmd.execute_with_stone (create {CLASSC_STONE}.make (c))
				across
					develop_window.editors_manager.editor_editing (c.lace_class) as e
				loop
					e.item.flush
				end
				if attached manager.feature_remover as act then
					act.set_feature (feature_i)
					manager.execute_composer (act)
				end
			else
				prompts.show_error_prompt (warning_messages.w_feature_not_written_in_class, Void, Void)
			end
		end

	can_drop (a_stone: ANY): BOOLEAN
			-- Can `a_stone' be dropped onto current?
		do
			Result := attached {FEATURE_STONE} a_stone as l_feat_stone and then
					l_feat_stone.is_valid and then
					l_feat_stone.is_storable
		end

feature -- Execution

	execute
		do
			if attached feature_stone as fs then
				drop_feature (fs)
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


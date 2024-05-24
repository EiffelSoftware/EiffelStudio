note
	description: "Command to add a creation procedure using a dedicated dialog"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMPOSER_ADD_CREATOR_COMMAND

inherit
	EB_COMPOSER_COMMAND_I
		redefine
			new_sd_toolbar_item,
			is_tooltext_important,
			tooltext
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
			Result := interface_names.f_composer_add_creator
		end

	tooltip: STRING_GENERAL
			-- Pop-up help on buttons.
		do
			Result := description
		end

	tooltext: STRING_GENERAL
			-- Text for toolbar button
		do
			Result := interface_names.b_composer_add_creator
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new toolbar button for `Current'.
		do
			Result := Precursor {EB_COMPOSER_COMMAND_I} (display_text)
			Result.drop_actions.extend (agent drop_class (?))
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

	Name: STRING = "COMPOSER_class_creator_adder"
			-- Name of `Current' to identify it.

feature -- Events

	drop (s: ANY)
		do
			if attached {CLASSI_STONE} s as clst then
				drop_class (clst)
			end
		end

	drop_class (cs: CLASSI_STONE)
			-- Process class stone.
		local
			class_i: CLASS_I
			dlg: ES_ADD_CREATOR_DIALOG
--			l_attribs: ARRAYED_LIST [ATTRIBUTE_I]
		do
			class_i := cs.class_i
			if class_i /= Void then
--				if
--					attached class_i.compiled_class as cc and then
--					attached cc.feature_table.features as lst
--				then
--					create l_attribs.make (10)
--					across
--						lst as ic
--					loop
--						if attached {ATTRIBUTE_I} ic.item as l_attrib_i then
--							l_attribs.force (l_attrib_i)
--						end
--					end
--				end
				create dlg.make_with_class (class_i)
				dlg.show_on_active_window
				if
					attached dlg.values as tu and then
					attached manager.class_creator_adder as act
				then
					act.set_class (class_i)
					act.set_creator_name (tu.creator_name)
					act.set_attributes (tu.attributes)
					manager.execute_composer (act)
				end
			end
		end

	can_drop (a_stone: ANY): BOOLEAN
			-- Can `a_stone' be dropped onto current?
		do
			Result := attached {CLASSI_STONE} a_stone as l_class_stone and then
					l_class_stone.is_valid and then
					l_class_stone.is_storable
		end

feature -- Execution

	execute
		do
			if attached class_stone as cs then
				drop_class (cs)
			else
				prompts.show_info_prompt (warning_messages.w_Select_class_to_process, window_manager.last_focused_development_window.window, Void)
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


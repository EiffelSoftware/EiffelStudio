note
	description: "Window to edit auto entry property of a target."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_AUTO_ENTRY_DIALOG

inherit
	ES_DIALOG
		redefine
			on_after_initialized
		end

	ES_EIS_NOTE_PICKER

create
	make_with_target

feature {NONE} -- Initialization

	make_with_target (a_target: like target; a_apply_action: like apply_action)
			-- Init
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
			apply_action := a_apply_action
			make
		end

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- <precursor>
		local
			l_bordered: ES_BORDERED_WIDGET [EV_WIDGET]
		do
			create grid
			grid.hide_header
			grid.enable_border
			grid.set_minimum_size (400, 120)
			grid.set_column_count_to (2)
			grid.set_row_count_to (2)
			grid.column (1).set_width (150)
			grid.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text (locale_formatter.translation (l_enable)))
			grid.set_item (1, 2, create {EV_GRID_LABEL_ITEM}.make_with_text (locale_formatter.translation (l_source)))

			create enable_item
			grid.set_item (2, 1, enable_item)

			create source_item.make_with_text ("...")
			source_item.pointer_double_press_actions.force_extend (agent source_item.activate)
			grid.set_item (2, 2, source_item)

			create l_bordered.make (grid)
			a_container.extend (l_bordered)
		end

feature -- Access

	target: CONF_TARGET

	apply_action: detachable PROCEDURE [ANY, TUPLE]

feature {NONE} -- Widgets

	grid: ES_GRID

	enable_item: EV_GRID_CHECKABLE_LABEL_ITEM
	source_item: EV_GRID_EDITABLE_ITEM

feature {NONE} -- Implementation

	modify_auto_entry (a_target: CONF_TARGET; enabled: BOOLEAN; src: STRING_32)
			-- Modify auto entry in `a_target', add a new one if absent.
		require
			a_target_not_void: a_target /= Void
			src_not_void: src /= Void
		local
			l_note, l_notes, l_auto_note: detachable CONF_NOTE_ELEMENT
			l_attributes: HASH_TABLE [STRING, STRING]
			l_auto_value: STRING
		do
			if enabled then
				l_auto_value := {ES_EIS_TOKENS}.true_string
			else
				l_auto_value := {ES_EIS_TOKENS}.false_string
			end
			l_notes := a_target.note_node
			if l_notes /= Void then
				from
					l_notes.start
				until
					l_notes.after or l_auto_note /= Void
				loop
					l_note := l_notes.item_for_iteration
					check l_note /= Void end
					if l_note.element_name.is_case_insensitive_equal ({ES_EIS_TOKENS}.eis_string) then
						l_attributes := l_note.attributes
						l_attributes.search ({ES_EIS_TOKENS}.auto_string)
						if l_attributes.found then
							l_auto_note := l_note
						end
					end
					l_notes.forth
				end
				if l_auto_note /= Void then
					l_attributes := l_auto_note.attributes
					l_attributes.search ({ES_EIS_TOKENS}.auto_string)
					if l_attributes.found then
						l_attributes.replace (l_auto_value, {ES_EIS_TOKENS}.auto_string)
					else
						l_attributes.force (l_auto_value, {ES_EIS_TOKENS}.auto_string)
					end
					l_attributes.search ({ES_EIS_TOKENS}.source_string)
					if l_attributes.found then
						l_attributes.replace (src, {ES_EIS_TOKENS}.source_string)
					else
						l_attributes.force (src, {ES_EIS_TOKENS}.source_string)
					end
				else
					l_auto_note := new_auto_entry_note (enabled, src)
					l_notes.extend (l_auto_note)
				end
			else
				a_target.add_note (new_auto_entry_note (enabled, src))
			end
			a_target.system.store
		end

	on_after_initialized
            -- Use to perform additional creation initializations, after the UI has been created.
		local
			l_entry: like auto_entry
		do
			Precursor {ES_DIALOG}
			set_button_action_before_close (dialog_buttons.ok_button, agent on_apply)
			l_entry := auto_entry (target)
			read_auto_entry := l_entry
			if l_entry /= Void then
				enable_item.set_is_checked (l_entry.enabled)
				source_item.set_text (l_entry.src)
			else
				enable_item.set_is_checked (False)
				source_item.set_text (default_source)
			end
		end

	read_auto_entry: like auto_entry

	icon: EV_PIXEL_BUFFER
			-- <precursor>
		do
			Result := stock_pixmaps.tool_watch_icon_buffer
		end

	title: STRING_32
			-- <precursor>
		do
			Result := locale_formatter.translation (locale_formatter.formatted_translation (t_edit_auto_node, [target.name]))
		end

	buttons: DS_SET [INTEGER_32]
			-- <precursor>
		once
			Result := dialog_buttons.ok_cancel_buttons
		end

	default_button: INTEGER_32
			-- <precursor>
		once
			Result := {ES_DIALOG_BUTTONS}.ok_button
		end

	default_confirm_button: INTEGER_32
			-- <precursor>
		once
			Result := {ES_DIALOG_BUTTONS}.ok_button
		end

	default_cancel_button: INTEGER_32
			-- <precursor>
		once
			Result := {ES_DIALOG_BUTTONS}.cancel_button
		end

	default_source: STRING_32 once Result := "$(ISE_DOC_REF)$(unique_id)" end

feature {NONE} -- Action

	on_apply
			-- On OK pressed
		local
			l_entry: like read_auto_entry
			l_save: BOOLEAN
			l_enabled: BOOLEAN
			l_source_str: STRING_32
		do
			l_entry := read_auto_entry
			l_enabled := enable_item.is_checked
			l_source_str := source_item.text
			if l_entry /= Void then
				l_save := True
			else
				l_save := l_enabled or (not l_source_str.is_equal (default_source))
			end
			if l_save then
				modify_auto_entry (target, l_enabled, l_source_str)
			end

			if attached apply_action as l_action then
				l_action.call (Void)
			end
		end

feature {NONE} -- Internationalizations

	t_edit_auto_node: STRING = "Target - $1 : Edit Automatic EIS Entry"
	l_enable: STRING = "Enable Auto-Entry"
	l_source: STRING = "Source"

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

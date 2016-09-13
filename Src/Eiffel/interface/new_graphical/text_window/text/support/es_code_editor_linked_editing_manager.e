note
	description: "Summary description for {ES_CODE_EDITOR_LINKED_EDITING_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CODE_EDITOR_LINKED_EDITING_MANAGER

inherit
	ANY

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_text: like text)
		do
			text := a_text
			create items.make (1)
		end

feature -- Access

	text: SMART_TEXT
			-- Associated text.

	items: ARRAYED_LIST [ES_CODE_EDITOR_LINKING]
			-- Active linked tokens editing sessions.

	item_at (a_pos_in_text: INTEGER): detachable ES_CODE_EDITOR_LINKING
			-- Active linked tokens editing, if enabled.
			-- Related to the location of the position `a_pos_in_text'.
		do
			if attached items as lst and then not lst.is_empty then
				across
					lst as ic
				until
					Result /= Void
				loop
					if ic.item.is_active_at (a_pos_in_text) then
						Result := ic.item
					end
				end
			end
		ensure
			result_valid: Result /= Void implies Result.is_active_at (a_pos_in_text)
		end

feature -- Operation

	lightened_color (a_color: EV_COLOR; a_prop: REAL_32): EV_COLOR
		do
			create Result.make_with_rgb (
					(a_color.red + (1 - a_color.red) * a_prop).min (1),
					(a_color.green + (1 - a_color.green) * a_prop).min (1),
					(a_color.blue + (1 - a_color.blue) * a_prop).min (1)
				)
		end

	swapped_color (a_color: EV_COLOR): EV_COLOR
		do
			create Result.make_with_rgb (
					(1 - a_color.red),
					(1 - a_color.green),
					(1 - a_color.blue)
				)
		end

	darkened_color (a_color: EV_COLOR; a_prop: REAL_32): EV_COLOR
		do
			create Result.make_with_rgb (
					(a_color.red - (1 - a_color.red) * a_prop).max (0),
					(a_color.green - (1 - a_color.green) * a_prop).max (0),
					(a_color.blue - (1 - a_color.blue) * a_prop).max (0)
				)
		end

	linked_token_background_color: EV_COLOR
		do
			Result := lightened_color (preferences.editor_data.selection_background_color, 0.75)
		end

	linked_token_text_color: EV_COLOR
		do
			Result := darkened_color (preferences.editor_data.selection_text_color, 0.75)
		end

	prepare (a_editor: EDITABLE_TEXT_PANEL; a_pos_in_text: INTEGER; a_regions: LIST [TUPLE [start_pos,end_pos: INTEGER]]; a_token_texts: detachable ITERABLE [READABLE_STRING_GENERAL])
			-- Activate linked edit at position `a_pos_in_text' if set, otherwise at cursor.
			-- And if `a_regions' is not empty, limit the impact token in those regions.
		require
			a_regions /= Void and then not a_regions.is_empty
		local
			lst: like items
			l_linking: ES_CODE_EDITOR_LINKED_EDITING
		do
			clean

			lst := items
			if a_token_texts /= Void then
				across
					a_token_texts as ic
				loop
					create l_linking.make (text, a_editor, a_pos_in_text, a_regions, ic.item)
					lst.force (l_linking)
					prepare_linking (l_linking)
				end
			else
				create l_linking.make (text, a_editor, a_pos_in_text, a_regions, Void)
				lst.force (l_linking)
				prepare_linking (l_linking)
			end
		end

	prepare_linking (a_linking: ES_CODE_EDITOR_LINKED_EDITING)
			-- Setup and prepare `a_linking'.
		require
			a_linking_attached: a_linking /= Void
		do
			a_linking.set_background_color (linked_token_background_color)
			a_linking.set_text_color (linked_token_text_color)
			a_linking.associated_manager := Current
			a_linking.prepare
		end

	clean
		do
			if attached items as lst then
				across
					lst as ic
				loop
					ic.item.terminate
				end
			end
			items.wipe_out
		end

feature -- Callbacks

	on_editor_insertion (a_cursor: EDITOR_CURSOR; a_diff: INTEGER)
		local
			p: INTEGER
		do
			p := a_cursor.pos_in_text - a_diff
			if attached item_at (p) as lnk then
				text.update_token_pos_in_text_from (p)
				lnk.propagate_on_insertion (a_cursor, a_diff)
			else
				text.disable_linked_editing
			end
		end

	on_editor_deletion (a_cursor: EDITOR_CURSOR; a_diff: INTEGER)
		local
			p: INTEGER
		do
			p := a_cursor.pos_in_text - a_diff
			if attached item_at (p) as lnk then
				text.update_token_pos_in_text_from (p)
				lnk.propagate_on_deletion (a_cursor, a_diff)
			else
				text.disable_linked_editing
			end
		end

feature {ES_CODE_EDITOR_LINKED_EDITING} -- Callbacks		

	on_linked_editing (a_editing: ES_CODE_EDITOR_LINKED_EDITING; a_pos_in_text: INTEGER; a_diff: INTEGER)
		do
			across
				items as ic
			loop
--				if ic.item /= a_editing then
					ic.item.on_editing (a_pos_in_text, a_diff)
--				end
			end
--			a_editing.on_editing (a_pos_in_text, 0)
		end

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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

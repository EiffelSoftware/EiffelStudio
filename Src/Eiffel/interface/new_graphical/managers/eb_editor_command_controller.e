note
	description: "Intermediate object between development windows and the editor commands"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR_COMMAND_CONTROLLER

inherit
	ANY

	TEXT_OBSERVER

		export
			{NONE} all
		redefine
			on_text_reset, on_text_edited,
			on_selection_begun, on_selection_finished,
			on_text_back_to_its_last_saved_state,
			on_text_fully_loaded,
			on_text_loaded
		end

	TEXT_OBSERVER_MANAGER
		rename
			recycle as internal_recycle
		export
			{NONE} all
		undefine
			on_block_removed, on_text_block_loaded, on_line_modified,
			on_line_inserted, on_cursor_moved, on_line_removed
		redefine
			on_selection_begun, on_selection_finished,
			on_text_back_to_its_last_saved_state,
			on_text_edited, on_text_fully_loaded, on_text_loaded, on_text_reset,
			make, internal_recycle
		end

	EB_RECYCLABLE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			Precursor {TEXT_OBSERVER_MANAGER}
			create editor_commands.make (10)
			create selection_commands.make (10)
		ensure then
			state_correct: text_state = 0 and edition_state = 0 and selection_state = 0
			initialized: selection_commands /= Void and editor_commands /= Void
		end

feature -- Status setting

	set_current_editor (ed: EB_EDITOR)
			-- Change the observed editor.
		require
			valid_editor: ed /= Void
			not_same: not is_same_as_current_editor (ed)
		local
			l_current_editor: like current_editor
			l_textdisp: EDITABLE_TEXT
			ecmds: like editor_commands
			scmds: like selection_commands
			l_is_main_editor: BOOLEAN
		do
			l_current_editor := current_editor
			if l_current_editor /= Void then
				l_current_editor.remove_observer (Current)
			end

			current_editor := ed
			l_current_editor := current_editor
			l_is_main_editor := l_current_editor.is_main_editor
			l_textdisp := l_current_editor.text_displayed
			if l_textdisp /= Void and then l_textdisp.is_notifying then
				l_textdisp.post_notify_actions.extend (agent add_observers)
			else
				l_current_editor.add_edition_observer (Current)
				l_current_editor.add_selection_observer (Current)
			end
					-- Since the current editor has changed,
					-- it may be in a different state than the current state,
					-- and we have to update the state and send events accordingly....*sigh*
			if text_state = 0 then
				if l_current_editor.text_is_fully_loaded then
					on_text_loaded
					on_text_fully_loaded
				end
			elseif text_state = 1 then
				if l_current_editor.text_is_fully_loaded then
					on_text_fully_loaded
				elseif l_current_editor.is_empty then
					on_text_reset
				end
			else
					-- State was fully loaded.
				if l_current_editor.is_empty then
					on_text_reset
				end
			end
			if selection_state = 0 then
				if l_current_editor.has_selection then
					on_selection_begun
				end
			else
					-- Selection state is there is a selection.
				if not l_current_editor.has_selection then
					on_selection_finished
				end
			end
			if edition_state = 0 then
				if l_current_editor.changed then
						--| True is safer for the diagram.
					on_text_edited (True)
				end
			else
				if not l_current_editor.changed then
					on_text_back_to_its_last_saved_state
				end
			end

				-- Now for the "editability" of the editor...
			ecmds := editor_commands
			scmds := selection_commands
			if l_current_editor.is_editable then
				from
					ecmds.start
				until
					ecmds.after
				loop
					if ecmds.item.is_for_main_editor implies l_is_main_editor then
						ecmds.item.on_editable
					end
					ecmds.forth
				end
				from
					scmds.start
				until
					scmds.after
				loop
					if scmds.item.is_for_main_editor implies l_is_main_editor then
						scmds.item.on_editable
					end
					scmds.forth
				end
			else
				from
					ecmds.start
				until
					ecmds.after
				loop
					if ecmds.item.is_for_main_editor implies l_is_main_editor then
						ecmds.item.on_not_editable
					end
					ecmds.forth
				end
				from
					scmds.start
				until
					scmds.after
				loop
					if scmds.item.is_for_main_editor implies l_is_main_editor then
						scmds.item.on_not_editable
					end
					scmds.forth
				end
			end
		ensure
			editor_set: current_editor = ed
		end

	add_edition_command (cmd: EB_EDITOR_COMMAND)
			-- Add a new editor command to the list of observers.
		require
			valid_command: cmd /= Void
		do
			editor_commands.extend (cmd)
			edition_observer_list.extend (cmd)
		ensure
			cmd_now_known: editor_commands.has (cmd)
		end

	add_selection_command (cmd: EB_ON_SELECTION_COMMAND)
			-- Add a new selection command to the list of observers.
		require
			valid_command: cmd /= Void
		do
			selection_commands.extend (cmd)
			selection_observer_list.extend (cmd)
		ensure
			cmd_now_known: selection_commands.has (cmd)
		end

feature -- Contract support

	is_same_as_current_editor (a_editor: EB_EDITOR): BOOLEAN
			-- Check if `current_editor' same as `a_editor'
			-- This can make sure not breaking the arrayed list looping of `on_text_fully_loaded' from TEXT_OBSERVER_MANAGER.
		do
			Result := current_editor = a_editor
		end

feature {NONE} -- Event handling

	on_text_reset
			-- Text in editor was reset.
		do
			if not is_recycled then
				Precursor {TEXT_OBSERVER_MANAGER}
				text_state := 0
			end
		end

	on_text_loaded
			-- Update editor commands.
		do
			if not is_recycled then
				Precursor {TEXT_OBSERVER_MANAGER}
				text_state := 1
			end
		end

	on_text_fully_loaded
			-- The main editor has just been reloaded.
		local
			ecmds: like editor_commands
			scmds: like selection_commands
		do
			if not is_recycled then
				Precursor {TEXT_OBSERVER_MANAGER}
				text_state := 2
				ecmds := editor_commands
				scmds := selection_commands

				if current_editor.is_editable then
					from
						ecmds.start
					until
						ecmds.after
					loop
						ecmds.item.on_editable
						ecmds.forth
					end
					from
						scmds.start
					until
						scmds.after
					loop
						scmds.item.on_editable
						scmds.forth
					end
				else
					from
						ecmds.start
					until
						ecmds.after
					loop
						ecmds.item.on_not_editable
						ecmds.forth
					end
					from
						scmds.start
					until
						scmds.after
					loop
						scmds.item.on_not_editable
						scmds.forth
					end
				end
			end
		end

	on_text_back_to_its_last_saved_state
		do
			if not is_recycled then
				Precursor {TEXT_OBSERVER_MANAGER}
				edition_state := 0
			end
		end

	on_text_edited (unused: BOOLEAN)
			-- The text in the editor is modified, add the '*' in the title.
			-- Gray out the formatters.
		do
			if not is_recycled then
				Precursor {TEXT_OBSERVER_MANAGER} (unused)
				edition_state := 1
			end
		end

	on_selection_begun
			-- Update `editor_copy_cmd' and `editor_cut_command'
			-- (to be performed when selection starts in one of the editors)
		do
			if not is_recycled then
				Precursor {TEXT_OBSERVER_MANAGER}
				selection_state := 1
			end
		end

	on_selection_finished
			-- Update `editor_copy_cmd' and `editor_cut_command'
			-- (to be performed when selection stops in one fo the editors)
		do
			if not is_recycled then
				Precursor {TEXT_OBSERVER_MANAGER}
				if current_editor.has_selection then
					selection_state := 2
				else
					selection_state := 0
				end
			end
		end

feature {NONE} -- Implementation

	internal_recycle
			-- Destroy references to `Current'.
		local
			scmds: like selection_commands
		do
			Precursor {TEXT_OBSERVER_MANAGER}
			editor_commands.wipe_out
			from
				scmds := selection_commands
				scmds.start
			until
				scmds.after
			loop
				scmds.item.recycle
				scmds.forth
			end
			scmds.wipe_out
			current_editor := Void
		end

	add_observers
			-- Add observers
		do
			if not is_recycled then
				current_editor.add_edition_observer (Current)
				current_editor.add_selection_observer (Current)
				post_notify_actions.wipe_out
			end
		end

	current_editor: EB_EDITOR
			-- Currently observed editor.

	text_state: INTEGER
			-- Can be 0 if the current editor is empty, 1 if loaded, 2 if fully loaded.

	edition_state: INTEGER
			-- Can be 0 if the text has not been edited, 1 if it has been.

	selection_state: INTEGER
			-- Can be 0 if there is no selection,
			-- 1 if selection began,
			-- 2 if selection ended.

	editor_commands: ARRAYED_LIST [EB_EDITOR_COMMAND]
			-- Commands relative to the current editor.

	selection_commands: ARRAYED_LIST [EB_ON_SELECTION_COMMAND];
			-- Commands relative to the current editor.

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class EB_EDITOR_COMMAND_CONTROLLER

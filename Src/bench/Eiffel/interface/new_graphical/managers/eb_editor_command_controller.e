indexing
	description: "Intermediate object between development windows and the editor commands"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR_COMMAND_CONTROLLER

inherit
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
		export
			{NONE} all
		undefine
			on_block_removed, on_text_block_loaded, on_line_modified,
			on_line_inserted, on_line_removed
		redefine
			on_selection_begun, on_selection_finished,
			on_text_back_to_its_last_saved_state,
			on_text_edited, on_text_fully_loaded, on_text_loaded, on_text_reset,
			recycle, make
		end

create
	make
	
feature {NONE} -- Initialization

	make is
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

	set_current_editor (ed: EB_EDITOR) is
			-- Change the observed editor.
		require
			valid_editor: ed /= Void
		do
			if current_editor /= Void then
				current_editor.remove_observer (Current)
			end
			current_editor := ed
			current_editor.add_edition_observer (Current)
			current_editor.add_selection_observer (Current)
					-- Since the current editor has changed,
					-- it may be in a different state than the current state,
					-- and we have to update the state and send events accordingly....*sigh*
			if text_state = 0 then
				if current_editor.text_is_fully_loaded then
					on_text_loaded
					on_text_fully_loaded
				end
			elseif text_state = 1 then
				if current_editor.text_is_fully_loaded then
					on_text_fully_loaded
				elseif current_editor.is_empty then
					on_text_reset
				end
			else
					-- State was fully loaded.
				if current_editor.is_empty then
					on_text_reset
				end
			end
			if selection_state = 0 then
				if current_editor.has_selection then
					on_selection_begun
				end
			else
					-- Selection state is there is a selection.
				if not current_editor.has_selection then
					on_selection_finished
				end
			end
			if edition_state = 0 then
				if current_editor.changed then
						--| True is safer for the diagram.
					on_text_edited (True)
				end
			else
				if not current_editor.changed then
					on_text_back_to_its_last_saved_state
				end
			end
			
				-- Now for the "editability" of the editor...
			if current_editor.is_editable then
				from
					editor_commands.start
				until
					editor_commands.after
				loop
					editor_commands.item.on_editable
					editor_commands.forth
				end
				from
					selection_commands.start
				until
					selection_commands.after
				loop
					selection_commands.item.on_editable
					selection_commands.forth
				end
			else
				from
					editor_commands.start
				until
					editor_commands.after
				loop
					editor_commands.item.on_not_editable
					editor_commands.forth
				end
				from
					selection_commands.start
				until
					selection_commands.after
				loop
					selection_commands.item.on_not_editable
					selection_commands.forth
				end
			end
		ensure
			editor_set: current_editor = ed
		end

	add_edition_command (cmd: EB_EDITOR_COMMAND) is
			-- Add a new editor command to the list of observers.
		require
			valid_command: cmd /= Void
		do
			editor_commands.extend (cmd)
			edition_observer_list.extend (cmd)
		ensure
			cmd_now_known: editor_commands.has (cmd)
		end

	add_selection_command (cmd: EB_ON_SELECTION_COMMAND) is
			-- Add a new selection command to the list of observers.
		require
			valid_command: cmd /= Void
		do
			selection_commands.extend (cmd)
			selection_observer_list.extend (cmd)
		ensure
			cmd_now_known: selection_commands.has (cmd)
		end

	recycle is
			-- Destroy references to `Current'.
		do
			Precursor {TEXT_OBSERVER_MANAGER}
			editor_commands.wipe_out
			selection_commands.wipe_out
			current_editor := Void
		end

feature {NONE} -- Event handling

	on_text_reset is
			-- Text in editor was reset.
		do
			Precursor {TEXT_OBSERVER_MANAGER}
			text_state := 0
		end

	on_text_loaded is
			-- Update editor commands.
		do
			Precursor {TEXT_OBSERVER_MANAGER}
			text_state := 1
		end
					
	on_text_fully_loaded is
			-- The main editor has just been reloaded.
		do
			Precursor {TEXT_OBSERVER_MANAGER}
			text_state := 2
			if current_editor.is_editable then
				from
					editor_commands.start
				until
					editor_commands.after
				loop
					editor_commands.item.on_editable
					editor_commands.forth
				end
				from
					selection_commands.start
				until
					selection_commands.after
				loop
					selection_commands.item.on_editable
					selection_commands.forth
				end
			else
				from
					editor_commands.start
				until
					editor_commands.after
				loop
					editor_commands.item.on_not_editable
					editor_commands.forth
				end
				from
					selection_commands.start
				until
					selection_commands.after
				loop
					selection_commands.item.on_not_editable
					selection_commands.forth
				end
			end
		end

	on_text_back_to_its_last_saved_state is
		do
			Precursor {TEXT_OBSERVER_MANAGER}
			edition_state := 0
		end			
		
	on_text_edited (unused: BOOLEAN) is
			-- The text in the editor is modified, add the '*' in the title.
			-- Gray out the formatters.
		do
			Precursor {TEXT_OBSERVER_MANAGER} (unused)
			edition_state := 1
		end

	on_selection_begun is
			-- Update `editor_copy_cmd' and `editor_cut_command'
			-- (to be performed when selection starts in one of the editors)
		do
			Precursor {TEXT_OBSERVER_MANAGER}
			selection_state := 1
		end
	
	on_selection_finished is
			-- Update `editor_copy_cmd' and `editor_cut_command'
			-- (to be performed when selection stops in one fo the editors)
		do
			Precursor {TEXT_OBSERVER_MANAGER}
			if current_editor.has_selection then
				selection_state := 2
			else
				selection_state := 0
			end
		end

feature {NONE} -- Implementation

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

	selection_commands: ARRAYED_LIST [EB_ON_SELECTION_COMMAND]
			-- Commands relative to the current editor.

end -- class EB_EDITOR_COMMAND_CONTROLLER

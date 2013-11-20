note
	description: "Observer for TEXT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_OBSERVER

feature {NONE} -- Access

	text_observer_manager: detachable TEXT_OBSERVER_MANAGER
			-- Manager managing `Current'.

feature {TEXT_OBSERVER_MANAGER}-- Element Change

	set_manager (m: TEXT_OBSERVER_MANAGER)
			-- Define the manager managing `Current'.
		do
			text_observer_manager := m
		end

feature {TEXT_OBSERVER_MANAGER} -- Update

	on_text_edited (directly_edited: BOOLEAN)
			-- Update `Current' when some text has been modified
			-- if `directly_edited', the user has modified the text in the editor,
			-- not via another tool or wizard
			-- Observer must be registered as "edition_observer" for this feature to be called.
		do
		end

	on_text_loaded
			-- Update `Current' when the text has been completely loaded.
			-- Observer must be registered as "edition_observer" for this feature to be called.
		do
		end

	on_text_fully_loaded
			-- Update `Current' when the text has been completely loaded.
			-- Observer must be registered as "edition_observer" for this feature to be called.
		do
		end

	on_text_reset
			-- Update `Current' when the text has been reset.
			-- Observer must be registered as "edition_observer" for this feature to be called.
		do
		end

	on_text_back_to_its_last_saved_state
			-- Update `Current' when the text is back to its state when it was saved for the last time.
			-- Observer must be registered as "edition_observer" for this feature to be called.
		do
		end


	on_selection_begun
			-- Update `Current' when a selection begins in the observed editor.
			-- Observer must be registered as "selection_observer" for this feature to be called.
		do
		end

	on_selection_finished
			-- Update `Current' when there is no more selection in the observed editor.
			-- Observer must be registered as "selection_observer" for this feature to be called.
		do
		end

	on_text_block_loaded (was_first_block: BOOLEAN)
			-- Update `Current' when a new block of text has been loaded in the editor.
			-- Observer must be registered as "lines_observer" for this feature to be called.
			-- `was_first_block' is True if the loaded block was the first one
		do
		end

	on_line_modified (l_num: INTEGER)
			-- Update `Current' when a line is modified in the text.
			-- Observer must be registered as "lines_observer" for this feature to be called.
		do
		end

	on_line_inserted (l_num: INTEGER)
			-- Update `Current' when a line is inserted in the text.
			-- Observer must be registered as "lines_observer" for this feature to be called.
		do
		end

	on_line_removed (l_num: INTEGER)
			-- Update `Current' when a line is removed from the text.
			-- Observer must be registered as "lines_observer" for this feature to be called.
		do
		end

	on_block_removed
			-- Update `Current' when a block of lines is removed from the text.
			-- Observer must be registered as "lines_observer" for this feature to be called.
		do
		end

	on_cursor_moved
			-- Update `Current' when the main text cursor moves.
			-- Observer must be registered as "cursor_observer" for this feature to be called.
		do
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class OBSERVER

indexing
	description:	"Observer for TEXT."
	author:		"Etienne Amodeo"
	date:		"$Date$"
	revision:	"$Revision$"

deferred class
	TEXT_OBSERVER

feature {NONE} -- Access

	text_observer_manager: TEXT_OBSERVER_MANAGER
			-- Manager managing `Current'.

feature {TEXT_OBSERVER_MANAGER}-- Element Change

	set_manager (m: TEXT_OBSERVER_MANAGER) is
			-- Define the manager managing `Current'.
		do
			text_observer_manager := m
		end

feature {TEXT_OBSERVER_MANAGER} -- Update 

	on_text_edited (directly_edited: BOOLEAN) is
			-- Update `Current' when some text has been modified
			-- if `directly_edited', the user has modified the text in the editor,
			-- not via another tool or wizard
			-- Observer must be registered as "edition_observer" for this feature to be called.
		do
		end

	on_text_loaded is
			-- Update `Current' when the text has been completely loaded.
			-- Observer must be registered as "edition_observer" for this feature to be called.
		do
		end

	on_text_reset is
			-- Update `Current' when the text has been reset.
			-- Observer must be registered as "edition_observer" for this feature to be called.
		do
		end

	on_selection_begun is
			-- Update `Current' when a selection begins in the observed editor.
			-- Observer must be registered as "selection_observer" for this feature to be called.
		do
		end

	on_selection_finished is
			-- Update `Current' when there is no more selection in the observed editor.
			-- Observer must be registered as "selection_observer" for this feature to be called.
		do
		end

	on_text_block_loaded (was_first_block: BOOLEAN) is
			-- Update `Current' when a new block of text has been loaded in the editor.
			-- Observer must be registered as "lines_observer" for this feature to be called.
			-- `was_first_block' is True if the loaded block was the first one
		do
		end

	on_line_modified (l_num: INTEGER) is
			-- Update `Current' when a line is modified in the text.
			-- Observer must be registered as "lines_observer" for this feature to be called.
		do
		end

	on_line_inserted (l_num: INTEGER) is
			-- Update `Current' when a line is inserted in the text.
			-- Observer must be registered as "lines_observer" for this feature to be called.
		do
		end

	on_line_removed (l_num: INTEGER) is
			-- Update `Current' when a line is removed from the text.
			-- Observer must be registered as "lines_observer" for this feature to be called.
		do
		end

	on_block_removed is
			-- Update `Current' when a block of lines is removed from the text.
			-- Observer must be registered as "lines_observer" for this feature to be called.
		do
		end

end -- class OBSERVER

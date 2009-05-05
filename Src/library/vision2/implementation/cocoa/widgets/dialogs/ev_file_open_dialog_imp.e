indexing
	description: "Eiffel Vision file open dialog. Cocoa implementation."


class
	EV_FILE_OPEN_DIALOG_IMP

inherit
	EV_FILE_OPEN_DIALOG_I
		redefine
			interface
		end

	EV_FILE_DIALOG_IMP
		undefine
			internal_accept
		redefine
			make,
			interface,
			initialize,
			window,
			show_modal_to_window
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a window with a parent.
		do
			base_make (an_interface)
			create open_panel.open_panel
		end

	initialize
		do
			Precursor
			--set_title ("Open")
		end

	show_modal_to_window (a_window: EV_WINDOW)
			-- Note: OS X does not present a list with file types to select from. The files displayed are any of those in the filter
		local
			button: INTEGER
			l_file_types: NS_ARRAY[NS_STRING]
			l_filters: ARRAYED_LIST[NS_STRING]
		do
			create l_filters.make (filters.count)
			from
				filters.start
			until
				filters.after
			loop
				l_filters.extend (create {NS_STRING}.make_with_string (filters.item.filter.substring (3, filters.item.filter.count))) -- cut off the beginning "*." part
				filters.forth
			end
			create l_file_types.array_with_objects_count (l_filters)
			open_panel.set_allowed_file_types (l_file_types)

			button := open_panel.run_modal
			if button =  {NS_PANEL}.ok_button then
				selected_button := internal_accept
				interface.open_actions.call (Void)
			elseif button = {NS_PANEL}.cancel_button then
				selected_button := ev_cancel
				interface.cancel_actions.call (Void)
			end
		end

feature {NONE} -- Access

	multiple_selection_enabled: BOOLEAN
		-- Is dialog enabled to select multiple files.
		do
			Result := open_panel.allows_multiple_selection
		end

	file_names: ARRAYED_LIST [STRING_32]
			-- List of filenames selected by user
		local
			l_filenames: NS_ARRAY [NS_STRING]
		do
			l_filenames := open_panel.filenames
			create Result.make (l_filenames.count)
		end

feature {NONE} -- Setting

	enable_multiple_selection
			-- Enable multiple file selection
		do
			open_panel.set_allows_multiple_selection (True)
		end

	disable_multiple_selection
			-- Disable multiple file selection
		do
			open_panel.set_allows_multiple_selection (False)
		end

feature {NONE} -- Implementation

	open_panel: NS_OPEN_PANEL

	window: NS_WINDOW
		do
			Result ?= open_panel
		end

	interface: EV_FILE_OPEN_DIALOG;

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_FILE_OPEN_DIALOG_IMP


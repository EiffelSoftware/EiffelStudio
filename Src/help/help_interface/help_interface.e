indexing
	description: "Graphical interface to help system"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	HELP_INTERFACE

inherit
	EV_APPLICATION

creation
	make

feature -- Initialization

	main_window: EV_WINDOW is
			-- Main help window.
		once
			create Result.make_top_level
			Result.set_title ("Eiffel Help System");

			create_widgets
			setup_widgets

			Result.show
		end;

feature -- Access

	search_window: HELP_SEARCH_WINDOW
			-- The search window.

	canvas: EV_VERTICAL_BOX
			-- Container to enclose `main_window' area.

	index: HELP_INDEX
			-- The help index.

	document_area: HELP_DOCUMENT_DISPLAY
			-- The document area.

feature -- Status Setting

	create_widgets is
			-- Create buttons, text fields, etc. for the window.
		do
			-- Containers
			create canvas.make (main_window)
			create document_area.make (canvas)
			create search_window.make (main_window,document_area)
		end;

	setup_widgets is
			-- Set up the widgets in the windows.
		local
			format: EV_CHARACTER_FORMAT
		do
			-- Containers
			create format.make
			format.set_bold (False)
			document_area.set_character_format (format)
			document_area.set_minimum_size (400, 400)

			search_window.forbid_resize
			search_window.set_title ("Search")
			search_window.show
		end;

end -- class HELP_INTERFACE

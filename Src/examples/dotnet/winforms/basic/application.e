indexing
	description: "Root class for Basic Winforms demo."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature -- Initialization

	make is
			-- Initialize
		local
			point: DRAWING_POINT
			size: DRAWING_SIZE
			handler: EVENT_HANDLER
		do
			create main_win.make_winforms_form
			main_win.set_text (("Hello World!").to_cil)
			
			create button.make_winforms_button
			button.set_parent (main_win)
			point.make_drawing_point (80, 65)
			size.make_drawing_size_1 (75, 24)
			button.set_size (size)
			button.set_location (point)
			button.set_text (("Message").to_cil)
			
			create label.make_winforms_label
			point.make_drawing_point (20, 20)
			size.make_drawing_size_1 (200, 30)
			label.set_location (point)
			label.set_size (size)
			label.set_text (("Welcome to an Eiffel example on how to use Winforms.").to_cil)
			label.set_parent (main_win)
			
			create handler.make_event_handler (Current, $on_close)
			button.add_click (handler)
			
			size.make_drawing_size_1 (240, 130)
			main_win.set_size (size)
			
			main_win.show
			
			feature {WINFORMS_APPLICATION}.run_form (main_win)
		end

feature -- Access

	main_win: WINFORMS_FORM
			-- Main window.

	label: WINFORMS_LABEL
			-- Label.
	
	button: WINFORMS_BUTTON
			-- Main Button in Window.
	
feature -- Actions

	on_close (sender: SYSTEM_OBJECT; event_args: EVENT_ARGS) is
			-- Close current application.
		local
			res: WINFORMS_DIALOG_RESULT
		do
			res := feature {WINFORMS_MESSAGE_BOX}.show_string_string (
				("You just clicked on the Close button").to_cil, ("An Eiffel Message Box").to_cil)
		end

invariant
	main_win_not_void: main_win /= Void
	label_not_void: label /= Void
	button_not_void: button /= Void

end -- class APPLICATION

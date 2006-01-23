indexing
	description: "Root class for Basic Winforms demo."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			create main_win.make
			main_win.set_text ("Hello World!")
			
			create button.make
			button.set_parent (main_win)
			point.make (80, 65)
			size.make (75, 24)
			button.set_size (size)
			button.set_location (point)
			button.set_text ("Message")
			
			create label.make
			point.make (20, 20)
			size.make (200, 30)
			label.set_location (point)
			label.set_size (size)
			label.set_text ("Welcome to an Eiffel example on how to use Winforms.")
			label.set_parent (main_win)
			
			create handler.make (Current, $on_close)
			button.add_click (handler)
			
			size.make (240, 130)
			main_win.set_size (size)
			
			main_win.show
			
			{WINFORMS_APPLICATION}.run_form (main_win)
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
			res := {WINFORMS_MESSAGE_BOX}.show ("You just clicked on the %"Message%" button", "An Eiffel Message Box")
		end

invariant
	main_win_not_void: main_win /= Void
	label_not_void: label /= Void
	button_not_void: button /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class APPLICATION

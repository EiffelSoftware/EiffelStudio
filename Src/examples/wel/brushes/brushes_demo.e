indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	BRUSHES_DEMO

inherit
	WEL_APPLICATION
		redefine
			idle_action
		end

create
	make

feature

	main_window: MAIN_WINDOW is
			-- Create the application's main window
		once
			enable_idle_action
			create Result.make
		end

	idle_action is
			-- The message queue is empty.
			-- Execute the rectangle_demo if it exists.
		do
			if main_window.rectangle_demo /= Void and then
				main_window.rectangle_demo.exists then
				main_window.rectangle_demo.draw
			end
		end

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


end -- class BRUSHES_DEMO


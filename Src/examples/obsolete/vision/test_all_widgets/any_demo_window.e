indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
deferred class ANY_DEMO_WINDOW

inherit

	COMMAND
		rename
			execute as work
		end

feature

	main_widget: WIDGET is
		deferred
		end

	set_widgets is
		deferred
		end

	work (arg: ANY) is
		deferred
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


end -- class ANY_DEMO_WINDOW


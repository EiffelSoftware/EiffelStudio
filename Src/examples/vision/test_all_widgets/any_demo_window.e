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

end -- class ANY_DEMO_WINDOW

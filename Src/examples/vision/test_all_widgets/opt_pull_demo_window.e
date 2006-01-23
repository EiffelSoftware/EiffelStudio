indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class OPT_PULL_DEMO_WINDOW

inherit

	DEMO_WINDOW

create

	make

feature

	menu_entry1: MENU_B
	menu_entry2: MENU_B
	menu_entry3: MENU_B
	menu_entry4: MENU_B

	main_widget: WIDGET is
		once
			create {OPT_PULL} Result.make ("Opt_pull", Current)
		end

	set_widgets is
		local
			opt_pull: OPT_PULL
		do
			set_size (160, 200)
			main_widget.set_x_y (30, 30)
			opt_pull ?= main_widget
			opt_pull.set_title ("Option pull")

			create menu_entry1.make ("menu_entry1", opt_pull)
			menu_entry1.set_text ("Menu_entry1")
			create menu_entry2.make ("menu_entry2", opt_pull)
			menu_entry2.set_text ("Menu_entry2")
			create menu_entry3.make ("menu_entry3", opt_pull)
			menu_entry3.set_text ("Menu_entry3")
			create menu_entry4.make ("menu_entry4", opt_pull)
			menu_entry4.set_text ("Menu_entry4")
		end

	work (arg: INTEGER_REF) is
		do
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


end -- class OPT_PULL_DEMO_WINDOW


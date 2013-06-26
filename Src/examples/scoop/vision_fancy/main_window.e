note
	description: "Main window of fancy application, which contains two subwindows. One draws rectangles, the %
		%other one draws ovals."
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects
		end

create

	make

feature {NONE} -- Initialization

	make
			-- Create the main window of resource bench.
		do
			default_create
			build_interface
			launch_fancy
		end

	create_interface_objects
			-- <Precursor>
		local
			l_stop: STOP_CONTROLLER
		do
			create client_window_oval
			create client_window_rect

				-- Stop controller are need to stop worker processors
				-- Otherwise the process does not terminate.
			create stop_controllers.make (4)
			create l_stop
			l_stop.set_is_stopped (False)
			stop_controllers.extend (l_stop)
			create oval_area.make_in (client_window_oval, l_stop)
			create l_stop
			l_stop.set_is_stopped (False)
			stop_controllers.extend (l_stop)
			create rect_area.make_in (client_window_rect, l_stop)
		end

feature {NONE} -- Initialization

	build_interface
			-- Initialization of the different clients.
		local
			l_menu_bar: EV_MENU_BAR
			l_menu: EV_MENU
			l_menu_item: EV_MENU_ITEM
			l_split: EV_HORIZONTAL_SPLIT_AREA
			l_main_area: EV_VERTICAL_BOX
		do
			set_title ("Fancy")
			set_size (400, 300)

				-- Create the menu bar.
			create l_menu_bar
			set_menu_bar (l_menu_bar)
			create l_menu.make_with_text ("Windows")
			l_menu_bar.extend (l_menu)
			create l_menu_item.make_with_text ("Rectangle")
			l_menu.extend (l_menu_item)
			l_menu_item.select_actions.extend (agent on_rectangle_selected)
			create l_menu_item.make_with_text ("Oval")
			l_menu.extend (l_menu_item)
			l_menu_item.select_actions.extend (agent create_separate_oval)
			l_menu.extend (create {EV_MENU_SEPARATOR})
			create l_menu_item.make_with_text ("Exit")
			l_menu.extend (l_menu_item)
			l_menu_item.select_actions.extend (agent on_exit_selected)

			create l_main_area
			extend (l_main_area)

				-- Split
			create l_split
			l_main_area.extend (l_split)

				-- Create client_windows
			l_split.extend (client_window_oval)
			l_split.extend (client_window_rect)
			l_split.set_proportion (0.5)

			close_request_actions.extend (agent on_exit_selected)
		end

feature -- Action

	launch_fancy
			-- Launch fancy display
		do
			launch_area (oval_area)
			launch_area (rect_area)
			on_rectangle_selected
			on_oval_selected
		end

	stop_controllers: ARRAYED_LIST [STOP_CONTROLLER]
			-- Stop controller

feature {NONE} -- Commands

	launch_area (a_cmd: separate DEMO_CMD)
			-- Launch `a_area'
		do
			a_cmd.execute
		end

	oval_area: separate OVAL_DEMO_CMD
			-- Commands to draw ovals.

	rect_area: separate RECTANGLE_DEMO_CMD
			-- Commands to draw rectangles.

feature {NONE} -- Actions

	on_rectangle_selected
			-- On Rectangle menu selected
		do
			create rectangle_window.make
			rectangle_window.show
		end

	rectangle_window: detachable RECTANGLE_DEMO_WINDOW
		note
			option: stable
		attribute
		end

	on_oval_selected
			-- On Oval menu selected
		do
			create oval_window.make
			oval_window.show
		end

	create_separate_oval
		local
			l_w: separate OVAL_DEMO_WINDOW
		do
			create l_w.make
			show_window (l_w)
		end

	show_window (a_w: separate EV_WINDOW)
		do
			a_w.show
		end

	oval_window: detachable OVAL_DEMO_WINDOW
		note
			option: stable
		attribute
		end

	on_exit_selected
			-- On Exit menu selected
		do
			across
				stop_controllers as l_c
			loop
				l_c.item.set_is_stopped (True)
			end
			destroy_and_exit_if_last
		end

feature {NONE} -- Implementation: access

	client_window_oval: CLIENT_AREA
			-- Drawing area for working processor drawing ovals.

	client_window_rect: CLIENT_AREA;
			-- Drawing area for worker processor drawing rectangles.

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end

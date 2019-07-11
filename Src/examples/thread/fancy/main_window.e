note
	description: "Main window of fancy application, which contains two subwindows. One draws rectangles, the %
		%other one draws ovals."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_wm_close,
			closeable,
			class_background,
			on_size,
			on_menu_command,
			on_menu_select,
			on_accelerator_command,
			on_control_id_command
		end

	WEL_WINDOWS_ROUTINES

	WEL_SIZE_CONSTANTS
		export
			{NONE} all
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_STANDARD_COLORS
		export
			{NONE} all
		end

	THREAD_CONTROL
	EXIT_CONTROL

create

	make

feature {NONE} -- Creation

	make
			-- Create the main window of resource bench.
		local
			win_status: like status_window
		do
			make_top ("Fancy")
			resize (400, 300)

				-- Create the menu bar.
			set_menu (main_menu)

				-- Initialization.
			initialize

				-- Create Status.
			create win_status.make (Current, status_window_id)
			status_window := win_status
			win_status.set_parts (<<-1>>)


				-- Launch clients.
			launch_area (oval_area)
			launch_area (rect_area)
			show
		end

feature {NONE} -- Initialization

	initialize
			-- Initialization of the different clients.
		do
			create display_mutex.make

				-- Create client_windows for each thread.
			create client_window_oval.make (Current, "Client Window_Oval")

			create client_window_rect.make (Current, "Client Window_Rect")

				-- Create threads (without launching them).
			create oval_area.make_in (client_window_oval, display_mutex)
			create rect_area.make_in (client_window_rect, display_mutex)
		end

feature {NONE} -- Thread

	launch_area (a_area: detachable DEMO_CMD)
			-- Launch `a_area'
		do
			if a_area /= Void then
				a_area.launch
			end
		end

	oval_area: detachable OVAL_DEMO_CMD
			-- Commands to draw ovals.

	rect_area: detachable RECTANGLE_DEMO_CMD
			-- Commands to draw rectangles.

	display_mutex: MUTEX
			-- Since display is a bottleneck on Windows, serialization
			-- of the drawing operations are done through this mutex.

feature {NONE} -- Behavior

	on_size (a_size_type, a_width, a_height: INTEGER)
			-- Reposition windows in the main window.
		local
			win_status_height: INTEGER
		do
			if a_size_type /= Size_minimized then
				if status_window /= Void then
					status_window.reposition
					win_status_height := status_window.height
				end
				if client_window_oval /= Void then
					client_window_oval.move_and_resize (2, 2,
						client_rect.width // 2 - 4, client_rect.height - win_status_height - 4, True)
				end
				if client_window_rect /= Void then
					client_window_rect.move_and_resize (2 + client_rect.width // 2, 2,
						client_rect.width // 2 - 4, client_rect.height - win_status_height - 4, True)
				end
			end
		end

	on_menu_command (a_menu_id: INTEGER)
			-- Execute the command correpsonding to `menu_id'.
		do
			inspect
				a_menu_id
			when Cmd_win_rect then
				;(create {RECTANGLE_DEMO_WINDOW}.make (display_mutex)).do_nothing
			when Cmd_win_oval then
				;(create {OVAL_DEMO_WINDOW}.make (display_mutex)).do_nothing
			when Cmd_help_about then
				if attached about_box as b then
					b.activate
				end
			when Cmd_win_exit then
				if closeable then
					do_exit (Current)
				end
			end
		end

	on_menu_select (menu_item: INTEGER; flags: INTEGER; a_menu: detachable WEL_MENU)
			-- Display a message in the status window corresponding
			-- to the selected menu_item.
		do
			if status_window /= Void then
				status_window.set_text_part (0, resource_string_id (menu_item))
			end
		end

	on_accelerator_command (a_accelerator_id: INTEGER)
			-- Perform the corresponding menu command with id `a_accelerator_id'.
		do
			on_menu_command (a_accelerator_id)
		end

	on_control_id_command (a_control_id: INTEGER)
			-- Perform the corresponding menu command with id `a_control_id'.
		do
			on_menu_command (a_control_id)
		end

	on_wm_close
			-- Wm_close message.
			-- If `closeable' is False further processing is halted.
		do
			set_default_processing (closeable)
		end

feature {NONE} -- Implementation: access

	status_window_id: INTEGER = 128
			-- The status window id.

	main_menu: WEL_MENU
			-- The `main_menu' of the Resource Bench application.
		once
			create Result.make_by_id (Idr_menu)
		ensure
			result_not_void: Result /= Void
		end

	client_window_oval: detachable CLIENT_WINDOW
			-- Client_Window for thread drawing ovals.
		note
			option: stable
		attribute
		end

	client_window_rect: detachable CLIENT_WINDOW
			-- Client_Window for thread drawing rectangles.
		note
			option: stable
		attribute
		end

	status_window: detachable WEL_STATUS_WINDOW
			-- Status window of main window.
		note
			option: stable
		attribute
		end

	class_background: WEL_LIGHT_GRAY_BRUSH
			-- Standard window background color
		once
			create Result.make
		end

feature {NONE} -- Implementation

	stop_all_threads
			-- Tell the threads to stop, and wait for their end.
		local
			l_oval_area: like oval_area
			l_rect_area: like rect_area
		do
			exit_mutex.lock
			from
				demos_list.start
			until
				demos_list.after
			loop
				demos_list.item.stop_demo
				demos_list.item.join_demo
				demos_list.remove
			end
			l_oval_area := oval_area
			l_rect_area := rect_area

			if l_oval_area /= Void then
				l_oval_area.stop
			end
			if l_rect_area /= Void then
				l_rect_area.stop
			end
			if l_oval_area /= Void then
				l_oval_area.join
			end
			if l_rect_area /= Void then
				l_rect_area.join
			end

			exit_mutex.unlock
		end

	closeable: BOOLEAN
			-- Show the standard dialog box.
		do
			msg_box.question_message_box (Current, "Do you want to exit?", "Exit")
			if msg_box.message_box_result = Idyes then
				stop_all_threads
				Result := True
			else
				Result := False
			end
		end

	msg_box: WEL_MSG_BOX
		once
			create Result.make
		ensure
			Result_not_void: Result /= Void
		end

	about_box: WEL_MODAL_DIALOG
			-- About dialog box
		once
			create Result.make_by_id (Current, Idr_about)
		ensure
			Result_not_void: Result /= Void
		end

	do_exit (a_parent: WEL_COMPOSITE_WINDOW)
			-- Exit to application.
		require
			a_parent_not_void: a_parent /= Void
		do
			a_parent.destroy
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

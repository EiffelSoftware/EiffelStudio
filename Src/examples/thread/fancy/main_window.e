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

feature {NONE} -- Initialization

	make is
			-- Create the main window of resource bench.
		do
			make_top ("Fancy")
			resize (400, 300)

				-- Create the menu bar.
			set_menu (main_menu)

				-- Create Status.
			create status_window.make (Current, status_window_id)
			status_window.set_parts (<<-1>>)

				-- Initialization.
			initialize

				-- Launch clients.
			oval_area.launch
			rect_area.launch
			show
		end

feature -- Initialization

	initialize is
			-- Initialization of the different clients.
		do
				-- Create client_windows for each thread.
			create client_window_oval.make (Current, "Client Window_Oval")
			create client_window_rect.make (Current, "Client Window_Rect")

				-- Create threads (without launching them).
			create oval_area.make_in (client_window_oval.item)
			create rect_area.make_in (client_window_rect.item)
			
	
		end

feature -- Thread

	oval_area: OVAL_DEMO_CMD
	rect_area: RECTANGLE_DEMO_CMD

feature -- Access

	status_window_id: INTEGER is 128
			-- The status window id.

	main_menu: WEL_MENU is
			-- The `main_menu' of the Resource Bench application.
		once
			create Result.make_by_id (Idr_menu)
		ensure
			result_not_void: Result /= Void
		end

			-- A Client_Window for each thread.
	client_window_oval: CLIENT_WINDOW
	client_window_rect: CLIENT_WINDOW

			-- Window inside client area
			-- minus toolbar and status window.

	status_window: WEL_STATUS_WINDOW
			-- Status window of main window.

	class_background: WEL_LIGHT_GRAY_BRUSH is
			-- Standard window background color
		once
			create Result.make
		end

feature -- Behavior

	on_size (a_size_type, a_width, a_height: INTEGER) is
			-- Reposition windows in the main window.
		do
			if (a_size_type /= Size_minimized) then
				if (status_window /= Void) then
					status_window.reposition
				end
				if client_window_oval /= Void then
					client_window_oval.move_and_resize (2, 2,
						client_rect.width // 2 - 4, client_rect.height - status_window.height - 4, True)
				end
				if client_window_rect /= Void then
					client_window_rect.move_and_resize (2 + client_rect.width // 2, 2,
						client_rect.width // 2 - 4, client_rect.height - status_window.height - 4, True)
				end
			end
		end

	on_menu_command (a_menu_id: INTEGER) is
			-- Execute the command correpsonding to `menu_id'.
		require else
			about_box_not_void: about_box /= Void
		local
			rect_demo: RECTANGLE_DEMO_WINDOW
			oval_demo: OVAL_DEMO_WINDOW
		do
			inspect
				a_menu_id

			when Cmd_win_rect then
				create rect_demo.make 
			when Cmd_win_oval then
				create oval_demo.make 
			when Cmd_help_about then
				about_box.activate

			when Cmd_win_exit then
				if closeable then
					do_exit (Current) 
				end
			end
		end

	on_menu_select (menu_item: INTEGER; flags: INTEGER; a_menu: WEL_MENU) is
			-- Display a message in the status window corresponding
			-- to the selected menu_item.
		do
			status_window.set_text_part (0, resource_string_id (menu_item))
		end

	on_accelerator_command (a_accelerator_id: INTEGER) is
			-- Perform the corresponding menu command with id `a_accelerator_id'.
		do
			on_menu_command (a_accelerator_id)
		end

	on_control_id_command (a_control_id: INTEGER) is
			-- Perform the corresponding menu command with id `a_control_id'.
		do
			on_menu_command (a_control_id)
		end

	on_wm_close is
			-- Wm_close message.
			-- If `closeable' is False further processing is halted.
		do
			set_default_processing (closeable)
		end

feature -- Implementation
	

	stop_all_threads is
			-- Tell the threads to stop, and wait for their end.
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
			oval_area.stop
			rect_area.stop
			oval_area.join
			rect_area.join
			exit_mutex.unlock
		end

	closeable: BOOLEAN is
			-- Show the standard dialog box.
		do
			msg_box.question_message_box (Current, "Do you want to exit?", "Exit") 			
			if (msg_box.message_box_result = Idyes) then
				stop_all_threads
				Result := True
			else
				Result := False
			end
		end

	msg_box: WEL_MSG_BOX is
		once
			create Result.make
		ensure
			Result_not_void: Result /= Void
		end

	about_box: WEL_MODAL_DIALOG is
			-- About dialog box
		once
			create Result.make_by_id (Current, Idr_about)
		ensure
			Result_not_void: Result /= Void
		end

	do_exit (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Exit to application.
		do
			a_parent.destroy
		end

end -- class MAIN_WINDOW

indexing
	description: ""
	
class
	PROGRESS_BAR_CTL

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point."
		local
			dummy: SYSTEM_OBJECT
		do
			initialize_components

			i_sleep_time := 100 
			cmd_step.set_selected_index (0)
			prog_bar.set_step (1)
			
				-- Should be called automaticaly
			on_load

			dummy := my_window.show_dialog
		end

feature -- Access

	my_window: WINFORMS_FORM
			-- Main window.

	components: SYSTEM_DLL_SYSTEM_CONTAINER	
			-- System.ComponentModel.Container

	label_1, label_2, label_3, label_4: WINFORMS_LABEL
			-- System.Windows.Forms.Label 

	lbl_completed, lbl_value: WINFORMS_LABEL
			-- System.Windows.Forms.Label 

	sldr_speed: WINFORMS_TRACK_BAR
			-- System.Windows.Forms.TrackBar 

	prog_bar: WINFORMS_PROGRESS_BAR
			-- System.Windows.Forms.ProgressBar

	grp_behavior: WINFORMS_GROUP_BOX
			-- System.Windows.Forms.GroupBox

	cmd_step: WINFORMS_COMBO_BOX
			-- System.Windows.Forms.ComboBox 

	i_sleep_time: INTEGER
	timed_progress: THREAD

feature -- Implementation

	initialize_components is
			--
		local
			l_array: NATIVE_ARRAY [SYSTEM_STRING]
			l_point: DRAWING_POINT
			l_size: DRAWING_SIZE
		do
			create my_window.make
			
			create components.make
			create label_3.make
			create lbl_completed.make
			create label_2.make
			create label_1.make
			create lbl_value.make
			create cmd_step.make
			create prog_bar.make
			create sldr_speed.make
			create label_4.make
			create grp_behavior.make

			sldr_speed.begin_init

			my_window.set_text (("ProgressBar").to_cil)
			l_size.make_from_width_and_height (5, 13)
			my_window.set_auto_scale_base_size (l_size)
			l_size.make_from_width_and_height (506, 175)
			my_window.set_client_size_size (l_size)
			my_window.set_form_border_style (feature {WINFORMS_FORM_BORDER_STYLE}.fixed_dialog)
			my_window.set_maximize_box (False)
			my_window.set_minimize_box (False)

			l_point.make_from_x_and_y (16, 80)
			label_3.set_location (l_point)
			label_3.set_text (("Completion Speed:").to_cil)
			l_size.make_from_width_and_height (225, 16)
			label_3.set_size (l_size)
			label_3.set_tab_index (0)

			l_point.make_from_x_and_y (128, 56)
			lbl_completed.set_location (l_point)
			l_size.make_from_width_and_height (56, 16)
			lbl_completed.set_size (l_size)
			lbl_completed.set_tab_index (2)

			l_point.make_from_x_and_y (24, 56)
			label_2.set_location (l_point)
			label_2.set_text (("Percent Completed:").to_cil)
			l_size.make_from_width_and_height (112, 24)
			label_2.set_size (l_size)
			label_2.set_tab_index (1)

			l_point.make_from_x_and_y (16, 24)
			label_1.set_location (l_point)
			label_1.set_text (("Step:").to_cil)
			l_size.make_from_width_and_height (48, 16)
			label_1.set_size (l_size)
			label_1.set_tab_index (6)

			l_point.make_from_x_and_y (128, 80)
			lbl_value.set_location (l_point)
			l_size.make_from_width_and_height (56, 16)
			lbl_value.set_size (l_size)
			lbl_value.set_tab_index (4)

			l_point.make_from_x_and_y (136, 24)
			cmd_step.set_location (l_point)
			l_size.make_from_width_and_height (96, 21)
			cmd_step.set_size (l_size)
			cmd_step.set_drop_down_style (feature {WINFORMS_COMBO_BOX_STYLE}.drop_down_list)
			cmd_step.set_tab_index (7)
			cmd_step.add_selected_index_changed (create {EVENT_HANDLER}.make (Current, $cmb_step_selected_index_changed))
			create l_array.make (4)
			l_array.put (0, ("1").to_cil)
			l_array.put (1, ("5").to_cil)
			l_array.put (2, ("10").to_cil)
			l_array.put (3, ("20").to_cil)
			cmd_step.get_items.add_range (l_array)

			prog_bar.set_back_color (feature {DRAWING_SYSTEM_COLORS}.get_control)
			l_point.make_from_x_and_y (24, 24)
			prog_bar.set_location (l_point)
			prog_bar.set_tab_index (0)
			l_size.make_from_width_and_height (192, 16)
			prog_bar.set_size (l_size)
			prog_bar.set_step (1)
			prog_bar.set_text (("prog_bar").to_cil)

			sldr_speed.set_back_color (feature {DRAWING_SYSTEM_COLORS}.get_control)
			sldr_speed.set_tick_frequency (10)
			l_point.make_from_x_and_y (16, 96)
			sldr_speed.set_location (l_point)
			sldr_speed.set_tab_index (1)
			sldr_speed.set_tab_stop (False)
			sldr_speed.set_value (10)
			sldr_speed.set_maximum (100)
			l_size.make_from_width_and_height (216, 42)
			sldr_speed.set_size (l_size)
			sldr_speed.set_text (("trackBar1").to_cil)
			sldr_speed.set_minimum (10)
			sldr_speed.add_scroll (create {EVENT_HANDLER}.make (Current, $sldr_speed_scroll))

			l_point.make_from_x_and_y (24, 80)
			label_4.set_location (l_point)
			label_4.set_text (("Value:").to_cil)
			l_size.make_from_width_and_height (100, 16)
			label_4.set_size (l_size)
			label_4.set_tab_index (3)

			l_point.make_from_x_and_y (248, 16)
			grp_behavior.set_location (l_point)
			grp_behavior.set_tab_index (5)
			grp_behavior.set_tab_stop_boolean (False)
			grp_behavior.set_text (("ProgressBar").to_cil)
			l_size.make_from_width_and_height (248, 152)
			grp_behavior.set_size (l_size)
			grp_behavior.get_controls.add (cmd_step)
			grp_behavior.get_controls.add (label_1)
			grp_behavior.get_controls.add (sldr_speed)
			grp_behavior.get_controls.add (label_3)
			my_window.get_controls.add (grp_behavior)
			my_window.get_controls.add (lbl_value)
			my_window.get_controls.add (label_4)
			my_window.get_controls.add (lbl_completed)
			my_window.get_controls.add (label_2)
			my_window.get_controls.add (prog_bar)

			sldr_speed.end_init
		end


feature {NONE} -- Implementation

	dispose is
			-- method call when form is disposed.
		local
			dummy: WINFORMS_DIALOG_RESULT
		do
--			if timed_progress /= Void then
--				timed_progress.interrupt
--				timed_progress := Void
--			end

--			Precursor {WINFORMS_FORM}
			components.dispose
		end

--	on_load (e: EVENT_ARGS) is
	on_load is
			--
		local
			dummy: SYSTEM_OBJECT		
		do
			-- Spin off a new thread to update the ProgressBar control
			create timed_progress.make (create {THREAD_START}.make (Current, $timed_progress_proc))
			timed_progress.set_is_background (True)
			timed_progress.start
		end

	update_progress is
			-- This code executes on the Windows.Forms thread.
		local
			min: INTEGER
			numerator, denominator, completed: DOUBLE
		do
			-- Reset to start if required
			if prog_bar.get_value = prog_bar.get_maximum then
				prog_bar.set_value (prog_bar.get_minimum)
			else 
				prog_bar.perform_step
			end
	
			lbl_value.set_text (prog_bar.get_value.to_string)
	
			min         := prog_bar.get_minimum 
			numerator   := prog_bar.get_value - min 
			denominator := prog_bar.get_maximum - min 
			completed   := (numerator / denominator) * 100.0 
	
			--lbl_completed.set_text ((feature {MATH}.round (completed).to_string + "%"").to_cil) 
			lbl_completed.set_text ((completed.to_string_string2 (completed.to_string)))-- + "%"").to_cil)
			feature {SYSTEM_CONSOLE}.write (("titi").to_cil)
			feature {SYSTEM_CONSOLE}.write_double (completed)
		end

	timed_progress_proc is
			-- This function runs in the timed_progress thread and updates the
			-- ProgressBar on the form.
		local
			stop: BOOLEAN
			rescued: BOOLEAN
			l_mi: WINFORMS_METHOD_INVOKER
			sleep_time: INTEGER
			dummy: SYSTEM_OBJECT
		do
			if not rescued then
				feature {SYSTEM_CONSOLE}.write (("  1  ").to_cil)
				create l_mi.make (Current, $update_progress)
				feature {SYSTEM_CONSOLE}.write (("  2   ").to_cil)
				from
				until
					stop
				loop
					feature {SYSTEM_CONSOLE}.write (("  3   ").to_cil)
					dummy := my_window.invoke (l_mi)
					feature {SYSTEM_CONSOLE}.write (("  4   ").to_cil)
					sleep_time := 100
					feature {SYSTEM_CONSOLE}.write (("  5   ").to_cil)
					feature {THREAD}.sleep_integer_32 (i_sleep_time)
				end
	
				feature {SYSTEM_CONSOLE}.write (("not rescued").to_cil)
			else
				feature {SYSTEM_CONSOLE}.write (("rescued !!!!!!!!!!!").to_cil)
			end

			feature {SYSTEM_CONSOLE}.write (("timed_progress_proc").to_cil)
			
--			try {
--				MethodInvoker mi = new MethodInvoker(UpdateProgress)
--				while (true) {
--					Invoke(mi)
--					int i_sleep_time = create SleepTime
--					Thread.Sleep(i_sleep_time) 
--				}
--			}
--			//Thrown when the thread is interupted by the main thread - exiting the loop
--			catch (ThreadInterruptedException e) {
--				if (e != null) {}
--			}
--			catch (Exception we) {
--				if (we != null) {
--					MessageBox.Show(we.ToString())
--				}
--			}
		rescue
--			THREAD_INTERRUPTED_EXCEPTION
--			
			rescued := True
			-- msg_box
			retry
		end

	get_sleep_time: INTEGER is
			-- Property controlling the progress of the progress bar - used by the background thread
		do
			Result := i_sleep_time
		end
		
	set_sleep_time (a_value: INTEGER) is
			-- Property controlling the progress of the progress bar - used by the background thread
		require
			positive_value: a_value > 0
		do
			i_sleep_time := a_value
		ensure
			i_sleep_time_set: i_sleep_time = a_value	
		end

	sldr_speed_scroll (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			--
		local
			tb: WINFORMS_TRACK_BAR
			time: INTEGER
		do
			tb ?= sender 
--			if tb /= Void then
--				time := 110 - tb.get_value 
--				set_sleep_time (time)
--			end
		end

	cmb_step_selected_index_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			--
		do
--			try {
--				prog_bar.Step = Int32.Parse((string)cmd_step.SelectedItem)
--			}
--			catch (Exception ex) {
--				// thrown if Int32.Parse can't convert
--				if (ex !=null) {}
--			}
		end

end -- Class PROGRESS_BAR_CTL
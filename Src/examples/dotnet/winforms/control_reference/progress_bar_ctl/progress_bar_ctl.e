indexing
	description: ""
	
class
	PROGRESS_BAR_CTL

inherit 
	WINFORMS_FORM
		rename
			make as make_form
		undefine
			to_string, finalize, equals, get_hash_code
		redefine
			on_load,
			dispose_boolean
		end

	EXCEPTIONS

	ANY

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
			
			feature {WINFORMS_APPLICATION}.run_form (Current)
		end

feature -- Access

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
			-- Initialize all componants of the form.
		local
			l_array: NATIVE_ARRAY [SYSTEM_STRING]
			l_point: DRAWING_POINT
			l_size: DRAWING_SIZE
		do
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

			set_text (("ProgressBar").to_cil)
			l_size.make_from_width_and_height (5, 13)
			set_auto_scale_base_size (l_size)
			l_size.make_from_width_and_height (506, 175)
			set_client_size (l_size)
			set_form_border_style (feature {WINFORMS_FORM_BORDER_STYLE}.fixed_dialog)
			set_maximize_box (False)
			set_minimize_box (False)

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
			cmd_step.items.add_range (l_array)

			prog_bar.set_back_color (feature {DRAWING_SYSTEM_COLORS}.control)
			l_point.make_from_x_and_y (24, 24)
			prog_bar.set_location (l_point)
			prog_bar.set_tab_index (0)
			l_size.make_from_width_and_height (192, 16)
			prog_bar.set_size (l_size)
			prog_bar.set_step (1)
			prog_bar.set_text (("prog_bar").to_cil)

			sldr_speed.set_back_color (feature {DRAWING_SYSTEM_COLORS}.control)
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
			grp_behavior.set_tab_stop (False)
			grp_behavior.set_text (("ProgressBar").to_cil)
			l_size.make_from_width_and_height (248, 152)
			grp_behavior.set_size (l_size)
			grp_behavior.controls.add (cmd_step)
			grp_behavior.controls.add (label_1)
			grp_behavior.controls.add (sldr_speed)
			grp_behavior.controls.add (label_3)
			controls.add (grp_behavior)
			controls.add (lbl_value)
			controls.add (label_4)
			controls.add (lbl_completed)
			controls.add (label_2)
			controls.add (prog_bar)

			sldr_speed.end_init
		end


feature {NONE} -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- method called when form is disposed.
		local
			dummy: WINFORMS_DIALOG_RESULT
			retried: BOOLEAN
		do
			if not retried then
				if components /= Void then
					components.dispose	
				end
			end
			Precursor {WINFORMS_FORM}(a_disposing)
		rescue
			retried := true
			retry
		end

	on_load (e: EVENT_ARGS) is
			--
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
			if prog_bar.value = prog_bar.maximum then
				prog_bar.set_value (prog_bar.minimum)
			else 
				prog_bar.perform_step
			end
	
			lbl_value.set_text (prog_bar.value.to_string)
	
			min         := prog_bar.minimum 
			numerator   := prog_bar.value - min 
			denominator := prog_bar.maximum - min 
			completed   := (numerator / denominator) * 100.0 

			lbl_completed.set_text ((completed.out + "%%").to_cil)
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
				create l_mi.make (Current, $update_progress)
				from
				until
					stop
				loop
					dummy := invoke (l_mi)
					sleep_time := 100
					feature {THREAD}.sleep_integer (i_sleep_time)
				end
			end
		rescue
			rescued := True
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
			-- Feature performed when speed scroll is moved.
		local
			tb: WINFORMS_TRACK_BAR
			time: INTEGER
		do
			tb ?= sender 
			if tb /= Void then
				time := 110 - tb.value 
				set_sleep_time (time)
			end
		end

	cmb_step_selected_index_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- Feature performed when step selected change.
		local
			l_selected_item: SYSTEM_STRING
			l_step_string: STRING
			l_step: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				l_selected_item ?= cmd_step.selected_item
				create l_step_string.make_from_cil (l_selected_item)
				l_step := l_step_string.to_integer
				prog_bar.set_step (l_step)
			else
				prog_bar.set_step (1)
			end
		rescue
			retried := True
			retry
		end

end -- Class PROGRESS_BAR_CTL

indexing

	description: 
		"Degree messages output during compilation. %
		%By default, all output is redirected to `io'."
	date: "$Date$"
	revision: "$Revision $"

class EB_GRAPHICAL_DEGREE_OUTPUT

inherit
--	EV_DIALOG
--		redefine
--			make
--		end

	EB_SHARED_INTERFACE_TOOLS
--	WINDOW_ATTRIBUTES
	EV_COMMAND
	SHARED_ERROR_HANDLER
	DEGREE_OUTPUT
		redefine
			put_start_degree_6, put_end_degree_6, put_start_degree, 
			put_end_degree, put_melting_changes_message, put_freezing_message, 
			put_start_dead_code_removal_message, put_end_dead_code_removal_message,
			put_degree_6, put_degree_5, put_degree_4, put_degree_3, 
			put_degree_2, put_degree_1, put_degree_minus_1, 
			put_degree_minus_2, put_degree_minus_3,
			put_dead_code_removal_message, finish_degree_output,
			put_start_reverse_engineering, put_case_cluster_message,
			put_case_class_message, put_case_message, put_string,
			put_resynchronizing_breakpoints_message,
			put_class_document_message,
			put_start_documentation,
			display_degree_output
		end
	NEW_EB_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_WINDOW) is
		do
			parent := par
			create event_queue.make
		end

feature -- Start output features

	put_start_degree_6 (total_nbr: INTEGER) is
			-- Put message indicating the start of degree six
			-- with `total_nbr' passes to be done.
		local
			i_name: STRING
		do
			if not is_valid (dialog) then
				create_window
			end
			total_number := total_nbr
			current_degree := 6
			processed := 0

			degree_l.set_text (Interface_names.d_Degree)
			entity_l.set_text (Interface_names.d_Compilation_cluster)
			nbr_to_go_l.set_text (Interface_names.d_Clusters_to_go)
			current_nbr_to_go_l.set_text (total_nbr.out)
			current_degree_l.set_text (current_degree.out)
			current_entity_l.set_text (Empty_string)
			percentage_l.set_text (Zero_percent)

			popup_window
			progress_bar.set_percentage (0)
			create i_name.make (0)
			i_name.append (Interface_names.d_Degree)
			i_name.append (current_degree.out)
--			set_project_icon_name (i_name)
--			update_display
			event_queue.process
		end

	put_end_degree_6 is
			-- Put message indicating the end of degree six.
		do
			progress_bar.set_percentage (100)
			degree_l.set_text (Interface_names.d_Degree)
			update_interface (Empty_string, 0, 100)
		end

	put_start_degree (degree_nbr: INTEGER total_nbr: INTEGER) is
			-- Put message indicating the start of a degree 
			-- with `total_nbr' passes to be done.
		local
			tmp: STRING
		do
--			parent.set_title (Interface_names.d_Compilation_progress)
			total_number := total_nbr
			current_degree := degree_nbr
			processed := 0

			tmp := Interface_names.d_Degree
			if not tmp.is_equal (degree_l.text) then
				degree_l.set_text (tmp)
			end
			tmp := Interface_names.d_Compilation_class
			if not tmp.is_equal (entity_l.text) then
				entity_l.set_text (tmp)
			end
			tmp := Interface_names.d_Classes_to_go
			if not tmp.is_equal (nbr_to_go_l.text) then
				nbr_to_go_l.set_text (tmp)
			end

			current_nbr_to_go_l.set_text (total_nbr.out)
			current_degree_l.set_text (degree_nbr.out)
			current_entity_l.set_text (Empty_string)

			percentage_l.set_text (Zero_percent)
--			if not is_managed then
--				popup_window
--			end
			progress_bar.set_percentage (0)
			create tmp.make (0)
			tmp.append (Interface_names.d_Degree)
			tmp.append (current_degree.out)
--			set_project_icon_name (tmp)
			event_queue.process
		end

	put_end_degree is
			-- Put message indicating the end of a degree.
		do
			if current_degree = 3 then
				cancel_b.set_insensitive (True)
			end
			progress_bar.set_percentage (100)
			update_interface (Empty_string, 0, 100)
			total_number := 0
		end

	put_melting_changes_message  is
			-- Put message indicating that melting changes is ocurring.
		do
--			set_project_icon_name (melting_changes_message)
			put_non_degree_message (melting_changes_message)
		end

	put_freezing_message is
			-- Put message indicating that freezing is occurring.
		do
--			set_project_icon_name (freezing_system_message)
			put_non_degree_message (freezing_system_message)
			entity_l.set_text (Interface_names.d_Compilation_class)
			nbr_to_go_l.set_text (Interface_names.d_Classes_to_go)
			degree_l.set_text (Interface_names.d_Degree)
		end

	put_start_dead_code_removal_message  is
			-- Put message indicating the start of dead code removal.
		do
			processed := 0
--			set_project_icon_name (removing_dead_code_message)
			put_non_degree_message (removing_dead_code_message)
			entity_l.set_text (Interface_names.d_Features_processed)
			nbr_to_go_l.set_text (Interface_names.d_Features_to_go)
		end

	put_end_dead_code_removal_message  is
			-- Put message indicating the end of dead code removal.
		do
			put_non_degree_message (finished_removing_dead_code_message)
		end

	finish_degree_output is
			-- Process end degree output.
		do
--			if icon_name /= Void then
--				Project_tool.set_icon_name (icon_name)
--				icon_name := Void
--			end
			if is_valid (dialog) then
				dialog.destroy
			end
		end

	put_start_reverse_engineering (total_num: integer) is
			-- initialize the reverse engineering part.
		do
--			parent.set_title (Interface_names.d_Reverse_engineering)
--			icon_name := Project_tool.icon_name	
			total_number := total_num
			processed := 0
			degree_l.set_text (Interface_names.d_Compilation_cluster)
			entity_l.set_text (Interface_names.d_Compilation_class)
			nbr_to_go_l.set_text (Interface_names.d_Classes_to_go)
			current_nbr_to_go_l.set_text (total_num.out)
			current_entity_l.set_text (Empty_string)
--			set_project_icon_name (Interface_names.d_Reverse_engineering)
		end

	put_start_documentation (total_num: INTEGER; type: STRING) is
			-- Initialize the document generation.
		do
			total_number := total_num
			processed := 0
			dialog.show
--			parent.set_title (Interface_names.d_Documentation) 
--			icon_name := Project_tool.icon_name	
			total_number := total_num
			processed := 0
			degree_l.set_text (Interface_names.d_Generating)
			current_degree_l.set_text (type)
			entity_l.set_text (Interface_names.d_Compilation_class)
			nbr_to_go_l.set_text (Interface_names.d_Classes_to_go)
			current_nbr_to_go_l.set_text (total_num.out)
			current_entity_l.set_text (Empty_string)
--			if not is_managed then	
				popup_window
--			end
			cancel_b.set_insensitive (True)
			progress_bar.set_percentage (0)
--			set_project_icon_name (Interface_names.d_Documentation)
		end

	put_case_message (a_message: STRING) is
			-- Put `a_message' to the output window.
		do
			if not is_valid (dialog) then	
				create_window
				degree_l.set_text (Empty_string)
				degree_l.set_text (Empty_string)
				entity_l.set_text (Empty_string)
				nbr_to_go_l.set_text (Empty_string)
				current_nbr_to_go_l.set_text (Empty_string)
				current_degree_l.set_text (Empty_string)
				current_entity_l.set_text (Empty_string)
				percentage_l.set_text (Zero_percent)
			end
--			if not is_managed then	
--				popup_window
--			end
			put_non_degree_message (a_message)
		end

	put_resynchronizing_breakpoints_message is
			-- Put a message to indicate that the
			-- breakpoints are being resyncronized.
		do
			put_non_degree_message (Interface_names.d_Resynchronizing_breakpoints)
		end

feature -- Output on per class

	put_degree_6 (a_cluster: CLUSTER_I) is
			-- Put message to indicate that `a_cluster' is being
			-- compiled during degree six' clusters to go. 
		local
			a_per: INTEGER
			nbr_of_clusters: INTEGER
		do
			nbr_of_clusters := total_number - processed
			a_per := percentage_calculation (nbr_of_clusters)

			progress_bar.set_percentage (a_per)
			update_interface (a_cluster.cluster_name, nbr_of_clusters, a_per)
			processed := processed + 1
		end

	put_degree_5, put_degree_4 (a_class: CLASS_C nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during a degree four and five pass with `nbr_to_go' 
			-- classes to go.
		local
			a_per: INTEGER
		do
			total_number := nbr_to_go + processed
			a_per := percentage_calculation (nbr_to_go)
			progress_bar.set_percentage (a_per)
			update_interface (a_class.name_in_upper, nbr_to_go, a_per)
			processed := processed + 1
		end

	put_degree_3 (a_class: CLASS_C nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during a degree pass with `nbr_to_go'
			-- classes to go.
		local
			a_per: INTEGER
		do
			processed := processed + 1 -- Used when error ocurrs
				-- Could not call put_degree_2 or other degrees even
				-- though it is doing the same here because of
				-- the precondition.
			a_per := percentage_calculation (nbr_to_go)
			progress_bar.set_percentage (a_per)
			update_interface (a_class.name_in_upper, nbr_to_go, a_per)
		end

	put_degree_2,
	put_degree_1, 
	put_degree_minus_1, 
	put_degree_minus_2, 
	put_degree_minus_3 (a_class: CLASS_C nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during a degree pass with `nbr_to_go' 
			-- classes to go.
		local
			a_per: INTEGER
		do
			a_per := percentage_calculation (nbr_to_go)
			progress_bar.set_percentage (a_per)
			update_interface (a_class.name_in_upper, nbr_to_go, a_per)
		end

	put_dead_code_removal_message (features_done, nbr_to_go: INTEGER) is
			-- Put message progress of dead code removal with
			-- `features_done' in last cycle with `nbr_to_go'
			-- features to go.
		local
			a_per: INTEGER
		do
			processed := features_done + processed
			total_number := processed + nbr_to_go
			a_per := percentage_calculation (nbr_to_go)
			progress_bar.set_percentage (a_per)
			update_interface (processed.out, nbr_to_go, a_per)
		end

	put_case_cluster_message (a_name: STRING) is
			-- Put message to indicate that `a_name' is being
			-- analyzed.
		local
			str: STRING
		do
			str := clone (a_name)
			str.to_lower
			current_degree_l.set_text (str)
			event_queue.process
		end

	put_case_class_message, put_class_document_message (a_class: CLASS_C) is
			-- Put message to indicate that `a_class' is being
			-- generated for documentation.
		local
			to_go, a_per: INTEGER
		do
			to_go := total_number - processed
			a_per := percentage_calculation (to_go)
			processed := processed + 1
			progress_bar.set_percentage (a_per)
			update_interface (a_class.name_in_upper, to_go, a_per)
		end

	display_degree_output (deg_nbr: STRING to_go: INTEGER; total: INTEGER) is
			-- Update the interface.
		local
			a_per_out: STRING
			a_per: INTEGER
		do
			total_number := total
			put_string (deg_nbr)
			a_per := percentage_calculation (to_go)
			a_per_out := a_per.out
			a_per_out.extend ('%%')
			percentage_l.set_text (a_per_out)

			progress_bar.set_percentage (a_per)

			event_queue.process
		end

feature {NONE} -- Implementation

	update_interface (a_name: STRING nbr_to_go: INTEGER; a_per: INTEGER) is
			-- Update the interface for entity `a_name' with `nbr_to_go'
			-- and `a_per' done.
		local
			a_per_out: STRING
		do
			current_nbr_to_go_l.set_text (nbr_to_go.out)
			current_entity_l.set_text (a_name)
			a_per_out := a_per.out
			a_per_out.extend ('%%')
			percentage_l.set_text (a_per_out)

			event_queue.process
		end

	put_string (a_message: STRING) is
			-- Put `a_message' to output window.
		do
			if not is_valid (dialog) then 
				create_window
			end
			put_non_degree_message (a_message)
		end

	put_non_degree_message (a_message: STRING) is
			-- Put a non degree message.
		require
			valid_message: a_message /= Void
		do
			if not destroyed then
				degree_l.set_text (a_message)
				current_degree_l.set_text (Empty_string)
				entity_l.set_text (Empty_string)
				nbr_to_go_l.set_text (Empty_string)
				current_nbr_to_go_l.set_text (Empty_string)
				current_entity_l.set_text (Empty_string)
				percentage_l.set_text (Zero_percent)

--				if not is_managed then
--					popup_window
--				end
				progress_bar.set_percentage (0)

				event_queue.process
			end
		end

feature {NONE} -- Implementation

	dialog: EV_DIALOG

	event_queue: EV_EVENTS_QUEUE

	parent: EV_WINDOW

--	icon_name: STRING
			-- Icon name of project tool

	Zero_percent: STRING is "0%%"

	Empty_string: STRING is "  "

	finished_removing_dead_code_message: STRING is
				"Removing dead code completed"

	degree_l: EV_LABEL
			-- Degree: label

	entity_l: EV_LABEL
			-- Class/Cluster: label

	nbr_to_go_l: EV_LABEL
			-- Number of entities to go: label

	current_degree_l: EV_LABEL
			-- Label indicating current degree

	current_entity_l: EV_LABEL
			-- Label indicating current class/cluster

	current_nbr_to_go_l: EV_LABEL
			-- Label indicating number of entities to go

	progress_bar: EV_HORIZONTAL_PROGRESS_BAR
			-- Progress bar indicating percentage done

	percentage_l: EV_LABEL
			-- Percentage label

	cancel_b: EV_BUTTON
			-- Cancel button

	create_window is
			-- Create the compilation progress window.
		require
			dialog_non_valid: not is_valid (dialog)
		local
			frame: EV_FRAME
			hbox: EV_HORIZONTAL_BOX
		do
--			icon_name := Project_tool.icon_name
			create dialog.make (parent)
			dialog.set_title (Interface_names.d_Compilation_progress)

			create hbox.make (dialog.display_area)
			create degree_l.make (hbox)
			degree_l.set_left_alignment
			hbox.set_child_expandable (degree_l, False)
			create current_degree_l.make (hbox)
			current_degree_l.set_left_alignment

			create hbox.make (dialog.display_area)
			create entity_l.make (hbox)
			entity_l.set_left_alignment
			hbox.set_child_expandable (entity_l, False)
			create current_entity_l.make (hbox)
			current_entity_l.set_left_alignment

			create hbox.make (dialog.display_area)
			create nbr_to_go_l.make (hbox)
			nbr_to_go_l.set_left_alignment
			hbox.set_child_expandable (nbr_to_go_l, False)
			create current_nbr_to_go_l.make (hbox)
			current_nbr_to_go_l.set_left_alignment

			create frame.make (dialog.display_area)
			create progress_bar.make (frame)
			create cancel_b.make_with_text (dialog.action_area, "Cancel")
			cancel_b.add_click_command (Current, Void)
			create percentage_l.make_with_text (dialog.display_area, "100%%")

			dialog.show
--			update_resources
		end

	update_resources is
			-- Update the font/color of progress window.
		local
--			imp: EV_COLOR_IMP
--			font_x: EV_FONT_IMP
--			bg_color, fg_color: EV_COLOR
--			global_font: EV_FONT
		do
--			bg_color := Graphical_resources.background_color.actual_value
--			fg_color := Graphical_resources.foreground_color.actual_value
--			global_font := Graphical_resources.font.actual_value
--			if bg_color /= Void then
--				imp ?= bg_color.implementation
--				set_background_color (imp)
--				cancel_b.set_background_color (imp)
--				progress_bar.set_background_color (imp)
--			end
--			if fg_color /= Void then
--				imp ?= fg_color.implementation
--				set_foreground_color (imp)
--				cancel_b.set_foreground_color (imp)
--			end
--			if global_font /= Void then
--				font_x ?= global_font.implementation
--				a_font_list := font_x.font_list
--				if a_font_list.is_valid then
--					degree_l.set_font_list (a_font_list)
--					entity_l.set_font_list (a_font_list)
--					nbr_to_go_l.set_font_list (a_font_list)
--					current_degree_l.set_font_list (a_font_list)
--					current_entity_l.set_font_list (a_font_list)
--					percentage_l.set_font_list (a_font_list)
--					cancel_b.set_font_list (a_font_list)
--					a_font_list.destroy
--				else
--					io.error.putstring ("Warning can not allocate font%N")
--
--				end
--			end
		end

--	set_project_icon_name (message: STRING) is
--			-- Set icon name of project_tool to `message'.
--		require
--			valid_icon_name: icon_name /= Void
--		local
--			i_name: STRING
--		do
--			if icon_name /= Void then
--				i_name := clone (icon_name)
--			else
--				i_name := clone (Project_tool.icon_name)
--			end
--			i_name.append (": ")
--			i_name.append (message)
--			Project_tool.set_icon_name (i_name)
--		end

	popup_window is
			-- Popup the window.
		local
--			cursor_imp: SCREEN_CURSOR_IMP
--			mp: MOUSE_PTR
			new_x, new_y: INTEGER
			p: EV_CONTAINER
		do
			cancel_b.set_insensitive (False)
--			create mp.do_nothing
--			p := parent.parent
--			new_x := p.x + (p.width - width) // 2
--			new_y := p.y + (p.height - height) // 2
--			set_x_y (new_x, new_y)
--			manage
--			parent.set_max_height (height)
--			parent.set_max_width (width)
--			parent.set_min_height (height)
--			parent.set_min_width (width)
--			cursor_imp ?= mp.watch_cursor.implementation
--			define_cursor (cursor_imp)
			dialog.show
		end

--	process_events is
--			-- Process all available events in the queue.
--		local
--			event: MEL_EVENT
--			app: like app_context
--			mask: INTEGER
--		do
--			update_display
--			app := app_context
--			from
--				mask := app.pending
--			until
--				mask = 0
--			loop
--					-- Dispatch the event
--				app.process_event (mask)
--					-- Get the next event in queue, if any.
--				mask := app.pending
--			end
--		end

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Cancel the compilation.
		do
			cancel_b.set_insensitive (True)
			Error_handler.insert_interrupt_error (True)
		end

	destroyed: BOOLEAN is
		do
			Result := dialog.destroyed
		end


	is_valid (x: EV_ANY): BOOLEAN is
		do
			Result := x /= void and then not x.destroyed
		end


end -- class EB_GRAPHICAL_DEGREE_OUTPUT

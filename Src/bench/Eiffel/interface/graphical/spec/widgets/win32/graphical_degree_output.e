indexing
	description:
		"Degree messages output during compilation. %
		%By default, all output is redirected to `io'."
	date: "$Date$"
	revision: "$Revision $"

class GRAPHICAL_DEGREE_OUTPUT

inherit
	DEGREE_OUTPUT
		redefine
			put_start_degree_6, put_end_degree_6, put_degree_6,
			put_recursive_degree_6,
			put_start_degree, put_end_degree, put_degree_5,
			put_degree_4, put_degree_3, put_degree_2,
			put_degree_1, put_degree_minus_1, put_degree_minus_2,
			put_degree_minus_3, put_melting_changes_message,
			put_freezing_message, finish_degree_output,
			put_start_dead_code_removal_message,
			put_end_dead_code_removal_message,
			put_dead_code_removal_message,
			put_case_cluster_message,
			put_case_class_message, put_string,
			put_resynchronizing_breakpoints_message,
			put_class_document_message,
			put_start_documentation,
			put_initializing_documentation,
			display_degree_output
		end

	WEL_MODELESS_DIALOG
		redefine
			setup_dialog, on_cancel
		end

	EB_CONSTANTS

	WINDOWS

	SHARED_ERROR_HANDLER

feature -- Initialize `parent' of dialog

	set_parent_window (wel_parent: BASE_I) is
			-- Set `parent' to `wel_parent'.
		do
			parent ?= wel_parent
		end

feature -- Start output

	put_start_degree_6 (total_nbr: INTEGER) is
			-- Put message indicating the start of degree six
			-- with `total_nbr' passes to be done.
		local
			tmp: STRING
		do
			if not exists then
				create_window
			end
			cancel_b.enable
			total_number := total_nbr
			processed := 0
			current_degree := 6

			degree_text.set_width (saved_width)
			degree_text.set_text (Interface_names.d_Degree)
			entity_text.set_text (Interface_names.d_Compilation_cluster)
			nbr_to_go_text.set_text (Interface_names.d_Clusters_to_go)
			current_degree_text.set_text (current_degree.out)
			current_entity_text.set_text (Empty_string)
			current_nbr_to_go_text.set_text (total_nbr.out)
			percentage_text.set_text (Zero_percent)

			!! tmp.make (0)
			tmp.append (Interface_names.d_Degree)
			tmp.append (current_degree.out)
			set_project_icon_name (tmp)

			process_messages
		end

	put_start_degree (degree_nbr: INTEGER total_nbr: INTEGER) is
			-- Put message indicating the start of a degree
			-- with `total_nbr' to be done.
		local
			tmp: STRING
		do
			set_text (Interface_names.d_Compilation_progress)
			total_number := total_nbr
			current_degree := degree_nbr
			processed := 0

			degree_text.set_width (saved_width)
			degree_text.set_text (Interface_names.d_Degree)

			entity_text.set_text (Interface_names.d_Compilation_class)
			nbr_to_go_text.set_text (Interface_names.d_Classes_to_go)

			current_nbr_to_go_text.set_text (total_nbr.out)
			current_degree_text.set_text (degree_nbr.out)
			current_entity_text.set_text (Empty_string)

			percentage_text.set_text (Zero_percent)
			progress_bar.set_position (0)
			!! tmp.make (0) 
			tmp.append (Interface_names.d_Degree)
			tmp.append (current_degree.out)
			set_project_icon_name (tmp)

			if current_degree = 2 then
					-- Cannot cancel a compilation after end of degree 3
					-- because we do not save a compilation context after.
				cancel_b.disable
			elseif current_degree = -2 then
					-- A finalization can be stopped at any time since it implies
					-- to always recompile everything all the time.
				cancel_b.enable
			end

			process_messages
		end

	put_melting_changes_message is
			-- Put message indicating that the changes
			-- are being melted.
		do
			set_project_icon_name (melting_changes_message)
			put_non_degree_message (melting_changes_message)

			process_messages
		end

	put_freezing_message is
			-- Put message indicating that the system is
			-- being frozen.
		do
			set_project_icon_name (freezing_system_message)
			put_non_degree_message (freezing_system_message)

			process_messages
		end

	put_start_dead_code_removal_message is
			-- Put message indicating the start of dead code removal.
		do
			processed := 0

			set_project_icon_name (removing_dead_code_message)
			put_non_degree_message (removing_dead_code_message)
			entity_text.set_text (Interface_names.d_Features_processed)
			nbr_to_go_text.set_text (Interface_names.d_Features_to_go)

			process_messages
		end

	put_initializing_documentation is
			-- Start documentation generation.
		do
			put_string ("Initializing")
		end

	put_start_documentation (total_num: INTEGER type: STRING) is
			-- Initialize the reverse engineering part.
		do
			if not exists then
				create_window
			end
			set_text (Interface_names.d_Documentation)
			icon_name := Project_tool.icon_name
			total_number := total_num
			processed := 0

			degree_text.set_text (Interface_names.d_Generating)
			entity_text.set_text (Interface_names.d_Compilation_class)
			nbr_to_go_text.set_text (Interface_names.d_Classes_to_go)
			current_degree_text.set_text (type)
			current_nbr_to_go_text.set_text (total_num.out)
			current_entity_text.set_text (Empty_string)

			progress_bar.set_position (0)

			process_messages
		end

	put_resynchronizing_breakpoints_message is
			-- Put a message to indicate that the
			-- breakpoints are being resynchronized.
		do
			put_non_degree_message (Interface_names.d_Resynchronizing_breakpoints)
		end

feature -- End output

	put_end_degree_6 is
			-- Put message indicating the end of degree six.
		do
			current_degree := 0
			processed := 0
			update_interface (Empty_string, 0, 100)
			progress_bar.set_position (0)
			total_number := 0

			process_messages
		end

	put_end_degree is
			-- Put message indeicating the end of `current_degree'.
		do
			current_degree := 0
			update_interface (Empty_string, 0, 100)
			progress_bar.set_position (100)
			total_number := 0

			process_messages
		end

	finish_degree_output is
			-- Process end degree output.
		do
			if icon_name /= Void then
				Project_tool.set_icon_name (icon_name)
			end

			if exists then
				hide
				destroy
			end

			process_messages
		end

	put_end_dead_code_removal_message is
			-- Put message indicating the end of dead code removal.
		do
			set_project_icon_name (finished_removing_dead_code_message)

			process_messages
		end

feature -- Per entity output

	put_degree_6 (a_cluster: CLUSTER_SD; nbr_to_go: INTEGER) is
			-- Put message to indicate that a_cluster' is being
			-- compiled during degree six.
		local
			a_per: INTEGER
		do
			total_number := nbr_to_go + processed
			a_per := percentage_calculation (nbr_to_go)
			update_interface (a_cluster.cluster_name, nbr_to_go, a_per)
			progress_bar.set_position (a_per)
			processed := processed + 1

			process_messages
		end

	put_recursive_degree_6 (a_cluster: CLUSTER_I; a_path: STRING) is
			-- Put message to indicate that `a_cluster' is being compiled
			-- during degree six and that it is a recursive cluster so we have
			-- to display the path too.
		local
			a_per: INTEGER
			nbr_of_clusters: INTEGER
			l_path: STRING
			cluster_name, output_string: STRING
		do
			nbr_of_clusters := total_number - processed
			a_per := percentage_calculation (nbr_of_clusters)

			cluster_name := a_cluster.cluster_name
			if cluster_name.count + a_path.count > 40 then
				l_path := clone(a_path)
				l_path.head (12)
				output_string := clone (cluster_name) + " in " + l_path
				l_path := clone(a_path)
				l_path.tail (15)
				output_string.append ("..." + l_path)
			else
				output_string := clone (cluster_name) + " in " + a_path
			end

			update_interface (output_string, nbr_of_clusters, a_per)

			process_messages
		end

	put_degree_5, put_degree_4 (a_class: CLASS_C nbr_to_go: INTEGER) is
			-- Put message indicating that `a_class' is being
			-- compiled during `current_degree' with `nbr_to_go'
			-- classes to go.
		local
			a_per: INTEGER
		do
			total_number := nbr_to_go + processed
			a_per := percentage_calculation (nbr_to_go)
			update_interface (a_class.name_in_upper, nbr_to_go, a_per)
			progress_bar.set_position (a_per)
			processed := processed + 1

			process_messages
		end

	put_degree_3 (a_class: CLASS_C nbr_to_go: INTEGER) is
			-- Put message to inidcate that `a_class' is_being
			-- compiled during `current_degree' with `nbr_to_go'
			-- classes to go.
		local
			a_per: INTEGER
		do
			processed := processed + 1
			a_per := percentage_calculation (nbr_to_go)

			update_interface (a_class.name_in_upper, nbr_to_go, a_per)
			progress_bar.set_position (a_per)

			process_messages
		end

	put_degree_2,
	put_degree_1,
	put_degree_minus_1,
	put_degree_minus_2,
	put_degree_minus_3 (a_class: CLASS_C nbr_to_go: INTEGER) is
			-- Put message to inidcate that `a_class' is_being
			-- compiled during `current_degree' with `nbr_to_go'
			-- classes to go.
		local
			a_per: INTEGER
		do
			a_per := percentage_calculation (nbr_to_go)

			update_interface (a_class.name_in_upper, nbr_to_go, a_per)
			progress_bar.set_position (a_per)

			process_messages
		end

	put_dead_code_removal_message (features_done, nbr_to_go: INTEGER) is
			-- Put message progress of dead code removal with
			-- `features_done' in last cycle with `nbr_to_go'
			-- features to go.
		local
			a_per: INTEGER
		do
			processed := processed + features_done
			total_number := nbr_to_go + processed
			a_per := percentage_calculation (nbr_to_go)
			update_interface (processed.out, nbr_to_go, a_per)
			progress_bar.set_position (a_per)

			process_messages
		end

	put_case_cluster_message (a_name: STRING) is
			-- Put message to indicate that `a_name' is being
			-- analyzed.
		local
			str: STRING
		do
			str := clone (a_name)
			str.to_lower
			current_degree_text.set_text (str)

			process_messages
		end

	put_class_document_message, put_case_class_message (a_class: CLASS_C) is
			-- Put message to indicate that `a_class' is being
			-- analyzed for ECase.
		local
			a_per: INTEGER
			to_go: INTEGER
		do
			to_go := total_number - processed
			a_per := percentage_calculation (to_go)
			processed := processed + 1
			progress_bar.set_position (a_per)
			update_interface (a_class.name_in_upper, to_go, a_per)

			process_messages
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
			a_per_out.append (" %%")
			percentage_text.set_text (a_per_out)

			progress_bar.set_position (a_per)

			process_messages
		end

feature {NONE} -- Implementation

	create_window is
			-- Create the dialog box.
		require
			parent_defined: parent /= Void
		do
			icon_name := Project_tool.icon_name
			make_by_id (parent, Dlg_graphical_degree_output)
			!! progress_bar.make_by_id (Current, Prg_compilation_progress)
			!! degree_text.make_by_id (Current, Txt_degree)
			!! entity_text.make_by_id (Current, Txt_entity)
			!! cancel_b.make_by_id (Current, Idcancel)
			!! nbr_to_go_text.make_by_id (Current, Txt_nbr_to_go)
			!! current_degree_text.make_by_id (Current, Txt_current_degree)
			!! current_entity_text.make_by_id (Current, Txt_current_entity)
			!! current_nbr_to_go_text.make_by_id (Current, Txt_current_nbr_to_go)
			!! percentage_text.make_by_id (Current, Txt_percentage)

			activate
			set_text (Interface_names.d_Compilation_progress)
		end

	update_interface (a_name: STRING nbr_to_go: INTEGER; a_per: INTEGER) is
			-- Update the interface for entity `a_name' with `nbr_to_go'
			-- and `a_per' done.
		local
			a_per_out: STRING
		do
			current_nbr_to_go_text.set_text (nbr_to_go.out)
			current_entity_text.set_text (a_name)
			a_per_out := a_per.out
			a_per_out.append (" %%")
			percentage_text.set_text (a_per_out)
		end

	put_string (a_message: STRING) is
			-- Put `a_message' in the output window.
		do
			--VISIONLITE
			if not exists then
				create_window
			end
			--VISIONLITE
			put_non_degree_message (a_message)
		end

	put_non_degree_message (a_msg: STRING) is
			-- Put `a_msg' in Current.
		require
			valid_message: a_msg /= Void
		do
			if exists then
				progress_bar.set_position (0)
				saved_width := degree_text.width
				degree_text.resize (width, degree_text.height)
				current_degree_text.set_text (Empty_string)
				nbr_to_go_text.set_text (Empty_string)
				current_nbr_to_go_text.set_text (Empty_string)
				entity_text.set_text (Empty_string)
				current_entity_text.set_text (Empty_string)
				percentage_text.set_text (Empty_string)
				degree_text.set_text (a_msg)
			end
		end

	set_project_icon_name (msg: STRING) is
			-- Set icon name of `Project_tool' to `msg'.
		require
			valid_icon_name: icon_name /= Void
		local
			i_name: STRING
		do
			i_name := clone (icon_name)
			i_name.append (": ")
			i_name.append (msg)
			Project_tool.set_icon_name (i_name)
		end

	setup_dialog is
			-- Setting up Current.
		do
			progress_bar.set_range (0, 100)
			progress_bar.set_step (5)
			progress_bar.set_position (0)

			saved_width := degree_text.width
		end

	process_messages is
			-- Process messages in the msg queue of current app.
		do
			from
				win_msg.peek_all
			until
				not win_msg.last_boolean_result
			loop
				if win_msg.last_boolean_result then
					win_msg.translate
					win_msg.dispatch
				end
				win_msg.peek_all
			end
		end

feature {NONE} -- Dialog IDs found in the resource files

	Dlg_graphical_degree_output: INTEGER is 101
	Prg_compilation_progress: INTEGER is 1000
	Txt_degree: INTEGER is 1001
	Txt_entity: INTEGER is 1002
	Txt_current_degree: INTEGER is 1003
	Txt_current_entity: INTEGER is 1005
	Txt_percentage: INTEGER is 3019
	Txt_nbr_to_go: INTEGER is 1004
	Txt_current_nbr_to_go: INTEGER is 1006

feature {NONE} -- Properties

	finished_removing_dead_code_message: STRING is "Removing dead code completed"

	Zero_percent: STRING is "0%%   "

	Empty_string: STRING is "    "

	icon_name: STRING
			-- Name of the icon for the Project tool.

	saved_width: INTEGER
			-- Saved width of `degree_text' when used for `non_degree_messages'

	win_msg: WEL_MSG is
			-- Used by `process_messages'
		once
			!! Result.make
		end

feature {NONE} -- Windows Message Handlers

	on_cancel is
			-- Button Cancel has been pressed between degree 6 and degree 3.
			-- We generate an exception that will be catch later by the rescue clause
			-- in the compiler.
		do
			Error_handler.insert_interrupt_error (True)
		end

feature {NONE} -- User Interface Objects

	cancel_b: WEL_PUSH_BUTTON
	progress_bar: WEL_PROGRESS_BAR
	degree_text,
	entity_text,
	nbr_to_go_text,
	current_degree_text,
	current_entity_text,
	current_nbr_to_go_text,
	percentage_text: WEL_STATIC

end -- class GRAPHICAL_DEGREE_OUTPUT


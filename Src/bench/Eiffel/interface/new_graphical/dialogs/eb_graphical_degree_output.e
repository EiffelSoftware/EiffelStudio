indexing
	description: 
		"Grahical version of degree output by compiler or documentation."
	date: "$Date$"
	revision: "$Revision $"

class
	EB_GRAPHICAL_DEGREE_OUTPUT

inherit
	EB_SHARED_WINDOW_MANAGER

	EB_CONSTANTS

	DEGREE_OUTPUT
		redefine
			put_start_degree_6, put_end_degree_6, put_start_degree, 
			put_end_degree, put_melting_changes_message, put_freezing_message, 
			put_start_dead_code_removal_message, put_end_dead_code_removal_message,
			put_degree_6, put_degree_5, put_degree_4, put_degree_3, 
			put_degree_2, put_degree_1, put_degree_minus_1, 
			put_degree_minus_2, put_degree_minus_3,
			put_dead_code_removal_message, finish_degree_output,
			put_case_cluster_message,
			put_case_class_message, put_string,
			put_resynchronizing_breakpoints_message,
			put_class_document_message,
			put_start_documentation,
			put_new_compilation,
			display_degree_output,
			put_initializing_documentation
		end

create
	make_with_dialog

feature {NONE} -- Initialization

	make_with_dialog (a_dialog: like dialog) is
			-- Create with `a_dialog'.
		do
			dialog := a_dialog
		end

feature -- Start output features

	put_start_degree_6 (total_nbr: INTEGER) is
			-- Put message indicating the start of degree six
			-- with `total_nbr' passes to be done.
		do
			dialog.set_title (Interface_names.d_Compilation_progress)

			total_number := total_nbr
			current_degree := 6
			last_reached_degree := 6
			processed := 0

			dialog.set_degree (Interface_names.d_Degree)
			dialog.set_current_compilation_degree (current_degree)
			dialog.set_entity (Interface_names.d_Compilation_cluster)
			dialog.set_current_entity (Empty_string)
			dialog.set_to_go_label (Interface_names.d_Clusters_to_go)
			dialog.set_to_go (total_nbr.out)

			dialog.enable_cancel
			dialog.set_icon_name (Interface_names.d_Degree + " " + current_degree.out)
			dialog.start (100)
		end

	put_end_degree_6 is
			-- Put message indicating the end of degree six.
		do
			dialog.set_degree (Interface_names.d_Degree)
			update_interface (Empty_string, 0, 100)
		end

	put_start_degree (degree_nbr: INTEGER total_nbr: INTEGER) is
			-- Put message indicating the start of a degree 
			-- with `total_nbr' passes to be done.
		do
			dialog.set_title (Interface_names.d_Compilation_progress)

			total_number := total_nbr
			current_degree := degree_nbr
			last_reached_degree := degree_nbr
			processed := 0

			dialog.set_degree (Interface_names.d_Degree)
			dialog.set_entity (Interface_names.d_Compilation_class)
			dialog.set_to_go_label (Interface_names.d_Classes_to_go)
			dialog.set_to_go (total_nbr.out)
			dialog.set_current_compilation_degree (degree_nbr)
			dialog.set_current_entity (Empty_string)

			dialog.set_icon_name (Interface_names.d_Degree + " " + current_degree.out)
			if current_degree = 2 then
					-- Cannot cancel a compilation after end of degree 3
					-- because we do not save a compilation context after.
				dialog.disable_cancel
			elseif current_degree = -2 or current_degree = 5 then
					-- A finalization can be stopped at any time since it implies
					-- to always recompile everything all the time.
					-- Added the enabling at degree 5 for the quick compile command.
				dialog.enable_cancel
			end
			dialog.start (100)
		end

	put_new_compilation is
			-- A new compilation has begun.
		do
			last_reached_degree := 6
		end

	put_end_degree is
			-- Put message indicating the end of a degree.
		do
			update_interface (Empty_string, 0, 100)
			total_number := 0
		end

	put_melting_changes_message  is
			-- Put message indicating that melting changes is ocurring.
		do
			dialog.set_icon_name (melting_changes_message)
			put_non_degree_message (melting_changes_message)
		end

	put_freezing_message is
			-- Put message indicating that freezing is occurring.
		do
			dialog.set_icon_name (freezing_system_message)
			put_non_degree_message (freezing_system_message)
			dialog.set_entity (Interface_names.d_Compilation_class)
			dialog.set_to_go_label (Interface_names.d_Classes_to_go)
			dialog.set_degree (Interface_names.d_Degree)
		end

	put_start_dead_code_removal_message  is
			-- Put message indicating the start of dead code removal.
		do
			dialog.disable_cancel
			processed := 0
			dialog.set_icon_name (removing_dead_code_message)
			put_non_degree_message (removing_dead_code_message)
			dialog.set_entity (Interface_names.d_Features_processed)
			dialog.set_to_go_label (Interface_names.d_Features_to_go)
		end

	put_end_dead_code_removal_message  is
			-- Put message indicating the end of dead code removal.
		do
			put_non_degree_message (Interface_names.d_Finished_removing_dead_code)
		end

	finish_degree_output is
			-- Process end degree output.
		do
			dialog.hide
		end

	put_initializing_documentation is
			-- Start documentation generation.
		do
			dialog.set_title (Interface_names.d_Documentation)
			put_non_degree_message ("Initializing")
		end

	put_start_documentation (total_num: INTEGER; type: STRING) is
			-- Initialize the document generation.
		do
			dialog.set_title (Interface_names.d_Documentation)

			total_number := total_num
			processed := 0

			total_number := total_num
			processed := 0
			dialog.set_degree (Interface_names.d_Generating)
			dialog.set_current_degree (type)
			dialog.set_entity (Interface_names.d_Compilation_class)
			dialog.set_to_go_label (Interface_names.d_Classes_to_go)
			dialog.set_to_go (total_num.out)
			dialog.set_current_entity (Empty_string)

			dialog.enable_cancel
			dialog.set_icon_name (Interface_names.d_Documentation)
			dialog.start (100)
		end

	put_case_message (a_message: STRING) is
			-- Put `a_message' to the output window.
		do
			dialog.show
			dialog.set_message (a_message)
		end

	put_resynchronizing_breakpoints_message is
			-- Put a message to indicate that the
			-- breakpoints are being resyncronized.
		do
			put_non_degree_message (Interface_names.d_Resynchronizing_breakpoints)
		end

feature -- Output on per class

	put_degree_6 (a_cluster: CLUSTER_SD; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_cluster' is being
			-- compiled during degree six' clusters to go. 
		local
			a_per: INTEGER
		do
			total_number := nbr_to_go + processed
			a_per := percentage_calculation (nbr_to_go)
			update_interface (a_cluster.cluster_name, nbr_to_go, a_per)
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
			dialog.set_current_degree (str)
			dialog.graphical_update
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
			update_interface (a_class.name_in_upper, to_go, a_per)
		end

	display_degree_output (deg_nbr: STRING to_go: INTEGER; total: INTEGER) is
			-- Update the interface.
		local
			a_per: INTEGER
		do
			total_number := total
			put_string (deg_nbr)
			a_per := percentage_calculation (to_go)
			dialog.set_value (a_per)
		end

feature {NONE} -- Implementation

	update_interface (a_name: STRING nbr_to_go: INTEGER; a_per: INTEGER) is
			-- Update the interface for entity `a_name' with `nbr_to_go'
			-- and `a_per' done.
		do
			dialog.set_to_go (nbr_to_go.out)
			dialog.set_current_entity (a_name)
			dialog.set_value (a_per)
		end

	put_string (a_message: STRING) is
			-- Put `a_message' to output window.
		do
			put_non_degree_message (a_message)
		end

	put_non_degree_message (a_message: STRING) is
			-- Put a non degree message.
		require
			valid_message: a_message /= Void
		do
			dialog.show
			dialog.set_message (a_message)
			dialog.set_value (0)
		end

feature {NONE} -- Implementation

	dialog: EB_PROGRESS_DIALOG
			-- Shared graphical object.

	Empty_string: STRING is " "
			-- Used to remove text from labels.

end -- class EB_GRAPHICAL_DEGREE_OUTPUT

note
	description: "Grid item to display external command criterion in grid"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_COMMAND_CRITERION_GRID_ITEM

inherit
	EB_METRIC_CRITERION_GRID_ITEM [EB_METRIC_EXTERNAL_COMMAND_CRITERION]
		undefine
			default_create,
			is_equal,
			copy
		end

	DIALOG_PROPERTY [
		TUPLE [command: STRING; working_directory: STRING; input: STRING; input_as_file: BOOLEAN;
			   output: STRING; output_enabled: BOOLEAN; output_as_file: BOOLEAN;
			   error: STRING; error_enabled: BOOLEAN; error_as_file: BOOLEAN; error_redirected_to_output: BOOLEAN;
			   exit_code: INTEGER; exit_code_enabled: BOOLEAN
		]]
		rename
			make as property_make
		redefine
			convert_to_data
		end

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize.
		local
			l_value: like value
		do
			l_value := safe_value

			create property_dialog
			property_dialog.set_value (l_value)
			property_dialog.data_change_actions.extend (agent set_value)

			make_with_dialog ("", property_dialog)
			set_display_agent (agent display_value_agent)
			set_value (l_value)
			enable_text_editing
			set_tooltip (metric_names.f_insert_text_here)
		end

feature -- Access

	grid_item: EV_GRID_ITEM
			-- Grid item for Current property
		do
			Result := Current
		end

feature -- Setting

	load_criterion (a_criterion: EB_METRIC_EXTERNAL_COMMAND_CRITERION)
			-- Load `a_criterion' into Current.
		local
			l_tester: EB_METRIC_EXTERNAL_COMMAND_TESTER
		do
			change_value_actions.block
			l_tester := a_criterion.tester

			set_value ([
				l_tester.command,
				l_tester.working_directory,
				l_tester.input,
				l_tester.is_input_as_file,
				l_tester.output,
				l_tester.is_output_enabled,
				l_tester.is_output_as_file,
				l_tester.error,
				l_tester.is_error_enabled,
				l_tester.is_error_as_file,
				l_tester.is_error_redirected_to_output,
				l_tester.exit_code,
				l_tester.is_exit_code_enabled
			])
			set_text (displayed_value)
			change_value_actions.resume
		end

	store_criterion (a_criterion: EB_METRIC_EXTERNAL_COMMAND_CRITERION)
			-- Store Current in `a_criterion'.
		local
			l_tester: EB_METRIC_EXTERNAL_COMMAND_TESTER
			l_value: like value
		do
			l_tester := a_criterion.tester
			l_value := safe_value
			l_tester.set_command (l_value.command.as_string_8)
			l_tester.set_working_directory (l_value.working_directory.as_string_8)
			l_tester.set_input (l_value.input.as_string_8)
			l_tester.set_input_as_file (l_value.input_as_file)
			l_tester.set_output (l_value.output.as_string_8)
			l_tester.set_is_output_enabled (l_value.output_enabled)
			l_tester.set_output_as_file (l_value.output_as_file)
			l_tester.set_error (l_value.error.as_string_8)
			l_tester.set_is_error_enabled (l_value.error_enabled)
			l_tester.set_error_as_file (l_value.error_as_file)
			l_tester.set_is_error_redirected_to_output (l_value.error_redirected_to_output)
			l_tester.set_exit_code (l_value.exit_code)
			l_tester.set_is_exit_code_enabled (l_value.exit_code_enabled)
		end

	safe_value: like value
			-- Returns `value'.
			-- If `value' is Void, return a default value.
		do
			Result := value
			if Result = Void then
				Result := ["", "", "", False, "", False, False, "", False, False, False, 0, False]
			end
			Result.compare_objects
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	convert_to_data (a_string: like displayed_value): like value
			-- Convert displayed data into data.
		local
			l_value: like value
		do
			l_value := value

			if l_value = Void then
				Result := [a_string.as_string_8, "", "", False, "", False, False, "", False, False, False, 0, False]
			else
				Result := [
					a_string.as_string_8,
					l_value.working_directory,
					l_value.input,
					l_value.input_as_file,
					l_value.output,
					l_value.output_enabled,
					l_value.output_as_file,
					l_value.error,
					l_value.error_enabled,
					l_value.error_as_file,
					l_value.error_redirected_to_output,
					l_value.exit_code,
					l_value.exit_code_enabled]
			end
			Result.compare_objects
		end

	property_dialog: EB_METRIC_COMMAND_PROPERTY_DIALOG
			-- Dialog to display advanced options for text criterion

	display_value_agent (a_value: like value): STRING_32
			-- Action to return displayable string
		local
			l_str: STRING_GENERAL
		do
			if a_value /= Void then
				l_str := a_value.command
			end
			if l_str /= Void then
				Result := l_str.to_string_32
			else
				Result := ""
			end
		ensure
			result_attached: Result /= Void
		end

invariant
	property_dialog_attached: property_dialog /= Void


end

indexing
	description	: "Command to display information concerning a compiled class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_CLASS_INFO_FORMATTER

inherit
	EB_FORMATTER

	SHARED_APPLICATION_EXECUTION

	SHARED_FORMAT_INFO

feature -- Properties

	associated_class: CLASS_C
			-- Class about which information is displayed.

feature -- Status setting

	enable_breakpoints is
			-- `Current' must display breakpoints from now on, if possible.
		do
			has_breakpoints := True
		end

	disable_breakpoints is
			-- `Current' must not display breakpoints from now on.
		do
			has_breakpoints := False
		end

	set_stone (new_stone: CLASSI_STONE) is
			-- Associate current formatter with class contained in `a_stone'.
		local
			a_stone: CLASSC_STONE
		do
			a_stone ?= new_stone
			if a_stone /= Void then
				set_class (a_stone.e_class)
			else
				associated_class := Void
				class_cmd := Void
				reset_display
				if 
					selected and then
					not widget.is_displayed
				then
					if widget_owner /= Void then
						widget_owner.set_widget (widget)
					end
					display_header
				end
			end
		end

	set_class (a_class: CLASS_C) is
			-- Associate current formatter with `a_class'.
		do
			associated_class := a_class
			if a_class = Void then
				class_cmd := Void
			else
				create_class_cmd
			end
			must_format := True
			format
			if selected then
				if widget_owner /= Void then
					widget_owner.set_widget (widget)
				end
				display_header
			end
		ensure
			class_set: a_class = associated_class
			cmd_created_if_possible: (a_class = Void) = (class_cmd = Void)
		end

feature -- Formatting

	formatted_text: STRUCTURED_TEXT is
			-- Structured text representing information concerning `class'.
		do
			if class_cmd /= Void then
				Result := class_cmd.structured_text
			else
				create Result.make
			end
		ensure
			result_non_void: Result /= Void
		end

	save_in_file is
			-- Save output format to a file.
		require else
			class_non_void: associated_class /= Void
		do
--|FIXME XR: To be implemented.
		end

feature {NONE} -- Implementation

	reset_display is
			-- Clear all graphical output.
		deferred
		end

	create_class_cmd is
			-- Create `class_cmd' depending on its actual type.
		require
			associated_class_non_void: associated_class /= Void
		deferred
		ensure
			class_cmd /= Void
		end

	file_name: FILE_NAME is
			-- Name of the file in which displayed information may be stored.
		require else
			class_non_void: associated_class /= Void
		do
			create Result.make_from_string (clone (associated_class.name))
			Result.add_extension (post_fix)
		end

	generate_text is
			-- Fill `formatted_text' with information concerning `class'.
		local
			retried: BOOLEAN
		do
			if not retried then
				if class_cmd /= Void then
					if formatted_text /= Void then
						formatted_text.wipe_out
					end
					if has_breakpoints then
						set_is_with_breakable
					else
						set_is_without_breakable
					end
					class_cmd.execute
				end
				last_was_error := False
			else
				last_was_error := True
			end
		rescue
			retried := True
			retry
		end

	temp_header: STRING is
			-- Temporary header displayed during the format processing.
		do
			Result := clone (Interface_names.l_Working_formatter)
			Result.append (command_name)
			Result.append (Interface_names.l_Of_class)
			Result.append (associated_class.name)
			Result.append (Interface_names.l_Three_dots)
		end

	header: STRING is
			-- Header displayed when current formatter is selected.
		do
			if associated_class /= Void then
				Result := clone (capital_command_name)
				Result.append (Interface_names.l_Of_class)
				Result.append (associated_class.name)
			else
				Result := Interface_names.l_Not_in_system_no_info
			end
		end

feature {NONE} -- Properties

	has_breakpoints: BOOLEAN
			-- Should `Current' display breakpoints?

	class_cmd: E_CLASS_CMD
			-- Class command that is used to generate text output (especially in files).

end -- class EB_CLASS_INFO_FORMATTER


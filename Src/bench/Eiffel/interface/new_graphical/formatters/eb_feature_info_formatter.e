indexing
	description: "Formatter that displays information about a feature."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FEATURE_INFO_FORMATTER

inherit
	EB_FORMATTER

	SHARED_APPLICATION_EXECUTION

feature -- Properties

	associated_feature: E_FEATURE
			-- Feature about which information is displayed.

feature -- Status setting

	set_stone (new_stone: FEATURE_STONE) is
			-- Associate current formatter with feature contained in `new_stone'.
		do
			if new_stone /= Void then
				set_feature (new_stone.e_feature)
			else
				associated_feature := Void
				feature_cmd := Void
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

	set_feature (a_feature: E_FEATURE) is
			-- Associate current formatter with `a_class'.
		do
			associated_feature := a_feature
			if a_feature = Void or else not a_feature.associated_class.has_feature_table then
				feature_cmd := Void
				associated_feature := Void
			else
				create_feature_cmd
			end
			must_format := True
			format
			if
				selected and then
				not widget.is_displayed
			then
				if widget_owner /= Void then
					widget_owner.set_widget (widget)
				end
				display_header
			end
		ensure
			feature_set: a_feature = associated_feature
			cmd_created_if_possible: (a_feature = Void) = (feature_cmd = Void)
		end

feature -- Formatting

	formatted_text: STRUCTURED_TEXT is
			-- Structured text representing information concerning `class'.
		do
			if feature_cmd /= Void then
				Result := feature_cmd.structured_text
			else
				create Result.make
			end
		ensure
			result_non_void: Result /= Void
		end

	save_in_file is
			-- Save output format to a file.
		require else
			feature_non_void: associated_feature /= Void
		do
--|FIXME XR: To be implemented.
		end

feature {NONE} -- Implementation

	reset_display is
			-- Clear all graphical output.
		deferred
		end

	create_feature_cmd is
			-- Create `feature_cmd' depending on `Current's actual type.
		require
			associated_feature_non_void: associated_feature /= Void
		deferred
		ensure
			feature_cmd /= Void
		end

	file_name: FILE_NAME is
			-- Name of the file in which displayed information may be stored.
		require else
			class_non_void: associated_feature /= Void
		do
			create Result.make_from_string (clone (associated_feature.name))
			Result.add_extension (post_fix)
		end

	generate_text is
			-- Fill `formatted_text' with information concerning `associated_feature'.
		local
			retried: BOOLEAN
		do
			if not retried then
				if feature_cmd /= Void then
					if formatted_text /= Void then
						formatted_text.wipe_out
					end
					feature_cmd.execute
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
			Result.append (Interface_names.l_Of_feature)
			Result.append (associated_feature.name)
			Result.append (Interface_names.l_Three_dots)
		end

	header: STRING is
			-- Header displayed when current formatter is selected.
		local
			class_name: STRING
		do
			if associated_feature /= Void then
				Result := clone (capital_command_name)
				Result.append (Interface_names.l_Of_feature)
				Result.append (associated_feature.name)
				Result.append (Interface_names.l_Of_class)
				class_name := clone (associated_feature.associated_class.name)
				class_name.to_upper
				Result.append (class_name)
			else
				Result := Interface_names.l_No_feature
			end
		end

feature {NONE} -- Properties

	feature_cmd: E_FEATURE_CMD
			-- Feature command that is used to generate text output (especially in files).

end -- class EB_FEATURE_INFO_FORMATTER

note
	description: "A command to invoke of AutoProof."

class
	E_AUTOPROOF

inherit
	E_CMD
		redefine
			executable
		end

	SHARED_LOCALE
	SHARED_WORKBENCH
	E2B_SHARED_CONTEXT

create
	make

feature {NONE} -- Creation

	make
			-- Initialize the command.
		do
			create features.make (0)
			create classes.make (1)
			create groups.make (0)
		end

feature -- Status report

	executable: BOOLEAN
			-- <Precursor>
		do
			Result := not autoproof.is_running
		end

	is_html: BOOLEAN
			-- Is HTML output requested?

	is_measured: BOOLEAN
			-- Is time measurement requested?

feature {NONE} -- Status report

	has_failed: BOOLEAN
			-- Has verification failed?

feature -- Status setting

	set_html (v: BOOLEAN)
			-- Set `is_html` to `v`.
		do
			is_html := v
		ensure
			is_html = v
		end

	set_measured (v: BOOLEAN)
			-- Set `is_measured` to `v`.
		do
			is_measured := v
		ensure
			is_measured = v
		end

feature {NONE} -- Access

	features: ARRAYED_LIST [TUPLE [feature_name: READABLE_STRING_32; class_name: READABLE_STRING_32]]
			-- A list of features to verify.

	classes: ARRAYED_LIST [READABLE_STRING_32]
			-- A list of classes to verify.

	groups: ARRAYED_LIST [READABLE_STRING_32]
			-- A list of groups to verify.

	is_cluster_collection_requested: BOOLEAN
			-- Is verification of all clusters of the target requested?

	is_override_collection_requested: BOOLEAN
			-- Is verification of all overrides of the target requested?

feature -- Modification

	add_feature (f, c: READABLE_STRING_32)
			-- Add a feature of name `f` in the class of name `c`
		do
			features.extend (f, c)
		ensure
			features.has (f, c)
		end

	add_class (c: READABLE_STRING_32)
			-- Add a class of name `c` to the list of classes to verify.
		do
			classes.extend (c)
		ensure
			classes.has (c)
		end

	add_group (g: READABLE_STRING_32)
			-- Add a group of name `g` to the list of groups to verify.
		do
			groups.extend (g)
		ensure
			groups.has (g)
		end

	add_cluster_collection
			-- Add all clusters of the target to the list of clusters to verify.
		do
			is_cluster_collection_requested := True
		ensure
			is_cluster_collection_requested
		end

	add_override_collection
			-- Add all overrides of the target to the list of clusters to verify.
		do
			is_override_collection_requested := True
		ensure
			is_override_collection_requested
		end

feature {NONE} -- Execution

	execute
			-- <Precursor>
		local
			cs: like {UNIVERSE_I}.compiled_classes_with_name
			has_error: BOOLEAN
			html_writer: E2B_HTML_OUTPUT
			t: DATE_TIME
			d: DATE_TIME_DURATION
		do
				-- Clean up the state.
			has_failed := False
			autoproof.reset
			if attached workbench.universe as u then
					-- Add features if possible.
				⟳ fc: features ¦
					cs := u.compiled_classes_with_name ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (fc.class_name))
					if cs.is_empty then
						has_error := True
						output_window.add (locale.formatted_string (locale.translation_in_context ("Class `$1` is not found or not compiled.", "command.autoproof"), fc.class_name))
						output_window.add_new_line
					else
						⟳ c: cs ¦
							if attached c.compiled_class.feature_named_32 (fc.feature_name) as f then
								autoproof.add_feature (f)
							else
								has_error := True
								output_window.add (locale.formatted_string (locale.translation_in_context ("Feature `$1` is not found in class `$2`.", "command.autoproof"), fc.feature_name, fc.class_name))
								output_window.add_new_line
							end
						⟲
					end
				⟲
					-- Add classes if possible.
				⟳ n: classes ¦
					cs := u.compiled_classes_with_name ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (n))
					if cs.is_empty then
						has_error := True
						output_window.add (locale.formatted_string (locale.translation_in_context ("Class `$1` is not found or not compiled.", "command.autoproof"), n))
						output_window.add_new_line
					else
						⟳ c: cs ¦ autoproof.add_class (c.compiled_class) ⟲
					end
				⟲
					-- Add groups if possible.
				⟳ n: groups ¦
					if attached u.cluster_of_name (n) as g then
						autoproof.add_group (g)
					else
						has_error := True
						output_window.add (locale.formatted_string (locale.translation_in_context ("Group `$1` is not in the system.", "command.autoproof"), n))
						output_window.add_new_line
					end
				⟲
				if attached u.target as p then
					if is_cluster_collection_requested then
						⟳ c: p.clusters ¦ autoproof.add_group (c) ⟲
					end
					if is_override_collection_requested then
						⟳ c: p.overrides ¦ autoproof.add_group (c) ⟲
					end
				end
			else
				has_error := True
				output_window.add (locale.translation_in_context ("The project is not compiled.", "command.autoproof"))
				output_window.add_new_line
			end
			if not has_error then
					-- Register output procedures.
				if is_html then
					create html_writer
					html_writer.print_header
					autoproof.add_notification (agent html_writer.print_verification_result)
				else
					autoproof.add_notification (agent print_result)
				end
				autoproof.add_notification (agent record_status)

				if is_measured then
					create t.make_now_utc
				end
					-- Verify selected classes.
				if options.is_bulk_verification_enabled then
					autoproof.verify
				else
					autoproof.verify_forked
				end
				if attached t then
					d := (create {DATE_TIME}.make_now_utc).relative_duration (t)
				end

				if attached html_writer then
					html_writer.print_footer
				end

				if attached d then
					output_window.add
						(if attached html_writer then "<p>Total time: " else "Total time: " end +
						time_format.formatted (d.fine_seconds_count) +
						if is_html then "s</p>" else "s%N" end)
				end
			end
			features.wipe_out
			classes.wipe_out
			groups.wipe_out
			is_cluster_collection_requested := False
			is_override_collection_requested := False
			workbench.error_handler.checksum
		end

	record_status (r: E2B_RESULT)
			-- Record verification status of `r`.
		do
			if not r.is_verification_successful and then not has_failed then
					-- Avoid duplicate verification failure reports.
				has_failed := True
				workbench.error_handler.insert_error (create {AP_VERIFICATION_FAILURE}.make)
			end
		end

feature {NONE} -- Output

	output_window: OUTPUT_WINDOW
			-- Output sink.
		do
			Result := {ES}.command_line_io.output_window
		end

	print_result (a_result: E2B_RESULT)
			-- Print results to output.
		do
			across a_result.verification_results as i loop
				output_window.add ("======================================%N")
				if attached {E2B_SUCCESSFUL_VERIFICATION} i as l_success then
					print_successful_verification (l_success)
				elseif attached {E2B_FAILED_VERIFICATION} i as l_failure then
					print_failed_verification (l_failure)
				elseif attached {E2B_AUTOPROOF_ERROR} i as l_error then
					print_error (l_error)
				else
					check False end
				end
			end
		end

	print_successful_verification (a_success: E2B_SUCCESSFUL_VERIFICATION)
			-- Print successful verification information.
		local
			time_string: STRING
		do
			print_feature_information (a_success)
			if options.is_print_time then
				time_string := " (" + time_format.formatted (a_success.time) + "s)"
			else
				time_string := ""
			end
			if a_success.original_errors = Void or else a_success.original_errors.is_empty then
				output_window.add ("Successfully verified" + time_string + ".%N")
			else
					-- Two-step verification result
				output_window.add ("Successfully verified after inlining" + time_string + ".%N")
				output_window.add ("Original errors:%N")
				across a_success.original_errors as i loop
					if @ i.cursor_index = 1 then
						output_window.add_new_line
					else
						output_window.add ("--------------------------------------%N")
					end
					i.multi_line_message (output_window)
					output_window.add_new_line
				end
			end
		end

	print_failed_verification (a_failure: E2B_FAILED_VERIFICATION)
			-- Print failed verifcation information.
		local
			time_string: STRING
		do
			print_feature_information (a_failure)
			if options.is_print_time then
				time_string := " (" + time_format.formatted (a_failure.time) + "s)"
			else
				time_string := ""
			end
			output_window.add ("Verification failed" + time_string + ".%N")
			across a_failure.errors as i loop
				if @ i.cursor_index = 1 then
					output_window.add_new_line
				else
					output_window.add ("--------------------------------------%N")
				end
				if i.context_line_number > 0 then
					output_window.add ("Line: " + i.context_line_number.out + ". ")
				end
				i.single_line_message (output_window)
				output_window.add_new_line
			end
		end

	print_error (a_error: E2B_AUTOPROOF_ERROR)
			-- Print failed verifcation information.
		do
			print_feature_information (a_error)
			output_window.add ("AutoProof error.%N")
			if a_error.context_line_number > 0 then
				output_window.add ("Line: " + a_error.context_line_number.out + ". ")
			end
			output_window.add (a_error.type + ": ")
			a_error.single_line_message (output_window)
			output_window.add_new_line
		end

	print_feature_information (a_proc: E2B_VERIFICATION_RESULT)
			-- Print feature information.
		do
			if attached a_proc.context_class then
				output_window.add_class (a_proc.context_class.original_class)
			end
			if attached a_proc.context_feature then
				output_window.add (".")
				output_window.add_feature (a_proc.context_feature.e_feature, a_proc.context_feature.feature_name_32)
			end
			if attached a_proc.verification_context then
				output_window.add (" (")
				output_window.add (a_proc.verification_context)
				output_window.add (")")
			end
			output_window.add_new_line
		end

	time_format: FORMAT_DOUBLE
			-- Format for verfication times.
		once
			create Result.make (4, 3)
		end

feature {NONE} -- Verification engine

	autoproof: E2B_AUTOPROOF
			-- Shared autoproof instance.
		once
			create Result.make
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2021-2022 Schaffhausen Institute of Technology"
	author: "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end

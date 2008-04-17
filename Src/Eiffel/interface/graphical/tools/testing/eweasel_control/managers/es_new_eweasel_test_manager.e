indexing
	description: "[
					Manager which control test case files creation.
					The files including:
						test case Eiffel class file
						test case ecf file
						eWeasel control file tcf file
						test case note file
																			]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NEW_EWEASEL_TEST_MANAGER

inherit
	ES_EWEASEL_SUB_MANAGER

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Command

	add_whole_set_of_files is
			-- Create a new eweasel unit test directory and files.
			-- Prepare default conditions
		do
			add_folder
			add_files
		end

	set_target_test_case_folder (a_folder_name: like folder_name) is
			-- Set `target_test_case_folder' with `a_dir'
		require
			not_void: a_folder_name /= Void
			valid: not a_folder_name.is_empty and a_folder_name.is_valid
		do
			folder_name := a_folder_name
		ensure
			set: folder_name = a_folder_name
		end

	set_wizard_information (a_info: like wizard_information) is
			-- Set `wizard_information' with `a_info'
		require
			not_void: a_info /= Void
			valid: a_info.is_valid
		do
			wizard_information := a_info
		ensure
			set: wizard_information = a_info
		end

feature -- Query

	folder_name: DIRECTORY_NAME
			-- New test case directory name
			-- Not including full path

	wizard_information: ES_NEW_UNIT_TEST_WIZARD_INFORMATION
			-- Wizard information

	full_target_test_case_folder: DIRECTORY_NAME is
			-- `folder_name' and full path included
		require
			not_void: folder_name /= Void and then not folder_name.is_empty
		do
			create Result.make_from_string (manager.environment_manager.test_case_directory.twin)
			Result.extend (folder_name)
		end

	test_case_root_class_name: STRING is
			-- Root eWeasel test case Eiffel class name
		do
			Result := manager.environment_manager.test_case_root_eiffel_class_name
		end

	test_case_root_class_file_name: STRING is
			-- File name of class `test_case_root_class_name'
		do
			-- We must use lower class name here.
			-- Otherwise, in {CONF_BUILD_VISITR}.handle_class, the new created class will be excluded from resued_classes.
			Result := test_case_root_class_name.as_lower + ".e"
		end

feature {NONE} -- Implementation

	add_folder is
			-- Create eWeasel testing folder
		local
			l_dir: DIRECTORY
		do
			create l_dir.make (full_target_test_case_folder)
			if not l_dir.exists then
				l_dir.create_dir
				check created: l_dir.exists end
			end
		ensure
			exists: (create {DIRECTORY}.make (full_target_test_case_folder)).exists
		end

	add_files is
			-- Add all files of a new eWeasel unit test.
		local
			l_retry: BOOLEAN
			l_prompt: ES_PROMPT_PROVIDER
			l_manager: ISE_EXCEPTION_MANAGER
			l_error_string: STRING_GENERAL
			l_meaning: STRING
		do
			if not l_retry then
				add_file_ecf
				add_file_tcf
				add_file_notes
				add_file_test_case_eiffel_class
			else
				l_error_string := interface_names.l_Cannot_create_test_case_files
				create l_manager
				l_meaning := l_manager.last_exception.meaning
				if l_meaning /= Void and then not l_meaning.is_empty then
					l_error_string.append ("%N")
					l_error_string.append (l_meaning)
				end
				create l_prompt
				l_prompt.show_error_prompt (l_error_string, Void, Void)
			end
		rescue
			l_retry := True
			retry
		end

	create_file (a_file_name: FILE_NAME): IO_MEDIUM  is
			-- Create a new {IO_MEDIUM} which file name is `a_file_name'
			-- Callers have to close `Result' themselves
		require
			not_void: a_file_name /= Void
			valid: a_file_name.is_valid
			not_exists: not (create {RAW_FILE}.make (a_file_name)).exists
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name)
			check not_exits: not l_file.exists end

			l_file.create_read_write

			Result := l_file
		ensure
			not_void: Result /= Void
			created: (create {RAW_FILE}.make (a_file_name)).exists
		end

	add_file_ecf is
			-- Add Eiffel project config file for test case
		local
			l_io: IO_MEDIUM
			l_file_name: FILE_NAME
		do
			create l_file_name.make
			l_file_name.set_directory (full_target_test_case_folder)
			l_file_name.set_file_name ("Ecf")

			l_io := create_file (l_file_name)
			l_io.put_string (ecf_content)
			l_io.close
		ensure
			file_created:
		end

	add_file_tcf is
			-- Add eWeasel test control file
		local
			l_io: IO_MEDIUM
			l_file_name: FILE_NAME
		do
			create l_file_name.make
			l_file_name.set_directory (full_target_test_case_folder)
			l_file_name.set_file_name (manager.environment_manager.tcf_file_name)

			l_io := create_file (l_file_name)
			l_io.put_string (tcf_content)
			l_io.close
		ensure
			file_created:
		end

	add_file_notes is
			-- Add test case file which contain test case comments
		local
			l_io: IO_MEDIUM
			l_file_name: FILE_NAME
		do
			create l_file_name.make
			l_file_name.set_directory (full_target_test_case_folder)
			l_file_name.set_file_name ("notes")

			l_io := create_file (l_file_name)
			l_io.put_string (notes_content)
			l_io.close
		ensure
			file_created:
		end

	add_file_test_case_eiffel_class is
			-- Add new Eiffel class file for new test case.
		require
			not_void: wizard_information /= Void
		local
			l_io: IO_MEDIUM
			l_file_name: FILE_NAME
			l_content: STRING
		do
			create l_file_name.make
			l_file_name.set_directory (full_target_test_case_folder)
			l_file_name.set_file_name (test_case_root_class_file_name)

			l_io := create_file (l_file_name)
			l_content := eiffel_test_case_class_content
			if l_content /= Void then
				-- Added texts to file
				add_predefined_features (l_content)
				add_features_to_test (l_content)
				add_make_content (l_content)
				l_io.put_string (l_content)
			end
			l_io.close
		ensure
			file_created:
		end

	add_make_content (a_file_content: STRING) is
			-- Add `make' content
		require
			not_void: a_file_content /= Void
		local
			l_features_to_test: ARRAYED_LIST [E_FEATURE]
			l_feature_test_content: STRING
		do
			if wizard_information.is_on_before_test_runs_selected then
				a_file_content.replace_substring_all (start_test_class_actions_in_make_template_string, "%N%T%T%T" + on_before_test_runs_string)
			else
				a_file_content.replace_substring_all (start_test_class_actions_in_make_template_string, "")
			end

			if wizard_information.is_on_after_test_runs_selected then
				a_file_content.replace_substring_all (after_test_class_actions_in_make_template_string, "%N%N%T%T%T" + on_after_test_runs_string)
			else
				a_file_content.replace_substring_all (after_test_class_actions_in_make_template_string, "")
			end

			-- Fill test features part
			l_features_to_test := wizard_information.features_to_test
			if l_features_to_test /= Void and then not l_features_to_test.is_empty then
				from
					create l_feature_test_content.make_empty
					l_features_to_test.start
				until
					l_features_to_test.after
				loop
					l_feature_test_content.append ("%N")

					if wizard_information.is_on_before_test_run_selected then
						l_feature_test_content.append ("%N%T%T%T" + on_before_test_run_string)
					end

					l_feature_test_content.append ("%N%T%T%T" + test_feature_name (l_features_to_test.item.name))

					if wizard_information.is_on_after_test_run_selected then
						l_feature_test_content.append ("%N%T%T%T" + on_after_test_run_string)
					end

					l_features_to_test.forth
				end

				a_file_content.replace_substring_all (core_test_in_make_template_string, l_feature_test_content)
			else
				a_file_content.replace_substring_all (core_test_in_make_template_string, "%N%T%T%T--Please add your tests here")
			end
		ensure
			replaced: not a_file_content.has_substring (start_test_class_actions_in_make_template_string)
			replaced: not a_file_content.has_substring (after_test_class_actions_in_make_template_string)
			replaced: not a_file_content.has_substring (core_test_in_make_template_string)
		end

	add_predefined_features (a_file_content: STRING) is
			-- Added four predefined feature base on `wizard_information'
		require
			not_void: a_file_content /= Void
			ready: wizard_information /= Void
		local
			l_redefined_features: STRING
		do
			if wizard_information.is_on_after_test_runs_selected or wizard_information.is_on_after_test_run_selected or
				wizard_information.is_on_before_test_runs_selected or wizard_information.is_on_before_test_run_selected then

				create l_redefined_features.make_empty

				if wizard_information.is_on_after_test_runs_selected then
					l_redefined_features.append ("%N%N%T" + feature_content(on_after_test_runs_string, "Do cleanup work after all test runs"))
				end
				if wizard_information.is_on_after_test_run_selected then
					l_redefined_features.append ("%N%N%T" + feature_content(on_after_test_run_string, "Do cleanup work after a test run"))
				end
				if wizard_information.is_on_before_test_runs_selected then
					l_redefined_features.append ("%N%N%T" + feature_content(on_before_test_runs_string, "Do prepare work before all test runs"))
				end
				if wizard_information.is_on_before_test_run_selected then
					l_redefined_features.append ("%N%N%T" + feature_content(on_before_test_run_string, "Do prepare work before a test run"))
				end

				a_file_content.replace_substring_all (start_after_test_actions_template_string, l_redefined_features)
			else
				-- None selected, we should remove all of them
				a_file_content.replace_substring_all (start_after_test_actions_template_string, "")
			end
		ensure
			replaced: not a_file_content.has_substring (start_after_test_actions_template_string)
		end

	add_features_to_test (a_file_content: STRING) is
			-- Result void if none
		require
			not_void: a_file_content /= Void
			ready: wizard_information /= Void
		local
			l_list: ARRAYED_LIST [E_FEATURE]
			l_features: STRING
			l_class: CLASS_C
		do
			l_list := wizard_information.features_to_test
			if l_list /= Void and then not l_list.is_empty then
				from
					create l_features.make_empty
					l_list.start
				until
					l_list.after
				loop
					if l_list.isfirst then
						l_features.append ("%N")
						l_class := l_list.first.associated_class
						l_features.append ("%Nfeature {NONE} -- Test {" + l_class.name_in_upper + "} implementation")
					end
					l_features.append ("%N%N%T" + feature_content (test_feature_name (l_list.item.name), ("Test feature {" + l_list.item.associated_class.name_in_upper +  "}." + l_list.item.name)))
					l_list.forth
				end
			else

			end

			if l_features /= Void and not l_features.is_empty then
				a_file_content.replace_substring_all (features_to_test_template_string, l_features)
			else
				a_file_content.replace_substring_all (features_to_test_template_string, "")
			end
		ensure
			replaced: not a_file_content.has_substring (features_to_test_template_string)
		end

	feature_content (a_feature_name: STRING; a_comment: STRING): STRING is
			-- Generate feature content of `a_feature_name'
			-- `a_comment' can be void
		require
			not_void: a_feature_name /= Void
			valid: wizard_information /= Void
		do
			create Result.make_empty
			if wizard_information.is_add_frozen_feature_stubs_selected then
				Result.append ("frozen " + a_feature_name + " is %N")
			else
				Result.append (a_feature_name + " is %N")
			end

			if a_comment /= Void then
				Result.append ("			-- " + a_comment + "%N")
			else
				Result.append ("			-- Redefine%N")
			end
			Result.append ("		do%N")
			if wizard_information.is_add_to_be_implemented_selected then
				Result.append ("			check to_be_implemented: False end%N")
			end
			Result.append ("		end")
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- File contents

	ecf_content: STRING is
			-- Default Eiffel config file content.
		local
			l_file: RAW_FILE
		do
			create l_file.make (ecf_content_file_name)
			create Result.make_empty
			if l_file.exists then
				l_file.open_read

				l_file.read_stream (l_file.count)
				Result.append (l_file.last_string)

				-- Set class name
				Result.replace_substring_all ("$ROOT_CLASS", test_case_root_class_name)
			else
				Result := ""
				prompts.show_error_prompt (Warning_messages.w_cannot_read_file (l_file.name), Void, Void)
			end
		ensure
			not_void: Result /= Void
		end

	test_name: STRING is
			-- Test case name.
			-- The Result same as test root class name for the moment
		do
			Result := test_case_root_class_name
		end

	tcf_content: STRING is
			-- Testing control file content.
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make (tcf_content_file_name)
			create Result.make_empty
			if l_file.exists then
				l_file.open_read

				l_file.read_stream (l_file.count)
				Result.append (l_file.last_string)

				-- Set test name
				Result.replace_substring_all ("$TEST_NAME", test_name)
				-- Set test root class name
				Result.replace_substring_all ("$ROOT_CLASS_FILE_NAME", test_case_root_class_file_name)
			else
				prompts.show_error_prompt (Warning_messages.w_cannot_read_file (l_file.name), Void, Void)
			end
		ensure
			not_void: Result /= Void
		end

	eiffel_test_case_class_content: STRING is
			-- Default Eiffel test class content.
			-- Result void if error
		local
			l_file: PLAIN_TEXT_FILE
			l_date_time: DATE_TIME
		do
			create l_file.make (class_content_file_name)
			create Result.make_empty
			if l_file.exists then
				l_file.open_read

				l_file.read_stream (l_file.count)
				Result.append (l_file.last_string)

				-- Set class name
				Result.replace_substring_all ("$CLASS_NAME", manager.environment_manager.test_case_root_eiffel_class_name)

				-- Set date time
				create l_date_time.make_now
				Result.replace_substring_all ("$DATE", l_date_time.out)
			else
				prompts.show_error_prompt (Warning_messages.w_cannot_read_file (l_file.name), Void, Void)
			end
		ensure
			not_void: Result /= Void
		end

	notes_content: STRING is
			-- Default test notes content
		local
			l_file: PLAIN_TEXT_FILE
			l_date: DATE
		do
			create l_file.make (notes_content_file_name)
			create Result.make_empty
			if l_file.exists then
				l_file.open_read

				l_file.read_stream (l_file.count)
				Result.append (l_file.last_string)

				-- FIXIT: We should able to find current user name
				-- On Windows, the API is "WNetGetUser"
				-- On Linux, the API is "getlogin"
				-- Then we can automatically have the texts like "reported by XXX"

				-- Set date
				create l_date.make_now
				Result.replace_substring_all ("$DATE", l_date.out)
			else
				prompts.show_error_prompt (Warning_messages.w_cannot_read_file (l_file.name), Void, Void)
			end
		ensure
			not_void: Result /= Void
		end

	class_content_file_name: !FILE_NAME is
			-- Class file content file name
		do
			create Result.make
			Result.set_directory (eiffel_layout.default_templates_path)
			Result.set_file_name ("eiffel_unit_test_class_template.e")
		end

	ecf_content_file_name: !FILE_NAME is
			-- Ecf content file name
		do
			create Result.make
			Result.set_directory (eiffel_layout.default_templates_path)
			Result.set_file_name ("eiffel_unit_test_ecf_template.ecf")
		end

	notes_content_file_name: !FILE_NAME is
			-- Default note file name.
		do
			create Result.make
			Result.set_directory (eiffel_layout.default_templates_path)
			Result.set_file_name ("eiffel_unit_test_note_template.txt")
		end

	tcf_content_file_name: !FILE_NAME is
			-- Default eweasel tcf file name
		do
			create Result.make
			Result.set_directory (eiffel_layout.default_templates_path)
			Result.set_file_name ("eiffel_unit_test_tcf_template.txt")
		end

	on_before_test_runs_string: !STRING is
			-- Predefined feature name
		do
			create Result.make_from_string ("on_before_test_runs")
		end

	on_after_test_runs_string: !STRING is
			-- Predefined feature name
		do
			create Result.make_from_string ("on_after_test_runs")
		end

	on_before_test_run_string: !STRING is
			-- Predefined feature name
		do
			create Result.make_from_string ("on_before_test_run")
		end

	on_after_test_run_string: !STRING is
			-- Predefined feature name
		do
			create Result.make_from_string ("on_after_test_run")
		end

	start_after_test_actions_template_string: !STRING is
			-- $ string in template file
		do
			create Result.make_from_string ("$start_after_test_actions")
		end

	start_test_class_actions_in_make_template_string: !STRING
			-- $ string in template file
		do
			create Result.make_from_string ("$start_test_class_actions_in_make")
		end

	after_test_class_actions_in_make_template_string: !STRING
			-- $ string in template file
		do
			create Result.make_from_string ("$after_test_class_actions_in_make")
		end

	core_test_in_make_template_string: !STRING
			-- $ string in template file
		do
			create Result.make_from_string ("$core_test_in_make")
		end

	features_to_test_template_string: !STRING is
			-- $ string in template file
		do
			create Result.make_from_string ("$features_to_test")
		end

feature {NONE} -- Utility

	test_feature_name (a_feature_to_test: STRING): !STRING is
			-- Test feature name for `a_feature_to_test'
		require
			not_void: a_feature_to_test /= Void and then not a_feature_to_test.is_empty
		do
			create Result.make_from_string ("test_" + a_feature_to_test)
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end


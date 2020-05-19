note
	description: "Run code analysis instruction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class
	EW_RUN_CODE_ANALYSIS_INST

inherit

	EW_START_COMPILE_INST
		redefine
			inst_initialize,
			compilation_type,
			execute
		end

feature -- Instruction

	inst_initialize (line: READABLE_STRING_32)
			-- Initialize instruction from `line'.
			-- Set `init_ok' to indicate whether
			-- initialization was successful.
		local
			l_args: LIST [READABLE_STRING_32]
			l_error: BOOLEAN
		do
			load_defaults := False
			preference_file_path := Void
			class_list := Void
			l_args := broken_into_arguments (line)
			from
				l_args.start
			until
				l_args.after or l_error
			loop
				if l_args.item.same_string (Load_defaults_ew_option) then
					load_defaults := true
				elseif l_args.item.same_string (Load_preferences_ew_option) then
					l_args.forth
					if l_args.after then
						l_error := True
						failure_explanation := {STRING_32} "No preference file specified after " + load_preferences_ew_option + {STRING_32} " option."
					else
						preference_file_path := l_args.item
					end
				elseif l_args.item.same_string (Specify_classes_ew_option) then
					l_args.forth
					if l_args.after then
						l_error := True
						failure_explanation := {STRING_32} "No class or list of classes specified after " + Specify_classes_ew_option + {STRING_32} " option."
					else
						class_list := broken_into_words (l_args.item)
					end
				elseif l_args.item.same_string (Force_rules_ew_option) then
					l_args.forth
					if l_args.after then
						l_error := True
						failure_explanation := {STRING_32} "No rule or list of rules specified after " + Force_rules_ew_option + {STRING_32} " option."
					else
						forced_rules_argument := l_args.item
					end
				else
					l_error := True
					failure_explanation := {STRING_32} "Unrecognized argument: " + l_args.item
				end
				l_args.forth
			end
			init_ok := not l_error
		end

	compilation_options (a_test: EW_EIFFEL_EWEASEL_TEST): LIST [READABLE_STRING_32]
			-- Options to be passed to Eiffel compiler,
			-- if Eiffel compiler is run.
		do
			create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (16)
			if load_defaults then
				Result.extend (Load_defaults_ec_option)
			end
			if attached preference_file_path as l_preference_file_name then
				Result.extend (Load_preferences_ec_option)
				Result.extend (os.full_file_name (a_test.environment.value (Test_dir_name), l_preference_file_name))
			end
			Result.extend (Specify_classes_ec_option)
			if attached class_list as l_class_list then
				Result.extend (merged_with_separator (l_class_list, {STRING_32} " "))
			else
				Result.extend (all_classes_ec_option)
			end
			if attached forced_rules_argument as l_forced_rules_argument then
				Result.extend (Force_rules_ec_option)
				Result.extend (l_forced_rules_argument)
			end
		end

feature {EW_RUN_CODE_ANALYSIS_INST} -- Redefinition

	compilation_type: EW_CODE_ANALYSIS_PROCESS
			-- <Precursor>
		do
			check
				callable: False
			then
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
		do
			Precursor (test)
		end

feature {NONE} -- Implementation

	load_defaults: BOOLEAN
			-- Was the argument for loading default settings specified?

	preference_file_path: detachable READABLE_STRING_32
			-- The path to the preference file to be loaded. Void if preferences should not be loaded.

	class_list: detachable LIST [READABLE_STRING_32]
			-- The list of names of classes to be analyzed. Void if the whole system is to be analyzed.

	forced_rules_argument: READABLE_STRING_32
			-- The string argument with the forced rules and preferences, which will be passed to the ec as it is.
			-- Void if we are not forcing rules and preferences

feature {NONE} -- Internal constants

		-- Arguments for this EWeasel command

	Load_defaults_ew_option: STRING_32 = "loaddefaults"

	Load_preferences_ew_option: STRING_32 = "loadprefs"

	Specify_classes_ew_option: STRING_32 = "class"

	Force_rules_ew_option: STRING_32 = "rule"

		-- Arguments to be passed to the compiler.

	Load_defaults_ec_option: STRING_32 = "-ca_default"

	Load_preferences_ec_option: STRING_32 = "-ca_setting"

	Specify_classes_ec_option: STRING_32 = "-ca_class"

	Force_rules_ec_option: STRING_32 = "-ca_rule"

	all_classes_ec_option: STRING_32 = "-all"

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2020, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	revised_by: "Alexander Kogtenkov"
	license: "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
		This file is part of the EiffelWeasel Eiffel Regression Tester.
		
		The EiffelWeasel Eiffel Regression Tester is free
		software; you can redistribute it and/or modify it under
		the terms of the GNU General Public License version 2 as published
		by the Free Software Foundation.
		
		The EiffelWeasel Eiffel Regression Tester is
		distributed in the hope that it will be useful, but
		WITHOUT ANY WARRANTY; without even the implied warranty
		of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License version 2 for more details.
		
		You should have received a copy of the GNU General Public
		License version 2 along with the EiffelWeasel Eiffel Regression Tester
		if not, write to the Free Software Foundation,
		Inc., 51 Franklin St, Fifth Floor, Boston, MA
	]"

end

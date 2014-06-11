note
	description: "Run code analysis instruction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "05/2014"

class
	EW_RUN_CODE_ANALYSIS_INST

inherit
	EW_START_COMPILE_INST
	redefine
		inst_initialize,
		compilation_type,
		execute
	end

feature

	inst_initialize (line: STRING)
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [STRING];
			i: INTEGER
		do
			load_defaults := False
			preference_file_path := Void
			class_list := Void

			args := broken_into_words (line);

			args.start

			if not args.after and then args.item ~ load_defaults_ew_option then
				load_defaults := true
				args.forth
			end

			if not args.after and then args.item ~ load_preferences_ew_option then
				args.forth
				if args.after then
					init_ok := false
					failure_explanation := "No preference file specified after " + load_preferences_ew_option + " option."
				else
					preference_file_path := args.item
					args.forth
				end
			end

			if not args.after and then args.item ~ specify_classes_ew_option then
				create {ARRAYED_LIST [STRING]} class_list.make (16)
				from
					args.forth -- Yes, this is correct!
				until
					args.after
				loop
					class_list.extend (args.item)
				end
			end
		end


	compilation_options: LIST [STRING]
			-- Options to be passed to Eiffel compiler,
			-- if Eiffel compiler is run
		do
			create {ARRAYED_LIST [STRING]} Result.make (16)
			Result.extend ("-melt")
			Result.extend (code_analysis_ec_option)

			if load_defaults then
				Result.extend (load_defaults_ec_option)
			end
			if attached preference_file_path as l_preference_file_path then
				Result.extend (load_preferences_ec_option)
				Result.extend (l_preference_file_path)
			end
			if attached class_list as l_class_list then
				Result.extend (specify_classes_ec_option)
				across l_class_list as ic loop
					Result.extend (ic.item)
				end
			end
		end

feature {EW_RUN_CODE_ANALYSIS_INST} -- Redefinition

	compilation_type: EW_CODE_ANALYSIS_PROCESS
			-- <Precursor>
		do
			check callable: False then
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
		do
			Precursor (test)
		end

feature {NONE} -- Implementation

	load_defaults: BOOLEAN
		-- Was the argument for loading default settings specified?

	preference_file_path: STRING
		-- The path to the preference file to be loaded. Void if preferences should not be loaded.

	class_list: LIST [STRING]
		-- The list of names of classes to be analyzed. Void if the whole system is to be analyzed.

feature {NONE} -- Internal constants

		-- Arguments for this EWeasel command
	load_defaults_ew_option: STRING = "loaddefaults"
	load_preferences_ew_option: STRING = "loadprefs"
	specify_classes_ew_option: STRING = "class"

		-- Arguments to be passed to the compiler.
	code_analysis_ec_option: STRING = "-code-analysis"
	load_defaults_ec_option: STRING = "-cadefaults"
	load_preferences_ec_option: STRING = "-caloadprefs"
	specify_classes_ec_option: STRING = "-caclass"


note
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
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

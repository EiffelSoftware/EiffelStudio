indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_DEFINE_DIR_INST

inherit
	EW_TEST_INSTRUCTION;
	EW_OS_ACCESS;
	EW_STRING_UTILITIES;
	EW_SUBSTITUTION_CONST;

feature

	inst_initialize (line: STRING) is
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [STRING];
			count: INTEGER;
		do
			args := broken_into_words (line);
			count := args.count;
			if count < 3 then
				failure_explanation := "argument count must be at least 3";
				init_ok := False;
			elseif args.first.item (1) = Substitute_char then
				create failure_explanation.make (0);
				failure_explanation.append ("variable being defined cannot start with ");
				failure_explanation.extend (Substitute_char);
				init_ok := False;
			else
				variable := args.first;
				value := make_dir_value (args);
				init_ok := True;
			end;
			if init_ok then
				init_environment.define (variable, value);
			end
		end;

	execute (test: EW_EIFFEL_EWEASEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.  Always successful.
		do
			test.environment.define (variable, value);
		end;

	init_ok: BOOLEAN;
			-- Was last call to `initialize' successful?
	
	execute_ok: BOOLEAN is True;
			-- Calls to `execute' are always successful.

feature {NONE}
	
	variable: STRING;
			-- Name of environment value
	
	value: STRING;
			-- Value to be given to environment value
	
	make_dir_value (args: LIST [STRING]): STRING is
			-- Directory name derived from arguments of `args'
		do
			from
				create Result.make (0);
				args.start;
				args.forth;
				Result.append (args.item);
				args.forth;
			until
				args.after
			loop
				Result := os.full_directory_name (Result, args.item);
				args.forth;
			end
		end
	
indexing
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

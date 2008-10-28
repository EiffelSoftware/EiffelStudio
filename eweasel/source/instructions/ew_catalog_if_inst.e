indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

class EW_CATALOG_IF_INST

inherit
	EW_CATALOG_INSTRUCTION;
	EW_STRING_UTILITIES
		export
			{NONE} all
		end
	EW_KEYWORD_CONST
		export
			{NONE} all
		end

feature

	execute (tcf: EW_TEST_CATALOG_FILE) is
			-- Execute instruction from information in `tcf'.
			-- Set `execute_ok' to indicate whether
			-- execution was successful.
		local
			args: LIST [STRING];
			count, pos: INTEGER;
			orig_args: STRING
			val, controlled_inst, cmd, table_cmd, rest: STRING
			inst: EW_CATALOG_INSTRUCTION
		do
			orig_args := tcf.arguments.twin
			orig_args.left_adjust;
			orig_args.right_adjust;
			args := broken_into_words (orig_args);
			count := args.count;
			if count < 1 then
				failure_explanation := "argument count must be at least 1";
				execute_ok := False;
			else
				if args.first.as_lower.is_equal (Not_keyword) then
					positive := False
					if count < 2 then
						failure_explanation := "argument count for instruction with %"" + Not_keyword + "%" must be at least 2";
						execute_ok := False;
					else
						pos := 2
						execute_ok := True;
					end
				else
					positive := True
					pos := 1
					execute_ok := True;
				end
			end;
			if execute_ok then	-- OK so far
				variable := args.i_th (pos)
				val := tcf.environment.value (variable)
				if positive and val /= Void or not positive and val = Void then
					-- Condition satisified
					controlled_inst := leading_args_removed (orig_args, pos)
					pos :=  first_white_position (controlled_inst);
					if pos <= 0 then
						cmd := controlled_inst;
						create rest.make (0);
					else
						cmd := controlled_inst.substring (1, pos - 1);
						rest := controlled_inst.substring (pos + 1, controlled_inst.count);
					end;
					cmd.to_lower;
					tcf.set_command (cmd)
					tcf.set_arguments (rest)
					table_cmd := cmd
					if not tcf.test_catalog_command_table.has (cmd) then
						table_cmd := Unknown_keyword
					end;
					check
						known_command: tcf.test_catalog_command_table.has (table_cmd)
					end;
					inst := tcf.test_catalog_command_table.item (table_cmd).twin
					inst.execute (tcf);
					execute_ok := inst.execute_ok;
					-- FIXME: add text about "if"
					failure_explanation := inst.failure_explanation
				else
					execute_ok := True
				end
			end
		end;

feature {NONE}
	
	variable: STRING
			-- Name of substitution variable which triggers
			-- execution of test instruction, if it is defined
			-- when `Current' is parsed
	
	positive: BOOLEAN;
			-- Is condition positive (e.g., "if DOTNET")
			-- rather than negative (e.g., "if not DOTNET")?
	
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

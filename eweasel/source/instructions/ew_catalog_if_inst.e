note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

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

	execute (tcf: EW_TEST_CATALOG_FILE)
			-- Execute instruction from information in `tcf'.
			-- Set `execute_ok' to indicate whether
			-- execution was successful.
		local
			args: LIST [READABLE_STRING_32]
			count, pos: INTEGER
			orig_args: STRING_32
			controlled_inst, cmd, table_cmd, rest: STRING_32
			val: READABLE_STRING_32
			inst: EW_CATALOG_INSTRUCTION
		do
			create orig_args.make_from_string (tcf.arguments)
			orig_args.adjust
			args := broken_into_words (orig_args)
			count := args.count
			if count < 1 then
				failure_explanation := {STRING_32} "argument count must be at least 1";
				execute_ok := False;
			else
				if args.first.is_case_insensitive_equal (Not_keyword) then
					positive := False
					if count < 2 then
						failure_explanation := {STRING_32} "argument count for instruction with %"" + Not_keyword + {STRING_32} "%" must be at least 2"
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
					end
					check
						known_command: tcf.test_catalog_command_table.has (table_cmd)
					end
					if attached tcf.test_catalog_command_table.item (table_cmd) as c then
						inst := c.twin
					else
						check from_assertion: False then end
					end
					inst.execute (tcf)
					execute_ok := inst.execute_ok
					-- FIXME: add text about "if"
					failure_explanation := inst.failure_explanation
				else
					execute_ok := True
				end
			end
		end

feature {NONE}

	variable: READABLE_STRING_32
			-- Name of substitution variable which triggers
			-- execution of test instruction, if it is defined
			-- when `Current' is parsed

	positive: BOOLEAN
			-- Is condition positive (e.g., "if DOTNET")
			-- rather than negative (e.g., "if not DOTNET")?

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2020, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	revised_by: "Alexander Kogtenkov"
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

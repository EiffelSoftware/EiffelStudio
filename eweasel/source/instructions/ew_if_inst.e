note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class EW_IF_INST

inherit
	EW_TEST_INSTRUCTION
		redefine
			test_execution_terminated
		end
	EW_STRING_UTILITIES
		export
			{NONE} all
		end
	EW_KEYWORD_CONST
		export
			{NONE} all
		end

feature

	inst_initialize (line: READABLE_STRING_32)
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [READABLE_STRING_32]
			count, pos: INTEGER
			val: READABLE_STRING_32
			controlled_inst, cmd, table_cmd, rest: STRING_32
			i: like instruction
		do
			args := broken_into_words (line)
			count := args.count
			if count < 1 then
				failure_explanation := {STRING_32} "argument count must be at least 1"
				init_ok := False
			else
				if args.first.is_case_insensitive_equal (Not_keyword) then
					positive := False
					if count < 2 then
						failure_explanation := {STRING_32} "argument count for instruction with %"" + Not_keyword + "%" must be at least 2"
						init_ok := False
					else
						pos := 2
						init_ok := True
					end
				else
					positive := True
					pos := 1
					init_ok := True
				end
			end
			if init_ok then	-- OK so far
					-- Name of substitution variable which triggers
					-- execution of test instruction, if it is defined
					-- when `Current' is parsed.
				val := init_environment.value (args.i_th (pos))
				if positive and val /= Void or not positive and val = Void then
					-- Condition satisified
					controlled_inst := leading_args_removed (line, pos)
					pos :=  first_white_position (controlled_inst)
					if pos <= 0 then
						cmd := controlled_inst
						create rest.make_empty
					else
						cmd := controlled_inst.substring (1, pos - 1)
						rest := controlled_inst.substring (pos + 1, controlled_inst.count)
					end
					cmd.to_lower
					table_cmd := cmd
					if not command_table.has (cmd) then
						table_cmd := Unknown_keyword
					end
					check
						known_command: command_table.has (table_cmd)
					end
					if attached command_table.item (table_cmd) as c then
						i := c.twin
						i.initialize_for_conditional (test_control_file, cmd, rest)
						init_ok := i.init_ok
						-- FIXME: add text about "if"
						failure_explanation := i.failure_explanation
						instruction := i
					else
						check from_assertion: False then end
					end
				else
					instruction := Void
				end
			end
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST)
			-- Execute `Current' as one of the
			-- instructions of `test'
		do
			if attached instruction as i then
				i.execute (test)
				execute_ok := i.execute_ok
				test_execution_terminated := i.test_execution_terminated
				failure_explanation := i.failure_explanation
			else
				-- Condition false, so controlled instruction
				-- is skipped
				execute_ok := True
			end
		end

	init_ok: BOOLEAN
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN
			-- Was last call to `execute' successful?

	test_execution_terminated: BOOLEAN
			-- Did last call to `execute' indicate that
			-- execution of test should be terminated?

feature {NONE}

	positive: BOOLEAN
			-- Is condition positive (e.g., "if DOTNET")
			-- rather than negative (e.g., "if not DOTNET")?

	instruction: detachable EW_TEST_INSTRUCTION;
			-- Test instruction to be conditionally executed

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2020, University of Southern California and contributors.
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

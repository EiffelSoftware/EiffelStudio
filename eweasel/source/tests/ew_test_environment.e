note
	description: "An Eiffel test environment."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EW_TEST_ENVIRONMENT

inherit
	EW_SUBSTITUTION_CONST
		export
			{NONE} all
		end
	EW_STRING_UTILITIES
		export
			{NONE} all
		end
	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	EW_SHARED_OBJECTS

create

	make

feature {NONE} -- Creation

	make (n: INTEGER)
			-- Create an environment which can hold at least
			-- `n' environment variable definitions.  The
			-- environment will be automatically resized as
			-- needed to hold new definitions.
		require
			non_negative_size: n >= 0;
		do
			create table.make (n);
			create list.make (0);
				-- We initialize our list of environment variables by using
				-- the environment variables that were used to start the eweasel
				-- process
			environment_variables := starting_environment
			max_c_processes := -1
		ensure
			table_large_enough: table.capacity >= n
		end;

feature  -- Modification

	define (var: READABLE_STRING_32; val: READABLE_STRING_32)
			-- Define environment variable named `var' to
			-- have value `val'.  If `var' already has a
			-- value, override it.
		require
			variable_not_void: var /= Void
			value_not_void: val /= Void
		do
			table.force (val, var)
		end

	remove (var: READABLE_STRING_32)
			-- Remove any association of a value with `var'.
			-- No error if `var' does not have a value.
		require
			variable_not_void: var /= Void
		do
			table.remove (var)
		end

	add_environment_variable (var, val: READABLE_STRING_32)
			-- Add `var' to list of operating system environment
			-- variables to be defined in spawned processes
		require
			variable_not_void: var /= Void;
			value_not_void: val /= Void;
		do
			environment_variables.force (val, var)
		end

	remove_environment_variable (var: READABLE_STRING_32)
			-- Remove `var' from list of operating system environment
			-- variables to be defined in spawned processes
		require
			variable_not_void: var /= Void
		do
			environment_variables.remove (var)
		end

	set_max_c_processes (n: INTEGER)
		do
			max_c_processes := n
		ensure
			max_c_processes_set: max_c_processes = n
		end

feature  -- Properties

	substitute_recursive (a_line: READABLE_STRING_32): STRING_32
			-- Call `substitute' recursively util no '$' found anymore
		require
			not_void: a_line /= Void
		local
			l_temp: STRING_32
			l_stop: BOOLEAN
		do
			from
				Result := a_line
			until
				not Result.has ('$') or l_stop
			loop
				l_temp := substitute (Result)
				if l_temp.is_equal (Result) then
					l_stop := True
				else
					l_stop := False
					Result := l_temp
				end
			end
		ensure
			not_void: Result /= Void
		end

	substitute (line: READABLE_STRING_32): STRING_32
			-- `line' with all environment variables replaced
			-- by their values (or left alone if not in
			-- environment).
		require
			line_not_void: line /= Void;
		local
			k, count, start: INTEGER
			c: CHARACTER_32
			word, replacement: READABLE_STRING_32
			subst_started, in_group: BOOLEAN
		do
			create Result.make (line.count)
			from
				count := line.count
				k := 1
			until
				k > count
			loop
				c := line.item (k)
				if c = Substitute_char then
					if subst_started then
						subst_started := False
						Result.extend (c)
					else
						subst_started := True
					end
				elseif subst_started then
					if c = Left_group_char then
						in_group := True
					else
						from
							start := k
						until
							k > count or not is_identifier_char (line.item (k))
						loop
							k := k + 1
						end;
						k := k - 1
						word := line.substring (start, k)
						replacement := value (word)
						if replacement /= Void then
							Result.append (replacement)
						else
							Result.extend (Substitute_char)
							Result.append (word)
						end
						if in_group then
							in_group := False
							k := k + 1
							-- Skip right paren
						end
						subst_started := False
					end;
				else
					Result.extend (c)
				end;
				k := k + 1
			end;
			if subst_started then
				Result.extend (c)
			end
		end

	value (var: READABLE_STRING_32): detachable READABLE_STRING_32
			-- Value associated with environment variable
			-- `var' (Void if no associated value).
		require
			variable_not_void: var /= Void
		do
			Result := table.item (var)
		end

	replaced_variable (var: READABLE_STRING_32): STRING_32
			-- Find proper argument if possible.
			-- If not found, Result is the orignal argument `var`.
		require
			var_attached: attached var
			var_not_empty: not var.is_empty
		do
			if var.count > 1 and then var [1] = {CHARACTER_32} '$' then
				Result := value (var.substring (2, var.count))
			end
			if not attached Result then
				Result := var
			end
		ensure
			result_attached: attached Result
		end

	max_c_processes: INTEGER
			-- Maximum number of processes to use for
			-- one test for any required C compilations

	environment_variables: HASH_TABLE [READABLE_STRING_32, READABLE_STRING_32]
			-- Operating system environment variable values,
			-- indexed by OS environment variable name

feature {NONE} -- Implementation	

	table: STRING_TABLE [READABLE_STRING_32]
			-- Table which associates environment variable
			-- names (keys) with their values.

	list: ARRAYED_LIST [STRING]
			-- List of operating system environment variables
			-- that have been defined

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
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

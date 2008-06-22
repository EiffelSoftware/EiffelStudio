indexing
	description: "An Eiffel test environment"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/07/16"

class TEST_ENVIRONMENT

inherit
	SUBSTITUTION_CONST
		export
			{NONE} all
		end
	STRING_UTILITIES
		export
			{NONE} all
		end
	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end
	
	SHARED_OBJECTS
		
	ANY

create
	
	make

feature  -- Creation

	make (n: INTEGER) is
			-- Create an environment which can hold at least
			-- `n' environment variable definitions.  The
			-- environment will be automatically resized as
			-- needed to hold new definitions.
		require
			non_negative_size: n >= 0;
		do
			create table.make (n);
			create list.make (0);
			max_c_processes := -1
		ensure
			table_large_enough: table.capacity >= n
		end;

feature  -- Modification

	define (var, val: STRING) is
			-- Define environment variable named `var' to
			-- have value `val'.  If `var' already has a
			-- value, override it.
		require
			variable_not_void: var /= Void;
			value_not_void: val /= Void;
		do
			table.force (val, var);
		end;

	remove (var: STRING) is
			-- Remove any association of a value with `var'.
			-- No error if `var' does not have a value.
		require
			variable_not_void: var /= Void;
		do
			table.remove (var);
		end;

	add_environment_variable (var: STRING) is
			-- Add `var' to list of operating system environment
			-- variables that have been defined.
		require
			variable_not_void: var /= Void;
		do
			list.extend (var);
		end;

	unset_environment_variables is
			-- Unset all operating system environment
			-- variables that have been defined (actually,
			-- set their values to the empty string)
		do
			from
				list.start
			until
				list.after
			loop
				put ("", list.item)
				list.forth
			end
			list.wipe_out
		end;

	set_max_c_processes (n: INTEGER) is
		do
			max_c_processes := n
		ensure
			max_c_processes_set: max_c_processes = n
		end

feature  -- Properties

	substitute (line: STRING): STRING is
			-- `line' with all environment variables replaced
			-- by their values (or left alone if not in
			-- environment).
		require
			line_not_void: line /= Void;
		local
			k, count, start: INTEGER;
			c: CHARACTER;
			word, replacement: STRING;
			subst_started, in_group: BOOLEAN;
		do
			create Result.make (line.count);
			from
				count := line.count;
				k := 1;
			until
				k > count
			loop
				c := line.item (k);
				if c = Substitute_char then
					if subst_started then
						subst_started := False;
						Result.extend (c);
					else
						subst_started := True;
					end
				elseif subst_started then
					if c = Left_group_char then
						in_group := True
					else
						from
							start := k;
						until
							k > count or not is_identifier_char (line.item (k))
						loop
							k := k + 1;
						end;
						k := k - 1;
						word := line.substring (start, k);
						replacement := value (word);
						if replacement /= Void then
							Result.append (replacement);
						else
							Result.extend (Substitute_char);
							Result.append (word);
						end
						if in_group then
							in_group := False
							k := k + 1
							-- Skip right paren
						end
						subst_started := False;
					end;
				else
					Result.extend (c);
				end;
				k := k + 1;
			end;
			if subst_started then
				Result.extend (c);
			end;
		end;

	value (var: STRING): STRING is
			-- Value associated with environment variable
			-- `var' (Void if no associated value).
		require
			variable_not_void: var /= Void;
		do
			Result := table.item (var);
		end;

	max_c_processes: INTEGER
			-- Maximum number of processes to use for
			-- one test for any required C compilations

feature  -- Display

	display is
			-- Display contents of `Current'
		local
			keys: ARRAY [STRING];
			pos: INTEGER;
		do
			keys := table.current_keys;
			from
				pos := keys.lower
			until
				pos > keys.upper
			loop
				output.append (keys.item (pos), False);
				output.append ("%T", False)
				output.append (table.item (keys.item (pos)), False);
				output.append_new_line
				pos := pos + 1;
			end
		end;

feature {NONE} -- Implementation	

	table: HASH_TABLE [STRING, STRING];
			-- Table which associates environment variable
			-- names (keys) with their values.
	
	list: ARRAYED_LIST [STRING];
			-- List of operating system environment variables
			-- that have been defined
	
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

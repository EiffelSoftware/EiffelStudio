indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "93/08/30"

deferred class EW_COPY_INST

inherit
	EW_TEST_INSTRUCTION;
	EW_PREDEFINED_VARIABLES;
	EW_STRING_UTILITIES;
	EW_OS_ACCESS;
	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end
	EW_SHARED_OBJECTS

feature

	inst_initialize (line: STRING) is
			-- Initialize instruction from `line'.  Set
			-- `init_ok' to indicate whether
			-- initialization was successful.
		local
			args: LIST [STRING];
		do
			args := broken_into_words (line);
			if args.count /= 3 then
				failure_explanation := "argument count is not 3";
				init_ok := False;
			else
				inst_initialize_with (args.i_th (1), args.i_th (2), args.i_th (3))
				init_ok := True;
			end
		end;

	inst_initialize_with (a_source_file, a_dest_directory, a_dest_file: STRING) is
			-- Initialize with arguments
		require
			not_void: a_source_file /= Void
			not_void: a_dest_directory /= Void
			not_void: a_dest_file /= Void
		do
			source_file := a_source_file
			dest_directory := a_dest_directory
			dest_file := a_dest_file
		end

	execute (test: EW_EIFFEL_EWEASEL_TEST) is
			-- Execute `Current' as one of the
			-- instructions of `test'.
			-- Set `execute_ok' to indicate whether successful.
		local
			src_name, dest_name: STRING;
			src, dir, dest: like new_file;
			before_date, after_date: INTEGER
			orig_date, final_date: INTEGER

			l_factory: EW_EQA_TEST_FACTORY
		do
			create l_factory
			dest_directory := l_factory.replace_environments (test.environment, dest_directory)

			execute_ok := False;
			src_name := os.full_file_name (test.environment.value (Source_dir_name),
				source_file);
			dest_name := os.full_file_name (dest_directory,
				dest_file);
			src := new_file (src_name)
			ensure_dir_exists (dest_directory);
			dir := new_file (dest_directory)
			if (src.exists and then src.is_plain) and
			   (dir.exists and then dir.is_directory) then
				dest := new_file (dest_name)
				if dest.exists then
					orig_date := dest.date
				else
					orig_date := 0
				end
				if is_fast then
					copy_file (src, test.environment, dest);
					if orig_date /= 0 then
						dest.set_date (orig_date + 1)
					end
				else

					before_date := os.current_time_in_seconds
					from
					until
						not test.copy_wait_required
					loop
						os.sleep_milliseconds (100)
					end;
					after_date := os.current_time_in_seconds

					copy_file (src, test.environment, dest);

					final_date := dest.date

					if final_date <= orig_date then
						-- Work around possible Linux bug
						if after_date <= orig_date then
							output.append_error ("ERROR: After date " + after_date.out + " not greater than original date " + orig_date.out, True)
						else
							dest.set_date (after_date)
							final_date := dest.date
							if final_date /= after_date then
								output.append_error ("ERROR: failed to set dest modification date to " + after_date.out, True)
							end
						end
					end

					check_dates (test.e_compile_start_time, orig_date, final_date, before_date, after_date, dest_name)

					test.unset_copy_wait;
				end
				execute_ok := True;
			elseif not src.exists then
				failure_explanation := "source file not found";
			elseif not src.is_plain then
				failure_explanation := "source file not a plain file";
			elseif not dir.exists then
				failure_explanation := "destination directory not found";
			elseif not dir.is_directory then
				failure_explanation := "destination directory not a directory";
			end

		end;

	check_dates (start_date, orig_date, final_date, before_date, after_date: INTEGER fname: STRING) is
		do
			if final_date <= orig_date then
				output.append_new_line
				output.append_error ("ERROR: final date " + final_date.out +
					" not greater than original date " +
					orig_date.out + " for file " + fname, True)
				output.append ("Compile start = " + start_date.out +
					" Before = " + before_date.out +
					" After = " + after_date.out, True)
			end
		end

	init_ok: BOOLEAN;
			-- Was last call to `initialize' successful?

	execute_ok: BOOLEAN;
			-- Was last call to `execute' successful?

feature -- Properties

	substitute: BOOLEAN is
			-- Should each line of copied file have
			-- environment variable substitution applied to it?
		deferred
		end;

	is_fast: BOOLEAN is
			-- Should "speed" mode be used?
		do
			Result := get (Eweasel_fast_name) /= Void
		end;

feature {NONE}  -- Implementation

	ensure_dir_exists (dir_name: STRING) is
			-- Try to ensure that directory `dir_name' exists
			-- (it is not guaranteed to exist at exit).
		require
			name_not_void: dir_name /= Void
		local
			dir: DIRECTORY;
			tried: BOOLEAN;
		do
			if not tried then
				create dir.make (dir_name);
				if not dir.exists then
					dir.create_dir;
				end;
			end
		rescue
			tried := True;
			retry;
		end

	copy_file (src: like new_file; env: EW_TEST_ENVIRONMENT; dest: like new_file) is
			-- Append lines of file `src', with environment
			-- variables substituted according to `env' (but
			-- only if `substitute' is true) to
			-- file `dest'.
		require
			source_not_void: src /= Void;
			destination_not_void: dest /= Void;
			environment_not_void: env /= Void;
			source_is_closed: src.is_closed;
			destination_is_closed: dest.is_closed;
		local
			line: STRING;
		do
			from
				src.open_read;
				dest.open_write;
			until
				src.end_of_file
			loop
				src.readline;
				if substitute then
					line := env.substitute (src.laststring);
				else
					line := src.laststring;
				end;
				if not src.end_of_file then
					dest.put_string (line);
					dest.new_line;
				elseif not line.is_empty then
					dest.put_string (line);
				end
			end;
			src.close;
			dest.flush;
			dest.close;
		end;

feature {NONE}

	source_file: STRING;
			-- Name of source file (always in source directory)

	dest_file: STRING;
			-- Name of destination file

	dest_directory: STRING;
			-- Name of destination directory

	new_file (a_file_name: STRING): FILE is
			-- Create an instance of FILE.
		require
			a_file_name_not_void: a_file_name /= Void
		deferred
		ensure
			new_file_not_void: Result /= Void
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

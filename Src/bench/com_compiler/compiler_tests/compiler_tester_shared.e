indexing
	description: "Shared components for testing the compiler"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER_TESTER_SHARED
	
inherit
	SHARED_EIFFEL_PROJECT
	
feature -- Access

	epr_filename: STRING is
			-- name of epr loaded
		do
			Result := epr_filename_internal.item	
		end
		
	ace_filename: STRING is
			-- name of ace file
		do
			Result := ace_filename_internal.item	
		end
		
	project_loaded: BOOLEAN is
			-- has a project already been loaded?
		do
			Result := project_loaded_internal.item	
		end
		
	project_manager: TESTING_PROJECT_MANAGER is
			-- active project manager for loaded project
		do
			Result := project_manager_internal.item	
		end
		
	test_failure_count: INTEGER
			-- number of failed tests
		
	test_path: STRING is "C:\ISE.Compiler Testing"
		-- path to save files to
		
	void_keyword: STRING is "Void"
		-- Void keyword for output
		
	last_string: STRING is
			-- last string entered by user
		do
			if last_string_internal.item /= Void then
				Result := clone (last_string_internal.item)				
			end
		end
		
	last_bool: BOOLEAN is
			-- last boolean entered by user
		do
			Result := last_boolean_internal.item
		end
		
feature -- Basic Operations

	load_epr_project (a_epr_filename: STRING): BOOLEAN is
			-- load a compiled project
			-- returns True if loaded
		require
			non_void_epr_filename: a_epr_filename /= Void
			non_empty_epr_filename: not a_epr_filename.is_empty
			epr_filename_exists: (create {RAW_FILE}.make (a_epr_filename)).exists
		do
			if not project_loaded then
				project_manager_internal.put (create {TESTING_PROJECT_MANAGER}.make)
				project_manager.retrieve_eiffel_project (a_epr_filename)
				project_loaded_internal.set_item (True)
				epr_filename_internal.put (a_epr_filename)
				ace_filename_internal.put (project_manager.ace_file_name)
				Result := True
			else
				io.putstring ("%N# A project has already been loaded - exit to restart")
			end
		end
		
	load_ace_project (a_ace_filename: STRING): BOOLEAN is
			-- load just the project settings
			-- returns True if loaded
		require
			non_void_ace_filename: a_ace_filename /= Void
			non_empty_ace_filename: not a_ace_filename.is_empty
			ace_filename_exists: (create {RAW_FILE}.make (a_ace_filename)).exists
		local
			l_test_path: DIRECTORY
		do
			project_manager_internal.put (create {TESTING_PROJECT_MANAGER}.make)
			
			create l_test_path.make (test_path)
			if not l_test_path.exists then
				l_test_path.create_dir
			end
			project_manager.create_eiffel_project (a_ace_filename, test_path)
			ace_filename_internal.put (a_ace_filename)
			Result := True
		end
		
	call_test (a_p: PROCEDURE [ANY, TUPLE [ARRAYED_LIST [STRING]]]; a_args: ARRAYED_LIST [STRING]; a_required_project, a_requires_ace: BOOLEAN) is
			-- call a test method
		require
			non_void_p: a_p /= Void
			non_void_args: a_Args /= Void
		local
			retried: BOOLEAN
			l_able_to_run: BOOLEAN
		do
			l_able_to_run := True
			if a_required_project then
				if project_loaded and Eiffel_project.initialized then
					l_able_to_run := True
				else
					test_failure_count := test_failure_count + 1
					put_string ("%N# Loaded project required for test%N")
				end
			else
				if a_requires_ace then
					if Eiffel_project.initialized and Eiffel_ace /= Void then
						l_able_to_run := True
					else
						test_failure_count := test_failure_count + 1
						put_string ("%N# Loaded ace required for test%N")
					end
				end
			end
			
			if l_able_to_run then
				if not retried then
					a_p.call ([a_args])
					put_string ("%NTest completed successfully%N")
				else
					test_failure_count := test_failure_count + 1
					io.putstring ("%N# Exception was throwing in last call!")
					put_string ("%NTest completed with errors%N")
				end				
			end
		rescue
			retried := True
			retry
		end
		
feature -- Atom Tests

	test_string (a_name: STRING; a_getter: FUNCTION [ANY, TUPLE, STRING]; a_setter: PROCEDURE [ANY, TUPLE [STRING]]; a_test_vals: ARRAY [STRING]) is
			-- test a string function
		require
			non_void_name: a_name /= Void
			non_void_args: a_setter /= Void implies a_test_vals /= Void
		local
			l_index: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%NTesting String " + a_name + ": ")
				if a_getter /= Void then
					put_string ("%N  " + a_name + ": ")
					a_getter.call ([])
					put_string (a_getter.last_result)
				end
				if a_setter /= Void then
					from
						l_index := 1
					until
						l_index > a_test_vals.count
					loop
						test_single_string (a_name, a_getter, a_setter, a_test_vals.item (l_index), l_index)
						l_index := l_index + 1
					end
				end
				put_string ("%N")
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N# TEST FAILED!%N")
			end
		rescue
			retried := True
			retry
		end
		
	test_single_string (a_name: STRING; a_getter: FUNCTION [ANY, TUPLE, STRING]; a_setter: PROCEDURE [ANY, TUPLE [STRING]]; a_value: STRING; a_index: INTEGER) is
			-- test setting a single string value
		require
			non_void_name: a_name /= Void
			non_void_setter: a_setter /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Setting " + a_name + " to: ")
				put_string (a_value)
				a_setter.call ([a_value])
				if a_getter /= Void then
					put_string ("%N    New #" + a_index.out + " " + a_name + "  : ")
					a_getter.call ([])
					put_string (a_getter.last_result)
				end	
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N#   Failed to set " + a_name + " with '")
				put_string (a_value)
				put_string ("'")
			end
		rescue
			retried := True
			retry
		end
		
	test_integer (a_name: STRING; a_getter: FUNCTION [ANY, TUPLE, INTEGER]; a_setter: PROCEDURE [ANY, TUPLE [INTEGER]]; a_test_vals: ARRAY [INTEGER]) is
			-- test a string function
		require
			non_void_name: a_name /= Void
			non_void_args: a_setter /= Void implies a_test_vals /= Void
		local
			l_index: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%NTesting String " + a_name + ": ")
				if a_getter /= Void then
					put_string ("%N  " + a_name + ": ")
					a_getter.call ([])
					put_int (a_getter.last_result)
				end
				if a_setter /= Void then
					from
						l_index := 1
					until
						l_index > a_test_vals.count
					loop
						test_single_integer (a_name, a_getter, a_setter, a_test_vals.item (l_index), l_index)
						l_index := l_index + 1
					end
				end
				put_string ("%N")
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N# TEST FAILED!%N")
			end
		rescue
			retried := True
			retry
		end
		
	test_single_integer (a_name: STRING; a_getter: FUNCTION [ANY, TUPLE, INTEGER]; a_setter: PROCEDURE [ANY, TUPLE [INTEGER]]; a_value: INTEGER; a_index: INTEGER) is
			-- test setting a single string value
		require
			non_void_name: a_name /= Void
			non_void_setter: a_setter /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Setting " + a_name + " to: ")
				put_int (a_value)
				a_setter.call ([a_value])
				if a_getter /= Void then
					put_string ("%N    New #" + a_index.out + " " + a_name + "  : ")
					a_getter.call ([])
					put_int (a_getter.last_result)
				end	
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N#   Failed to set " + a_name + " with '")
				put_int (a_value)
				put_string ("'")
			end
		rescue
			retried := True
			retry
		end
		
	test_boolean (a_name: STRING; a_getter: FUNCTION [ANY, TUPLE, BOOLEAN]; a_setter: PROCEDURE [ANY, TUPLE [BOOLEAN]]; a_test_vals: ARRAY [BOOLEAN]) is
			-- test a string function
		require
			non_void_name: a_name /= Void
			non_void_args: a_setter /= Void implies a_test_vals /= Void
		local
			l_index: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%NTesting String " + a_name + ": ")
				if a_getter /= Void then
					put_string ("%N  " + a_name + ": ")
					a_getter.call ([])
					put_bool (a_getter.last_result)
				end
				if a_setter /= Void then
					from
						l_index := 1
					until
						l_index > a_test_vals.count
					loop
						put_string ("%N  Setting " + a_name + " to: ")
						put_bool (a_test_vals.item (l_index))
						a_setter.call ([a_test_vals.item (l_index)])
						if a_getter /= Void then
							put_string ("%N    New #" + l_index.out + " " + a_name + "  : ")
							a_getter.call ([])
							put_bool (a_getter.last_result)
						end	
						l_index := l_index + 1
					end
				end
				put_string ("%N")
			else
				test_failure_count := test_failure_count + 1
				put_string ("%N# TEST FAILED!%N")
			end
		rescue
			retried := True
			retry
		end
		
feature -- Output

	put_string (s: STRING) is
			-- put a string to output
		do
			if s /= Void then
				io.putstring (s)
			else
				io.putstring (Void_keyword)
			end
		end
		
	put_bool (b: BOOLEAN) is
			-- put a bool to output
		do
			io.put_boolean (b)
		end
		
	put_int (i: INTEGER) is
			-- put an integer to output
		do
			io.put_integer (i)
		end
		
	display_failure_count is
			-- display current number of failures
		do
			put_String ("%N=================================%N")
			put_string ("Current number of failures: ")
			put_int (test_failure_count)
			put_String ("%N=================================%N")
		end
		
feature -- Input

	read_bool is
			-- read a boolean from console
		local
			l_last_string: STRING
		do
			io.read_line
			l_last_string := clone (io.last_string)
			l_last_string.to_lower
			if l_last_string.is_equal ("true") then
				last_boolean_internal := True
			elseif l_last_string.is_equal ("false") then
				last_boolean_internal := False
			else
				io.put_string ("%NPlease use true or false!")
				read_bool
			end
		end

	read_line is
			-- read a line from console
		local
			l_last_string: STRING
		do
			io.read_line
			l_last_string := clone (io.last_string)
			l_last_string.to_lower
			if l_last_string.is_equal ("void") then
				last_string_internal.put (Void)
			else
				last_string_internal.put (io.last_string)
			end
		end
		
	read_args_line (args: ARRAYED_LIST [STRING]) is
			-- read a line from console or uses first items or 'args' if exists
			-- arg item will then be removed
		require
			non_void_args: args /= Void
		local
			l_last_string: STRING
		do
			if args.count > 0 then
				last_string_internal.put (args.first)
				args.go_i_th (1)
				args.remove
			else
				io.read_line
				l_last_string := clone (io.last_string)
				l_last_string.to_lower
				if l_last_string.is_equal ("void") then
					last_string_internal.put (Void)
				else
					last_string_internal.put (io.last_string)
				end
			end
		end
		
feature -- Generators

	random_string_generator (a_contains_whitespace, a_contains_alpha, a_contains_numerical, a_contains_other: BOOLEAN): STRING is
			-- generate a random string of charactes based upon arguments:
			-- if 'a_contains_whitespace' string will contain ' ' '%N' and/or '%T'
			-- if 'a_contains_alpha' string will contain 'A-Z' and/or 'a-z'
			-- if 'a_contains_numerical' string will contain '0-9'
			-- if 'a_contains_other' string will contain other ASCII characters - e.g. '-', '+', '$'
		do
			create Result.make (20)
		end
		
feature {NONE} -- Implementation

	epr_filename_internal: CELL [STRING] is
			-- name of epr loaded
		once
			create Result.put (Void)
		end
		
	ace_filename_internal: CELL [STRING] is
		-- name of ace file
		once
			create Result.put (Void)
		end
		
	project_loaded_internal: BOOLEAN_REF is
		-- has a project already been loaded?
		once
			create Result
			Result.set_item (False)
		end
		
	project_manager_internal: CELL [TESTING_PROJECT_MANAGER] is
		-- active project manager for loaded project
		once
			create Result.put (Void)
		end
		
	last_string_internal: CELL[STRING] is
			-- last string entered by user
		once
			create Result.put (Void)
		end
		
	last_boolean_internal: BOOLEAN_REF;
			-- last bool entered by user
		
		

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class COMPILER_TESTER_SHARED

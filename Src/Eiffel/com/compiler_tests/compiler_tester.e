indexing
	description: "Tests IEIFFEL_COMPILER_INTERFACE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER_TESTER

inherit
	COMPILER_TESTER_SHARED
	
create 
	make
	
feature {NONE} -- Initialization

	make (a_interface: IEIFFEL_COMPILER_INTERFACE) is
			-- create tester for IEIFFEL_COMPILER_INTERFACE interface
		do
			compiler_interface := a_interface
			create menu.make ("IEIFFEL_COMPILER_INTERFACE Tests")
			add_menu_items
			menu.show
		end

feature {NONE} -- Agent Handlers

	on_compile_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'compile' safely
		do
			test_failure_count := 0
			call_test (agent test_compile, args, False, False)
			display_failure_count
		end
		
	test_compile (args: ARRAYED_LIST [STRING]) is
			-- test 'compile'
		do
			put_string ("%NTesting 'compile'")
			compile
		end
		
	on_expand_path_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'expand_path' safely
		do
			test_failure_count := 0
			call_test (agent test_expand_path, args, False, False)
			display_failure_count
		end
		
	test_expand_path (args: ARRAYED_LIST [STRING]) is
			-- test 'expand_path'
		do
			put_string ("%NTesting 'expand_path'")
			put_string ("%N  Enter path: ")
			read_line
			expand_path (last_string)
		end
		
	on_finalize_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'finalize' safely
		do
			test_failure_count := 0
			call_test (agent test_finalize, args, False, False)
			display_failure_count
		end
		
	test_finalize (args: ARRAYED_LIST [STRING]) is
			-- test 'finalize'
		do
			put_string ("%NTesting 'finalize'")
			finalize
		end
		
	on_generate_msil_keyfile_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'generate_msil_keyfile' safely
		do
			test_failure_count := 0
			call_test (agent test_generate_msil_keyfile, args, False, False)
			display_failure_count
		end
		
	test_generate_msil_keyfile (args: ARRAYED_LIST [STRING]) is
			-- test 'generate_msil_keyfile'
		do
			put_string ("%NTesting 'generate_msil_keyfile'")
			put_string ("%N    Enter filename: ")
			read_line
			generate_msil_keyfile (last_string)
		end
		
	on_precompile_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'precompile' safely
		do
			test_failure_count := 0
			call_test (agent test_precompile, args, False, False)
			display_failure_count
		end
		
	test_precompile (args: ARRAYED_LIST [STRING]) is
			-- test 'precompile'
		do
			put_string ("%NTesting 'precompile'")
			precompile
		end
		
	on_remove_file_locks_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'remove_file_locks' safely
		do
			test_failure_count := 0
			call_test (agent test_remove_file_locks, args, False, False)
			display_failure_count
		end
		
	test_remove_file_locks (args: ARRAYED_LIST [STRING]) is
			-- test 'remove_file_locks'
		do
			put_string ("%NTesting 'remove_file_locks'")
			remove_file_locks
		end
		
	on_output_pipe_name_selected (args: ARRAYED_LIST [STRING]) is
			-- test 'output_pipe_name' safely
		do
			test_failure_count := 0
			call_test (agent test_output_pipe_name, args, False, False)
			display_failure_count
		end
		
	test_output_pipe_name (args: ARRAYED_LIST [STRING]) is
			-- test 'output_pipe_name'
		do
			put_string ("%NTesting 'output_pipe_name'")
			test_string ("output_pipe_name", agent compiler_interface.output_pipe_name, agent compiler_interface.set_output_pipe_name, <<"pipe", "c:\ace.ace", "_Sdfsd", "2sdf", "sdf-sdf", "", void>>)
		end

	on_display_selected (args: ARRAYED_LIST [STRING]) is
			-- display properties safely
		do
			test_failure_count := 0
			call_test (agent test_display, args, False, False)
			display_failure_count
		end
		
	test_display (args: ARRAYED_LIST [STRING]) is
			-- display current properties
		do
			display_current_properties
			put_string ("%N")
		end

feature {NONE} -- Output

	display_current_properties is
			-- display 'project_manager_interface' current properties
		do
			put_string ("%N  Current Properties")
			put_string ("%N    freeze_command_arguments=")
			put_string (compiler_interface.freeze_command_arguments)
			put_string ("%N    freeze_command_name=")
			put_string (compiler_interface.freeze_command_name)
			put_string ("%N    freezing_occurred=")
			put_bool (compiler_interface.freezing_occurred)
			put_string ("%N    has_signable_generation=")
			put_bool (compiler_interface.has_signable_generation)
			put_string ("%N    is_output_piped=")
			put_bool (compiler_interface.is_output_piped)
			put_string ("%N    is_successful=")
			put_bool (compiler_interface.is_successful)
			put_string ("%N    output_pipe_name=")
			put_string (compiler_interface.output_pipe_name)
		end
		
	
feature {NONE} -- Implementation

	compile is
			-- compile
		local
			retried: BOOLEAN
			l_compiler: COMPILER
		do
			if not retried then
				put_string ("%N  Testing 'compile'%N")
				l_compiler ?= compiler_interface
				l_compiler.set_output_to_console
				compiler_interface.compile
			else
				put_string ("%N  Failed%N")
			end
		rescue
			retried := True
			retry
		end
		
	expand_path (a_path: STRING) is
			-- expand_path
		local
			retried: BOOLEAN
			l_result: STRING
		do
			if not retried then
				put_string ("%N  Testing 'expand_path' with '")
				put_string (a_path)
				put_string ("'")
				l_result := compiler_interface.expand_path (a_path)
				put_string ("%N    Result=")
				put_string (l_result)
			end
		rescue
			retried := True
			retry
		end
		
	finalize is
			-- finalize
		local
			retried: BOOLEAN
			l_compiler: COMPILER
		do
			if not retried then
				put_string ("%N  Testing 'finalize'%N")
				l_compiler ?= compiler_interface
				l_compiler.set_output_to_console
				compiler_interface.finalize				
			end
		rescue
			retried := True
			retry
		end
		
	generate_msil_keyfile (a_filename: STRING) is
			-- generate_msil_keyfile
		local
			l_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing 'compiler' with '")
				put_string (a_filename)
				put_string ("'")
				if last_string /= Void and not last_string.is_empty then
					create l_file.make (last_string)
					if l_file.exists then
						put_string ("%N  File already exists.")
					end
				end
				compiler_interface.generate_msil_keyfile (last_string)
				put_string ("%N    Result=")
				if l_file /= Void and l_file.exists then
					put_string ("Exists")
				else
					put_string ("Doesnt Exists")
				end
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end
		
	precompile is
			-- precompile
		local
			retried: BOOLEAN
			l_compiler: COMPILER
		do
			if not retried then
				put_string ("%N  Testing 'precompile'%N")
				l_compiler ?= compiler_interface
				l_compiler.set_output_to_console
				compiler_interface.precompile				
			end
		rescue
			retried := True
			retry
		end
		
	remove_file_locks is
			-- remove_file_locks
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing 'remove_file_locks'")
				compiler_interface.remove_file_locks				
			end
		rescue
			retried := True
			retry
		end
		
	add_menu_items is
			-- add menu items to menu
		require
			non_void_menu: menu /= Void
		do
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "Test compile", agent on_compile_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("2", "Test expand_path", agent on_expand_path_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("3", "Test finalize", agent on_finalize_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("4", "Test generate_msil_keyfile", agent on_generate_msil_keyfile_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("5", "Test precompile", agent on_precompile_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("6", "Test remove_file_locks", agent on_remove_file_locks_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("7", "Test output_pipe_name", agent on_output_pipe_name_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("d", "Display Current Properties", agent on_display_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Menu", Void))
			menu.set_return_item (menu.items.last)
		end
		
	menu: CONSOLE_MENU
		-- menu
		
	compiler_interface: IEIFFEL_COMPILER_INTERFACE
		-- IEIFFEL_COMPILER_INTERFACE interface
		
invariant
	non_void_menu: menu /= Void
	non_void_interace: compiler_interface /= Void

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
end -- class COMPILER_TESTER
indexing
	description: "Root object for all compiler testing"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER_TESTS
	
inherit
	COMPILER_TESTER_SHARED
		export
			{ECOM_ISE_REGISTRATION} all
		end
	
create
	make
	
feature {NONE} -- Implementation

	make is
			-- create a compiler tester
		do
			create main_menu.make ("Compiler Test Main Menu")
			add_menu_items
		end
		
feature -- Basic operations

	show_menu is
			-- show main menu
		do
			main_menu.show
		end
		
	load_project (a_filename: STRING): BOOLEAN is
			-- load a project
		local
			l_extension: STRING
		do
			if a_filename /= Void and not a_filename.is_empty then
				l_extension := a_filename.substring (a_filename.count - 3, a_filename.count)
				l_extension.to_lower
				if l_extension.is_equal (".epr") then
					Result := load_epr_project (a_filename)
				elseif l_extension.is_equal (".ace") then
					Result := load_ace_project (a_filename)
				else
					put_string ("%N# Unreconised file type. Make sure file has .epr or .ace extension.")
				end
			else
				put_string ("# WARNING! no project loaded!!!#")
				put_string ("%NKey enter to continue.")
				io.readline
				Result := True
			end
			if not Result then
				put_string ("%N# Could not load the selected file: '" + a_filename + "'")
				io.readline
			end
		end
		

feature {NONE} -- Agents Routines

	on_project_selected (args: ARRAYED_LIST [STRING]) is
			-- go to project manager menu
		local
			l_tests: PROJECT_MANAGER_TESTER
		do
			create l_tests.make
		end

	on_project_properties_selected (args: ARRAYED_LIST [STRING]) is
			-- go to project properties menu
		local
			l_tests: PROJECT_PROPERTIES_TESTER
		do
			create l_tests.make
		end
		
	on_load_project_selected (args: ARRAYED_LIST [STRING]) is
			-- go to load project menu
		local
			--l_menu: LOAD_PROJECT_MENU
			l_result: BOOLEAN
		do
			if args.count > 0 then
				l_result := load_project (args.i_th (1))
			else
				put_string ("%NPlease enter a filename (*.ace or *.epr): ")
				io.read_line
				if not io.last_string.is_empty then
					l_result := load_project (io.last_string)
				else
					put_string ("%NNo project Loaded!")
				end
			end
		end
		
	on_completion_info_selected (args: ARRAYED_LIST [STRING]) is
			-- go to competion info menu
		local
			l_tests: COMPLETION_INFO_TESTER
		do
			create l_tests.make (project_manager.completion_information)
		end
		

	on_system_browser_selected (args: ARRAYED_LIST [STRING]) is
			-- go to system brower menu
		do
			test_failure_count := 0
			call_test (agent test_system_browser, args, True, True)
			display_failure_count
		end
		
	test_system_browser (args: ARRAYED_LIST [STRING]) is
			-- test IEIFFEL_SYSTEM_BROWSER_INTERFACE
		require
			non_void_project_manager: project_manager /= Void
		local
			l_tests: SYSTEM_BROWSER_TESTER
		do
			create l_tests.make (project_manager.system_browser)
		end
		

feature {NONE} -- Implementation

	add_menu_items is
			-- add menu items to menu
		do
			if not Eiffel_project.initialized then
				main_menu.add_item (create {CONSOLE_MENU_ITEM}.make ("load", "Load Project [*.ace|*.epr filename]", agent on_load_project_selected))	
			end
			main_menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "IEIFFEL_PROJECT_INTERFACE", agent on_project_selected))
			main_menu.add_item (create {CONSOLE_MENU_ITEM}.make ("2", "IEIFFEL_COMPLETION_INFO", agent on_completion_info_selected))
			main_menu.add_item (create {CONSOLE_MENU_ITEM}.make ("3", "IEIFFEL_PROJECT_PROPERTIES", agent on_project_properties_selected))
			main_menu.add_item (create {CONSOLE_MENU_ITEM}.make ("4", "IEIFFEL_SYSTEM_BROWSER_INTERFACE", agent on_system_browser_selected))
			
			main_menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Tester", Void))
			main_menu.set_return_item (main_menu.items.last)
		end

	main_menu: CONSOLE_MENU
		-- test menu

invariant
	non_void_main_menu: main_menu /= Void

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
end -- class COMPILER_TESTS

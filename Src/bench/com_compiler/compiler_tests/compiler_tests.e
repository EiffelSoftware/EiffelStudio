indexing
	description: "Root object for all compiler testing"
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
			l_loaded: BOOLEAN
			l_filename: STRING
		do
			if a_filename /= Void and not a_filename.is_empty then
				l_extension := a_filename.substring (a_filename.count - 3, a_filename.count)
				l_extension.to_lower
				if l_extension.is_equal (".epr") then
					Result := load_epr_project (a_filename)
				elseif l_extension.is_equal (".ace") then
					Result := load_ace_project (a_filename)
				else
					io.putstring ("%N# Unreconised file type. Make sure file has .epr or .ace extension.")
				end
			else
				io.putstring ("# WARNING! no project loaded!!!#")
				io.putstring ("%NKey enter to continue.")
				io.readline
				Result := True
			end
			if not Result then
				io.putstring ("%N# Could not load the selected file: '" + a_filename + "'")
				io.readline
			end
		end
		

feature {NONE} -- Agents Routines

	on_project_properties_selected (args: ARRAYED_LIST [STRING]) is
			-- go to project properties menu
		local
			--l_tests: PROJECT_PROPERTIES_TESTER
		do
			--create l_tests.make
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
				--create l_menu.make
			end
		end

feature {NONE} -- Implementation

	add_menu_items is
			-- add menu items to menu
		do
			if not project_loaded then
				main_menu.add_item (create {CONSOLE_MENU_ITEM}.make ("0", "Load Project", agent on_load_project_selected))	
			end
			main_menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "Project Properties Test", agent on_project_properties_selected))
			main_menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Tester", Void))
			main_menu.set_return_item (main_menu.items.last)
		end

	main_menu: CONSOLE_MENU
		-- test menu

invariant
	non_void_main_menu: main_menu /= Void

end -- class COMPILER_TESTS

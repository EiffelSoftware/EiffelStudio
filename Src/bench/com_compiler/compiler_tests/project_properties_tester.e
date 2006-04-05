indexing
	description: "Test Project Properties"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECT_PROPERTIES_TESTER

inherit
	COMPILER_TESTER_SHARED
		export
			{NONE} all
		end
	
create 
	make
	
feature {NONE} -- Initialization

	make is
			-- create tester for project properties
			
		do
			create menu.make ("Project Properties")
			add_menu_items
			menu.show
		end
		
feature {NONE} -- Agent Handlers

	on_test_all_properties (args: ARRAYED_LIST [STRING]) is
			--
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_system_properties, args, False, True)
			call_test (agent test_root_properties, args, False, True)
			call_test (agent test_defaults_properties, args, False, True)
			-- display number of failures
			display_failure_count
		end

	on_system_properties (args: ARRAYED_LIST [STRING]) is
			--
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_system_properties, args, False, True)
			-- display number of failures
			display_failure_count
		end
		
	test_system_properties (args: ARRAYED_LIST [STRING]) is
			--
		local
			l_properties: IEIFFEL_PROJECT_PROPERTIES_INTERFACE
		do
			l_properties := project_manager.project_properties
			put_string ("%NTesting System%N")
			test_string ("System Name", agent l_properties.system_name, agent l_properties.set_system_name, <<"Valid System Name", "2Valid System Name", "_Valid System Name", Void>>)
		end
		
	on_root_properties (args: ARRAYED_LIST [STRING]) is
			--
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_root_properties, args, False, True)
			-- display number of failures
			display_failure_count
		end
		
	test_root_properties (args: ARRAYED_LIST [STRING]) is
			--
		local
			l_properties: IEIFFEL_PROJECT_PROPERTIES_INTERFACE
		do
			l_properties := project_manager.project_properties
			put_string ("%NTesting Root%N")
			test_string ("Root Class Name", agent l_properties.root_class_name, agent l_properties.set_root_class_name, <<"VALID_CLASS_NAME", "Invalid Class Name", "2InvalidClassName", "_InvalidClassName", Void>>)
			test_string ("Creation Routine", agent l_properties.creation_routine, agent l_properties.set_creation_routine, <<"valid_creation_routine", "Invalid Creation Routine", "2InvalidCreationRoutine", "_InvalidCreationRoutine", Void>>)
		end

	on_defaults_properties (args: ARRAYED_LIST [STRING]) is
			--
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_defaults_properties, args, False, True)
			-- display number of failures
			display_failure_count
		end
		
	test_defaults_properties (args: ARRAYED_LIST [STRING]) is
			--
		local
			l_properties: IEIFFEL_PROJECT_PROPERTIES_INTERFACE
--			l_comp_enum: ECOM_X__EIF_COMPILATION_TYPES_ENUM
		do
--			l_properties := project_manager.project_properties
--			put_string ("%NTesting Ace Defaults%N")
--			
--			l_properties.set_company ("sfsdfs")
--			test_string ("Company", agent l_properties.company, agent l_properties.set_company, <<"A Company Name", Void>>)
--			create l_comp_enum
--			test_integer ("Compilation Type", agent l_properties.compilation_type, agent l_properties.set_compilation_type, <<l_comp_enum.Eif_compt_is_application, l_comp_enum.Eif_compt_is_library, 44>>)
--			test_string ("Company", agent l_properties.company, agent l_properties.set_company, <<"A Company Name", Void>>)
--			test_string ("Copyright", agent l_properties.copyright, agent l_properties.set_copyright, <<"Copyright info", Void>>)
--			test_string ("Culture", agent l_properties.culture, agent l_properties.set_culture, <<"en-gb", Void>>)
--			test_boolean ("Debug Info", agent l_properties.debug_info, agent l_properties.set_debug_info, <<True, False>>)
--			test_boolean ("Evaluate Check", agent l_properties.evaluate_check, agent l_properties.set_evaluate_check, <<True, False>>)
--			test_boolean ("Evaluate Ensure", agent l_properties.evaluate_ensure, agent l_properties.set_evaluate_ensure, <<True, False>>)
--			test_boolean ("Evaluate Invariant", agent l_properties.evaluate_invariant, agent l_properties.set_evaluate_invariant, <<True, False>>)
--			test_boolean ("Evaluate Loop", agent l_properties.evaluate_loop, agent l_properties.set_evaluate_loop, <<True, False>>)
--			test_boolean ("Evaluate Require", agent l_properties.evaluate_require, agent l_properties.set_evaluate_require, <<True, False>>)
--			test_string ("Default Namespace", agent l_properties.default_namespace, agent l_properties.set_default_namespace, <<"Default.Namepace", "Default Namepace", "_Default.Namepace", "2Default.Namepace", Void>>)
--			test_string ("Description", agent l_properties.description, agent l_properties.set_description, <<"A Description", Void>>)
--			test_string ("Key File Name", agent l_properties.key_file_name, agent l_properties.set_key_file_name, <<"c:\a key filename.snk", Void>>)
--			test_string ("Precompiled", agent l_properties.precompiled, agent l_properties.set_precompiled, <<"c:\a procompled dir", Void>>)
--			test_string ("Product", agent l_properties.product, agent l_properties.set_product, <<"ISE.Compiler Tester Build", Void>>)
--			test_string ("Title", agent l_properties.title, agent l_properties.set_title, <<"ISE.Compiler Test Edition", Void>>)
--			test_string ("Trademark", agent l_properties.trademark, agent l_properties.set_trademark, <<"Interactive Software Engineering", Void>>)
--			test_string ("Version", agent l_properties.version, agent l_properties.set_version, <<"5.2.0.0", "NoLegalVersion", Void>>)
		end
		
	on_cluster_properties (args: ARRAYED_LIST [STRING]) is
			-- test system cluster properites
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_system_clusters, args, False, True)
			-- display number of failures
			display_failure_count
		end
		
	test_system_clusters (args: ARRAYED_LIST [STRING]) is
			-- create cluster properties test menu
		require
			non_void_project_manager: project_manager /= Void
			non_void_project_properties: project_manager.project_properties /= Void
		local
			l_tests: SYSTEM_CLUSTER_TESTER
		do
			create l_tests.make (project_manager.project_properties.clusters)
		end
		
	on_assembly_properties (args: ARRAYED_LIST [STRING]) is
			--
		do
			-- reset failure count
			test_failure_count := 0
			-- call test(s)
			call_test (agent test_system_assemblies, args, False, True)
			-- display number of failures
			display_failure_count
		end
		
	test_system_assemblies (args: ARRAYED_LIST [STRING]) is
			-- create assembly properties test menu
		require
			non_void_project_manager: project_manager /= Void
			non_void_project_properties: project_manager.project_properties /= Void
		local
			l_tests: SYSTEM_ASSEMBLIES_TESTER
		do
			create l_tests.make (project_manager.project_properties.assemblies)
		end
		
	on_external_properties (args: ARRAYED_LIST [STRING]) is
			-- create external properties test menu
		local
			l_tests: EXTERNAL_PROPERTIES_TESTER
		do
			create l_tests.make (project_manager.project_properties.externals)
		end
		
	on_test_apply (args: ARRAYED_LIST [STRING]) is
			-- test apply
		do
			test_failure_count := 0
			call_test (agent test_apply, args, False, True)
			display_failure_count
		end

	test_apply (args: ARRAYED_LIST [STRING]) is
			--
		do
			project_manager.project_properties.apply
		end
		
feature {NONE} -- Implementation

	add_menu_items is
			-- add menu items to menu
		do
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "Test System Properties", agent on_system_properties))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("2", "Test Root Properties", agent on_root_properties))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("3", "Test Ace Defaults", agent on_defaults_properties))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("4", "Test clusters", agent on_cluster_properties))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("5", "Test assemblies", agent on_assembly_properties))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("6", "Test externals", agent on_external_properties))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("a", "Test All Defaults", agent on_test_all_properties))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("s", "Test apply", agent on_test_apply))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Menu", Void))
			menu.set_return_item (menu.items.last)
		end
		
	menu: CONSOLE_MENU
		
		
invariant
	non_void_menu: menu /= Void

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
end -- class PROJECT_PROPERTIES_TESTER

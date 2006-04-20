indexing
	description: "Tester for IEIFFEL_SYSTEM_ASSEMBIES_INTERFACE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_ASSEMBLIES_TESTER
	
inherit
	COMPILER_TESTER_SHARED
	
create 
	make
	
feature {NONE} -- Initialization

	make (a_interface: like system_assemblies_interface) is
			-- create tester for completion info
		require
			non_void_interface: a_interface /= Void
		do
			system_assemblies_interface := a_interface
			create menu.make ("IEIFFEL_SYSTEM_ASSEMBIES_INTERFACE Tests")
			add_menu_items
			menu.show
		end

feature {NONE} -- Agent Handlers

	on_store_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'store'
		do
			test_failure_count := 0
			call_test (agent test_store, args, False, True)
			display_failure_count
		end
		
	test_store (args: ARRAYED_LIST [STRING]) is
			-- test 'store'
		do
			put_string ("%NTesting 'store'")
			system_assemblies_interface.store
		end

	on_add_assembly_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'add_assembly'
		do
			test_failure_count := 0
			call_test (agent test_add_assembly, args, False, True)
			display_failure_count
		end
		
	test_add_assembly (args: ARRAYED_LIST [STRING]) is
			-- test 'add_assembly'
		local
			l_prefix: STRING
			l_cluster_name: STRING
			l_name: STRING
			l_culture: STRING
			l_version: STRING
			l_key: STRING
		do
			put_string ("%NTesting 'add_assembly'")
			display_assemblies
			put_string ("%N  Enter assembly prefix: ")
			read_line
			l_prefix := last_string
			put_string ("%N  Enter assembly cluster name: ")
			read_line
			l_cluster_name := last_string
			put_string ("%N  Enter assembly name: ")
			read_line
			l_name := last_string
			put_string ("%N  Enter assembly version: ")
			read_line
			l_version := last_string
			put_string ("%N  Enter assembly culture: ")
			read_line
			l_culture := last_string
			put_string ("%N  Enter assembly public key token: ")
			read_line
			l_key := last_string
			add_assembly (l_prefix, l_cluster_name, l_name, l_version, l_culture, l_key)
			display_assemblies
		end
		
	on_add_local_assembly_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'add_local_assembly'
		do
			test_failure_count := 0
			call_test (agent test_add_local_assembly, args, False, True)
			display_failure_count
		end
		
	test_add_local_assembly (args: ARRAYED_LIST [STRING]) is
			-- test 'add_assembly'
		local
			l_prefix: STRING
			l_cluster_name: STRING
			l_path: STRING
		do
			put_string ("%NTesting 'add_assembly'")
			display_assemblies
			put_string ("%N  Enter assembly prefix: ")
			read_line
			l_prefix := last_string
			put_string ("%N  Enter assembly cluster name: ")
			read_line
			l_cluster_name := last_string
			put_string ("%N  Enter assembly path: ")
			read_line
			l_path := last_string
			add_local_assembly (l_prefix, l_cluster_name, l_path)
			display_assemblies
		end

	on_remove_assembly_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'remove_assembly'
		do
			test_failure_count := 0
			call_test (agent test_remove_assembly, args, False, True)
			display_failure_count
		end
		
	test_remove_assembly (args: ARRAYED_LIST [STRING]) is
			-- test 'remove_assembly'
		do
			put_string ("%NTesting 'remove_assembly'")
			display_assemblies
			put_string ("%N  Enter assembly cluster name: ")
			read_line
			remove_assembly (last_string)
			display_assemblies
		end

	on_assemblies_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'assemblies'
		do
			test_failure_count := 0
			call_test (agent test_assemblies, args, False, True)
			display_failure_count
		end
		
	test_assemblies (args: ARRAYED_LIST [STRING]) is
			-- test 'assemblies'
		do
			put_string ("%NTesting 'assemblies'")
			display_assemblies
		end

	on_assembly_properties_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'assembly_properties'
		do
			test_failure_count := 0
			call_test (agent test_assembly_properties, args, False, True)
			display_failure_count
		end
		
	test_assembly_properties (args: ARRAYED_LIST [STRING]) is
			-- test 'assembly_properties'
		do
			put_string ("%NTesting 'assembly_properties'")
			display_assemblies
			if args.count > 0 then
				from 
					args.start
				until
					args.after
				loop
					assembly_properties (args.item)
					args.forth
				end
			else
				put_string ("%N  Choose cluster name: ")
				read_line
				assembly_properties (last_string)
			end
			put_string ("%N")
		end
		
	on_is_valid_cluster_name_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'is_valid_cluster_name'
		do
			test_failure_count := 0
			call_test (agent test_is_valid_cluster_name, args, False, True)
			display_failure_count
		end
		
	test_is_valid_cluster_name (args: ARRAYED_LIST [STRING]) is
			-- test 'is_valid_cluster_name'
		do
			put_string ("%NTesting 'is_valid_cluster_name'")
			
			if args.count > 0 then
				from 
					args.start
				until
					args.after
				loop
					is_valid_cluster_name (args.item)
					args.forth
				end
			else
				put_string ("%NEnter cluster name: ")
				read_line
				is_valid_cluster_name (last_string)
			end
			put_string ("%N")
		end		

	on_is_valid_prefix_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'is_valid_prefix'
		do
			test_failure_count := 0
			call_test (agent test_is_valid_prefix, args, False, True)
			display_failure_count
		end
		
	test_is_valid_prefix (args: ARRAYED_LIST [STRING]) is
			-- test 'is_valid_prefix'
		do
			put_string ("%NTesting 'is_valid_prefix'")
			
			if args.count > 0 then
				from 
					args.start
				until
					args.after
				loop
					is_valid_prefix (args.item)
					args.forth
				end
			else
				put_string ("%NEnter prefix: ")
				read_line
				is_valid_prefix (last_string)
			end
			put_string ("%N")
		end


	on_contains_assembly_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'contains_assembly'
		do
			test_failure_count := 0
			call_test (agent test_contains_assembly, args, False, True)
			display_failure_count
		end
		
	test_contains_assembly (args: ARRAYED_LIST [STRING]) is
			-- test 'contains_assembly'
		do
			put_string ("%NTesting 'contains_assembly'")
			display_assemblies
			if args.count > 0 then
				from 
					args.start
				until
					args.after
				loop
					contains_assembly (args.item)
					args.forth
				end
			else
				put_string ("%N  Enter assembly cluster name: ")
				read_line
				contains_assembly (last_string)
			end
			put_string ("%N")
		end

	on_contains_gac_assembly_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'contains_gac_assembly'
		do
			test_failure_count := 0
			call_test (agent test_contains_gac_assembly, args, False, True)
			display_failure_count
		end
		
	test_contains_gac_assembly (args: ARRAYED_LIST [STRING]) is
			-- test 'contains_gac_assembly'
		local
			l_name: STRING
			l_version: STRING
			l_culture: STRING
			l_key: STRING
		do
			put_string ("%NTesting 'contains_gac_assembly'")
			display_assemblies
			put_string ("%N  Enter assembly name: ")
			read_line
			l_name := last_string
			put_string ("%N  Enter assembly version: ")
			read_line
			l_version := last_string
			put_string ("%N  Enter assembly culture: ")
			read_line
			l_culture := last_string
			put_string ("%N  Enter assembly public key token: ")
			read_line
			l_key := last_string
			contains_gac_assembly (l_name, l_version, l_culture, l_key)
			put_string ("%N")
		end
		
	on_contains_local_assembly_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'contains_local_assembly'
		do
			test_failure_count := 0
			call_test (agent test_contains_local_assembly, args, False, True)
			display_failure_count
		end
		
	test_contains_local_assembly (args: ARRAYED_LIST [STRING]) is
			-- test 'contains_local_assembly'
		do
			put_string ("%NTesting 'contains_local_assembly'")
			display_assemblies
			if args.count > 0 then
				from 
					args.start
				until
					args.after
				loop
					contains_local_assembly (args.item)
					args.forth
				end
			else
				put_string ("%N  Enter assembly path: ")
				read_line
				contains_local_assembly (last_string)
			end
			put_string ("%N")
		end

	on_cluster_name_from_gac_assembly_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'cluster_name_from_gac_assembly'
		do
			test_failure_count := 0
			call_test (agent test_cluster_name_from_gac_assembly, args, False, True)
			display_failure_count
		end
		
	test_cluster_name_from_gac_assembly (args: ARRAYED_LIST [STRING]) is
			-- test 'cluster_name_from_gac_assembly'
		local
			l_name: STRING
			l_version: STRING
			l_culture: STRING
			l_key: STRING
		do
			put_string ("%NTesting 'cluster_name_from_gac_assembly'")
			display_assemblies
			put_string ("%N  Enter assembly name: ")
			read_line
			l_name := last_string
			put_string ("%N  Enter assembly version: ")
			read_line
			l_version := last_string
			put_string ("%N  Enter assembly culture: ")
			read_line
			l_culture := last_string
			put_string ("%N  Enter assembly public key token: ")
			read_line
			l_key := last_string
			cluster_name_from_gac_assembly (l_name, l_version, l_culture, l_key)
			put_string ("%N")
		end

	on_cluster_name_from_local_assembly_selected (args: ARRAYED_LIST [STRING]) is
			-- test safely 'cluster_name_from_local_assembly'
		do
			test_failure_count := 0
			call_test (agent test_cluster_name_from_local_assembly, args, False, True)
			display_failure_count
		end
		
	test_cluster_name_from_local_assembly (args: ARRAYED_LIST [STRING]) is
			-- test 'cluster_name_from_local_assembly'
		do
			put_string ("%NTesting 'cluster_name_from_local_assembly'")
			display_assemblies
			if args.count > 0 then
				from 
					args.start
				until
					args.after
				loop
					cluster_name_from_local_assembly (args.item)
					args.forth
				end
			else
				put_string ("%N  Enter assembly path: ")
				read_line
				cluster_name_from_local_assembly (last_string)
			end
			put_string ("%N")
		end
		
	on_test_assembly_properties_selected (args: ARRAYED_LIST [STRING]) is
			-- test IEIFFEL_ASSEMBLY_PROPERTIES
		do
			test_failure_count := 0
			call_test (agent test_test_assembly_properties, args, False, True)
			display_failure_count
		end
		
	test_test_assembly_properties (args: ARRAYED_LIST [STRING]) is
			-- test IEIFFEL_ASSEMBLY_PROPERTIES
		local
			l_menu: ASSEMBLY_PROPERTIES_TESTER
		do
			display_assemblies
			put_string ("%N  Enter assembly cluster name to test: ")
			read_line
			if last_string /= Void and not last_string.is_empty then
				--create	l_menu.make (system_assemblies_interface.assembly_properties (last_string))
			end
		end
		
feature {NONE} -- Output
	
	display_assemblies is
			-- display assembly list
		local
			l_enum_assemblies: IENUM_ASSEMBLY_INTERFACE
			l_assembly: CELL [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE]
			l_index: INTEGER
		do
			put_string ("%N  Current Assemblies")
			--l_enum_assemblies := system_assemblies_interface.assemblies
			if l_enum_assemblies /= Void then
				if l_enum_assemblies.count > 0 then
					from
						l_index := 1
					until
						l_index > l_enum_assemblies.count
					loop
						create l_assembly.put (Void)
						l_enum_assemblies.ith_item (l_index, l_assembly)
						put_string ("%N    ")
						if l_assembly.item.is_local then
							put_string ("{LOCAL} (")
						else
							put_string ("{GAC}   (")
						end
						put_string (l_assembly.item.assembly_cluster_name)
						put_string (") ")
						put_string (l_assembly.item.assembly_prefix)
						put_string (" ")
						put_string (l_assembly.item.assembly_name)
						put_string (", ")
						put_string (l_assembly.item.assembly_version)
						put_string (", ")
						put_string (l_assembly.item.assembly_culture)
						put_string (", ")
						put_string (l_assembly.item.assembly_public_key_token)
						l_index := l_index + 1
					end
				else
					put_string ("%N    <NONE>")
				end
			else
				put_string ("%N    Void")
			end

		end
		
feature {NONE} -- Implementation

	add_assembly (a_prefix, a_cluster_name, name, version, culture, public_key:STRING) is
			-- test add_assembly
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing 'add_assembly' with '")
				put_string (a_prefix)
				put_string ("', '")
				put_string (a_cluster_name)
				put_string ("', '")
				put_string (name)
				put_string ("', '")
				put_string (version)
				put_string ("', '")
				put_string (culture)
				put_string ("', '")
				put_string (public_key)
				put_string ("'")
				--system_assemblies_interface.add_assembly (a_prefix, a_cluster_name, name, version, culture, public_key)
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end
		
	add_local_assembly (a_prefix, a_cluster_name, a_path:STRING) is
			-- test add_local_assembly
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing 'add_local_assembly' with '")
				put_string (a_prefix)
				put_string ("', '")
				put_string (a_cluster_name)
				put_string ("', '")
				put_string (a_path)
				put_string ("'")
				--system_assemblies_interface.add_local_assembly (a_prefix, a_cluster_name, a_path)
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end
		
	remove_assembly (a_cluster_name: STRING) is
			-- test add_assembly
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing 'add_assembly' with '")
				put_string (a_cluster_name)
				put_string ("'")
				--system_assemblies_interface.remove_assembly (a_cluster_name)
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end		
		
	assembly_properties (a_cluster_name:STRING) is
			-- test assembly_properties
		local
			retried: BOOLEAN
			l_assembly_properties: IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE
		do
			if not retried then
				put_string ("%N  Testing 'assembly_properties' with '")
				put_string (a_cluster_name)
				put_string ("'")
				--l_assembly_properties := system_assemblies_interface.assembly_properties (a_cluster_name)
				put_string ("%N    Result=")
				if l_assembly_properties /= Void then
					put_string (l_assembly_properties.assembly_name)
				else
					put_string (Void)
				end
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end

	is_valid_cluster_name (a_cluster_name: STRING) is
			-- is_valid_cluster_name test
		local
			l_result: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing 'is_valid_cluster_name' with '")
				put_string (a_cluster_name)
				put_string ("'")
				--l_result := system_assemblies_interface.is_valid_cluster_name (a_cluster_name)
				put_string ("%N    Result=")
				put_bool (l_result)
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end
		
	is_valid_prefix (a_prefix: STRING) is
			-- is_valid_prefix test
		local
			l_result: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing 'is_valid_prefix' with '")
				put_string (a_prefix)
				put_string ("'")
				--l_result := system_assemblies_interface.is_valid_prefix (a_prefix)
				put_string ("%N    Result=")
				put_bool (l_result)
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end
		
	
	contains_assembly (a_cluster_name: STRING) is
			-- contains_assembly test
		local
			l_result: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing 'contains_assembly' with '")
				put_string (a_cluster_name)
				put_string ("'")
				--l_result := system_assemblies_interface.contains_assembly (a_cluster_name)
				put_string ("%N    Result=")
				put_bool (l_result)
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end

	contains_gac_assembly (a_name, a_version, a_culture, a_key: STRING) is
			-- contains_gac_assembly test
		local
			l_result: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing 'contains_gac_assembly' with '")
				put_string (a_name)
				put_string ("', '")
				put_string (a_version)
				put_string ("', '")
				put_string (a_culture)
				put_string ("', '")
				put_string (a_key)
				put_string ("'")
				--l_result := system_assemblies_interface.contains_gac_assembly (a_name, a_version, a_culture, a_key)
				put_string ("%N    Result=")
				put_bool (l_result)
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end
		
	contains_local_assembly (a_path: STRING) is
			-- contains_assembly test
		local
			l_result: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing 'contains_local_assembly' with '")
				put_string (a_path)
				put_string ("'")
				--l_result := system_assemblies_interface.contains_local_assembly (a_path)
				put_string ("%N    Result=")
				put_bool (l_result)
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end
		
	cluster_name_from_gac_assembly (a_name, a_version, a_culture, a_key: STRING) is
			-- contains_gac_assembly test
		local
			l_result: STRING
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing 'contains_gac_assembly' with '")
				put_string (a_name)
				put_string ("', '")
				put_string (a_version)
				put_string ("', '")
				put_string (a_culture)
				put_string ("', '")
				put_string (a_key)
				put_string ("'")
				--l_result := system_assemblies_interface.cluster_name_from_gac_assembly (a_name, a_version, a_culture, a_key)
				put_string ("%N    Result=")
				put_string (l_result)
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end
		
	cluster_name_from_local_assembly (a_path: STRING) is
			-- contains_assembly test
		local
			l_result: STRING
			retried: BOOLEAN
		do
			if not retried then
				put_string ("%N  Testing 'contains_local_assembly' with '")
				put_string (a_path)
				put_string ("'")
				--l_result := system_assemblies_interface.cluster_name_from_local_assembly (a_path)
				put_string ("%N    Result=")
				put_string (l_result)
			else
				put_string ("%N# Failed!")
			end
		rescue
			retried := True
			retry
		end
			
	add_menu_items is
			-- add menu items to menu
		do
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "Test add_assembly", agent on_add_assembly_selected))		
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("2", "Test add_local_assembly", agent on_add_local_assembly_selected))		
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("3", "Test remove_assembly", agent on_remove_assembly_selected))		
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("4", "Test assemblies", agent on_assemblies_selected))		
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("5", "Test assembly_properties", agent on_assembly_properties_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("6", "Test is_valid_cluster_name", agent on_is_valid_cluster_name_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("7", "Test is_valid_prefix", agent on_is_valid_prefix_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("9", "Test contains_assembly", agent on_contains_assembly_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("10", "Test contains_gac_assembly", agent on_contains_gac_assembly_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("11", "Test contains_local_assembly", agent on_contains_local_assembly_selected))		
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("12", "Test cluster_name_from_gac_assembly", agent on_cluster_name_from_gac_assembly_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("13", "Test cluster_name_from_local_assembly", agent on_cluster_name_from_local_assembly_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("p", "Test IEIFFEL_ASSEMBLY_PROPERTIES", agent on_test_assembly_properties_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("s", "Test store", agent on_store_selected))
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Menu", Void))
			menu.set_return_item (menu.items.last)
		end
		
	menu: CONSOLE_MENU
		-- menu
		
	system_assemblies_interface: IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE
		-- SYSTEM_ASSEMBLIES interface
		
invariant
	non_void_menu: menu /= Void
	non_void_interace: system_assemblies_interface /= Void
	
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
end -- class SYSTEM_ASSEMBLIES_TESTER

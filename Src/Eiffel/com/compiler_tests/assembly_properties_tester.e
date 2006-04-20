indexing
	description: "Tests for IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_PROPERTIES_TESTER

inherit
	COMPILER_TESTER_SHARED
	
create 
	make
	
feature {NONE} -- Initialization

	make (a_interface: like assembly_properties_interface) is
			-- create tester for completion info
		require
			non_void_interface: a_interface /= Void
		do
			assembly_properties_interface := a_interface
			create menu.make ("IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE Tests")
			add_menu_items
			menu.show
		end

feature {NONE} -- Agent Handlers

	on_assembly_prefix_selected (args: ARRAYED_LIST [STRING]) is
			-- safely test 'assembly_prefix'
		do
			test_failure_count := 0
			cache_current_properties
			call_test (agent test_assembly_prefix, args, False, True)
			diff_properties
			display_failure_count
		end

	test_assembly_prefix (args: ARRAYED_LIST [STRING]) is
			-- test 'assembly_prefix'
		do
			put_string ("%NTesting 'assembly_prefix'")
			put_string ("%N  assembly_prefix=")
			put_string (assembly_properties_interface.assembly_prefix)
			put_string ("%N Enter a new prefix: ")
			read_line
			set_assembly_prefix (last_string)
		end
		
	on_display_selected (args: ARRAYED_LIST [STRING]) is
			-- display all assembly properties
		do
			display_properties
		end

feature {NONE} -- Output

	display_properties is
			-- display all of an assemblies properties
		do
			put_string ("%N  Current Assembly Properties")
			put_string ("%N    is_local=")
			put_bool (assembly_properties_interface.is_local)
			put_string ("%N    assembly_prefix=")
			put_string (assembly_properties_interface.assembly_prefix)
			put_string ("%N    assembly_name=")
			put_string (assembly_properties_interface.assembly_name)
			put_string ("%N    assembly_version=")
			put_string (assembly_properties_interface.assembly_version)
			put_string ("%N    assembly_culture=")
			put_string (assembly_properties_interface.assembly_culture)
			put_string ("%N    assembly_cluster_name=")
			put_string (assembly_properties_interface.assembly_cluster_name)
			put_string ("%N    assembly_public_key_token=")
			put_string (assembly_properties_interface.assembly_public_key_token)
			put_string ("%N    is_prefix_read_only=")
			put_bool (assembly_properties_interface.is_prefix_read_only)
			put_string ("%N  End%N")
		end
		
	diff_properties is
			-- display the difference in properties
		require
			cached_called: cached_called
		do
			put_string ("%N  Diff Assembly Properties")
			if is_local /= assembly_properties_interface.is_local then
				put_string ("%N    is_local=")
				put_bool (is_local)
				put_string (" => ")
				put_bool (assembly_properties_interface.is_local)
			end
			if not assembly_prefix.is_equal (assembly_properties_interface.assembly_prefix) then
				put_string ("%N    assembly_prefix=")
				put_string (assembly_prefix)
				put_string (" => ")
				put_string (assembly_properties_interface.assembly_prefix)
			end
			if not assembly_name.is_equal (assembly_properties_interface.assembly_name) then
				put_string ("%N    assembly_name=")
				put_string (assembly_name)
				put_string (" => ")
				put_string (assembly_properties_interface.assembly_name)
			end
			if not assembly_version.is_equal (assembly_properties_interface.assembly_version) then
				put_string ("%N    assembly_version=")
				put_string (assembly_version)
				put_string (" => ")
				put_string (assembly_properties_interface.assembly_version)
			end
			if not assembly_culture.is_equal (assembly_properties_interface.assembly_culture) then
				put_string ("%N    assembly_culture=")
				put_string (assembly_culture)
				put_string (" => ")
				put_string (assembly_properties_interface.assembly_culture)
			end
			if not assembly_cluster_name.is_equal (assembly_properties_interface.assembly_cluster_name) then
				put_string ("%N    assembly_cluster_name=")
				put_string (assembly_cluster_name)
				put_string (" => ")
				put_string (assembly_properties_interface.assembly_cluster_name)
			end
			if not assembly_public_key_token.is_equal (assembly_properties_interface.assembly_public_key_token) then
				put_string ("%N    assembly_public_key_token=")
				put_string (assembly_public_key_token)
				put_string (" => ")
				put_string (assembly_properties_interface.assembly_public_key_token)
			end
			put_string ("%N  End%N")
		end
		

feature {NONE} -- Implementation

	set_assembly_prefix (a_prefix: STRING) is
			-- test set_assembly_prefix
		local
			retried: BOOLEAN
		do
			if not retried then
				put_string ("Testing assembly_prefix with '")
				put_string (a_prefix)
				put_string ("'")
				put_string ("%N    assembly_prefix=")
				put_string (a_prefix)
				assembly_properties_interface.set_assembly_prefix (a_prefix)
			else
				put_string ("%N#   Failed%N")
			end
		rescue
			retried := True
			retry
		end
		
	cache_current_properties is
			-- cache current properties for diff
		do
			is_local := assembly_properties_interface.is_local
			assembly_prefix := assembly_properties_interface.assembly_prefix
			assembly_name := assembly_properties_interface.assembly_name
			assembly_version := assembly_properties_interface.assembly_version
			assembly_culture := assembly_properties_interface.assembly_culture
			assembly_cluster_name := assembly_properties_interface.assembly_cluster_name
			assembly_public_key_token := assembly_properties_interface.assembly_public_key_token
			cached_called := True
		end
		

	add_menu_items is
			-- add menu items to menu
		do
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("1", "Test assembly_prefix", agent on_assembly_prefix_selected))		
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("d", "Display Current Properties", agent on_display_selected))		
			menu.add_item (create {CONSOLE_MENU_ITEM}.make ("x", "Exit Menu", Void))
			menu.set_return_item (menu.items.last)
		end

	menu: CONSOLE_MENU
			-- menu

	assembly_properties_interface: IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE
			-- assembly properties interface
			
	cached_called: BOOLEAN
		-- has 'cache_current_properties' been called?
			
	is_local: BOOLEAN
	assembly_prefix: STRING
	assembly_name: STRING
	assembly_version: STRING
	assembly_culture: STRING
	assembly_cluster_name: STRING
	assembly_public_key_token: STRING
			-- cached assembly properties

invariant
	non_void_interface: assembly_properties_interface /= Void
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
end -- class ASSEMBLY_PROPERTIES_TESTER

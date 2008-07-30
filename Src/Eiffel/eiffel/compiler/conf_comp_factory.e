indexing
	description: "Factory for configuration objects, used by the compiler."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_COMP_FACTORY

inherit
	CONF_FACTORY
		redefine
			new_class,
			new_class_assembly,
			new_class_partial,
			new_cluster,
			new_test_cluster,
			new_override,
			new_physical_assembly,
			new_assertions
		end

feature

	new_class (a_file_name: STRING; a_group: CLUSTER_I; a_path: STRING): EIFFEL_CLASS_I is
			-- Create a `CONF_CLASS' object.
		do
			create Result.make (a_file_name, a_group, a_path, Current)
		end

	new_class_assembly (a_name, a_dotnet_name: STRING; an_assembly: ASSEMBLY_I; a_position: INTEGER): EXTERNAL_CLASS_I is
			-- Create a `CONF_CLASS_ASSEMBLY' object.
		do
			create Result.make_assembly_class (a_name, a_dotnet_name, an_assembly, a_position, Current)
		end

	new_class_partial (a_partial_classes: ARRAYED_LIST [STRING]; a_group: CLUSTER_I; a_base_location: CONF_DIRECTORY_LOCATION): PARTIAL_EIFFEL_CLASS_I is
			-- Create a `CONF_CLASS_PARTIAL' object.
		do
			create Result.make_from_partial (a_partial_classes, a_group, a_base_location, Current)
		end

	new_cluster (a_name: STRING; a_directory: CONF_DIRECTORY_LOCATION; a_target: CONF_TARGET): CLUSTER_I is
			-- Create a `CONF_CLUSTER' object.
		do
			create Result.make (a_name, a_directory, a_target)
		end

	new_test_cluster (a_name: STRING; a_directory: CONF_DIRECTORY_LOCATION; a_target: CONF_TARGET): TEST_CLUSTER_I is
			-- Create a `CONF_CLUSTER' object.
		do
			create Result.make (a_name, a_directory, a_target)
		end

	new_override (a_name: STRING; a_directory: CONF_DIRECTORY_LOCATION; a_target: CONF_TARGET): OVERRIDE_I is
			-- Create a `CONF_OVERRIDE' object.
		do
			create Result.make (a_name, a_directory, a_target)
		end

	new_physical_assembly (a_consumed: CONSUMED_ASSEMBLY; a_cache_path: DIRECTORY_NAME; a_target: CONF_TARGET): ASSEMBLY_I is
			-- Create a `CONF_PHYSICAL_ASSEMBLY' object.
		do
			create Result.make_from_consumed (a_consumed, a_cache_path, a_target)
		end

	new_assertions: ASSERTION_I is
			-- Create a `CONF_ASSERTIONS' object.
		do
			create Result
		end

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
end

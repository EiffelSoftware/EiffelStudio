indexing
	description: "Factory for configuration objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FACTORY

inherit
	CONF_PARSE_FACTORY

feature

	new_class (a_file_name: STRING; a_group: CONF_CLUSTER; a_path: STRING; a_classname: STRING): CONF_CLASS is
			-- Create a `CONF_CLASS' object.
		require
			a_file_name_ok: a_file_name /= Void and then not a_file_name.is_empty
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
			a_classname_not_void: a_classname /= Void
			a_classname_not_empty: not a_classname.is_empty
		do
			create Result.make (a_file_name, a_group, a_path, a_classname, Current)
		ensure
			Result_not_void: Result /= Void
		end

	new_class_assembly (a_name, a_dotnet_name: STRING; an_assembly: CONF_PHYSICAL_ASSEMBLY; a_position: INTEGER): CONF_CLASS_ASSEMBLY is
			-- Create a `CONF_CLASS_ASSEMBLY' object.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_upper: a_name.is_equal (a_name.as_upper)
			a_dotnet_name_ok: a_dotnet_name /= Void and then not a_dotnet_name.is_empty
			an_assembly_not_void: an_assembly /= Void
			a_position_ok: a_position >= 0
		do
			create Result.make_assembly_class (a_name, a_dotnet_name, an_assembly, a_position, Current)
		ensure
			Result_not_void: Result /= Void
		end

	new_class_partial (a_partial_classes: ARRAYED_LIST [STRING]; a_group: CONF_CLUSTER; a_base_location: CONF_DIRECTORY_LOCATION): CONF_CLASS_PARTIAL is
			-- Create a `CONF_CLASS_PARTIAL' object.
		require
			a_partial_classes_not_void: a_partial_classes /= Void
			a_group_not_void: a_group /= Void
			a_base_location_not_void: a_base_location /= Void
		do
			create Result.make_from_partial (a_partial_classes, a_group, a_base_location, Current)
		ensure
			Result_not_void: Result /= Void
		end

	new_physical_assembly (a_consumed: CONSUMED_ASSEMBLY; a_cache_path: DIRECTORY_NAME; a_target: CONF_TARGET): CONF_PHYSICAL_ASSEMBLY is
			-- Create a `CONF_PHYSICAL_ASSEMBLY' object.
		require
			a_consumed_not_void: a_consumed /= Void
			a_cache_path_not_void: a_cache_path /= Void
			a_target_not_void: a_target /= Void
		do
			create Result.make_from_consumed (a_consumed, a_cache_path, a_target)
		ensure
			Result_not_void: Result /= Void
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end

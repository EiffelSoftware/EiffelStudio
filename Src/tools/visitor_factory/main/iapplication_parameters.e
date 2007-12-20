indexing
	description: "[
		Interface for raw application options passed via user interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	IAPPLICATION_PARAMETERS

feature -- Access

	included_files: LIST [STRING] is
			-- Included file/folder paths passed via command line
		require
			is_readable: is_readable
		deferred
		end

	exclude_expressions: LIST [STRING] is
			-- Exclude file/folder expressions passed via command line
		require
			is_readable: is_readable
		deferred
		end

	class_name: STRING is
			-- Output class name
		require
			is_readable: is_readable
			has_class_name: has_class_name
		deferred
		end

	user_data_class_name: STRING is
			-- User data class name
		require
			is_readable: is_readable
			use_user_data: use_user_data
		deferred
		end

	use_user_data: BOOLEAN is
			-- Inidicates if a user data class name was passed via command line
		require
			is_readable: is_readable
		deferred
		end

	generate_stub: BOOLEAN is
			-- Indiciates if a stub class file should be generated
		require
			is_readable: is_readable
		deferred
		end

	generate_interface: BOOLEAN is
			-- Indiciates if a interface class file should be generated
		require
			is_readable: is_readable
		deferred
		end

	generate_process_routines: BOOLEAN is
			-- Should we generate `process' routines for each class being added to the visitor?
		require
			is_readable: is_readable
		deferred
		end

	recurse_directories: BOOLEAN is
			-- Inidicates if user specified to recursively scan included directories
		require
			is_readable: is_readable
		deferred
		end

feature -- Status report

	has_class_name: BOOLEAN is
			-- Inidicates if a class name was passed via command line
		require
			is_readable: is_readable
		deferred
		end

	is_readable: BOOLEAN is
			-- Indiciates if application options can be read.
		deferred
		end

;indexing
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

end -- class {IAPPLICATION_PARAMETERS}

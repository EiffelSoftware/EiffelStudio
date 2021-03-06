note
	description: "Compilation contextual infomation shared between consumer and compiler"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_COMPILATION_CONTEXT

feature -- Access

	root_class_name: STRING
			-- Name of root class
			
	root_creation_routine_name: STRING
			-- Name of root creation routine

	precompile_file: STRING
			-- Path to precompile definition file

	namespace: STRING
			-- Namespace in which type should be generated

feature -- Element Settings

	set_root_class_name (a_name: like root_class_name)
			-- Set `root_class_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			root_class_name := a_name
		ensure
			root_class_name_set: root_class_name = a_name
		end
		
	set_root_creation_routine_name (a_name: like root_creation_routine_name)
			-- Set `root_class_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			root_creation_routine_name := a_name
		ensure
			root_creation_routine_name_set: root_creation_routine_name = a_name
		end
	
	set_precompile_file (a_file: like precompile_file)
			-- Set `precompile_file' with `a_file'.
		do
			precompile_file := a_file
		ensure
			precompile_file_set: precompile_file = a_file
		end

	set_namespace (a_namespace: like namespace)
			-- Set `namespace' with `a_namespace'.
		do
			namespace := a_namespace
		ensure
			namespace_set: namespace = a_namespace
		end

note
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
end -- class CODE_COMPILATION_CONTEXT


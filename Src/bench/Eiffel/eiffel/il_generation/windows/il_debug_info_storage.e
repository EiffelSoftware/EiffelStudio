indexing
	description: "Objects used to store and retrieve data for IL Debug Information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_DEBUG_INFO_STORAGE

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			system_name := Void
			project_path := Void			
			modules_debugger_info := Void
			class_types_debugger_info := Void
		end

feature -- Data

	system_name: STRING

	project_path: STRING

	modules_debugger_info: HASH_TABLE [IL_DEBUG_INFO_FROM_MODULE, STRING]

	class_types_debugger_info: HASH_TABLE [IL_DEBUG_INFO_FROM_CLASS_TYPE, INTEGER]

feature -- Change

	set_system_name (val: like system_name) is
			-- Change value
		require
		do
			system_name := val
		end

	set_project_path (val: like project_path) is
			-- Change value
		require
		do
			project_path := val
		end
		
	set_modules_debugger_info (val: like modules_debugger_info) is
			-- Change value
		require
		do
			modules_debugger_info := val
		end

	set_class_types_debugger_info (val: like class_types_debugger_info) is
			-- Change value
		require
		do
			class_types_debugger_info := val
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

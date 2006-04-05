indexing
	description: "Graphical settings saved between sessions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_SAVED_SETTINGS

inherit
	CODE_SETTINGS_MANAGER
		rename
			make as manager_make
		end

	TESTER_REGISTRY_KEYS

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize settings manager.
		do
			manager_make (Tester_hive_path)
			Default_values.put (50, X_key)
			Default_values.put (50, Y_key)
			Default_values.put (650, Width_key)
			Default_values.put (650, Height_key)
			Default_text_values.put ("Eiffel", Codedom_provider_key)
			Default_text_values.put ("%T%T%T", Indent_string_key)
		end
		
feature -- Access

	saved_blank_lines: BOOLEAN is
		do
			Result := setting (Blank_lines_key) = 1
		end

	saved_else_at_closing: BOOLEAN is
		do
			Result := setting (Else_at_closing_key) = 1
		end

	saved_generate_executable: BOOLEAN is
		do
			Result := setting (Generate_executable_key) = 1
		end

	saved_generate_in_memory: BOOLEAN is
		do
			Result := setting (Generate_in_memory_key) = 1
		end

	saved_include_debug: BOOLEAN is
		do
			Result := setting (Include_debug_key) = 1
		end

feature -- Basic Implementation

	set_saved_blank_lines (a_blank_lines: BOOLEAN) is
			-- Set `saved_blank_lines' with `a_blank_lines'.
		do
			if a_blank_lines then
				set_setting (Blank_lines_key, 1)
			else
				set_setting (Blank_lines_key, 2)
			end
		ensure
			set: saved_blank_lines = a_blank_lines
		end

	set_saved_else_at_closing (a_else_at_closing: BOOLEAN) is
			-- Set `saved_else_at_closing' with `a_else_at_closing'.
		do
			if a_else_at_closing then
				set_setting (Else_at_closing_key, 1)
			else
				set_setting (Else_at_closing_key, 2)
			end
		ensure
			set: saved_else_at_closing = a_else_at_closing
		end

	set_saved_generate_executable (a_generate_executable: BOOLEAN) is
			-- Set `saved_generate_executable' with `a_generate_executable'.
		do
			if a_generate_executable then
				set_setting (Generate_executable_key, 1)
			else
				set_setting (Generate_executable_key, 2)
			end
		ensure
			set: saved_generate_executable = a_generate_executable
		end

	set_saved_generate_in_memory (a_generate_in_memory: BOOLEAN) is
			-- Set `saved_generate_in_memory' with `a_generate_in_memory'.
		do
			if a_generate_in_memory then
				set_setting (Generate_in_memory_key, 1)
			else
				set_setting (Generate_in_memory_key, 2)
			end
		ensure
			set: saved_generate_in_memory = a_generate_in_memory
		end

	set_saved_include_debug (a_include_debug: BOOLEAN) is
			-- Set `saved_include_debug' with `a_include_debug'.
		do
			if a_include_debug then
				set_setting (Include_debug_key, 1)
			else
				set_setting (Include_debug_key, 2)
			end
		ensure
			set: saved_include_debug = a_include_debug
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


end -- class TESTER_SAVED_SETTINGS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------

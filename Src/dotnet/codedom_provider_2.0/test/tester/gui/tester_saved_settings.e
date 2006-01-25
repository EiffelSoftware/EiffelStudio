indexing
	description: "Graphical settings saved between sessions"
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

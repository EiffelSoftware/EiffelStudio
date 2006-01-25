indexing
	description: "Graphical settings for Eiffel Codedom Provider Manager"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDM_SAVED_SETTINGS

inherit
	ECDM_REGISTRY_KEYS
		export
			{NONE} all
		end

	CODE_GRAPHICAL_SETTINGS_MANAGER
		rename
			make as settings_make
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Intialization

	make is
			-- Initialize settings location.
		do
			settings_make (Saved_settings_key)
			Default_values.put (500, Height_key)
			Default_values.put (500, Width_key)
			Default_values.put (True_value, Show_text_key)
			Default_values.put (True_value, Show_tooltip_key)
		end

feature -- Access

	saved_show_text: BOOLEAN is
			-- Should toolbar buttons text be shown?
		do
			Result := saved_boolean (Show_text_key)
		end

	saved_show_tooltip: BOOLEAN is
			-- Should toolbar buttons tooltips be shown?
		do
			Result := saved_boolean (Show_tooltip_key)
		end

	saved_precompile_ace_files: LIST [STRING] is
			-- List of saved values for precompile ace file combo
		do
			Result := saved_list (Precompile_ace_files)
		end

	saved_metadata_cache_paths: LIST [STRING] is
			-- List of saved values for metadata cache combo
		do
			Result := saved_list (Metadata_cache_paths)
		end

	saved_compiler_metadata_cache_paths: LIST [STRING] is
			-- List of saved values for compiler metadata cache combo
		do
			Result := saved_list (Compiler_metadata_cache_paths)
		end

	saved_precompile_cache_paths: LIST [STRING] is
			-- List of saved values for metadata cache combo
		do
			Result := saved_list (Precompile_cache_paths)
		end

feature -- Element settings

	save_show_text (a_value: BOOLEAN) is
			-- Set `show text' checkable menu item state.
		do
			save_boolean (Show_text_key, a_value)
		end

	save_show_tooltip (a_value: BOOLEAN) is
			-- Set `show tooltip' checkable menu item state.
		do
			save_boolean (Show_tooltip_key, a_value)
		end

feature {NONE} -- Private Access

	Show_text_key: STRING is "show_text"
			-- Show text menu item

	Show_tooltip_key: STRING is "show_tooltip"
			-- Show tooltip menu item

	Precompile_ace_files: STRING is "precompile_ace_files"
			-- Precompiled paths

	Metadata_cache_paths: STRING is "metadata_cache_paths"
			-- Metadata Cache paths

	Compiler_metadata_cache_paths: STRING is "compiler_metadata_cache_paths"
			-- Compiler Metadata Cache paths

	Precompile_cache_paths: STRING is "precompile_cache_paths"
			-- Precompile Cache paths

end -- class ECDM_SAVED_SETTINGS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Manager
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------

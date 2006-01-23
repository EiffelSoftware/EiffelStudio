indexing
	description: "Graphical settings for Eiffel Codedom Provider Manager"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	Precompile_cache_paths: STRING is "precompile_cache_paths";
			-- Precompile Cache paths

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

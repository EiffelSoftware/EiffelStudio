note
	description: "Base addresses for help contexts URLs"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EB_HELP_CONTEXTS_BASES

feature -- Access

	Hc_root: INTEGER = 1
			-- Base URL id for the root of the documentation

	Hc_libraries: INTEGER = 2
			-- Base URL id for the root of the libraries documentation

	Hc_guided_tour: INTEGER = 3
			-- Base URL id for the root of the eiffelstudio guided tour

	Hc_eiffelstudio: INTEGER = 4
			-- Base URL id for the root of the eiffelstudio documentation

	Hc_reference: INTEGER = 5
			-- Base URL id for the root of the eiffelstudio reference

	Hc_how_to_s: INTEGER = 6
			-- Base URL id for the root of the eiffelstudio how to's

	Hc_profile_window: INTEGER = 7
			-- Base URL id for all profiler related help

	Hc_development_window: INTEGER = 8
			-- Base URL id for generic development window help

	Hc_dynamic_lib_window: INTEGER = 9
			-- Base URL id for dynamic library window help

	Hc_editor_window: INTEGER = 10
			-- Base URL id for editor window help

	Root_index: STRING = "index.html"
			-- Default help file for a given base

	url_extension: STRING = ".html"
			-- URL extension

feature -- Status Report

	is_valid_base_id (a_base_id: INTEGER): BOOLEAN
			-- Is `a_base_id' a valid base identifier?
		do
			Result := bases_table.has (a_base_id)
		end

	is_valid_url (a_url: STRING): BOOLEAN
			-- Does `a_url' have a valid URL syntax?
		local
			i: INTEGER
		do
			from
				i := 1
				Result := a_url /= Void and then a_url.count > url_extension.count
			until
				i > (a_url.count - url_extension.count) or not Result
			loop
				Result := Result and ((a_url.item (i) >= 'A' and a_url.item (i) <= 'z') or a_url.item (i) = '/' or a_url.item (i) = ':')
				i := i + 1
			end
			Result := Result and then (a_url.substring (a_url.count - url_extension.count + 1, a_url.count).is_equal (url_extension) or (a_url.has ('#') and a_url.substring (a_url.index_of ('#', 1) - url_extension.count, a_url.index_of ('#', 1) - 1 ).is_equal (url_extension)))
		end

feature -- Basic Operations

	base_url (a_base_id: INTEGER): STRING
			-- Convert base id `a_base_id' into a URL.
		require
			valid_base_id: is_valid_base_id (a_base_id)
		do
			Result := bases_table.item (a_base_id)
		ensure
			valid_base: is_valid_base (Result)
		end

feature {NONE} -- Implementation

	bases_table: HASH_TABLE [STRING, INTEGER]
			-- Context help bases table
		local
			ref_url: STRING
			studio_url: STRING
			how_to_s_url: STRING
		once
			studio_url := "/tools/eiffelstudio/"
			ref_url := studio_url + "reference/"
			how_to_s_url := studio_url + "how_to_s/"
			create Result.make (5)
			Result.put (ref_url + "05_general_interface_description/20_eiffelstudio_window_overview.html", Hc_development_window)
			Result.put (ref_url + "30_compiler/40_advanced_topics/20_dynamic_library_generation/10_dynamic_library_builder.html", Hc_dynamic_lib_window)
			Result.put (ref_url + "20_editor/", Hc_editor_window)
			Result.put (studio_url, Hc_eiffelstudio)
			Result.put ("/general/guided_tour/environment/", Hc_guided_tour)
			Result.put (how_to_s_url, Hc_how_to_s)
			Result.put ("/libraries/", Hc_libraries)
			Result.put (ref_url + "70_wizards_and_dialogs/10_profiler_wizard/", Hc_profile_window)
			Result.put (ref_url, Hc_reference)
			Result.put ("/", Hc_root)
		end

	is_valid_base (a_base: like base_url): BOOLEAN
			-- Does `a_base' have a valid base syntax?
		local
			i: INTEGER
		do
			from
				i := 1
				Result := a_base /= Void and then not a_base.is_empty
			until
				i > a_base.count - 1 or not Result
			loop
				Result := Result and ((a_base.item (i) > 'A' and a_base.item (i) < 'z') or a_base.item (i) = '/')
				i := i + 1
			end
			Result := Result and then a_base.item (i) = '/'
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

end -- class EB_HELP_CONTEXT_BASES

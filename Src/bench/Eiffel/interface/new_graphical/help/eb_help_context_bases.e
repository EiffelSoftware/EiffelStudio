indexing
	description: "Base addresses for help contexts URLs"

class
	EB_HELP_CONTEXTS_BASES

feature -- Access

	Hc_root: INTEGER is unique
			-- Base URL id for the root of the documentation

	Hc_libraries: INTEGER is unique
			-- Base URL id for the root of the libraries documentation

	Hc_guided_tour: INTEGER is unique
			-- Base URL id for the root of the eiffelstudio guided tour

	Hc_eiffelstudio: INTEGER is unique
			-- Base URL id for the root of the eiffelstudio documentation
	
	Hc_reference: INTEGER is unique
			-- Base URL id for the root of the eiffelstudio reference
	
	Hc_how_to_s: INTEGER is unique
			-- Base URL id for the root of the eiffelstudio how to's
	
	Hc_profile_window: INTEGER is unique
			-- Base URL id for all profiler related help

	Hc_development_window: INTEGER is unique
			-- Base URL id for generic development window help
		
	Hc_dynamic_lib_window: INTEGER is unique
			-- Base URL id for dynamic library window help

	Hc_editor_window: INTEGER is unique
			-- Base URL id for editor window help

	Root_index: STRING is "index.html"
			-- Default help file for a given base

	url_extension: STRING is ".html"
			-- URL extension

feature -- Status Report

	is_valid_base_id (a_base_id: INTEGER): BOOLEAN is
			-- Is `a_base_id' a valid base identifier?
		do
			Result := bases_table.has (a_base_id)
		end

	is_valid_url (a_url: STRING): BOOLEAN is
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
				Result := Result and ((a_url.item (i) > 'A' and a_url.item (i) < 'z') or a_url.item (i) = '/' or a_url.item (i) = ':')
				i := i + 1
			end
			Result := Result and then (a_url.substring (a_url.count - url_extension.count + 1, a_url.count).is_equal (url_extension) or (a_url.has ('#') and a_url.substring (a_url.index_of ('#', 1) - url_extension.count, a_url.index_of ('#', 1) - 1 ).is_equal (url_extension)))
		end

feature -- Basic Operations

	base_url (a_base_id: INTEGER): STRING is
			-- Convert base id `a_base_id' into a URL.
		require
			valid_base_id: is_valid_base_id (a_base_id)
		do
			Result := bases_table.item (a_base_id)
		ensure
			valid_base: is_valid_base (Result)
		end

feature {NONE} -- Implementation

	bases_table: HASH_TABLE [STRING, INTEGER] is
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

	is_valid_base (a_base: like base_url): BOOLEAN is
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
			
end -- class EB_HELP_CONTEXT_BASES

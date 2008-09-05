indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	URL_RESOLVER

inherit
	XML2WIKITEXT_HELPERS

feature -- Access

	resolved (s: STRING): STRING is
		local
			c: CHARACTER
		do
			if base_url /= Void then
				if s.is_empty then
					Result := base_url
				else
					if s.item (1) = '/' then
						Result := s
					else
						Result := removed_parent_redirection (base_url + s)
						Result := path_to_url (Result)
--						if Result.item (1) = '/' then
--							Result.remove_head (1)
--						end
					end
				end
			end
			if Result = Void then
				Result := s
			end
		ensure
			Result_attached: Result /= Void
		end

	resolved_for_image (s: STRING): STRING is
		local
			c: CHARACTER
			lid: STRING
		do
			if base_url /= Void then
				if s.is_empty then
					Result := base_url
				else
					if s.item (1) = '/' then
						Result := s.substring (2, s.count)
					else
						Result := removed_parent_redirection (base_url + s)
						Result := path_to_url (Result)
					end
					if image_catalog /= Void and then image_catalog.has_key (Result) then
						lid := image_catalog.found_item
						Result := lid
					end
				end
			end
			if Result = Void then
				Result := s
			end
		ensure
			Result_attached: Result /= Void
		end

feature -- Settings

	prefix_url: STRING assign set_prefix_url
			-- Prefix url if any

	source_url: STRING
			-- spurce url

	base_url: STRING
			-- Base url

	current_filename: STRING assign set_current_filename
			-- current_filename to resolve the url or location

	base_directory: STRING assign set_base_directory
			-- Base directory to resolve the url or location

	image_catalog: HASH_TABLE [STRING_8, STRING] assign set_image_catalog
			-- Image catalog

feature -- Element change

	set_prefix_url (v: like prefix_url)
			-- set `prefix_url' to `v'
		do
			if v /= Void and then not v.is_empty then
				prefix_url := v.twin
				if prefix_url.item (prefix_url.count) /= '/' then
					prefix_url.append_character ('/')
				end
			else
				prefix_url := void
			end
			update
		end

	set_current_filename (v: like current_filename)
			-- set `current_filename' to `v'
		do
			if v /= Void and then not v.is_empty then
				current_filename := v
			else
				current_filename := void
			end

			update
		end

	set_base_directory (v: like base_directory)
			-- set `base_directory' to `v'
		do
			if v /= Void and then not v.is_empty then
				base_directory := v
			else
				base_directory := void
			end

			update
		end

	set_image_catalog (v: like image_catalog)
		do
			image_catalog := v
		end

	add_image (a_fn: STRING_8; a_id: STRING)
		local
			s,s_id: STRING
			i: INTEGER

		do
			if image_catalog = Void then
				create image_catalog.make (1500)
			end
			s := absolute_path_name_to_url (a_fn)
			i := a_id.last_index_of ('.', a_id.count)
			s_id := a_id.substring (1, i - 1)
			image_catalog.put (s_id, s)
		end

	update
		local
			c: CHARACTER
			i, p: INTEGER
			fn: STRING
			pn: KI_PATHNAME
			lfn: STRING
		do
			c := op_env.directory_separator
			if current_filename /= Void then
				if base_directory /= Void then
					create source_url.make_from_string (current_filename)
					check source_url.substring (1, base_directory.count).is_case_insensitive_equal (base_directory) end
					source_url.remove_head (base_directory.count + 1)
					source_url.remove_tail (4) --| remove ".xml"
					source_url := path_to_url (source_url)

					pn := file_system.string_to_pathname (current_filename)
					lfn := pn.item (pn.count)
					create fn.make_from_string (current_filename)
					fn.remove_tail (lfn.count) --| Keep only folder with trailing '/'

					check fn.substring (1, base_directory.count).is_case_insensitive_equal (base_directory) end
					fn.remove_head (base_directory.count + 1)
					base_url := path_to_url (fn)
--					if prefix_url /= Void then
--						base_url.prepend (prefix_url)
--					end
				end
			end
		end

	absolute_path_name_to_url (a_pn: STRING): STRING
		local
			c: CHARACTER
			i, p: INTEGER
			fn: STRING
			pn: KI_PATHNAME
			lfn: STRING
		do
			c := op_env.directory_separator
			if a_pn /= Void then
				if base_directory /= Void then
					create Result.make_from_string (a_pn)
					check Result.substring (1, base_directory.count).is_case_insensitive_equal (base_directory) end
					Result.remove_head (base_directory.count + 1)
					Result := path_to_url (Result)
				end
			end
		end

end

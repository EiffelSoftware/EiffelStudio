note
	description: "Summary description for {DOWNLOAD_JSON_CONFIGURATION}."
	seealso: "class {DOWNLOAD_CONFIGURATION}"
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_JSON_CONFIGURATION

feature -- Access

	configuration_from_file (a_path: PATH; a_configuration: detachable DOWNLOAD_CONFIGURATION): DOWNLOAD_CONFIGURATION
			-- Build a new download configuration.
		do
			if a_configuration /= Void then
				Result := a_configuration
			else
				create Result
			end
			if attached json_file_from (a_path) as js then
				Result := configuration_from_string (js, Result)
			end
		end

	configuration_from_string (a_string: READABLE_STRING_8; a_configuration: detachable DOWNLOAD_CONFIGURATION): DOWNLOAD_CONFIGURATION
			-- Build a new download configuration.
		local
			l_parser: JSON_PARSER
			s32: READABLE_STRING_32
			l_mirror: detachable READABLE_STRING_8
			prod: like new_product
		do
			if a_configuration /= Void then
				Result := a_configuration
			else
				create Result
			end
			l_parser := new_json_parser (a_string)
			l_parser.parse_content
			if attached {JSON_OBJECT} l_parser.parsed_json_value as jv and then l_parser.is_parsed then
				if attached {JSON_STRING} jv.item ("mirror") as j_mirror then
					s32 := j_mirror.unescaped_string_32
					if s32.is_valid_as_string_8 then
						l_mirror := s32.to_string_8
						if l_mirror.is_whitespace then
							l_mirror := Void
						end
					else
							-- Invalid mirror value in configuration!
						l_mirror := Void
					end
					if l_mirror /= Void and Result.mirror = Void then
						Result.set_mirror (l_mirror)
					end
				else
					l_mirror := Void
				end
				if attached {JSON_ARRAY} jv.item ("products") as l_products then
					across
						l_products as ic
					loop
						if attached {JSON_OBJECT} ic.item as jo then
							prod := new_product (jo)
							prod.set_associated_configuration (Result)
							if l_mirror /= Void then
								prod.add_mirror (l_mirror)
							end
							Result.add_product (prod)
						end
					end
				elseif attached {JSON_OBJECT} jv.item ("products") as l_product then
					prod := new_product (l_product)
					prod.set_associated_configuration (Result)
					if l_mirror /= Void then
						prod.add_mirror (l_mirror)
					end
					Result.add_product (prod)
					sort_product_downloads (prod)
				end
			end
		end

feature {NONE} -- Implemenation: Platforms

	sort_product_downloads (prod: DOWNLOAD_PRODUCT)
		local
			l_sort: QUICK_SORTER [DOWNLOAD_PRODUCT_OPTIONS]
			l_comp: DOWNLOAD_PRODUCT_OPTIONS_COMPARATOR
		do
			if attached prod.downloads as lst then
				create l_comp
				create l_sort.make (l_comp)
				l_sort.sort (lst)
			end
		end

	new_platforms (a_platforms: JSON_ARRAY): LIST [DOWNLOAD_PLATFORM]
		local
			l_item: DOWNLOAD_PLATFORM
		do
			create {ARRAYED_LIST [DOWNLOAD_PLATFORM]} Result.make (19)
			across
				a_platforms as c
			loop
				if attached {JSON_OBJECT} c.item as ji then
					create l_item
					if attached {JSON_STRING} ji.item ("id") as l_id then
						l_item.set_id (l_id.item)
					end
					if attached {JSON_STRING} ji.item ("icon") as l_icon then
						l_item.set_icon (l_icon.item)
					end
					if attached {JSON_STRING} ji.item ("text") as l_text then
						l_item.set_text (l_text.item)
					end
					Result.force (l_item)
				end
			end
		end

feature {NONE} -- Implementation: Mirrors

	new_mirrors (a_mirrors: JSON_ARRAY): STRING_TABLE [DOWNLOAD_MIRROR]
		local
			l_item: DOWNLOAD_MIRROR
		do
			create {STRING_TABLE [DOWNLOAD_MIRROR]} Result.make (3)
			across
				a_mirrors as c
			loop
				if attached {JSON_OBJECT} c.item as ji then
					create l_item
					if attached {JSON_STRING} ji.item ("id") as l_id then
						l_item.set_id (l_id.item)
					end
					if attached {JSON_ARRAY} ji.item ("mirror") as l_mirror then
						l_item.set_mirrors (new_mirror_mirrors (l_mirror))
					end
					if attached l_item.id as l_id then
						Result.force (l_item, l_id)
					end
				end
			end
		end

	new_mirror_mirrors (a_mirrors: JSON_ARRAY): LIST [DOWNLOAD_MIRROR_MIRRORS]
		local
			l_item: DOWNLOAD_MIRROR_MIRRORS
		do
			create {ARRAYED_LIST [DOWNLOAD_MIRROR_MIRRORS]} Result.make (3)
			across
				a_mirrors as c
			loop
				if attached {JSON_OBJECT} c.item as ji then
					create l_item
					if attached {JSON_STRING} ji.item ("priority") as l_priority and then
					   l_priority.item.is_integer
					then
						l_item.set_priority (l_priority.item.to_integer)
					end
					if attached {JSON_STRING} ji.item ("url") as l_url then
						l_item.set_url (l_url.item)
					end
					if attached {JSON_STRING} ji.item ("text") as l_text then
						l_item.set_text (l_text.item)
					end
					Result.force (l_item)
				end
			end
		end

feature {NONE} -- Implemenation: Products

	new_product (j_product: JSON_OBJECT): DOWNLOAD_PRODUCT
		do
			create Result
			if attached {JSON_STRING} j_product.item ("id") as l_id then
				Result.set_id (l_id.item)
			end
			if attached {JSON_STRING} j_product.item ("name") as l_name then
				Result.set_name (l_name.item)
			end
			if attached {JSON_STRING} j_product.item ("version") as l_version then
				Result.set_version (l_version.item)
			end
			if attached {JSON_STRING} j_product.item ("release") as l_release then
				Result.set_release (l_release.item)
			end
			if attached {JSON_STRING} j_product.item ("date") as l_date then
				Result.set_date (l_date.item)
			end
			if attached {JSON_STRING} j_product.item ("sub_directory") as l_subdirectory then
				Result.set_sub_directory (l_subdirectory.item)
			end
			if attached {JSON_STRING} j_product.item ("number") as l_number then
				Result.set_number (l_number.item)
			end
			if attached {JSON_STRING} j_product.item ("build") as l_build then
				Result.set_build (l_build.item)
			end
			if attached {JSON_STRING} j_product.item ("icon") as l_icon then
				Result.set_icon (l_icon.item)
			end
			if
				attached {JSON_BOOLEAN} j_product.item ("public") as l_public
			then
				Result.set_public (l_public.item)
			elseif
				attached {JSON_STRING} j_product.item ("public") as l_public and then
				l_public.item.is_boolean
			then
				Result.set_public (l_public.item.to_boolean)
			end
			if
				attached {JSON_BOOLEAN} j_product.item ("for_evaluation") as l_evaluation
			then
				Result.set_evaluation (l_evaluation.item)
			elseif
				attached {JSON_STRING} j_product.item ("for_evaluation") as l_evaluation and then
				l_evaluation.item.is_boolean
			then
				Result.set_evaluation (l_evaluation.item.to_boolean)
			end
			if
				attached {JSON_STRING} j_product.item ("mirror") as l_mirror and then
				attached l_mirror.unescaped_string_32 as m and then
				m.is_valid_as_string_8
			then
				Result.add_mirror (m.to_string_8)
			end
			if attached {JSON_ARRAY} j_product.item ("mirrors") as l_mirrors then
				across
					l_mirrors as ic
				loop
					if
						attached {JSON_STRING} ic.item as jm and then
						attached jm.unescaped_string_32 as m and then
						m.is_valid_as_string_8
					then
						Result.add_mirror (m.to_string_8)
					end
				end
			elseif
				attached {JSON_STRING} j_product.item ("mirrors") as l_mirrors and then
				attached l_mirrors.unescaped_string_32 as ms and then
				ms.is_valid_as_string_8
			then
				Result.set_mirrors (ms.to_string_8)
			end
			if
				attached {JSON_OBJECT} j_product.item ("license") as l_license and then
				attached {JSON_STRING} l_license.item ("name") as l_name and then
				attached {JSON_STRING} l_license.item ("url") as l_url
			then
				Result.set_license ([l_name.item.as_string_32, l_url.item.as_string_32])
			end
			if attached {JSON_STRING} j_product.item ("download_link_pattern") as j_pattern then
				Result.set_download_link_pattern (j_pattern.unescaped_string_32)
			end
			if attached {JSON_ARRAY} j_product.item ("download") as l_download then
				Result.set_downloads (new_product_download (Result, l_download))
			end
		end

	new_product_download (a_product: DOWNLOAD_PRODUCT; a_downloads: JSON_ARRAY): LIST [DOWNLOAD_PRODUCT_OPTIONS]
		local
			l_item: DOWNLOAD_PRODUCT_OPTIONS
		do
			create {ARRAYED_LIST [DOWNLOAD_PRODUCT_OPTIONS]} Result.make (12)
			across
				a_downloads as c
			loop
				if
					attached {JSON_OBJECT} c.item as ji and then
					attached {JSON_STRING} ji.item ("platform") as l_platform and then
					attached {JSON_STRING} ji.item ("filename") as l_filename
				then
					create l_item.make (a_product, l_platform.unescaped_string_32, l_filename.unescaped_string_32)
					if attached {JSON_STRING} ji.item ("size") as l_size and then l_size.item.is_integer then
						l_item.set_size (l_size.item.to_integer)
					end
					if attached {JSON_STRING} ji.item ("hash") as l_hash then
						l_item.set_hash (l_hash.unescaped_string_32)
					end
					if attached {JSON_STRING} ji.item ("cdkey") as l_key then
						l_item.set_key (l_key.unescaped_string_32)
					end
					if attached {JSON_STRING} ji.item ("link") as l_link then
						l_item.set_link (l_link.unescaped_string_32)
					end
					Result.force (l_item)
				end
			end
		end


feature {NONE} -- Implementation

	json_file_from (a_fn: PATH): detachable STRING
		do
			Result := (create {JSON_FILE_READER}).read_json_from (a_fn.name)
		end

	new_json_parser (a_string: STRING): JSON_PARSER
		do
			create Result.make_with_string (a_string)
		end

end

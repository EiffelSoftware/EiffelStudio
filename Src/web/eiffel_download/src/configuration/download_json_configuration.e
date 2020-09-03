note
	description: "Summary description for {DOWNLOAD_JSON_CONFIGURATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_JSON_CONFIGURATION

inherit

	APP_JSON_CONFIGURATION

feature -- Access

	new_download_configuration (a_path: PATH): DOWNLOAD_CONFIGURATION
			-- Build a new download configuration.
		local
			l_parser: JSON_PARSER
		do
			create Result
			if attached json_file_from (a_path) as l_json_content then
				l_parser := new_json_parser (l_json_content)
				l_parser.parse_content
				if
					l_parser.is_valid and then
					attached l_parser.parsed_json_object as jv
				then
					if attached jv.string_item ("mirror") as l_mirror then
						Result.set_mirror (l_mirror.unescaped_string_8)
					end
					if attached jv.array_item ("products") as l_products then
						Result.set_products (new_products (l_products))
					end
				end
			end
		end

feature {NONE} -- Implemenation: Platforms

	new_platforms (a_plarforms: JSON_ARRAY): LIST [DOWNLOAD_PLATFORM]
		local
			l_item: DOWNLOAD_PLATFORM
		do
			create {ARRAYED_LIST [DOWNLOAD_PLATFORM]} Result.make (19)
			across
				a_plarforms as c
			loop
				if attached {JSON_OBJECT} c.item as ji then
					create l_item
					if attached ji.string_item ("id") as l_id then
						l_item.set_id (l_id.item)
					end
					if attached ji.string_item ("icon") as l_icon then
						l_item.set_icon (l_icon.item)
					end
					if attached ji.string_item ("text") as l_text then
						l_item.set_text (l_text.item)
					end
					Result.force (l_item)
				end
			end
		end

feature {NONE} -- Implemenation: Mirrors

	new_mirrors (a_mirrors: JSON_ARRAY): STRING_TABLE[DOWNLOAD_MIRROR]
		local
			l_item: DOWNLOAD_MIRROR
		do
			create {STRING_TABLE[DOWNLOAD_MIRROR]} Result.make (3)
			across
				a_mirrors as c
			loop
				if attached {JSON_OBJECT} c.item as ji then
					create l_item
					if attached ji.string_item ("id") as l_id then
						l_item.set_id (l_id.item)
					end
					if attached ji.array_item ("mirror") as l_mirror then
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
					if attached ji.string_item ("priority") as l_priority and then
					   l_priority.item.is_integer
					then
						l_item.set_priority (l_priority.item.to_integer)
					end
					if attached ji.string_item ("url") as l_url then
						l_item.set_url (l_url.item)
					end
					if attached ji.string_item ("text") as l_text then
						l_item.set_text (l_text.item)
					end
					Result.force (l_item)
				end
			end
		end

feature {NONE} -- Implemenation: Products

	new_products (a_products: JSON_ARRAY): LIST[DOWNLOAD_PRODUCT]
		local
			l_item: DOWNLOAD_PRODUCT
		do
			create {ARRAYED_LIST[DOWNLOAD_PRODUCT]} Result.make (2)
			across
				a_products as c
			loop
				if attached {JSON_OBJECT} c.item as ji then
					create l_item
					if attached ji.string_item ("id") as l_id then
						l_item.set_id (l_id.item)
					end
					if attached ji.string_item ("name") as l_name then
						l_item.set_name (l_name.item)
					end
					if attached ji.string_item ("version") as l_version then
						l_item.set_version (l_version.item)
					end
					if attached ji.string_item ("release") as l_release then
						l_item.set_release (l_release.item)
					end
					if attached ji.string_item ("date") as l_date then
						l_item.set_date (l_date.item)
					end
					if attached ji.string_item ("sub_directory") as l_subdirectory then
						l_item.set_sub_directory (l_subdirectory.item)
					end
					if attached ji.string_item ("number") as l_number then
						l_item.set_number (l_number.item)
					end
					if attached ji.string_item ("build") as l_build then
						l_item.set_build (l_build.item)
					end
					if attached ji.string_item ("icon") as l_icon then
						l_item.set_icon (l_icon.item)
					end
					if
						attached ji.string_item ("public") as l_public and then
						l_public.item.is_boolean
					then
						l_item.set_public (l_public.item.to_boolean)
					end
					if
						attached ji.string_item ("for_evaluation") as l_evaluation and then
						l_evaluation.item.is_boolean
					then
						l_item.set_evaluation (l_evaluation.item.to_boolean)
					end
					if attached ji.string_item ("mirrors") as l_mirrors then
						l_item.set_mirrors (l_mirrors.item)
					end
					if attached ji.string_item ("blerb") as l_blerb then
						l_item.set_blerb (l_blerb.item)
					end

					if
						attached {JSON_OBJECT} ji.item ("license") as l_license and then
						attached l_license.string_item ("name") as l_name and then
						attached l_license.string_item ("url") as l_url
					then
						l_item.set_license ([l_name.item.as_string_32, l_url.item.as_string_32])
					end

					if	attached ji.array_item ("download") as l_download then
						l_item.set_downloads (new_product_download (l_download))
					end

					Result.force (l_item)
				end
			end
		end

	new_product_download (a_downloads: JSON_ARRAY): LIST [DOWNLOAD_PRODUCT_OPTIONS]
		local
			l_item: DOWNLOAD_PRODUCT_OPTIONS
		do
			create {ARRAYED_LIST [DOWNLOAD_PRODUCT_OPTIONS]} Result.make (12)
			across
				a_downloads as c
			loop
				if attached {JSON_OBJECT} c.item as ji then
					create l_item
					if attached ji.string_item ("platform") as l_platform then
						l_item.set_platform (l_platform.item)
					end
					if attached ji.string_item ("filename") as l_filename then
						l_item.set_filename (l_filename.item)
					end
					if attached ji.string_item ("size") as l_size and then l_size.item.is_integer then
						l_item.set_size (l_size.item.to_integer)
					end
					if attached ji.string_item ("hash") as l_hash then
						l_item.set_hash (l_hash.item)
					end
					if attached ji.string_item ("cdkey") as l_key then
						l_item.set_key (l_key.item)
					end
					Result.force (l_item)
				end
			end
		end
end

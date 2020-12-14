note
	description: "Summary description for {EIFFEL_DOWNLOAD_API}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DOWNLOAD_API

inherit
	CMS_MODULE_API

	SHARED_LOGGER

create
	make

feature -- Channels

	default_channel: STRING = "stable"

	beta_channel: STRING = "beta"

	channels: ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			create Result.make (2)
			Result.extend (default_channel)
			Result.extend (beta_channel)
		end

	is_channel_available (ch: READABLE_STRING_GENERAL): BOOLEAN
			-- Is channel `ch` available?
		local
			fut: FILE_UTILITIES
		do
			Result := fut.directory_path_exists (channel_file_location (ch))
		end

feature -- Access: config

	configuration_files (a_channel: detachable READABLE_STRING_GENERAL): LIST [PATH]
		local
			p: PATH
			fut: FILE_UTILITIES
			lst: detachable LIST [READABLE_STRING_32]
			l_sort: QUICK_SORTER [READABLE_STRING_32]
			l_comp: COMPARABLE_COMPARATOR [READABLE_STRING_32]
		do
			create {ARRAYED_LIST [PATH]} Result.make (10)
			p := channel_file_location (a_channel)
			lst := fut.file_names (p.name)
			if lst /= Void then
				create l_comp
				create l_sort.make (l_comp);
				l_sort.reverse_sort (lst)
				across
					lst as ic
				loop
					create p.make_from_string (ic.item)
					if attached p.extension as ext and then ext.same_string_general ("json") then
						Result.force (p)
					end
				end
			end
		end

	channel_file_location (a_channel: detachable READABLE_STRING_GENERAL): PATH
		do
			Result := cms_api.module_location_by_name ("eiffel_download").extended ("channel")
			if a_channel = Void then
				Result := Result.extended (default_channel)
			else
				Result := Result.extended (a_channel)
			end
		end

	download_channel_configuration (a_channel: detachable READABLE_STRING_GENERAL): detachable DOWNLOAD_CONFIGURATION
			-- Get `download_channel_configuration' value.
			-- from a list of files.
		local
			l_dir: DIRECTORY
		do
			if internal_download_configuration = Void then
				create l_dir.make_with_path (channel_file_location (a_channel))
				if l_dir.exists then
						-- the file it's located at {module_name}/channel/$a_channel/file_name
					retrieve_download_configuration_from_dir (l_dir)
				end
			end
			Result := internal_download_configuration
		end

feature -- Persistency

	save_uploaded_configuration (a_channel: READABLE_STRING_GENERAL; a_uploaded_cfg: EIFFEL_UPLOAD_CONFIGURATION)
		local
			l_dir: DIRECTORY
			b: BOOLEAN
			p: PATH
			l_file: FILE
		do
			create l_dir.make_with_path (channel_file_location (a_channel))
			if not l_dir.exists then
				b := (create {CMS_FILE_SYSTEM_UTILITIES}).safe_create_parent_directory (l_dir.path.extended ("dummy-cfg.json"))
			end
			if l_dir.exists then
				p := l_dir.path.extended ("downloads_configuration_" + a_uploaded_cfg.number + ".json")
				create {PLAIN_TEXT_FILE} l_file.make_with_path (p)
				l_file.open_write
				l_file.put_string (a_uploaded_cfg.to_json_representation)
				l_file.close
			end
		end

	uploaded_configuration_exists (a_channel: READABLE_STRING_GENERAL; a_uploaded_cfg: EIFFEL_UPLOAD_CONFIGURATION): BOOLEAN
		local
			p: PATH
			f: FILE
		do
			p := channel_file_location (a_channel).extended ("downloads_configuration_" + a_uploaded_cfg.number + ".json")
			create {RAW_FILE} f.make_with_path (p)
			Result := f.exists
		end

	save_configuration (a_channel: READABLE_STRING_GENERAL; cfg: DOWNLOAD_CONFIGURATION)
		local
			l_dir: DIRECTORY
			b: BOOLEAN
			p: PATH
			l_file: FILE
		do
			create l_dir.make_with_path (channel_file_location (a_channel))
			if not l_dir.exists then
				b := (create {CMS_FILE_SYSTEM_UTILITIES}).safe_create_parent_directory (l_dir.path.extended ("dummy-cfg.json"))
			end
			if l_dir.exists then
				if
					attached cfg.products as prods and then
					prods.count = 1 and then
					attached prods.first.number as l_number
				then
					p := l_dir.path.extended ({STRING_32} "downloads_configuration_" + l_number + {STRING_32} ".json")
					create {PLAIN_TEXT_FILE} l_file.make_with_path (p)
					l_file.open_write
					l_file.put_string (cfg.to_json_representation)
					l_file.close
				end
			end
		end

feature -- Access

	retrieve_mirror (cfg: DOWNLOAD_CONFIGURATION): detachable READABLE_STRING_8
			-- Get mirror.
		do
			Result := cfg.mirror
		end

	retrieve_public_product (cfg: DOWNLOAD_CONFIGURATION): detachable DOWNLOAD_PRODUCT
			-- Get the latest release.
		do
			if attached retrieve_public_products (cfg) as l_products then
				Result := l_products.first
			end
		end

	retrieve_public_product_by_version (cfg: DOWNLOAD_CONFIGURATION; a_version: READABLE_STRING_32): detachable DOWNLOAD_PRODUCT
			-- Retrieve product by version a 'a_version'.
		local
			l_found: BOOLEAN
		do
			if attached retrieve_public_products (cfg)  as l_products then
				from
					l_products.start
				until
					l_products.after or l_found
				loop
					if attached l_products.item.number as l_version and then l_version.same_string (a_version) then
						Result := l_products.item
						l_found := True
					end
					l_products.forth
				end
			end
		end

	retrieve_public_products (cfg: DOWNLOAD_CONFIGURATION): detachable LIST[DOWNLOAD_PRODUCT]
			-- List of potential download public products.
		do
			Result := public_products_sorted (cfg)
		end

	retrieve_products (cfg: DOWNLOAD_CONFIGURATION): detachable LIST[DOWNLOAD_PRODUCT]
			-- List of potential download products.
		do
			Result := products_sorted (cfg)
		end

	public_products_sorted (cfg: DOWNLOAD_CONFIGURATION): detachable LIST[DOWNLOAD_PRODUCT]
		do
			Result := cfg.sorted_public_products
		end

	products_sorted (cfg: DOWNLOAD_CONFIGURATION): detachable LIST[DOWNLOAD_PRODUCT]
		do
			Result := cfg.sorted_products
		end

	selected_platform (a_downloads: detachable LIST [DOWNLOAD_PRODUCT_OPTIONS]; a_platform: READABLE_STRING_GENERAL): detachable DOWNLOAD_PRODUCT_OPTIONS
		do
			if a_downloads /= Void then
				across
					a_downloads as ic
				until
					Result /= Void
				loop
					if
						attached ic.item.platform as pf and then
					 	a_platform.is_case_insensitive_equal (pf)
					then
						Result := ic.item
					end
				end
			end
		end

	sort_downloads (prod: DOWNLOAD_PRODUCT)
		local
			l_sort: QUICK_SORTER [DOWNLOAD_PRODUCT_OPTIONS]
			l_comp: DOWNLOAD_PRODUCT_OPTIONS_COMPARATOR
		do
			if attached prod.downloads as lst then
				create l_comp
				create l_sort.make (l_comp)
				l_sort.sort (lst)
--				l_sort.reverse_sort (lst)
			end
		end

feature {NONE} -- Implementation

	internal_download_configuration: detachable DOWNLOAD_CONFIGURATION
			-- Internal cached configuration for eiffel download.

	retrieve_download_configuration_from_dir (a_dir: DIRECTORY)
			-- Parse JSON files for the current directory `a_dir'.
			-- and fill the `download_configuration` object.
		require
			exists: a_dir.exists
		local
			file: FILE
			p: PATH
			l_download: DOWNLOAD_CONFIGURATION
		do
			if internal_download_configuration = Void then
				across
					a_dir.entries as ic
				loop
					p := a_dir.path.extended_path (ic.item)
					check not_empty_file: not p.is_empty  end
					create {RAW_FILE} file.make_with_path (p)
					if
						not file.is_directory and then
					   	file.exists and then
						attached p.extension as ext and then ext.same_string_general ("json")
					then
						l_download := (create {DOWNLOAD_JSON_CONFIGURATION}).configuration_from_file (p, l_download)
					end
				end
				internal_download_configuration := l_download
			end
		end
end

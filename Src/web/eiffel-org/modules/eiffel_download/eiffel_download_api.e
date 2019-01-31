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


feature -- Access: config


	download_configuration: detachable DOWNLOAD_CONFIGURATION
			-- Get `download_configuration' value.
			-- from a list of files.
		local
			l_dir: DIRECTORY
		do
			write_debug_log (generator + ".get_download_configuration")
			if internal_download_configuration = Void then
				create l_dir.make_with_path (cms_api.module_location_by_name ("eiffel_download"))
				if l_dir.exists then
					retrieve_download_configuration_from_dir (create {DIRECTORY}.make_with_path (cms_api.module_location_by_name ("eiffel_download")))
				end
			end
			Result := internal_download_configuration
		end


	download_channel_configuration: detachable DOWNLOAD_CONFIGURATION
			-- Get `download_channel_configuration' value.
			-- from a list of files.
		local
			l_dir: DIRECTORY
		do
			write_debug_log (generator + ".get_download_channel_configuration")
			if internal_download_configuration = Void then
				create l_dir.make_with_path (cms_api.module_location_by_name ("eiffel_download"))
				if l_dir.exists then
						-- the file it's located at {module_name}/channel/file_name
					retrieve_download_configuration_from_dir (create {DIRECTORY}.make_with_path (cms_api.module_location_by_name ("eiffel_download").extended ("channel")))
				end
			end
			Result := internal_download_configuration
		end


feature -- Access

	retrieve_mirror_gpl (cfg: DOWNLOAD_CONFIGURATION): detachable READABLE_STRING_32
			-- Get mirror.
		do
			if attached cfg.mirror as l_mirror then
				Result := l_mirror
			end
		end

	retrieve_product_gpl (cfg: DOWNLOAD_CONFIGURATION): detachable DOWNLOAD_PRODUCT
			-- Get the latest release.
		do
			if attached retrieve_products (cfg)  as l_products then
				Result := l_products.at (1)
			end
		end

	retrieve_product_gpl_by_version (cfg: DOWNLOAD_CONFIGURATION; a_version: READABLE_STRING_32): detachable DOWNLOAD_PRODUCT
			-- Retrieve product by version a 'a_version'.
		local
			l_found: BOOLEAN
		do
			if attached retrieve_products (cfg)  as l_products then
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

	retrieve_products (cfg: DOWNLOAD_CONFIGURATION): detachable LIST[DOWNLOAD_PRODUCT]
			-- List of potential download products.
		do
			Result := products_sorted (cfg)
		end

	products_sorted (cfg: DOWNLOAD_CONFIGURATION): detachable LIST[DOWNLOAD_PRODUCT]
		local
			l_sort: QUICK_SORTER [DOWNLOAD_PRODUCT]
			l_comp: COMPARABLE_COMPARATOR [DOWNLOAD_PRODUCT]
		do
			if attached cfg.products as l_products then
				Result := l_products
				create l_comp
				create l_sort.make (l_comp)
				l_sort.reverse_sort (Result)
			end
		end

	selected_platform (a_downloads: detachable LIST[DOWNLOAD_PRODUCT_OPTIONS]; a_platform: READABLE_STRING_32): detachable DOWNLOAD_PRODUCT_OPTIONS
		local
			l_found: BOOLEAN
		do
			if
				attached a_downloads
			then
				from
					a_downloads.start
				until
					a_downloads.after or l_found
				loop
					if a_downloads.item.platform ~ a_platform then
						Result := a_downloads.item
					end
					a_downloads.forth
				end
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
			l_download: DOWNLOAD_CONFIGURATION
		do
			if internal_download_configuration = Void then
				across
					a_dir.entries as ic
				loop
					check not_empty_file: not a_dir.path.extended_path (ic.item).is_empty  end
					create {RAW_FILE} file.make_with_path (a_dir.path.extended_path (ic.item))
					if
						not file.is_directory  and then
					   	file.exists
					then
						l_download := (create {DOWNLOAD_JSON_CONFIGURATION}).build_download_configuration (a_dir.path.extended_path (ic.item), l_download)
					end
				end
				internal_download_configuration := l_download
			end
		end
end

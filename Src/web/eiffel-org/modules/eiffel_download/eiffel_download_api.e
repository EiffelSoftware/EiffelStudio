note
	description: "Summary description for {EIFFEL_DOWNLOAD_API}."
	author: ""
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
			-- Configuration for eiffel download.

	get_download_configuration
			-- Get `download_configuration' value.
			-- from a list of files.
		local
			l_dir: DIRECTORY
		do
			write_debug_log (generator + ".get_download_configuration")
			if download_configuration = Void then
				create l_dir.make_with_path (cms_api.module_location_by_name ("eiffel_download"))
				if l_dir.exists then
					retrieve_download_configuration_from_dir (create {DIRECTORY}.make_with_path (cms_api.module_location_by_name ("eiffel_download")))
				end
			end
		end


feature {NONE} -- Implementation

	retrieve_download_configuration_from_dir (a_dir: DIRECTORY)
			-- Parse JSON files for the current directory `a_dir'.
			-- and fill the `download_configuration` object.
		require
			exists: a_dir.exists
		local
			file: FILE
			l_download: DOWNLOAD_CONFIGURATION
		do
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
			download_configuration := l_download
		end
end

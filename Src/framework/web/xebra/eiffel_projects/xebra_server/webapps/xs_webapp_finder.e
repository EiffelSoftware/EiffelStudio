note
	description: "[
		Used to create a hash_table of webapps by searching config files in folders.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_WEBAPP_FINDER

feature -- Constants

	Webapp_config_filename: STRING = "config.ini"

feature -- Operations

	search_webapps (a_path: STRING): HASH_TABLE [XS_WEBAPP, STRING]
			-- Traverses folders to find config.inis which define webapps
		require
			not_a_path_is_detached_or_empty: a_path /= Void and then not a_path.is_empty
		local
			l_files: LIST [STRING]
			l_f_utils: XU_FILE_UTILITIES
			l_webapp_config_reader: XC_WEBAPP_JSON_CONFIG_READER
			l_ex: LINKED_LIST [STRING]
			l_inc: LINKED_LIST [STRING]
		do
			create l_ex.make
			create l_inc.make
			l_ex.force ("EIFGENs")
			l_ex.force (".svn")
			l_inc.force (Webapp_config_filename)
			create Result.make (1)
			create l_f_utils
			create l_webapp_config_reader

			l_files := l_f_utils.scan_for_files (a_path, -1, l_inc, l_ex)
			from
				l_files.start
			until
				l_files.after
			loop
				if attached {XC_WEBAPP_CONFIG} l_webapp_config_reader.process_file (l_files.item_for_iteration) as l_w then
					Result.force (create {XS_WEBAPP}.make (l_w), l_w.name)
				end

				l_files.forth
			end
		ensure
			Result_attached: Result /= Void
		end

end


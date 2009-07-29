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

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Access

feature -- Constants

	Webapp_config_filename: STRING = "config\.ini"

	Search_exclude: STRING = "\.svn|EIFGENs"

feature -- Status report

feature -- Operations

	search_webapps (a_path: STRING): HASH_TABLE [XS_WEBAPP, STRING]
			-- Traverses folders to find config.inis which define webapps
		require
			not_a_path_is_detached_or_empty: a_path /= Void and then not a_path.is_empty
		local
			l_files: LIST [STRING]
			l_f_utils: XU_FILE_UTILITIES
			l_webapp_config: XC_WEBAPP_CONFIG
			l_webapp_config_reader: XC_WEBAPP_CONFIG_READER
		do
			create Result.make (1)
			create l_f_utils
			create l_webapp_config_reader.make
			l_files := l_f_utils.scan_for_files (a_path, -1, Webapp_config_filename, Search_exclude)

			from
				l_files.start
			until
				l_files.after
			loop
				l_webapp_config := l_webapp_config_reader.process_file (l_files.item_for_iteration)
				Result.force (create {XS_WEBAPP}.make (l_webapp_config), l_webapp_config.name)
				l_files.forth
			end
		ensure
			Result_attached: Result /= Void
		end
feature -- Status setting

feature {NONE} -- Implementation

end


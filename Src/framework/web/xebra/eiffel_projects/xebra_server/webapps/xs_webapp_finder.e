note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
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

	Webapp_config_filename: STRING = "config.ini"

	Search_exclude: STRING = ".svn|EIFGENs"

feature -- Status report

feature -- Operations

	search_webapps (a_path: STRING): HASH_TABLE [XS_WEBAPP, STRING]
			-- Traverses folders to find config.inis which define webapps
		require
			not_a_path_is_detached_or_empty: a_path /= Void and then not a_path.is_empty
		local
			l_include: RX_PCRE_MATCHER
			l_exclude: RX_PCRE_MATCHER
			l_files: DS_ARRAYED_LIST [STRING]
			l_webapp_config: XS_WEBAPP_CONFIG
			l_webapp_config_reader: XS_WEBAPP_CONFIG_READER
		do
			create Result.make (1)
			create l_webapp_config_reader.make
			create l_include.make
			create l_exclude.make
			l_include.compile (Webapp_config_filename)
			l_exclude.compile (Search_exclude)
			l_files := (create {FILE_UTILITIES}).scan_for_files (a_path, -1, l_include, l_exclude)

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


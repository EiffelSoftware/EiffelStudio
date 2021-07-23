note
	description: "Summary description for {REPOSITORY_SVN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_SVN

inherit
	REPOSITORY
		redefine
			make
		end

create
	make,
	make_with_location,
	make_from_repository

feature {NONE} -- Initialization

	make
		do
			create location.make_empty
			Precursor
			create engine
		end

	make_with_location (a_loc: like location)
		do
			make
			set_location (a_loc)
		end

	make_from_repository (a_repo: like Current)
		do
			make
			location := a_repo.location.string
			engine.set_svn_executable_path (a_repo.engine.svn_executable_path)
		ensure
			new_engine: engine /= a_repo.engine
			same_location: location ~ a_repo.location
		end

feature -- Access

	kind: STRING = "svn"

	location: STRING

	root: detachable STRING
		local
			l_svn_info: like info
		do
			l_svn_info := info
			if l_svn_info /= Void and then attached l_svn_info.repository_root as l_root then
				Result := l_root
			end
		end

	info: detachable SVN_REPOSITORY_INFO
		do
			Result := engine.repository_info (location, options)
		end

	statuses (is_verbose, is_recursive, is_remote: BOOLEAN): detachable LIST [SVN_STATUS_INFO]
		do
			Result := engine.statuses (location, is_verbose, is_recursive, is_remote, options)
		end

	logs (is_verbose: BOOLEAN; a_start, a_end: INTEGER; a_limit: INTEGER): detachable LIST [SVN_REVISION_INFO]
		do
			Result := engine.logs (location, is_verbose, a_start, a_end, a_limit, options)
		end

	revision_diff (a_rev: SVN_REVISION_INFO): detachable STRING
		do
			if
				attached engine.diff (location, a_rev.revision, (a_rev.revision - 1).max (0), options) as res and then
				attached res.message as msg
			then
				Result := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (msg)
			end
		end

	revision_path_content (a_path: STRING; a_rev: SVN_REVISION_INFO): detachable STRING
		do
			if attached root as l_root then
				Result := engine.path_content (l_root, a_path, a_rev.revision, options)
			else
				Result := engine.path_content (location, a_path, a_rev.revision, options)
			end
		end

feature -- Element change

	set_location (v: like location)
		do
			location := v
		end

	set_svn_executable_path (p: STRING)
		require
			p_not_empty: p /= Void and then not p.is_empty
		do
			engine.set_svn_executable_path (p)
		end

feature -- Implementation

	options: SVN_ENGINE_OPTIONS
		do
			create Result
			if attached username as l_username then
				Result.set_username (l_username)
			end
			if attached password as l_password then
				Result.set_password (l_password)
			end
		end

	engine: SVN_ENGINE

end

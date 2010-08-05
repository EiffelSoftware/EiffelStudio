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
		ensure
			new_engine: engine /= a_repo.engine
			same_location: location ~ a_repo.location
		end

feature -- Access

	kind: STRING = "svn"

	location: STRING

	info: detachable SVN_REPOSITORY_INFO
		do
			Result := engine.repository_info (location)
		end

	statuses (is_verbose, is_recursive, is_remote: BOOLEAN): detachable LIST [SVN_STATUS_INFO]
		do
			Result := engine.statuses (location, is_verbose, is_recursive, is_remote)
		end

	logs (is_verbose: BOOLEAN; a_start, a_end: INTEGER; a_limit: INTEGER): detachable LIST [SVN_REVISION_INFO]
		do
			Result := engine.logs (location, is_verbose, a_start, a_end, a_limit)
		end

	revision_diff (a_rev: SVN_REVISION_INFO): detachable STRING
		do
			Result := engine.diff (location, a_rev.revision, 0)
		end

feature -- Element change

	set_location (v: like location)
		do
			location := v
		end

feature -- Implementation

	engine: SVN_ENGINE

end

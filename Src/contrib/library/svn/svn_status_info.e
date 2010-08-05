note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_STATUS_INFO

inherit
	SVN_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal
		end

	COMPARABLE

create
	make

feature

	make (d: STRING; p: like path; pp: like prefix_path )
		do
			set_path (p)
			prefix_path := pp
			create absolute_path.make_from_string (d)
			absolute_path.extend (path)
			wc_status := status_none_id
			repos_status := status_none_id
		end

feature

	path_is_directory: BOOLEAN
		local
			file: RAW_FILE
		do
			create file.make (absolute_path)
			Result := file.exists and then file.is_directory
		end

	absolute_path: FILE_NAME

	prefix_path: detachable STRING

	display_path: STRING
		local
			fn: FILE_NAME
		do
			if attached prefix_path as l_prefix_path then
				create fn.make_from_string (l_prefix_path)
				fn.extend (path)
				Result := fn
			else
				Result := path.twin
			end
		end

	path: STRING

	wc_revision, repos_revision: INTEGER

	wc_status, repos_status: STRING

	wc_status_code, repos_status_code: INTEGER

	props: detachable HASH_TABLE [STRING, STRING]

feature -- comp

	is_less alias "<" (other: like Current): BOOLEAN
		do
			Result := absolute_path < other.absolute_path
		end

feature

	set_path (v: like path)
		do
			path := v
		end

	set_wc_revision (v: like wc_revision)
		do
			wc_revision := v
		end

	set_wc_status (v: detachable like wc_status)
		do
			if v /= Void and then not v.is_empty then
				wc_status := v
			else
				wc_status := status_none_id
			end
			wc_status_code := status_codes.item (wc_status)
		end

	set_repos_revision (v: like repos_revision)
		do
			repos_revision := v
		end

	set_repos_status (v: detachable like repos_status)
		do
			if v /= Void and then not v.is_empty then
				repos_status := v
			else
				repos_status := status_none_id
			end
			repos_status_code := status_codes.item (repos_status)
		end

note
	copyright: "Copyright (c) 2003-2010, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end

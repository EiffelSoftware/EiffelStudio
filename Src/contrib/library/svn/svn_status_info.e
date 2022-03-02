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

	make (d: PATH; p: like path; pp: detachable READABLE_STRING_GENERAL)
		do
			set_path (p)
			if pp /= Void then
				create prefix_path.make_from_string_general (pp)
			else
				prefix_path := Void
			end
			absolute_path := d.extended (path)
			wc_status := status_none_id
			repos_status := status_none_id
		end

feature

	path_is_directory: BOOLEAN
		local
			file: RAW_FILE
		do
			create file.make_with_path (absolute_path)
			Result := file.exists and then file.is_directory
		end

	absolute_path: PATH

	prefix_path: detachable STRING_32

	display_path: STRING_32
		local
			fn: PATH
		do
			if attached prefix_path as l_prefix_path then
				create fn.make_from_string (l_prefix_path)
				Result := fn.extended (path).name
			else
				create Result.make_from_string_general (path)
			end
		end

	path: STRING_32

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

	set_wc_status (v: detachable READABLE_STRING_GENERAL)
		do
			if v /= Void and then not v.is_whitespace and then v.is_valid_as_string_8 then
				wc_status := v.to_string_8
			else
				wc_status := status_none_id
			end
			wc_status_code := status_codes.item (wc_status)
		end

	set_repos_revision (v: like repos_revision)
		do
			repos_revision := v
		end

	set_repos_status (v: detachable READABLE_STRING_GENERAL)
		do
			if v /= Void and then not v.is_whitespace and then v.is_valid_as_string_8 then
				repos_status := v.to_string_8
			else
				repos_status := status_none_id
			end
			repos_status_code := status_codes.item (repos_status)
		end

note
	copyright: "Copyright (c) 2003-2022, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end

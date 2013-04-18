note
	description: "Summary description for {IRON_FS_PACKAGE_INFO_DIRECTORY_ITERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_FS_PACKAGE_INFO_DIRECTORY_ITERATOR

inherit
	DIRECTORY_ITERATOR
		redefine
			process_directory,
			process_file,
			path_excluded,
			file_excluded
		end

create
	make

feature {NONE} -- Initialization

	make (lst: LIST [PATH])
		do
			list := lst
			depth := 0
		end

	list: LIST [PATH]

	depth: INTEGER

feature -- Access

	scan_folder (dn: PATH)
		do
			depth := 0
			process_directory (dn)
		end

	process_directory (dn: PATH)
		do
			depth := depth + 1
			Precursor (dn)
			depth := depth - 1
		end

	process_file (fn: PATH)
			-- Visit file `fn'
		do
			list.force (fn)
		end

feature -- Status

	path_excluded (a_path: PATH): BOOLEAN
		do
			Result := Precursor (a_path) or depth > 2
		end

	file_excluded (fn: PATH): BOOLEAN
		do
			Result := not fn.name.ends_with (".info")
		end


end

note
	description: "Summary description for {IRON_ECF_SCANNER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_ECF_SCANNER

inherit
	DIRECTORY_ITERATOR
		redefine
			directory_excluded,
			file_excluded,
			process_file,
			process_directory
		end

create
	make,
	make_with_depth

feature {NONE} -- Initialization

	make
		do
			max_depth := 0
			create items.make (0)
		end

	make_with_depth (a_max_depth: INTEGER)
			-- Visit with max depth `a_max_depth'
		require
			a_max_depth > 0
		do
			max_depth := a_max_depth
			create items.make (0)
		end

feature -- Access

	max_depth: INTEGER
			-- Max depth for recursion
			-- if <= 0: recursive
			-- else stop at `max_depth'

	items: ARRAYED_LIST [PATH]

feature {NONE} -- Implementation	

	depth: INTEGER

feature -- Reset

	reset
		do
			items.wipe_out
		end

feature -- Visitor

	process_directory (dn: PATH)
		do
			depth := depth + 1
			if max_depth <= 0 or else (depth <= max_depth) then
				Precursor (dn)
			end
		end

	process_file (fn: PATH)
			-- Visit file `fn'
		do
			items.force (fn)
		end

feature -- Status

	directory_excluded (dn: PATH): BOOLEAN
			-- Is Directory `dn' excluded?
		local
			n: READABLE_STRING_32
		do
			Result := Precursor (dn)
			if not Result then
				if attached dn.entry as e then
					n := e.name
				else
					n := dn.name
				end
				Result := n.starts_with_general (".") or n.same_string_general ("EIFGENs")
			end
		end

	file_excluded (fn: PATH): BOOLEAN
			-- Is file `fn' excluded?
		do
			Result := True
			if attached fn.extension as l_ext then
				Result := not l_ext.is_case_insensitive_equal_general ("ecf")
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

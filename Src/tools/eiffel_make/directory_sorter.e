indexing
	description: "[
		Sorting algorithm for W_code and F_code directories. The C directories
		appear first and then the E directories.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	DIRECTORY_SORTER

inherit
	DS_COMPARATOR [STRING]

feature -- Comparison

	less_than (u, v: STRING): BOOLEAN is
			-- Is `u' considered less than `v'?
		do
			if u.valid_index (1) and v.valid_index (1) then
				Result := u.item (1) = v.item (1)
				if Result then
						-- Same letter, we ensure that smaller strings
						-- are smaller than larger ones. If they have
						-- the same count, then we use the string comparison.
					if u.count = v.count then
						Result := u <= v
					else
						Result := u.count <= v.count
					end
				else
					Result := u.item (1) <= v.item (1)
				end
			else
				Result := u <= v
			end
		end

end

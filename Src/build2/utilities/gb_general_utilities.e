indexing
	description: "Objects that some very general purpose facilities used in Build2"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_GENERAL_UTILITIES

feature -- Basic operations

	list_from_single_spaced_values (string: STRING): ARRAYED_LIST [INTEGER] is
			-- `Result' is all values contained in `string' which is of the form "1 101 150 35".
			-- `string' must be single spaced.
		local
			last_space, counter: INTEGER
		do
			create Result.make (0)
			last_space := 1
			from
				counter := 1
			until
				counter > string.count
			loop
				if string @ counter = ' ' then
					check
						only_one_space_per_value: string @ (counter + 1) /= ' '
					end
					Result.extend ((string.substring (last_space, counter - 1)).to_integer)
					last_space := counter + 1
				elseif counter = string.count then
					Result.extend ((string.substring (last_space, counter)).to_integer)
				end
				counter := counter + 1
			end
		end
		
	single_spaced_values_from_list (list: ARRAYED_LIST [INTEGER]): STRING is
			-- `Result' is single spaced string representation of `list'.
		local
			counter: INTEGER
		do
			create Result.make (0)
			from
				counter := 1
			until
				counter > list.count
			loop
				Result.append_string ((list @ counter).out)
				if counter < list.count then
					Result.extend (' ')
				end
				counter := counter + 1
			end
		end
		
end -- class GB_GENERAL_UTILITIES

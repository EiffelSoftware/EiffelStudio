indexing
	description: "Buffer containing the text where a pattern is to be searched"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	SEARCH_BUFFER

inherit
	STRING
		redefine
			make_from_string
		end

create
	make_from_string 
		
feature -- Initialization

	make_from_string (a_string: STRING) is
			-- create a new search buffer from `a_string'
		do
			Precursor (a_string)
			create new_line_positions.make (0)
			process_line_count
		end

feature -- Access

	line_count: INTEGER
		-- number of lines in the buffer

feature -- Status report

	line_number_at_index (index: INTEGER): INTEGER is
			-- return the line number corresponding to the `index'th character
		local
			i: INTEGER
			found: BOOLEAN
		do
			Result := 1
			from
				i := 1	
			until
				i = line_count or found
			loop
				if index >= new_line_positions @ i then
					Result := i + 1
				else
					found := true
				end
				i := i + 1
			end
		end

	new_line_index(line_number: INTEGER): INTEGER is
			-- index of the new line preceeding `char_index'
		require
			valid_line_number: line_number > 0 and line_number <= count
		do
			if line_number = 1 then
				Result := 0
			else
				Result := new_line_positions @ (line_number - 1)
			end
		end

feature {NONE} -- Implementation

	new_line_positions: ARRAYED_LIST [INTEGER] 
			-- new lines indexes 

	process_line_count is
			-- detect new lines in the buffer
		local
			i: INTEGER
		do
			from
				i := 1
				line_count := 1
			until
			i >= count
			loop
				if item (i) = '%N' then
					if item(i+1) = '%R' then
						new_line_positions.extend (i + 2)
					else
						new_line_positions.extend (i + 1)
					end
					line_count := line_count + 1
				end
				i := i + 1
			end
			if item (i) = '%N' then
				new_line_positions.extend (i + 1)
				line_count := line_count + 1
			end
		end			
				

end -- class SEARCH_BUFFER

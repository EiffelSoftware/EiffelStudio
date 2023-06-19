note
	description: "Summary description for {APP_OUTPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APP_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (f: FILE)
		do
			output := f
			create offset.make_empty
		end

feature -- Access

	output: FILE

	offset: STRING

feature -- Operation

	indent
		do
			offset.append ("  ")
		ensure
			old (offset.count) + 2 = offset.count
		end

	exdent
		require
			offset.count >= 2
		do
			offset.remove_tail (2)
		end

	flush
		do
			output.flush
		end

	last_was_newline: BOOLEAN

	put_string (s: STRING)
		local
			i,j,n: INTEGER
			c: CHARACTER
		do
			if last_was_newline then
				last_was_newline := False
				output.put_string (offset)
			end
			if s.has ('%N') then
				from
					i := 1
					j := 1
					n := s.count
				until
					i <= 0 or j > n
				loop
					i := s.index_of ('%N', j)
					if i > 0 then
						output.put_string (s.substring (j, i))
						if i = n then
							last_was_newline := True
						else
							output.put_string (offset)
						end
						j := i + 1
					else
						output.put_string (s.substring (j, n))
					end
				end
				if s [s.count] = '%N' then
					last_was_newline := True
				end
			else
				output.put_string (s)
			end
		end


end

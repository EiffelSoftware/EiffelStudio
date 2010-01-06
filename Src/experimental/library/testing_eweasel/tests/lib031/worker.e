
class WORKER
inherit
	THREAD
create
	make

feature

	make (n, m: INTEGER c: CHARACTER src_name, dest_name: STRING) is
		do
			iteration_count := n
			length := m
			file_character := c
			source_file_name := src_name
			dest_file_name := dest_name
		end

	execute is
		local
			k: INTEGER
			src_file, dest_file: PLAIN_TEXT_FILE
			s: STRING
			c: CHARACTER
			invalid: BOOLEAN
		do
			create src_file.make_open_write (source_file_name)
			create s.make (length)
			s.fill_character (file_character)
			src_file.put_string (s)
			src_file.close

			create dest_file.make (dest_file_name)
			from
				k := 1
			until
				k > iteration_count
			loop
				dest_file.append (src_file)
				k := k + 1
			end
			
			create src_file.make_open_read (dest_file_name)
			from
				src_file.read_character
			until
				src_file.end_of_file or invalid
			loop
				c := src_file.last_character
				if c /= file_character then
					print ("Found incorrect character %'" + c.out + "%'%N")
					invalid := True
				end
				src_file.read_character
			end
			src_file.close
		end

	
	source_file_name: STRING
	
	dest_file_name: STRING
	
	file_character: CHARACTER
	
	iteration_count: INTEGER
	
	length: INTEGER
	
end

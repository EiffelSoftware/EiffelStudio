class SUPPLIER inherit SHARED

create
	make

feature -- {NONE} -- Creation

	make
			-- Run test.
		local
			f: RAW_FILE
		do
			if
				arguments.argument_count /= 1 or else
				not valid_arguments.has (arguments.argument (1))
			then
				io.error.put_string ("USAGE: supplier (ioe|Ioe|oie|oIe|oei|oeI|ieo|Ieo|eio|eIo|eoi|eoI)")
			else
				across
					arguments.argument (1) as c
				loop
					inspect c.item
					when 'i' then
							-- Stdin is redirected.
							-- Write input to a file.
						create f.make_create_read_write (output_file_name)
						from
							io.input.read_character
						until
							io.input.end_of_file
						loop
							f.put_character (io.input.last_character)
							io.input.read_character
						end
						f.close
					when 'I' then
							-- Stdin is not redirected.
							-- Delete an output file.
						create f.make (output_file_name)
						if f.path_exists then
							f.delete
						end
							-- Try to access input anyway.
						io.input.end_of_file.do_nothing
					when 'o' then
							-- Write something to standard output.
						io.output.put_string (output_message)
					when 'e' then
							-- Write something to standard error.
						io.error.put_string (error_message)
					end
				end
			end
		end

feature {NONE} -- Control

	arguments: ARGUMENTS_32
		once
			create Result
		end

end
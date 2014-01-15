note

    description:

       "[
          Simple example to demonstrate and test BZ_INPUT_STREAM and BZ_OUTPUT_STREAM.
          The resulting program compresses the generates C Source example.c into the
          file example.bz2 and decompresses it again into new_exmpl.c. The last
          step checks if both C files are identical.
        ]"

    library:    "ELJ"
    author:     "Uwe Sander"
	copyright:  "Copyright (c) 2002, Uwe Sander and others"
    license:    "Eiffel Forum License v1"
    date:       "$Date$"
    revision:   "$Revision$"
    last:       "$Author$"
	status:     "Tested"
	complete:   "yes"

class EXAMPLE

creation
	make

feature {NONE}

	make
		local
			bin: RAW_FILE
			brd: BZ_INPUT_STREAM
			bwr: BZ_OUTPUT_STREAM
		do
			from
				create bin.make_open_read ("example.c")
				create bwr.open ("example.bz2")
				bin.read_character
			until
				bin.end_of_file
			loop
				bwr.put (bin.last_character)
				bin.read_character
			end

			bin.close
			bwr.close

			from
				create bin.make_open_read ("new_exmpl.c")
				create brd.open ("example.bz2")
				brd.read
			until
				brd.end_of_input
			loop
				bin.put (brd.last_item)
				brd.read
			end

			brd.close
			bin.close

			if same_files ("new_exmpl.c", "example.c") then
				print ("%Ncompression / decompression was successful.%N")
			else
				print ("%N*** ERROR *** uncompressed file differs from original file%N")
			end
		end

	same_files (first_file, second_file: STRING): BOOLEAN
		local
			frs: RAW_FILE
			sec: RAW_FILE
		do
			from
				create frs.make_open_read (first_file)
				create sec.make_open_read (second_file)

				frs.read_character
				sec.read_character
			until
				frs.end_of_file or else sec.end_of_file or else frs.last_character /= sec.last_character
			loop
				frs.read_character
				sec.read_character
			end

			Result := frs.end_of_file and then sec.end_of_file
		end

end -- class EXAMPLE

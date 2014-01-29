note
	description : "testing application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS
	ZLIB_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make
		do
			example
		end


  example
		local
			inp: ARRAY[CHARACTER]
			fle: PLAIN_TEXT_FILE
			idx: INTEGER
			tou: ZLIB_OUTPUT_STREAM
			tst: ZLIB_INPUT_STREAM
			cin: INTEGER
			cot: INTEGER
			l_out: PLAIN_TEXT_FILE
		do
			create inp.make_empty

			create fle.make_open_read ("index.html")


			if fle.is_open_read then
				from
					fle.read_character
				until
					fle.end_of_file
				loop
					inp.force (fle.last_character, inp.upper + 1)
					fle.read_character
				end -- loop

				fle.close

				from
					create tou.connect_to_file ("index.bin")
					idx := inp.lower
				until
					idx > inp.upper
				loop
					cin := cin + 1
					tou.put (inp.item (idx))
					idx := idx + 1
				end -- loop

				tou.close

				create tst.connect_to_file ("index.bin")
				create l_out.make_create_read_write ("index_uncompress.html")

				if tst.has_error then
					if tst.has_error_message then
						print (tst.last_error_message)
					else
						print (tst.last_error_code)
					end -- if
				else
					from
						tst.read
						l_out.put_character (tst.last_item)
					until
						tst.end_of_input
					loop
						cot := cot + 1
						tst.read
						l_out.put_character (tst.last_item)
					end -- loop
				end -- if

				if tst.is_connected then
					tst.close
				end -- if




				print ("%NRead in%TCompress says%TCounted out%TUncompress says%N")
				print (cin)
				print ("%T")
				print (tou.total_bytes_compressed)
				print ("%T%T")
				print (cot)
				print ("%T%T")
				print (tst.total_bytes_uncompressed)
				print ("%N%N")


				print ("%NRead in%TCompress says%N")
				print (cin)
				print ("%T")
				print (tou.total_bytes_compressed)
				print ("%N%N")
			end -- if
		end -- make
end
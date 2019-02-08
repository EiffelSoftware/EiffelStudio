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
			-- TODO reimplement using the new input and output streams	
		end


  example
		local
			dc: ZLIB_IO_MEDIUM_COMPRESS
			di: ZLIB_IO_MEDIUM_UNCOMPRESS
			des_file: FILE
			src_file: FILE
			l_new_file: FILE
		do
			create {RAW_FILE}des_file.make_create_read_write (output_file)
			create {RAW_FILE}src_file.make_open_read (source_file)
			create dc.io_medium_stream (des_file)
			dc.put_io_medium (src_file)


			create {RAW_FILE}des_file.make_open_read (output_file)
			create {RAW_FILE}l_new_file.make_create_read_write (new_file)
			create di.io_medium_stream (des_file)
			di.to_medium (l_new_file)

			print ("%NBytes compresses:" + dc.total_bytes_compressed.out)
			print ("%NBytes uncompresses:" + di.total_bytes_uncompressed.out)


		end

feature -- Implementation

	source_file: STRING = "text_to_compress_2.txt"

	output_file: STRING = "test.gz"

	new_file: STRING = "new_text.txt"

end

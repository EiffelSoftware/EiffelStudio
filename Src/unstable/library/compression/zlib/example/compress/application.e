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
			dc: ZLIB_DATA_COMPRESSION
			di: ZLIB_DATA_INFLATE
			des_file: FILE
		do
			create {RAW_FILE}des_file.make_create_read_write (output_file)
			create dc.file_stream (des_file)
			dc.put_file (source_file)

			create {RAW_FILE}des_file.make_open_read (output_file)
			create di.file_stream (des_file)
			di.to_file (new_file)

			print ("%NBytes compresses:" + dc.total_bytes_compressed.out)
			print ("%NBytes uncompresses:" + di.total_bytes_uncompressed.out)


		end

feature -- Implementation

	source_file: STRING = "index.html"

	output_file: STRING = "testing.bin"

	new_file: STRING = "new.html"

end

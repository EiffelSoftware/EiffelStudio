note
	description: "Example showing how to use utility functions, gzread, gzwrite, gzclose, gzopen."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			compress_file
			decompress_file
		end

	compress_file
		do
			{ZLIB_UTILITIES}.compress_file (create {PATH}.make_from_string (original_file), create {PATH}.make_from_string (compressed_file))
		end

	decompress_file
		do
			{ZLIB_UTILITIES}.uncompress_file (create {PATH}.make_from_string (compressed_file), create {PATH}.make_from_string (uncompressed_file))
		end

feature -- Implementation

	Original_file: STRING = "index.html"
		-- The original uncompressed file.

	Compressed_file: STRING = "index.z"
		-- New compressed file

	Uncompressed_file : STRING = "new_index.html"
		-- Uncompressed version of Compressed file.

	Buffer_size: INTEGER = 2048
		-- Internal buffer.

end

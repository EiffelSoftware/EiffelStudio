indexing
	description: "INDEPENDENT_STORER translation table abstraction."
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

class
	IND_STORER_TRANS_TBL

creation
	make

feature -- Initialization

	make (a_filename: STRING) is
		require
		    Args_valid: a_filename /= Void and then not a_filename.empty
		do
		    filename := clone(a_filename)
		ensure
		    Filename_set: filename.is_equal(a_filename)
		end

	create is
		require
		    Valid_filename: filename /= Void and then not filename.empty
		local
			translation_file: RAW_FILE
		do
			!! translation_file.make_open_write (filename)
			create_translation_table (translation_file.file_pointer)
			translation_file.close
		end

	restore is
		require
		    Valid_filename: filename /= Void and then not filename.empty
		local
			translation_file: RAW_FILE
		do
			!! translation_file.make_open_read (filename)
			read_translation_table (translation_file.file_pointer)
			translation_file.close
		end;

feature -- Access
	filename: STRING

feature -- Status
	exists:BOOLEAN is
		local
			f: RAW_FILE
		do
			!! f.make(filename)
			Result := f.exists
		end

feature -- Implementation
	create_translation_table (file: POINTER) is
		external
			"C"
		alias
			"create_translation_table"
		end

	read_translation_table (file: POINTER) is
		external
			"C"
		alias
			"read_translation_table"
		end

	db_table_display is
		external
			"C"
		alias
			"display"
		end

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         |          support: info@deepthought.com.au         |
--         |                                                   |
--         +---------------------------------------------------+


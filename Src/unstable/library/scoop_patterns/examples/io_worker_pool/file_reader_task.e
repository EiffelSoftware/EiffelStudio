note
	description: "A future task that can read a file."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_READER_TASK

inherit

	CP_COMPUTATION [STRING]

create
	make, make_from_separate

feature {NONE} -- Initialization

	make (a_path: STRING)
			-- Create a new task which reads the whole content from `a_path'.
		do
			path := a_path
		end

feature {CP_DYNAMIC_TYPE_IMPORTER} -- Initialization

	make_from_separate (other: separate like Current)
			-- <Precursor>
		do
			create path.make_from_separate (other.path)
			promise := other.promise
		end

feature -- Access

	path: STRING
			-- The path of the file to read from.

feature -- Basic operations

	computed: STRING
			-- <Precursor>
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_open_read (path)
			l_file.read_stream (l_file.count)
			Result := l_file.last_string
			l_file.close
		end

end

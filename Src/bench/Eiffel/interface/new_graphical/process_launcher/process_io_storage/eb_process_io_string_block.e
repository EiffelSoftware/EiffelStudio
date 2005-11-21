indexing
	description: "Object that stores a block of data into a STRING object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROCESS_IO_STRING_BLOCK

inherit
	EB_PROCESS_IO_DATA_BLOCK

create
	make

feature{NONE} -- Initialization

	make (str: STRING; from_error: BOOLEAN; is_last_one: BOOLEAN) is
			-- Store `str' into `Current' object.
			-- `from_error' indicates whether `str' comes from error stream
			-- from process.
		require
			str_not_void: str /= Void
		do
			is_error := from_error
			is_end := is_last_one
			create string_buffer.make_from_string (str)
			string_buffer.replace_substring_all ("%R", "")
		ensure
			is_error_set: is_error = from_error
			is_end_set: is_end = is_last_one
			string_buffer_filtered: not string_buffer.has ('%R')
		end

feature  -- Status reporting

	data: ANY is
			--
		do
			Result := string_buffer
		end

	string_representation: STRING is
			--
		do
			Result := string_buffer
		end

	count: INTEGER is
		-- Length of stored data in bytes.
		do
			Result := string_buffer.count
		end


feature{NONE} -- Implementation

	string_buffer: STRING

invariant
	string_buffer_not_void: string_buffer /= Void

end

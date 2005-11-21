indexing
	description: "Object that stores a block of data into a STRUCTURED_TEXT object"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROCESS_IO_STRUCTURED_TEXT_BLOCK

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
			str.replace_substring_all ("%R", "")
			format_structured_image (str, from_error)
		ensure
			is_error_set: is_error = from_error
			is_end_set: is_end = is_last_one
			str_packed: structured_image /= Void
		end

feature -- Status reporting

	data: ANY is
			--
		do
			Result := structured_image
		end

	string_representation: STRING is
			--
		do
			Result := structured_image.image
		end

	count: INTEGER is
		-- Length of stored data in bytes.
		do
			Result := structured_image.image.count
		end



feature{NONE} -- Initialization

	format_structured_image (str: STRING; from_error: BOOLEAN) is
			--
		require
			str_not_null: str /= Void
			str_not_empty: not str.is_empty
		local
			l_pos, l_previous: INTEGER
			w: VD43
		do
			if not from_error then
				create structured_image.make
				structured_image.add_multiline_string (str, 0)
			else
				create structured_image.make
				l_pos := str.index_of ('%N', 1)
				if l_pos > 0 then
					from
						l_previous := 1
					until
						l_pos = 0
					loop
						create w
						structured_image.add_error(w, str.substring (l_previous, l_pos -1))
						structured_image.add_new_line
						l_previous := l_pos + 1
						l_pos := str.index_of ('%N', l_previous)
					end
					if l_previous <= str.count then
						create w
						structured_image.add_error (w,str.substring (l_previous, str.count))
					end
				else
					create w
					structured_image.add_error(w,str)
				end
			end
		ensure
			data_stored: structured_image /= Void
		end

feature -- Stuctured Storage

	structured_image: STRUCTURED_TEXT
		-- Image in which data comes from process is stored.

invariant

	structured_image_not_void: structured_image /= Void

end

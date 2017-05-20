note
    description:"[
    		Implements basic INPUT_STREAM as a stream filtered by the bzip2 compression
        	algorithms. Source must be a file which has been compressed by bzip2 before.
        ]"
    library:    "ELJ/base"
    author:     "Uwe Sander"
	copyright:  "Copyright (c) 2002-2017, Uwe Sander, Eiffel Software and others"
    license:    "Eiffel Forum License v1"
    date:       "$Date$"
    revision:   "$Revision$"
    last:       "$Author$"
	status:     "Tested"
	complete:   "yes"

class BZ_INPUT_STREAM

inherit
	BZ_STREAM_BASE
		redefine
			bz_file
		end

create
	make,
	open

feature {NONE} -- Initialization

	make
		do
			initialize_buffer
			create bz_file
			create name.make (0)
		end

	initialize_buffer
		do
			create buffer.make_empty
		end

feature --

	close
		do
			if attached bz_file as l_bz_file then
				l_bz_file.read_close
				l_bz_file.close
			end
			if attached name as l_name then
				l_name.copy ("")
			end
		end

	open (name_: STRING)
		require
			non_void_name: name_ /= Void
			non_empty_name: not name_.is_empty
		do
			initialize_buffer
			if bz_file = Void then
				create bz_file
				create name.make (0)
			end

			create buffer.make_filled ('%U', 1, 2048)

			if attached bz_file as l_bz_file then
				l_bz_file.open (name_)

				if not has_error then
					l_bz_file.read_open_default (default_pointer, 0)
					l_bz_file.read (buffer)

					memory := 1
					if attached name as l_name then
						l_name.copy (name_)
					end
				end
			end
		ensure
			open_if_no_error: not has_error implies is_open_read
		end

feature -- Status

	end_of_input: BOOLEAN

	is_closable: BOOLEAN
		do
			Result := is_open_read
		end

	is_open_read: BOOLEAN
		do
			Result := attached bz_file as l_bz_file and then l_bz_file.is_stream_open
		end

	valid_unread_item (item_: CHARACTER): BOOLEAN
		do
			Result := not push_back_flag
		end

feature -- Access

	last_item: CHARACTER

	name: detachable STRING

feature -- Operations

	read
		do
			if push_back_flag then
				last_item := push_back_character
				push_back_flag := False
			else

				if memory > buffer.upper then
					if attached bz_file as l_bz_file and then l_bz_file.last_operation = l_bz_file.Ok then
						l_bz_file.read (buffer)
						memory := 1
					else
						end_of_input := True
					end
				end

				if not end_of_input then
					last_item := buffer @ memory
					memory := memory + 1
				end
			end
		end

	read_line_in (a_buffer: STRING)
		do
			a_buffer.wipe_out
			from
				read
			until
				end_of_input or else last_item = '%N'
			loop
				a_buffer.extend (last_item)
				read
			end
		end

	unread (item_: CHARACTER)
		do
			push_back_flag := True
			push_back_character := item_
		end

feature {NONE} -- Implementation

	buffer: ARRAY[CHARACTER]

	bz_file: detachable BZFILE_READ

	memory: INTEGER

	push_back_character: CHARACTER

	push_back_flag: BOOLEAN

invariant

	buffer_created: is_open_read implies buffer /= Void

end

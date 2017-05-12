note

    description:
       "Implements basic OUTPUT_STREAM as a stream filtered by the bzip2 compression algorithms."
    library:    "ELJ"
    author:     "Uwe Sander"
	copyright:  "Copyright (c) 2002-2017, Uwe Sander, Eiffel Software and others"
    license:    "Eiffel Forum License v1"
    date:       "$Date$"
    revision:   "$Revision$"
    last:       "$Author$"
	status:     "Tested"
	complete:   "yes"

class BZ_OUTPUT_STREAM

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

feature -- Commands

	close
		do
			flush
			if attached bz_file as l_bz_file then
				l_bz_file.write_close (False)
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
			end -- if

			create buffer.make_filled ('%U', 1, 2048)

			if attached bz_file as l_bz_file then
				l_bz_file.open (name_)

				if not has_error then
					l_bz_file.write_open_default
					memory := 0
					if attached name as l_name then
						l_name.copy (name_)
					end

				end -- if
			end
		ensure
			open_if_no_error: not has_error implies is_open_write
		end

feature -- Status

	is_closable: BOOLEAN
		do
			Result := is_open_write
		end

	is_open_write: BOOLEAN
		do
			Result := attached bz_file as l_bz_file and then l_bz_file.is_stream_open
		end

feature -- Access

	name: detachable STRING

feature -- Operations

	flush
		do
			if
				memory > 0 and then
				attached bz_file as l_bz_file
			then
				l_bz_file.write_raw (character_array_to_external (buffer), memory)
				memory := 0
			end
		end

	put (a_char: CHARACTER)
		do
			if
				memory = buffer.upper and then
				attached bz_file as l_bz_file
			then
				l_bz_file.write (buffer)
				memory := 0
			end
			memory := memory + 1
			buffer.put (a_char, memory)
		end

feature {NONE}

	buffer: ARRAY[CHARACTER]

	bz_file: detachable BZFILE_WRITE

	memory: INTEGER

invariant

	buffer_created: is_open_write implies buffer /= Void

end

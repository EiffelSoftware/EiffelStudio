indexing
	description: "Ancestor for reading/writing basic known entities from and to a particular % 
		%location specified in concrete descendants of current."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SED_READER_WRITER

feature -- Header/Footer

	read_header is
			-- Action being executed before starting to read data.
		do
		end

	write_header is
			-- Action being executed before starting to write data.
		do
		end

	read_footer is
			-- Action being executed after finishing to read data.
		do
		end

	write_footer is
			-- Action being executed after finishing to write data.
		do
		end

feature -- Status report

	is_ready_for_reading: BOOLEAN is
			-- Is Current ready for future read operations?
		deferred
		end

	is_ready_for_writing: BOOLEAN is
			-- Is Current ready for future write operations?
		deferred
		end

	is_pointer_value_stored: BOOLEAN
			-- Is value of a POINTER stored?

feature -- Settings

	set_is_pointer_value_stored (v: like is_pointer_value_stored) is
			-- Set `is_pointer_value_stored' with `v'.
		do
			is_pointer_value_stored := v	
		ensure
			is_pointer_value_stored_set: is_pointer_value_stored = v
		end

feature -- Access

	read_character_8: CHARACTER is
			-- Read next 8-bits character
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_boolean: BOOLEAN is
			-- Read next boolean
		require
			is_ready: is_ready_for_reading
		deferred
		end
		
	read_natural_8: NATURAL_8 is
			-- Read next natural_8
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_natural_16: NATURAL_16 is
			-- Read next natural_16
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_natural_32: NATURAL_32 is
			-- Read next natural_32
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_natural_64: NATURAL_64 is
			-- Read next natural_64
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_integer_8: INTEGER_8 is
			-- Read next integer_8
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_integer_16: INTEGER_16 is
			-- Read next integer_16
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_integer_32: INTEGER is
			-- Read next integer_32
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_integer_64: INTEGER_64 is
			-- Read next integer_64
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_real_32: REAL is
			-- Read next real_32
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_real_64: DOUBLE is
			-- Read next real_64
		require
			is_ready: is_ready_for_reading
		deferred
		end

	read_pointer: POINTER is
			-- Read next pointer
		require
			is_ready: is_ready_for_reading
		deferred
		end

feature -- Element change

	write_character_8 (v: CHARACTER) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_boolean (v: BOOLEAN) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end
		
	write_natural_8 (v: NATURAL_8) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_natural_16 (v: NATURAL_16) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_natural_32 (v: NATURAL_32) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_natural_64 (v: NATURAL_64) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_integer_8 (v: INTEGER_8) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_integer_16 (v: INTEGER_16) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_integer_32 (v: INTEGER) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_integer_64 (v: INTEGER_64) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_real_32 (v: REAL) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_real_64 (v: DOUBLE) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

	write_pointer (v: POINTER) is
			-- Write `v'.
		require
			is_ready: is_ready_for_writing
		deferred
		end

end

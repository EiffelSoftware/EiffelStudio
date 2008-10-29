indexing
	description	: "Reads line by line from a ePosix file descriptor without blocking"
	author		: "Andreas Leitner"
	date		: "$Date$"
	revision	: "1.0.0"

class AUT_THREAD_SAFE_LINE_READER

create

	make

feature {NONE} -- Initialization

	make is
			-- Create new line reader which gets it's content via `put_string' handler
		do
			create buffer.make (256)
			create mutex.make
			create line_queue.make (20)
		end

feature -- Status

	has_read_line: BOOLEAN is
			-- Has a complete line been read?
		do
			Result := last_string /= Void
		ensure
			definition: Result = (last_string /= Void)
		end

feature -- Access

	last_string: STRING
			-- Last line read; Only in a defined state when
			-- `has_read_line' is true.

feature -- Writing

	put_string (a_string: STRING) is
			-- Put `a_string' into the buffer (append it)
			-- and put full lines into the `line_queue'.
		local
			i: INTEGER_32
			c: CHARACTER_8
		do
			if a_string /= Void and then a_string.count > 0 then
				from
					i := 1
				until
					i > a_string.count
				loop
					c := a_string.item (i)
					if c /= '%R' then
						if c = '%N' then
							mutex.lock
							line_queue.put (buffer.twin)
							mutex.unlock
							buffer.wipe_out
						else
							buffer.append_character (c)
						end
					end
					i := i + 1
				end
			end
		end

feature -- Reading

	reset_last_string is
			-- Set `last_string' to `Void'.
		do
			last_string := Void
		ensure
			last_string_reset: last_string = Void
		end

	try_read_line is
			-- Try to read a complete line into `last_string'. Doesn't block if it cannot
			-- read a complete line. Sets `has_read_line' to `True' if it
			-- succeeded. Exit immediately if no input is available at
			-- the moment or the end of input has been reached.
		do
			if has_line then
				mutex.lock
				last_string := line_queue.item.twin
				line_queue.remove
				mutex.unlock
			else
				last_string := Void
			end
		end

	try_read_all_lines is
			-- Try to read all lines available in `line_queue' and
			-- store result in `last_string'.
		do
			if has_line then
				create last_string.make (default_last_string_length)
				mutex.lock
				from
				until
					line_queue.is_empty
				loop
					last_string.append (line_queue.item)
					line_queue.remove
				end
				mutex.unlock
			else
				last_string := Void
			end
		end

feature {NONE} -- Implementation

	line_queue: ARRAYED_QUEUE [STRING]
			-- Buffer for completely read lines

	mutex: MUTEX
			-- Mutex for locking buffer operations

	buffer: STRING
			-- Buffer for partialy read lines

	default_last_string_length: INTEGER is 1024
			-- Default length in byte for `last_string'

	has_line: BOOLEAN is
			-- Has a complete line been stored in the `line_queue'?
		do
			mutex.lock
			Result := line_queue.count > 0
			mutex.unlock
		end

invariant

	mutex_not_void: mutex /= Void

end

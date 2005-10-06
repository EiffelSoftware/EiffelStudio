
indexing
	
	author: "David Hollenberg";
	date: "October 8, 1997";
	description: "An unnamed Unix pipe used for interprocess communication"

class PROCESS_UNIX_PIPE

inherit
	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end
create
	make

feature {PROCESS_UNIX_OS} -- Creation

	make (read_fd, write_fd: INTEGER) is
			-- Create a pipe object which represents the
			-- pipe with read file descriptor `read_fd' and
			-- write file descriptor `write_fd'
		require
			valid_read_desc: read_fd >= 0
			valid_write_desc: write_fd >= 0
		do
			read_descriptor := read_fd;
			write_descriptor := write_fd;
		ensure
			read_desc_set: read_descriptor = read_fd
			write_desc_set: write_descriptor = write_fd
		end;

feature -- Attributes

	read_descriptor: INTEGER;
			-- Descriptor to be used for reading from pipe

	write_descriptor: INTEGER;
			-- Descriptor to be used for writing to pipe

feature -- Modification

	close_read_descriptor is
			-- Close descriptor to be used for reading from pipe,
			-- if it is open
		do
			if read_descriptor /= Invalid_file_descriptor then
				close_file_descriptor (read_descriptor);
				erase_read_descriptor
			end
		end

	close_write_descriptor is
			-- Close descriptor to be used for write to pipe,
			-- if it is open
		do
			if write_descriptor /= Invalid_file_descriptor then
				close_file_descriptor (write_descriptor);
				erase_write_descriptor
			end
		end

	erase_read_descriptor is
			-- Set `read_descriptor' to an invalid value
			-- so it won't be closed if object is GC'ed.
			-- Caller must take responsiblity for ensuring
			-- that descriptor is closed when no longer needed
		do
			read_descriptor := Invalid_file_descriptor
		end

	erase_write_descriptor is
			-- Set `write_descriptor' to an invalid value
			-- so it won't be closed if object is GC'ed.
			-- Caller must take responsiblity for ensuring
			-- that descriptor is closed when no longer needed
		do
			write_descriptor := Invalid_file_descriptor
		end

feature {NONE} -- Cleanup

	dispose is
		do
			close_read_descriptor
			close_write_descriptor
		end

feature {NONE} -- Implementation

	close_file_descriptor (fd: INTEGER) is
			-- Close existing open file descriptor `fd'
		require
			valid_descriptor: fd >= 0
		external
			"C"
		alias
			"unix_close"
		end;

	Invalid_file_descriptor: INTEGER is -1
			-- File descriptor which is not in valid range

end -- class PROCESS_UNIX_PIPE

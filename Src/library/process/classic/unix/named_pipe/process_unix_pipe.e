indexing
	description: "An unnamed Unix pipe used for interprocess communication"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PROCESS_UNIX_PIPE

inherit
	PROCESS_UNIX_OS
		export
			{NONE} all
			{PROCESS_UNIX_PIPE} close_file_descriptor
		end

	DISPOSABLE
		
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

	Invalid_file_descriptor: INTEGER is -1;
			-- File descriptor which is not in valid range

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

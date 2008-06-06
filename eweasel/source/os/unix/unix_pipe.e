indexing
	date: "October 8, 1997";
	description: "An unnamed Unix pipe used for interprocess communication"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class UNIX_PIPE

inherit
	ANY
	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end
	UNIX_EXTERNALS
		export
			{NONE} all
		end

create
	make

feature {UNIX_OS} -- Creation

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


indexing
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"


end -- class UNIX_PIPE

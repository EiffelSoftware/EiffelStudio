note
	description: "Summary description for {EVENT_NAMED_PIPE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT_UNBLOCK_NAMED_PIPE

inherit
	UNIX_UNNAMED_PIPE
		rename
			make as make_process
		redefine
			name,
			exists
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING)
			-- Init
		require
			name_not_void: a_name /= Void
		do
			name := a_name
			create shared_mptr.make (initial_buffer_size)
			create last_string.make_empty
		end

feature -- Access

	name: STRING
			-- Name of the pipe

feature -- Operation

	create_read
			-- Open file in read mode;
			-- create it if it does not exist.
		local
			external_name: ANY
		do
			external_name := name.to_c
			read_descriptor := open_pipe ($external_name)
			is_read_descriptor_open := True
		end

	create_write
			-- Open file in read mode;
			-- create it if it does not exist.
		local
			external_name: ANY
		do
			is_write_descriptor_open := True
			external_name := name.to_c
			write_descriptor := open_pipe ($external_name)
		end

	read_to_end
			-- Read file into `last_string' until the end.
		local
			l_last_string: like last_string
		do
			from
				last_read_successful := True
				create l_last_string.make (initial_buffer_size)
			until
				not last_read_successful
			loop
				read_stream_non_block (initial_buffer_size)
				if last_read_successful then
					l_last_string.append (last_string)
				end
			end
			if not l_last_string.is_empty then
				last_read_successful := True
				last_string := l_last_string
			else
				last_read_successful := False
			end
		end

	delete
			-- Remove link with physical file.
			-- File does not physically disappear from the disk
			-- until no more processes reference it.
			-- I/O operations on it are still possible.
			-- A directory must be empty to be deleted.
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_unlink ($external_name)
		end

feature -- Status report

	exists: BOOLEAN
			-- Does physical file exist?
			-- (Uses effective UID.)
		local
			external_name: ANY
		do
			external_name := name.to_c
			Result := file_exists ($external_name)
		end

feature {NONE} -- Externals

	file_exists (f_name: POINTER): BOOLEAN
			-- Does `f_name' exist.
		external
			"C signature (char *): EIF_BOOLEAN use %"eif_file.h%""
		end

	file_unlink (fname: POINTER)
			-- Delete file `fname'.
		external
			"C signature (char *) use %"eif_file.h%""
		end

	open_pipe (a_name: POINTER): INTEGER
		external
			"C inline use <stdio.h>, <fcntl.h>"
		alias
			"[
				struct stat st;
				int socket;
			 
				if (lstat ($a_name, &st) == 0) {
					if ((st.st_mode & S_IFMT) == S_IFREG) {
						eise_io("PIPE: File exists.");
					}
				}

				unlink ($a_name);
				if (mkfifo ($a_name, 0666) == -1) {
					eise_io("PIPE: `mkfifo' error.");
				}

				socket = open ($a_name, O_RDWR | O_NONBLOCK, 0);

				if (socket == -1) {
					eise_io("PIPE: Open error.");
				}

				return socket;
			]"
		end

	read_file (fd: INTEGER)
		external
			"C inline"
		alias
			"[
				char buf[255];
				int len;
				len = read($fd, buf, sizeof(buf) - 1);

				if (len == -1) {
					perror("read");
					return;
				} else if (len == 0) {
					fprintf(stderr, "Connection closed\n");
					return;
				}

				buf[len] = '\0';
			]"
		end

	c_close (fd: INTEGER)
		external
			"C inline"
		alias
			"close($fd);"
		end


end

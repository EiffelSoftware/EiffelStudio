indexing

	description:

		"Output files containing extended ASCII characters %
		%(8-bit code between 0 and 255)"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class KL_OUTPUT_FILE

inherit

	KI_OUTPUT_FILE









	KL_FILE
		rename
			open as open_write,
			is_open as is_open_write
		end

feature -- Status report

	is_open_write: BOOLEAN is
			-- Is file opened in write mode?
		do
			Result := old_is_open_write
		end

feature -- Output

	put_character (c: CHARACTER) is
			-- Write `c' to output file.
		do
			old_put_character (c)
		end

	put_string (a_string: STRING) is
			-- Write `a_string' to output file.
			-- Note: If `a_string' is a UC_STRING or descendant, then
			-- write the bytes of its associated UTF unicode encoding.
		do
			old_put_string (STRING_.as_string (a_string))
		end

feature -- Basic operations

	open_write is
			-- Open current file in write-only mode if
			-- it can be opened, let it closed otherwise.
			-- If the file is successfully opened, it is
			-- either created if it didn't exist or its
			-- old content is removed otherwise.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if string_name /= Empty_name then
					old_open_write
				end
			elseif not is_closed then
				close
			end
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

	open_append is
			-- Open current file in append mode if it
			-- can be opened, let it closed otherwise.
			-- If the file is successfully opened, it is
			-- either created if it didn't exist or the
			-- data which will be written to the file will
			-- appear after its old content otherwise.
		local
			rescued: BOOLEAN
		do
			if not rescued then
				if string_name /= Empty_name then
					old_open_append
				end
			elseif not is_closed then
				close
			end
		rescue
			if not rescued then
				rescued := True
				retry
			end
		end

	recursive_open_write is
			-- Open current file in write-only mode if
			-- it can be opened, let it closed otherwise.
			-- If the file is successfully opened, it is
			-- either created if it didn't exist or its
			-- old content is removed otherwise. Try to
			-- recursively create its parent directory
			-- if it does not exist yet.
		local
			a_dirname: STRING
			a_pathname: STRING
			a_dir: KL_DIRECTORY
		do
			open_write
			if not is_open_write then
				a_pathname := file_system.canonical_pathname (name)
				a_dirname := file_system.dirname (a_pathname)
				create a_dir.make (a_dirname)
				if not a_dir.exists then
					a_dir.recursive_create_directory
					if a_dir.exists then
						open_write
					end
				end
			end
		end

	recursive_open_append is
			-- Open current file in append mode if it
			-- can be opened, let it closed otherwise.
			-- If the file is successfully opened, it is
			-- either created if it didn't exist or the
			-- data which will be written to the file will
			-- appear after its old content otherwise.
			-- Try to recursively create its parent directory
			-- if it does not exist yet.
		local
			a_dirname: STRING
			a_pathname: STRING
			a_dir: KL_DIRECTORY
		do
			open_append
			if not is_open_write then
				a_pathname := file_system.canonical_pathname (name)
				a_dirname := file_system.dirname (a_pathname)
				create a_dir.make (a_dirname)
				if not a_dir.exists then
					a_dir.recursive_create_directory
					if a_dir.exists then
						open_append
					end
				end
			end
		end

	flush is
			-- Flush buffered data to disk.
		do

			old_flush

		end


feature {NONE} -- Implementation


	old_open_write is
			-- Open file in write mode.
		require
			string_name_not_void: string_name /= Void
			string_name_not_empty: string_name.count > 0
		deferred
		end

	old_open_append is
			-- Open file in append mode.
		require
			string_name_not_void: string_name /= Void
			string_name_not_empty: string_name.count > 0
		deferred
		end

	old_is_open_write: BOOLEAN is
			-- Is file open for writing?
		deferred
		end

	old_put_character (c: CHARACTER) is
			-- Write `c' at current position.
		require
			is_open_write: old_is_open_write
		deferred
		end

	old_put_string (s: STRING) is
			-- Write `s' at current position.
		require
			is_open_write: old_is_open_write
			non_void: s /= void
		deferred
		end

	old_flush is
			-- Forces a write of unwritten character (write my have been 
			-- delayed, flush writes buffered characters).
		deferred
		end




































































end

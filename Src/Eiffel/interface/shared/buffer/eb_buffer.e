note
	description: "Buffer: A chunk of text"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_BUFFER

create
	make

feature{NONE} -- Initialization

	make (a_content: like content; a_temp_file_name: like temp_file_name)
			-- Initialize `content' with `a_content' and `temp_file_name' with `a_temp_file_name'.
		do
			set_temp_file_name (a_temp_file_name)
			set_temp_content (a_content)
		end

feature -- Access

	content: STRING
			-- Content of Current buffer
		require
			initialized: is_initialized
		local
			l_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make (temp_file_name)
				if l_file.change_date /= last_change_date then
					l_file.open_read
					l_file.read_stream (l_file.count)
					set_temp_content (l_file.last_string.twin)
					l_file.close
					set_last_change_date (l_file.change_date)
				end
				Result := temp_content.twin
			else
				Result := ""
			end
		ensure
			result_attached: Result /= Void
		rescue
			l_retried := True
			if l_file /= Void and then l_file.is_open_read then
				l_file.close
			end
			retry
		end

	temp_file_name: STRING
			-- File to store `content' temporarily
			-- Buffer is always treated as a file stored on disk.

feature -- Status report

	is_initialized: BOOLEAN
			-- Is current buffer initialized?			

feature -- Setting

	set_temp_file_name (a_name: like temp_file_name)
			-- Set `temp_file_name' with `a_name'.
		require
			not_initialized: not is_initialized
			a_name_attached: a_name /= Void
		do
			temp_file_name := a_name.twin
		ensure
			temp_file_name_set: temp_file_name /= Void and then temp_file_name.is_equal (a_name)
		end

	initialize
			-- Initialize current buffer.
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_create_read_write (temp_file_name)
			l_file.put_string (temp_content)
			l_file.close
			set_last_change_date (l_file.change_date)
			set_is_initialized (True)
		ensure
			initialized: is_initialized
		end

	dispose
			-- Dispose current buffer (remove temp file).
			-- After disposal, current buffer become not `is_initialized'.
		local
			l_file: RAW_FILE
		do
			create l_file.make (temp_file_name)
			if l_file.exists then
				l_file.delete
			end
			set_is_initialized (False)
		ensure
			not_initialized: not is_initialized
		end

feature{NONE} -- Implementation

	last_change_date: INTEGER
			-- Last change date of `temp_file_name'

	temp_content: like content
			-- Temporary content

	set_is_initialized (b: BOOLEAN)
			-- Set `is_initialized' with `b'.
		do
			is_initialized := b
		ensure
			is_initialized_set: is_initialized = b
		end

	set_temp_content (a_content: like temp_content)
			-- Set `temp_content' with `a_content'.
		require
			a_content_attached: a_content /= Void
		do
			temp_content := a_content.twin
		ensure
			temp_content_set: temp_content /= Void and then temp_content.is_equal (a_content)
		end

	set_last_change_date (a_date: INTEGER)
			-- Set `last_change_date' with `a_date'.
		do
			last_change_date := a_date
		ensure
			last_change_date_set: last_change_date = a_date
		end

invariant
	temp_file_name_attached: temp_file_name /= Void

end

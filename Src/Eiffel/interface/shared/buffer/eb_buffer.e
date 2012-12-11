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
				create l_file.make_with_path (temp_file_name)
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

	temp_file_name: PATH
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
			temp_file_name_set: temp_file_name /= Void and then temp_file_name.same_as (a_name)
		end

	initialize
			-- Initialize current buffer.
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_with_path (temp_file_name)
			l_file.create_read_write
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
			create l_file.make_with_path (temp_file_name)
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

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

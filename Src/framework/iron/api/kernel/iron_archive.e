note
	description: "Summary description for {IRON_ARCHIVE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_ARCHIVE

create
	make

feature {NONE} -- Initialization

	make (p: like path)
			-- Create archive object with path `p'.
		do
			path := p
			update_info
		end

feature -- Access

	path: PATH

	file_size: INTEGER

	last_modified: detachable DATE_TIME

feature -- Status report	

	file_exists: BOOLEAN
			-- Is file associated with `path' exists?
		local
			u: FILE_UTILITIES
		do
			Result := u.file_path_exists (path)
		end

feature -- Query	

	hash_md5: detachable STRING
			-- MD5 hash for associated archive file, if any.
		local
			f: RAW_FILE
			md5: MD5
		do
			create f.make_with_path (path)
			if f.exists then
				create md5.make
				f.open_read
				md5.update_from_io_medium (f)
				f.close
				Result := "MD5:" + md5.digest_as_string
			end
		end

	hash_sha1: detachable STRING
			-- SHA1 hash for associated archive file, if any.
		local
			f: RAW_FILE
			sha1: SHA1
		do
			create f.make_with_path (path)
			if f.exists then
				create sha1.make
				f.open_read
				sha1.update_from_io_medium (f)
				f.close
				Result := "SHA1:" + sha1.digest_as_string
			end
		end

	hash: detachable STRING
			-- Default hash for associated archive file, if any.
		do
			Result := internal_hash
			if Result = Void then
				compute_hash
				Result := internal_hash
			end
		end

feature -- Basic operation

	update_info
		local
			f: RAW_FILE
		do
			file_size := 0
			last_modified := Void
			internal_hash := Void

			create f.make_with_path (path)
			if f.exists then
				file_size := f.count
				create last_modified.make_from_epoch (f.change_date)
			end
		end

	compute_hash
		do
			set_hash (hash_sha1)
		end

	delete_file
			-- Delete Current archive file, if any.
		require
			file_exists
		local
			f: RAW_FILE
			l_retry_count: INTEGER
		do
			if l_retry_count < 3 then
				create f.make_with_path (path)
				if f.exists then
					f.delete
				end
			end
		rescue
			l_retry_count := l_retry_count + 1
			{EXECUTION_ENVIRONMENT}.sleep (1_000_000) -- 1 ms
			retry
		end

feature -- Change

	set_path (v: PATH)
		require
			v_attached: v /= Void
		do
			path := v
			update_info
		end

	set_hash (h: like hash)
		do
			internal_hash := h
		end

	reset_hash
		do
			set_hash (Void)
		end

feature {NONE} -- Implementation

	internal_hash: detachable STRING

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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

indexing
	description: "[
					When libcURL write data which get from remote web site,
					this memory stuct will be used by Eiffel language to store the data.
					For more informaton see:
					http://curl.haxx.se/libcurl/c/curl_easy_setopt.html#CURLOPTWRITEDATA
																							]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_MEMORY_STRUCT

inherit
	DISPOSABLE

create
	make

feature {NONE} -- Intialization

	make is
			-- Creation method.
		do
			item := item.memory_alloc (struct_size)
			set_size (0)
			set_memory_chunk (default_pointer)
		end

feature -- Query

	item: POINTER
			-- Managed pointer.

	size: INTEGER is
			-- String size.
		do
			if item /= default_pointer then
				Result := c_size (item)
			end
		end

	memory_chunk: POINTER is
			-- Memory chunk access pointer
		do
			if item /= default_pointer then
				Result := c_memory_chunck (item)
			end
		end

	string: STRING_GENERAL is
			-- Covert to Eiffel String.
			-- Maybe void if not exists.
		local
			l_c_string: C_STRING
			l_mem: POINTER
			l_size: INTEGER
		do
			l_mem := c_memory_chunck (item)
			l_size := size
			if l_mem /= default_pointer and then l_size > 0 then
				create l_c_string.share_from_pointer_and_count (l_mem, l_size)
				Result := l_c_string.string
			end
		end

	struct_size: INTEGER is
			-- Size of C Structure.
		do
			Result := c_size_of_memory_struct
		ensure
			nonnegative: Result >= 0
		end

feature -- Command

	set_size (a_size: INTEGER) is
			-- Set `size' to `a_size'
		require
			nonnegative: a_size >= 0
		do
			c_set_size (item, a_size)
		ensure
			set: size = a_size
		end

	set_memory_chunk (a_ptr: POINTER) is
			-- Set `memory_chunk' to `a_ptr'.
		do
			c_set_memory_chunk (item, a_ptr)
		ensure
			set: memory_chunk = a_ptr
		end

	dispose is
			-- Clean up.
		local
			l_mem: POINTER
		do
			if item /= default_pointer then
				l_mem := c_memory_chunck (item)
				if l_mem /= default_pointer then
					l_mem.memory_free
				end
				item.memory_free
				item := default_pointer
			end
		ensure then
			cleared: item = default_pointer
		end

feature {NONE} -- C externals

	c_size_of_memory_struct: INTEGER is
			-- CURL memory struct struct size.
		external
			"C [macro <eiffel_curl.h>]"
		alias
			"sizeof (struct cURLMemoryStruct)"
		end

	c_size (a_item: POINTER): INTEGER is
			-- `a_item''s size
		require
			exists: a_item /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
				((struct cURLMemoryStruct *)$a_item)->size
			]"
		end

	c_set_size (a_item: POINTER; a_size: INTEGER) is
			-- Set `a_item''s size to `a_size'.
		require
			exists: a_item /=default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
			{
				((struct cURLMemoryStruct *)$a_item)->size = $a_size;
			}
			]"
		ensure
			set: c_size (a_item) = a_size
		end

	c_memory_chunck (a_item: POINTER): POINTER is
			-- `a_item''s memory pointer.
		require
			exists: a_item /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
				((struct cURLMemoryStruct *)$a_item)->memory
			]"
		end

	c_set_memory_chunk (a_item: POINTER; a_ptr: POINTER) is
			-- Set `a_item''s memory to `a_ptr'.
		require
			exists: a_item /= default_pointer
		external
			"C inline use <eiffel_curl.h>"
		alias
			"[
			{
				((struct cURLMemoryStruct *)$a_item)->memory = $a_ptr;
			}
			]"
		ensure
			set: c_memory_chunck (a_item) = a_ptr
		end

indexing
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

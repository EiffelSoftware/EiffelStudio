note
	description: "Summary description for {EDK_STRING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDK_LOW_LEVEL_STRING


create
	make

feature -- Creation

	make (a_string: STRING_8)
			-- Create low-level representation of `Current'
		local
			l_character_count, l_character_size, l_buffer_size, i: INTEGER
		do
			l_character_count := a_string.count
			l_character_size := c_character_size_in_bytes
			l_buffer_size := (l_character_count + 1) * l_character_size
			create managed_data.make (l_buffer_size)
				-- + 1 for null character at the end

				-- Iterate string and add data to managed pointer
			from
				i := l_buffer_size - l_character_size
				managed_data.put_natural_16 (0, i)
			until
				i = 0
			loop
				i := i - l_character_size
				managed_data.put_natural_16 (a_string.code (i // l_character_size + 1).to_natural_16, i)
			end
		end

feature -- Access

	item: POINTER
			-- Get pointer to allocated area.
		do
			Result := managed_data.item
		ensure
			item_not_null: Result /= default_pointer
		end

feature {NONE} -- Implementation

	managed_data: MANAGED_POINTER
		-- Data held by Current.

	c_character_size_in_bytes: NATURAL_8
		external
			"C inline use <edk.h>"
		alias
			"[
				#if EIF_OS = EIF_WINNT
  					return sizeof(TCHAR);
				#endif
			]"
		end

end

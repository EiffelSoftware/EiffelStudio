note
	description: "Factory that create a memory stream holding IL instruction stream."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_METHOD_WRITER

inherit
	CLI_UTILITIES
		export
			{NONE} all
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make
			-- Create Factory to store method bodys into `item'.
		do
			create method_locations.make (10)
			create item.make (Chunk_size)
			current_position := 0
			capacity := Chunk_size
			is_previous_body_written := True
			is_closed := False
		end

feature -- Access

	item: MANAGED_POINTER
			-- Memory where IL data instruction stream is stored.

	count: INTEGER
			-- Size of code
		do
			Result := current_position
		end

feature -- Method body definition

	new_method_body (token: INTEGER): MD_METHOD_BODY
			-- Get a new body for method token `token'.
		require
			not_closed: not is_closed
			last_one_has_been_emitted: is_previous_body_written
			is_method_token:
				token & {MD_TOKEN_TYPES}.Md_mask = {MD_TOKEN_TYPES}.Md_method_def
		do
			Result := internal_method_body
			if Result = Void then
				create Result.make (token)
				internal_method_body := Result
			else
				Result.remake (token)
			end
			is_previous_body_written := False
		ensure
			result_not_void: Result /= Void
		end

feature -- Status Report

	is_previous_body_written: BOOLEAN
			-- Has last body generated through Current been emitted?

	is_closed: BOOLEAN
			-- Can Current object be used for further method body definition?
			-- If `True' no, otherwise yes.

feature -- Update

	update_rvas (md_emit: MD_EMIT; top_rva: INTEGER)
			-- Now that all bodys have been emitted, update each
			-- method token with its corresponding rva knowing
			-- that current memory stream starts at `top_rva'.
		require
			not_is_closed: not is_closed
		do
			is_closed := True
			across
				method_locations as l
			loop
				md_emit.set_method_rva (l.key, top_rva + l.item)
			end
		ensure
			is_closed: is_closed
		end

feature -- Settings

	write_duplicate_body (source_meth, new_meth: INTEGER)
			-- Make method `new_meth' point to same code location
			-- as `source_meth'. Useful in Eiffel as each Eiffel feature
			-- is in fact represented by two methods: one static
			-- and one virtual. Static one is only used when doing
			-- cross-assembly Eiffel inheritance.
		require
			not_is_closed: not is_closed
		do
			check
				has_source: method_locations.has (source_meth)
				not_has_new_meth: not method_locations.has (new_meth)
			end
			method_locations.put (method_locations.item (source_meth), new_meth)
		end

	write_current_body
			-- Store `current body' in `Current'.
		require
			not_closed: not is_closed
			not_yet_emitted: not is_previous_body_written
		local
			l_pos: INTEGER
			l_meth_size: INTEGER
			l_meth: like internal_method_body
			l_m: like item
			l_ex: MD_EXCEPTION_CLAUSE
			is_fat_seh: BOOLEAN
			i: INTEGER
			l_old_exceptions: detachable ARRAY [MD_EXCEPTION_CATCH]
			handler_size: INTEGER
			is_fat_handler: BOOLEAN
		do
			l_pos := current_position
			l_m := item
			l_meth := internal_method_body
			check l_meth /= Void then
				l_meth_size := l_meth.count
				method_locations.put (l_pos, l_meth.method_token)
				update_size (l_pos + l_meth_size + {MD_FAT_METHOD_HEADER}.Count)

				if
					not l_meth.has_locals and then not l_meth.has_exceptions_handling
					and then l_meth.max_stack <= 8 and then l_meth_size < 64
				then
						-- Valid candidate for tiny header.
					Tiny_method_header.set_code_size (l_meth_size)
					Tiny_method_header.write_to_stream (l_m, l_pos)
					l_pos := l_pos + Tiny_method_header.count
				else
						-- Valid candidate for fat header.
					Fat_method_header.remake (l_meth.max_stack.to_integer_16,
						l_meth_size, l_meth.local_token)

					if l_meth.has_exceptions_handling then
						Fat_method_header.set_flags ({MD_METHOD_CONSTANTS}.More_sections)
					end

					Fat_method_header.write_to_stream (l_m, l_pos)
					l_pos := l_pos + Fat_method_header.count
				end

				l_meth.write_to_stream (l_m, l_pos)
				l_pos := l_pos + l_meth_size

				if l_meth.has_exceptions_handling then
					l_pos := pad_up (l_pos, 4)
					Exception_header.reset
					l_old_exceptions := l_meth.old_exception_catch_blocks
					if l_old_exceptions /= Void then
						from
							i := l_old_exceptions.lower
						until
							i > l_old_exceptions.upper
						loop
							l_ex := l_old_exceptions.item (i)
							if l_ex.is_defined then
								Exception_header.register_exception_clause (l_ex)
							end
							i := i + 1
						end
					end
					l_ex := l_meth.exception_block
					if l_ex.is_defined then
						Exception_header.register_exception_clause (l_ex)
					end
					l_ex := l_meth.once_catch_block
					if l_ex.is_defined then
						Exception_header.register_exception_clause (l_ex)
					end
					l_ex := l_meth.once_finally_block
					if l_ex.is_defined then
						Exception_header.register_exception_clause (l_ex)
					end

					update_size (l_pos + Exception_header.count)
					Exception_header.write_to_stream (l_m, l_pos)
					is_fat_seh := Exception_header.is_fat
					l_pos := l_pos + Exception_header.count
					if l_old_exceptions /= Void then
						from
							i := l_old_exceptions.lower
						until
							i > l_old_exceptions.upper
						loop
							l_ex := l_old_exceptions.item (i)
							if l_ex.is_defined then
								is_fat_handler := l_ex.is_fat or is_fat_seh
								handler_size := l_ex.count (is_fat_handler)
								update_size (l_pos + handler_size)
								l_ex.write_to_stream (is_fat_handler, l_m, l_pos)
								l_pos := l_pos + handler_size
							end
							i := i + 1
						end
					end
					l_ex := l_meth.exception_block
					if l_ex.is_defined then
						is_fat_handler := l_ex.is_fat or is_fat_seh
						handler_size := l_ex.count (is_fat_handler)
						update_size (l_pos + handler_size)
						l_ex.write_to_stream (is_fat_handler, l_m, l_pos)
						l_pos := l_pos + handler_size
					end
					l_ex := l_meth.once_catch_block
					if l_ex.is_defined then
						is_fat_handler := l_ex.is_fat or is_fat_seh
						handler_size := l_ex.count (is_fat_handler)
						update_size (l_pos + handler_size)
						l_ex.write_to_stream (is_fat_handler, l_m, l_pos)
						l_pos := l_pos + handler_size
					end
					l_ex := l_meth.once_finally_block
					if l_ex.is_defined then
						is_fat_handler := l_ex.is_fat or is_fat_seh
						handler_size := l_ex.count (is_fat_handler)
						update_size (l_pos + handler_size)
						l_ex.write_to_stream (is_fat_handler, l_m, l_pos)
						l_pos := l_pos + handler_size
					end
				end

					-- Find next location that must be 4 bytes aligned.
				current_position := pad_up (l_pos, 4)
				is_previous_body_written := True
			end
		end

feature {NONE} -- Implementation

	current_position: INTEGER
			-- Current position for next write.

	capacity: INTEGER
			-- Number of `bytes' that `internal_item' can hold.

	method_locations: HASH_TABLE [INTEGER, INTEGER]
			-- Correspondances between method token and location in `internal_item'
			-- so that we can easily update the method token RVA
			-- when storing onto PE file in CLI_PE_FILE.
			-- Key: token
			-- Value: location

	internal_method_body: detachable MD_METHOD_BODY
			-- Body used over and over to avoid memory consumption.

	update_size (a_new_offset: INTEGER)
			-- Resized `internal_item' if it cannot hold up to `a_new_offset' new items.
		require
			a_new_offset_non_negative: a_new_offset >= 0
		do
			if a_new_offset > capacity then
					-- Resize `internal_item'.
				capacity := a_new_offset.max (capacity + Chunk_size)
				item.resize (capacity)
			end
		ensure
			resized_if_necessary: a_new_offset <= capacity
		end

feature {NONE} -- constants

	Chunk_size: INTEGER = 1000000
			-- Default chunk size is 1MB.

	tiny_method_header: MD_TINY_METHOD_HEADER
			-- To avoid over creating method headers.
		once
			create Result.make (0)
		end

	fat_method_header: MD_FAT_METHOD_HEADER
			-- To avoid over creating method headers.
		once
			create Result.make (0, 0, 0)
		end

	exception_header: MD_METHOD_SECTION_HEADER
			-- To avoid creating method section headers.
		once
			create Result.make
		end

invariant
	good_capacity: capacity > 0 and current_position <= capacity
	method_locations_not_void: method_locations /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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

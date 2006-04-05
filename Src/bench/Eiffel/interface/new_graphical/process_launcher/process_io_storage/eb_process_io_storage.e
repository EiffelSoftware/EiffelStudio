indexing
	description: "Object that stores all output and error from another process."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROCESS_IO_STORAGE

create
	make

feature{NONE}  -- Initialization
	make is
			-- Initialize.
		do
			create data_list.make
			create mutex
			capacity := initial_capacity
			count := 0
		ensure
			count_is_zero: count = 0
			capacity_set_to_initial_capacity: capacity = initial_capacity
		end

feature	-- Basic operations

	extend_block (i: EB_PROCESS_IO_DATA_BLOCK) is
			-- Extend `i' into current storage.
		require
			i_not_null: i /= Void
		local
			l_half_cap: INTEGER
		do
			mutex.lock
			data_list.extend (i)
			count := count + i.count
			if i.is_error then
				error_byte_count := error_byte_count + i.count
			else
				output_byte_count := output_byte_count + i.count
			end
			if count > capacity then
				from
					l_half_cap := capacity // 2
				until
					count <= l_half_cap or data_list.is_empty
				loop
					data_list.start
					count := count - data_list.item.count
					data_list.remove
				end
			end
			mutex.unlock
		end

	first_block (block_to_be_removed: BOOLEAN): EB_PROCESS_IO_DATA_BLOCK is
			-- First block in current storage.
			-- If `block_to_be_removed' is True, returned block will be removed from current storage.
		local
			blk: EB_PROCESS_IO_DATA_BLOCK
		do
			mutex.lock
			if not data_list.is_empty then
				blk := data_list.first
				Result := blk.deep_twin
				if block_to_be_removed then
					count := count - blk.count
					data_list.start
					data_list.remove
				end
			else
				Result := Void
			end

			mutex.unlock
		end

	all_blocks (block_to_be_removed: BOOLEAN) : EB_PROCESS_IO_DATA_BLOCK is
			-- All blocks from current storage.
			-- If `block_to_be_removed' is True, returned blocks will be removed from current storage.
		local
			is_end: BOOLEAN
			done: BOOLEAN
			s: STRING
		do
			mutex.lock
			if count = 0 then
				create s.make (0)
			else
				create s.make (count)
			end

			if block_to_be_removed then
				from
					data_list.start
					is_end := False
					done := False
				until
					data_list.is_empty or done
				loop
					if data_list.item.is_end then
						is_end := True
						done := True
					end
					s.append (data_list.item.string_representation)
					data_list.remove
				end
				count := 0
			else
				from
					data_list.start
					is_end := False
					done := False
				until
					data_list.after or done
				loop
					if data_list.item.is_end then
						is_end := True
						done := True
					end
					s.append (data_list.item.string_representation)
					data_list.forth
				end
			end
			create {EB_PROCESS_IO_STRING_BLOCK} Result.make (s, False, is_end)
			mutex.unlock
		end


	wipe_out is
			-- Wipe out current storage.
		do
			mutex.lock
			data_list.wipe_out
			count := 0
			mutex.unlock
		end

feature -- Status setting

	reset_output_byte_count is
			-- Set output byte count to zero.
		do
			mutex.lock
			output_byte_count := 0
			mutex.unlock
		ensure
			output_byte_count_set_to_zero: output_byte_count = 0
		end

	reset_error_byte_count is
			-- Set error byte count to zero
		do
			mutex.lock
			error_byte_count := 0
			mutex.unlock
		ensure
			error_byte_count_set_to_zero: error_byte_count = 0
		end

	set_capacity (cap: INTEGER) is
			-- Set `capacity' with `cap'.
		require
			cap_positive: cap > 0
		do
			mutex.lock
			capacity := cap
			mutex.unlock
		ensure
			capacity_set: capacity = cap
		end

feature -- Status reporting

	output_byte_count: INTEGER
			-- How many bytes of output from process has arrived since the last
			-- time output_byte_count is reset to zero?

	error_byte_count: INTEGER
			-- How many bytes of error from process has arrived since the last
			-- time output_byte_count is reset to zero.	

	capacity: INTEGER
			-- Capacity of current storage.

	count: INTEGER
			-- Number in bytes of data in current storage.

	has_new_block: BOOLEAN is
			-- Is there any data block in current storage?
		do
			mutex.lock
			Result := (data_list.count > 0)
			mutex.unlock
		end

feature{NONE} -- Implementation

	data_list: LINKED_LIST [EB_PROCESS_IO_DATA_BLOCK]
			-- Linked list where output and error data from process is stored.

	mutex: MUTEX
			-- Internal mutex

	initial_capacity: INTEGER is 1048576
			-- Initial capacity


invariant
	data_list_not_null: data_list /= Void
	mutex_not_null: mutex /= Void
	count_not_larger_than_capacity: count <= capacity
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

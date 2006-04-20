indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class ASSERT_ID_SET 

inherit
	ARRAY [INH_ASSERT_INFO]
		rename
			make as array_create,
			put as array_put,
			count as array_count,
			force as array_force,
			empty as array_empty,
			full as array_full,
			has as array_has
		redefine
			wipe_out
		end

create
	make
	

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Array creation
		do
			array_create (1, n)
		end

feature -- Access

	count: INTEGER
			-- Number of routine ids present in the set

	Chunk: INTEGER is 5
			-- Array chunk

	first: INH_ASSERT_INFO is
			-- First routine id
		do
			Result := item (1)
		end

feature -- Element change

	set_count (i: INTEGER) is
			-- Assign `i' to `count'.
		do
			count := i
		end

	wipe_out is
			-- Clear the structure.
		do
			count := 0
			clear_all
		end

feature -- Status report

	full: BOOLEAN is
			-- Is the set full ?
		do
			Result := count = array_count
		end

	empty: BOOLEAN is
			-- Is the set empty ?
		do
			Result := count = 0
		end

	has (assert: INH_ASSERT_INFO): BOOLEAN is
			-- Is the body id `body_index' present in the set ?
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > count or else Result
			loop
				Result := item (i).body_index = assert.body_index
				i := i + 1
			end
		end

	has_assert (assert: INH_ASSERT_INFO): BOOLEAN is
			-- Is the `assert' in Current? 
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > count or else Result
			loop
				Result := item (i).same_as (assert)
				i := i + 1
			end
		end

feature -- Status Report

	has_precondition: BOOLEAN
			-- Has the set any precondition (inner or inherited)?

feature -- Status Setting

	set_has_precondition (b: BOOLEAN) is
			-- Set `has_precondition' to `b'.
		do
			has_precondition := b
		ensure
			has_precondition_set: has_precondition = b
		end

feature -- Basic operations

	put (assert: INH_ASSERT_INFO) is
			-- Insert routine id `rout_id' in the set if not already
			-- present.
		require
			not_full: not full
		do
			if not has (assert) then
					-- Body index `body_index' is not present in the set
				count := count + 1
				array_put (assert, count)
			end
		end

	force (assert: INH_ASSERT_INFO) is
			-- Insert body index `body_index' in the set if not already
			-- present. Resize the array if needed.
		do
			if not has (assert) then
					-- Routine id `body_index' is not present in the set.
				if count >= array_count then
						-- Resize needed
					conservative_resize (1, array_count + Chunk)
				end
				count := count + 1
				array_put (assert, count)
			end
		end

	merge (other: like Current) is
			-- Put assert body index of `other' not present in Current.
		require
			good_argument: other /= Void
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := other.count
			until
				i > nb
			loop
				force (other.item (i))
				i := i + 1
			end
		end

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Has `other' the same content than Current ?
		local
			i: INTEGER
			local_copy: like Current
		do
			if (other /= Void) and then count = other.count then
				from
					local_copy := Current
					i := 1
					Result := True
				until
					i > count or else not Result
				loop
					Result := other.has_assert (local_copy.item (i))
					i := i + 1
				end
			end
			debug ("ASSERTION")
				io.put_string ("same as: ")
				io.put_boolean (Result)
				io.put_new_line
				if other = Void then
					io.put_string ("other is void%N")
				elseif count /= other.count then
					io.put_string ("count is not same%N")
				end
			end
		end

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

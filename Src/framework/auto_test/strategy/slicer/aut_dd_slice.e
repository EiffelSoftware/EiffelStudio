indexing

	description:

		"Disconnected sequence of requests all from the same witness"

	copyright: "Copyright (c) 2007, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_DD_SLICE

create

	make_from_witness

create {AUT_DD_SLICE}

	make_with_list

feature {NONE} -- Initialization

	make_from_witness (a_witness: like witness) is
			-- Create a slice containing all requests from `a_wintess'.
		do
			witness := a_witness
			create index_list.make (witness.count)
		ensure
			witness_set: witness = a_witness
		end

	make_with_list (a_witness: like witness; a_index_list: like index_list) is
			-- Create new slice.
		do
			witness := a_witness
			index_list := a_index_list
		ensure
			witness_set: witness = a_witness
			index_list_set: index_list = a_index_list
		end

feature -- Element change

	include_all is
			-- Make this slice include all requests from `a_witness'.
		local
			i: INTEGER
		do
			from
				i := 1
				index_list.wipe_out
			until
				i > witness.count
			loop
				index_list.force_last (i)
				i := i + 1
			end
		ensure
			count_correct: count = witness.count
		end

feature -- Access

	index_list: DS_ARRAYED_LIST [INTEGER]
			-- List containing indexes (into `a_witness') of those requests that make up current slice

	witness: AUT_WITNESS
			-- Witness this slice is a slice of

	count: INTEGER is
			-- Number of requests in this slice
		do
			Result := index_list.count
		end

	list: DS_LIST [AUT_REQUEST] is
			-- List of request from `witness' that make up this slice
		local
			cs: DS_LINEAR_CURSOR [INTEGER]
			arrayed_list: DS_ARRAYED_LIST [AUT_REQUEST]
		do
			from
				create arrayed_list.make (count)
				cs := index_list.new_cursor
				cs.start
			until
				cs.off
			loop
				arrayed_list.force_last (witness.item (cs.item))
				cs.forth
			end
			Result := arrayed_list
		ensure
			list_not_void: Result /= Void
			list_doesnt_have_void: not list.has (Void)
		end

	fresh_list: DS_LIST [AUT_REQUEST] is
			-- List of fresh requests from `witness' that make up this slice
		local
			cs: DS_LINEAR_CURSOR [INTEGER]
			arrayed_list: DS_ARRAYED_LIST [AUT_REQUEST]
		do
			from
				create arrayed_list.make (count)
				cs := index_list.new_cursor
				cs.start
			until
				cs.off
			loop
				arrayed_list.force_last (witness.item (cs.item).fresh_twin)
				cs.forth
			end
			Result := arrayed_list
		ensure
			list_not_void: Result /= Void
			list_doesnt_have_void: not list.has (Void)
		end

	deltas (n: INTEGER): DS_LINEAR [AUT_DD_SLICE] is
			-- `n' sub-slices of this slice (each approximately of the same size)
		require
			n_big_enough: n >= 2
			n_small_enough: n <= count
		local
			result_list: DS_ARRAYED_LIST [AUT_DD_SLICE]
			l: DS_ARRAYED_LIST [INTEGER]
			s: AUT_DD_SLICE
			i: INTEGER
			slice_index: INTEGER
				-- Index of slice currntly being built
			slice_size: INTEGER
				-- Number of requests in each slice (if `count \\ n /= 0' some slices will have one more request)
			remainder: INTEGER
				-- Number of requests that must be put "extra"
			first_index_index: INTEGER
				-- First index into `index_list' of current slice
			last_index_index: INTEGER
				-- Last index into `index_list' of current slice
		do
			slice_size := count // n
			remainder := count \\ n
			create result_list.make (n)
			from
				slice_index := 1
				first_index_index := 1
			until
				slice_index > n
			loop
				last_index_index := first_index_index + slice_size - 1
				if remainder > 0 then
						-- Add one of the remaining requests to the first few slices.
					last_index_index := last_index_index + 1
					remainder := remainder - 1
				end
					-- Create an index array with the requests from the current slice
				from
					i := first_index_index
					create l.make (last_index_index - first_index_index + 1)
				until
					i > last_index_index
				loop
					l.force_last (index_list.item (i))
					i := i + 1
				end
				create s.make_from_witness (witness)
				s.set_index_list (l)
				result_list.force_last (s)

				first_index_index := last_index_index + 1
				slice_index := slice_index + 1
			end
			Result := result_list
		ensure
			list_not_void: Result /= Void
			list_doesnt_have_void: not Result.has (Void)
		end

	delta_complements (n: INTEGER): DS_LINEAR [AUT_DD_SLICE] is
			-- Complements of the `n' sub-slices of this slice
		require
			n_big_enough: n >= 2
			n_small_enough: n <= count
		local
			result_list: DS_ARRAYED_LIST [AUT_DD_SLICE]
			l: DS_ARRAYED_LIST [INTEGER]
			s: AUT_DD_SLICE
			i: INTEGER
			slice_index: INTEGER
				-- Index of slice currntly being built
			slice_size: INTEGER
				-- Number of requests in each slice (if `count \\ n /= 0' some slices will have one more request)
			remainder: INTEGER
				-- Number of requests that must be put "extra"
			first_index_index: INTEGER
				-- First index into `index_list' of current slice
			last_index_index: INTEGER
				-- Last index into `index_list' of current slice
		do
			slice_size := count // n
			remainder := count \\ n
			create result_list.make (n)
			from
				slice_index := 1
				first_index_index := 1
			until
				slice_index > n
			loop
				last_index_index := first_index_index + slice_size - 1
				if remainder > 0 then
						-- Add one of the remaining requests to the first few slices.
					last_index_index := last_index_index + 1
					remainder := remainder - 1
				end
					-- Create an index array with the requests from the current slice
				from
					i := 1
					create l.make (count - (last_index_index - first_index_index + 1))
				until
					i > count
				loop
					if i < first_index_index or i > last_index_index then
						l.force_last (index_list.item (i))
					end
					i := i + 1
				end
				create s.make_from_witness (witness)
				s.set_index_list (l)
				result_list.force_last (s)

				first_index_index := last_index_index + 1
				slice_index := slice_index + 1
			end
			Result := result_list
		ensure
			list_not_void: Result /= Void
			list_doesnt_have_void: not Result.has (Void)
		end

feature -- Debugging

	append_debugging_info (a_stream: KI_TEXT_OUTPUT_STREAM) is
			-- Append debugging info about this slice to `a_stream'.
		require
			a_stream_not_void: a_stream /= Void
			a_stream_open_write: a_stream.is_open_write
		local
			cs: DS_LIST_CURSOR [INTEGER]
		do
			from
				cs := index_list.new_cursor
				cs.start
				a_stream.put_character ('[')
			until
				cs.off
			loop
				a_stream.put_integer (cs.item)
				if not cs.is_last then
					a_stream.put_string (", ")
				end
				cs.forth
			end
			a_stream.put_character (']')
		end

feature {AUT_DD_SLICE} -- Implementation

	set_index_list (a_index_list: like index_list) is
			-- Make `a_index_list' the new `index_list'.
		require
			a_index_list_not_void: a_index_list /= Void
		do
			index_list := a_index_list
		ensure
			index_list_set: index_list = a_index_list
		end

invariant

	witness_not_void: witness /= Void
	index_list_not_void: index_list /= Void

end

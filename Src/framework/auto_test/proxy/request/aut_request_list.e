indexing
	description:

		"List of requests"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_REQUEST_LIST

create

	make,
	make_default

feature {NONE} -- Initialization

	make (a_list: like list; a_first_index: like first_index; a_last_index: like last_index) is
			-- Create new list.
		require
			a_list_not_void: a_list /= Void
			no_request_void: not a_list.has (Void)
			a_first_index_large_enough: a_first_index >= 1
			a_first_index_small_enough: a_first_index <= a_list.count
			a_last_index_large_enough: a_last_index >= 1
			a_last_index_small_enough: a_last_index <= a_list.count and a_last_index >= a_first_index
		do
			list := a_list
			first_index := a_first_index
			last_index := a_last_index
		ensure
			list_set: list = a_list
			first_index_set: first_index = a_first_index
			last_index_set: last_index = a_last_index
		end

	make_default (a_list: like list) is
			-- Create new witness.
		do
			make (a_list, 1, a_list.count)
		end

feature -- Access

	count: INTEGER is
			-- Number of requests
		do
			Result := last_index - first_index + 1
		ensure
			definition: Result = (last_index - first_index + 1)
		end

	item (an_index: INTEGER): AUT_REQUEST is
			-- `an_index'-th request
		require
			an_index_large_enough: an_index >= 1
			an_index_small_enough: an_index <= count
		do
			Result := list.item (first_index + an_index - 1)
		ensure
			request_not_void: Result /= Void
			definition: Result = list.item (first_index + an_index - 1)
		end

	request_list: DS_LIST [AUT_REQUEST] is
			-- List of all requests
		local
			arrayed_list: DS_ARRAYED_LIST [AUT_REQUEST]
			i: INTEGER
		do
			from
				create arrayed_list.make (count)
				i := 1
			until
				i > count
			loop
				arrayed_list.force_last (item (i))
				i := i + 1
			end
			Result := arrayed_list
		ensure
			request_list_not_void: Result /= Void
			no_request_void: not Result.has (Void)
			counts_match: count = Result.count
		end

	fresh_request_list: DS_LIST [AUT_REQUEST] is
			-- Fresh (as in requests without responses) list of all requests
		local
			arrayed_list: DS_ARRAYED_LIST [AUT_REQUEST]
			i: INTEGER
		do
			from
				create arrayed_list.make (count)
				i := 1
			until
				i > count
			loop
				arrayed_list.force_last (item (i).fresh_twin)
				i := i + 1
			end
			Result := arrayed_list
		ensure
			request_list_not_void: Result /= Void
			no_request_void: not Result.has (Void)
			counts_match: count = Result.count
		end

	all_but_i_requests (i: INTEGER): DS_LIST [AUT_REQUEST] is
			-- List of all requests except the `i'-th
		require
			i_big_enough: i >= 1
			i_small_enough: i <= count
		local
			arrayed_list: DS_ARRAYED_LIST [AUT_REQUEST]
			j: INTEGER
		do
			from
				create arrayed_list.make (count - 1)
				j := 1
			until
				j > count
			loop
				if i /= j then
					arrayed_list.force_last (item (j))
				end
				j := j + 1
			end
			Result := arrayed_list
		ensure
			request_list_not_void: Result /= Void
			no_request_void: not Result.has (Void)
			counts_match: count - 1= Result.count
		end

	all_but_i_requests_fresh (i: INTEGER): DS_LIST [AUT_REQUEST] is
			-- Fresh (as in requests without responses) list of all requests except the `i'-th
		require
			i_big_enough: i >= 1
			i_small_enough: i <= count
		local
			arrayed_list: DS_ARRAYED_LIST [AUT_REQUEST]
			j: INTEGER
		do
			from
				create arrayed_list.make (count - 1)
				j := 1
			until
				j > count
			loop
				if i /= j then
					arrayed_list.force_last (item (j).fresh_twin)
				end
				j := j + 1
			end
			Result := arrayed_list
		ensure
			request_list_not_void: Result /= Void
			no_request_void: not Result.has (Void)
			counts_match: count - 1= Result.count
		end

feature {NONE} -- Implementation

	list: DS_INDEXABLE [AUT_REQUEST]
			-- Full list of requests

	first_index: INTEGER
			-- Index of first request of `history' that belong to this witness

	last_index: INTEGER
			-- Index of last request of `history' that belongs to this witness

invariant

	list_not_void: list /= Void
	no_request_void: not list.has (Void)
	first_index_large_enough: first_index >= 1
	first_index_small_enough: first_index <= list.count
	last_index_large_enough: last_index >= 1
	last_index_small_enough: last_index <= list.count and last_index >= first_index

end

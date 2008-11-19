indexing

	description:

		"Strategy that seeks to minimize test cases by program slicing"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_SLICER

create

	make

feature {NONE} -- Initialization

	make  is
			-- Create new slicer.
		do
		end

feature -- Access

	last_slice: DS_LIST [AUT_REQUEST]
			-- Last slice extracted

feature -- Slicing

	extract_backward_slice (a_request_list: AUT_REQUEST_LIST) is
			-- Extract backward slice from `a_witness' that includes the last request from `a_witness'.
		require
			a_request_not_void: a_request_list /= Void
			a_request_not_empty: a_request_list.count > 0
		local
			equality_tester: AUT_VARIABLE_EQUALITY_TESTER
			relevancy_tester: AUT_REQUEST_RELEVANCY_TESTER
			relevancy_updater: AUT_RELEVANT_VARIABLES_UPDATER
			relevant_variables: DS_HASH_SET [ITP_VARIABLE]
			request: AUT_REQUEST
			i: INTEGER
		do
			from
					-- Setup empty variable set and its processors.
				create relevant_variables.make_default
				create equality_tester.make
				relevant_variables.set_equality_tester (equality_tester)
				create relevancy_tester.make (relevant_variables)
				create relevancy_updater.make (relevant_variables)
					-- Setup initial slice with just the last request from the witness.
				create {DS_ARRAYED_LIST [AUT_REQUEST]} last_slice.make (a_request_list.count)
				i := a_request_list.count
				request := a_request_list.item (i)
				last_slice.force_first (request.twin)
				request.process (relevancy_updater)
				i := i - 1
			until
				i = 0
			loop
				request := a_request_list.item (i)
				if request /= Void then
					request.process (relevancy_tester)
					if relevancy_tester.is_relevant then
						last_slice.force_first (request.twin)
						request.process (relevancy_updater)
					end
				end

				i := i - 1
			end
		ensure
			last_slice_not_void: last_slice /= Void
			last_slice_minimized: last_slice.count <= a_request_list.count
		end

end

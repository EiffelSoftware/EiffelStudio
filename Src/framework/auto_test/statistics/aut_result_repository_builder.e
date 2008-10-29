indexing
	description:

		"Builds result repositories from log files"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_RESULT_REPOSITORY_BUILDER

inherit
	AUT_LOG_PARSER
		redefine
			process_start_request,
			process_create_object_request,
			process_invoke_feature_request
		end

create
	make

feature -- Building

	build (a_input_stream: KI_TEXT_INPUT_STREAM) is
			-- Build result repository from `a_input_stream' and
			-- store result in `last_result_repository'.
		require
			a_input_stream_attached: a_input_stream /= Void
			a_input_stream_is_open_read: a_input_stream.is_open_read
		do
			create last_result_repository.make
			parse_stream (a_input_stream)
		ensure
			last_result_repository_built: last_result_repository /= Void
		end

feature -- Access

	last_result_repository: AUT_TEST_CASE_RESULT_REPOSITORY
			-- Last result repository built by `build'

feature{NONE} -- Processing

	process_start_request (a_request: AUT_START_REQUEST) is
		do
			check
				a_request_in_history: request_history.has (a_request)
			end
			Precursor (a_request)
			last_start_index := request_history.count + 1
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST) is
		do
			Precursor (a_request)
			update_result_reposotory
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST) is
		do
			Precursor (a_request)
			update_result_reposotory
		end

feature {NONE} -- Implementation

	last_start_index: INTEGER
			-- Index of the last "start" request in `request_history'

	update_result_reposotory is
			-- Update result repository based on last request in result-history.			
		require
			last_start_index_large_enough: last_start_index > 0 -- To be removed when added back to invariant
			last_start_index_small_enough: last_start_index <= request_history.count -- To be removed when added back to invariant
			request_history_not_empty: request_history.count > 0
			last_request_has_response: request_history.item (request_history.count).response /= Void
		local
			witness: AUT_WITNESS
		do
			create witness.make (request_history, last_start_index, request_history.count)
			last_result_repository.add_witness (witness)
		end

end

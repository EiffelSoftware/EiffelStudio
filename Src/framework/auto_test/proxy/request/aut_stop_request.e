indexing
	description:

		"Instruction that requests the shutdown of the interprter"

	copyright: "Copyright (c) 2006, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_STOP_REQUEST

inherit

	AUT_REQUEST

create

	make

feature -- Processing

	process (a_processor: AUT_REQUEST_PROCESSOR) is
			-- Process current request.
		do
			a_processor.process_stop_request (Current)
		end

end
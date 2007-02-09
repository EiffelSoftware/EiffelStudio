indexing

	description:

		"Imported routines that ought to be in class INPUT_STREAM"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class KL_IMPORTED_INPUT_STREAM_ROUTINES

obsolete

	"[020502] Use descendants of KI_INPUT_STREAM instead."

feature -- Access

	INPUT_STREAM_: KL_INPUT_STREAM_ROUTINES is
			-- Routines that ought to be in class INPUT_STREAM
		once
			create Result
		ensure
			input_stream_routines_not_void: Result /= Void
		end

feature -- Type anchors







	INPUT_STREAM_TYPE: FILE is do end


			-- Type anchor

end

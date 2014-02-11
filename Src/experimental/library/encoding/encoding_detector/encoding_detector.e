note
	description: "Encoding Detector"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENCODING_DETECTOR

inherit
	ANY

	SYSTEM_ENCODINGS
		export
			{NONE} all
		end

feature -- Access

	detected_encoding: detachable ENCODING
			-- Detected encoding
		deferred
		ensure
			last_detection_successful_implies_not_void: last_detection_successful implies Result /= Void
		end

feature -- Status report

	last_detection_successful: BOOLEAN
			-- Was last detection successful?

feature -- Basic operations

	detect (a_string: READABLE_STRING_GENERAL)
			-- Detect `detected_encoding' of `a_string'.
		require
			a_string_not_void: a_string /= Void
		deferred
		ensure
			detected_encoding_set_when_found: last_detection_successful implies detected_encoding /= Void
		end

note
	library:   "Encoding: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"



end

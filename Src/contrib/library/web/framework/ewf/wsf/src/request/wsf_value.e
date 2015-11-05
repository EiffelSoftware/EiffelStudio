note
	description: "Summary description for {WSF_VALUE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_VALUE

inherit
	DEBUG_OUTPUT

	SHARED_WSF_PERCENT_ENCODER
		rename
			percent_encoder as url_encoder
		export
			{NONE} all
		end

feature -- Access

	name: READABLE_STRING_32
			-- Parameter name
		deferred
		end

	url_encoded_name: READABLE_STRING_8
			-- URL encoded string of `name'.
		deferred
		end

	frozen key: like name
		do
			Result := name
		end

feature -- Element change

	change_name (a_name: like name)
			-- Change parameter `name'.
		deferred
		ensure
			name_changed: a_name.same_string (name)
		end

feature -- Status report

	is_string: BOOLEAN
			-- Is Current as a WSF_STRING representation?
		deferred
		end

	is_empty: BOOLEAN
			-- Is Current empty?
			--| i.e empty string, empty table, ...
		deferred
		end

feature -- Query

	as_string: WSF_STRING
			-- String value
		require
			is_string: is_string
		do
			if attached {WSF_STRING} Current as str then
				Result := str
			else
				check is_string: is_string end
				create Result.make (name, string_representation)
			end
		end

	string_representation: STRING_32
			-- String representation of Current
			-- if possible
			-- note: unicode value.
		deferred
		end

feature -- Helper

	same_string (a_other: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `a_other' represent the same string as `Current'?
		do
			if is_string then
				Result:= as_string.same_string (a_other)
			end
		ensure
			result_true_only_for_string: Result implies is_string
		end

	is_case_insensitive_equal (a_other: READABLE_STRING_8): BOOLEAN
			-- Does `a_other' represent the same case insensitive string as `Current'?
		do
			if is_string then
				Result:= as_string.is_case_insensitive_equal (a_other)
			end
		ensure
			result_true_only_for_string: Result implies is_string
		end

feature -- Status report

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string (name + {STRING_32} "=" + string_representation)
		end

feature {NONE} -- Implementation

	url_encoded_string (s: READABLE_STRING_GENERAL): STRING_8
			-- Decoded url-encoded string `s'
		do
			create Result.make (s.count)
			url_encoder.append_percent_encoded_string_to (s, Result)
		end

	url_decoded_string (s: READABLE_STRING_GENERAL): STRING_32
			-- Decoded url-encoded string `s'
		do
			create Result.make (s.count)
			url_encoder.append_percent_decoded_string_to (s, Result)
		end

feature -- Visitor

	process (vis: WSF_VALUE_VISITOR)
		deferred
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

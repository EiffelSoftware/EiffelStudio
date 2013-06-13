note
	description: "[
				{WSF_STRING} represents a String parameter
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_STRING

inherit
	WSF_VALUE
		redefine
			same_string,
			is_case_insensitive_equal
		end

create
	make

convert
	string_representation: {READABLE_STRING_32, STRING_32}

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8; a_string: READABLE_STRING_8)
		do
			name := url_decoded_string (a_name)
			value := url_decoded_string (a_string)

			url_encoded_name := a_name
			url_encoded_value := a_string
		end

feature -- Access

	name: READABLE_STRING_32
			-- <Precursor>
			--| Note that the value might be html encoded as well
			--| this is the application responsibility to html decode it

	value: READABLE_STRING_32
			-- <Precursor>
			--| Note that the value might be html encoded as well
			--| this is the application responsibility to html decode it

	url_encoded_name: READABLE_STRING_8
			-- URL encoded string of `name'.

	url_encoded_value: READABLE_STRING_8
			-- URL encoded string of `value'.

feature -- Conversion

	integer_value: INTEGER
			-- Integer value of `value'.
		require
			value_is_integer: is_integer
		do
			Result := value.to_integer
		end

feature -- Status report

	is_string: BOOLEAN = True
			-- Is Current as a WSF_STRING representation?

	is_empty: BOOLEAN
			-- Is empty?
		do
			Result := value.is_empty
		end

	is_integer: BOOLEAN
			-- Is `value' an integer?
		do
			Result := value.is_integer
		end

feature -- Element change

	change_name (a_name: like name)
		do
			name := url_decoded_string (a_name)
			url_encoded_name := a_name
		ensure then
			a_name.same_string (url_encoded_name)
		end

feature -- Helper

	same_string (a_other: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `a_other' represent the same string as `Current'?	
		do
			Result := value.same_string_general (a_other)
		end

	is_case_insensitive_equal (a_other: READABLE_STRING_8): BOOLEAN
			-- Does `a_other' represent the same case insensitive string as `Current'?
		local
			v: like value
		do
			v := value
			if v = a_other then
				Result := True
			elseif v.is_valid_as_string_8 then
				Result := v.is_case_insensitive_equal (a_other)
			end
		end

feature -- Conversion

	string_representation: STRING_32
		do
			create Result.make_from_string (value)
		end

feature -- Visitor

	process (vis: WSF_VALUE_VISITOR)
		do
			vis.process_string (Current)
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

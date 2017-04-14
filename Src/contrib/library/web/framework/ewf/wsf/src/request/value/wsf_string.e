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
	make,
	make_with_percent_encoded_values

convert
	string_representation: {READABLE_STRING_32, STRING_32}

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL; a_string: READABLE_STRING_GENERAL)
		do
			url_encoded_name := url_encoded_string (a_name)
			url_encoded_value := url_encoded_string (a_string)
		end

	make_with_percent_encoded_values (a_encoded_name: READABLE_STRING_8; a_encoded_value: READABLE_STRING_8)
		do
			url_encoded_name := a_encoded_name
			url_encoded_value := a_encoded_value
		end

feature -- Access

	name: READABLE_STRING_32
			-- <Precursor>
			--| Note that the value might be html encoded as well
			--| this is the application responsibility to html decode it
		local
			v: like internal_name
		do
			v := internal_name
			if v = Void then
				v := url_decoded_string (url_encoded_name)
				internal_name := v
			end
			Result := v
		end

	value: READABLE_STRING_32
			-- <Precursor>
			--| Note that the value might be html encoded as well
			--| this is the application responsibility to html decode it
		local
			v: like internal_value
		do
			v := internal_value
			if v = Void then
				v := url_decoded_string (url_encoded_value)
				internal_value := v
			end
			Result := v
		end

	url_encoded_name: READABLE_STRING_8
			-- URL encoded string of `name'.

	url_encoded_value: READABLE_STRING_8
			-- URL encoded string of `value'.

feature {NONE} -- Access: internals

	internal_name: detachable like name
			-- Cached value of `name'.		

	internal_value: detachable like value
			-- Cached value of `value'.

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
			-- <Precursor>
		do
			internal_name := a_name
			url_encoded_name := url_encoded_string (a_name)
		end

feature -- Helper

	same_string (a_other: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `a_other' represent the same string as `Current'?	
		do
			Result := value.same_string_general (a_other)
		end

	is_case_insensitive_equal (a_other: READABLE_STRING_GENERAL): BOOLEAN
			-- Does `a_other' represent the same case insensitive string as `Current'?
		do
			Result := value.is_case_insensitive_equal_general (a_other)
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
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

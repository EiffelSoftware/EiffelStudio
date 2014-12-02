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
			url_encoded_name := utf_8_percent_encoded_string (a_name)
			url_encoded_value := utf_8_percent_encoded_string (a_string)
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
		do
			internal_name := Void
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

feature {NONE} -- Implementation

	utf_8_percent_encoded_string (s: READABLE_STRING_8): READABLE_STRING_8
			-- Percent-encode the UTF-8 sequence characters from UTF-8 encoded `s' and
			-- return the Result.
		local
			s8: STRING_8
			i, n, nb: INTEGER
		do
				-- First check if there are such UTF-8 character
				-- If it has, convert them and return a new object as Result
				-- otherwise return `s' directly to avoid creating a new object
			from
				i := 1
				n := s.count
				nb := 0
			until
				i > n
			loop
				if s.code (i) > 0x7F then -- >= 128
					nb := nb + 1
				end
				i := i + 1
			end
			if nb > 0 then
				create s8.make (s.count + nb * 3)
				utf_8_string_8_into_percent_encoded_string_8 (s, s8)
				Result := s8
			else
				Result := s
			end
		end

	utf_8_string_8_into_percent_encoded_string_8 (s: READABLE_STRING_8; a_result: STRING_8)
			-- Copy STRING_32 corresponding to UTF-8 sequence `s' appended into `a_result'.
		local
			i: INTEGER
			n: INTEGER
			c: NATURAL_32
		do
			from
				n := s.count
				a_result.grow (a_result.count + n)
			until
				i >= n
			loop
				i := i + 1
				c := s.code (i)
				if c <= 0x7F then
						-- 0xxxxxxx
					a_result.append_code (c)
				elseif c <= 0xDF then
						-- 110xxxxx 10xxxxxx
					url_encoder.append_percent_encoded_character_code_to (c, a_result)
					i := i + 1
					if i <= n then
						url_encoder.append_percent_encoded_character_code_to  (s.code (i), a_result)
					end
				elseif c <= 0xEF then
						-- 1110xxxx 10xxxxxx 10xxxxxx
					url_encoder.append_percent_encoded_character_code_to  (s.code (i), a_result)
					i := i + 2
					if i <= n then
						url_encoder.append_percent_encoded_character_code_to  (s.code (i - 1), a_result)
						url_encoder.append_percent_encoded_character_code_to  (s.code (i), a_result)
					end
				elseif c <= 0xF7 then
						-- 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
					url_encoder.append_percent_encoded_character_code_to  (s.code (i), a_result)
					i := i + 3
					if i <= n then
						url_encoder.append_percent_encoded_character_code_to  (s.code (i - 2), a_result)
						url_encoder.append_percent_encoded_character_code_to  (s.code (i - 1), a_result)
						url_encoder.append_percent_encoded_character_code_to  (s.code (i), a_result)
					end
				else
					a_result.append_code (c)
				end
			end
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

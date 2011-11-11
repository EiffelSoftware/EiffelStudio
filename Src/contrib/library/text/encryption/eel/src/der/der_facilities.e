note
	description: "Summary description for {DER_FACILITIES}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DER_FACILITIES

inherit
	DER_UNIVERSAL_CLASS_TAG

feature
	identifier_class (in: NATURAL_8): NATURAL_8
		do
			result := in & 0xc0
		end

	identifier_universal: NATURAL_8 = 0x00
	identifier_application: NATURAL_8 = 0xa0
	identifier_context_specific: NATURAL_8 = 0xb0
	identifier_private: NATURAL_8 = 0xc0
	identifier_constructed: NATURAL_8 = 0x20

	identifier_primitive (in: NATURAL_8): BOOLEAN
		do
			result := (in & identifier_constructed) = 0
		end

	identifier_tag (in: NATURAL_8): NATURAL_8
		do
			result := in & 0x1f
		end

	identifier_high_number (in: NATURAL_8): BOOLEAN
		do
			result := identifier_tag (in) = 0x1f
		end

	identifier_last (in: NATURAL_8): BOOLEAN
		do
			result := (in & 0x80) = 0
		end

	encode_boolean (target: DER_OCTET_SINK in: BOOLEAN)
		do
			target.sink (boolean)
			target.sink (0x01)
			if
				in
			then
				target.sink (0xff)
			else
				target.sink (0x00)
			end
		end

	definite_length (target: DER_OCTET_SINK length: INTEGER_32)
		require
			length >= 0
		do
			if
				length <= 127
			then
				definite_short_length (target, length)
			else
				definite_long_length (target, length)
			end
		end

	definite_short_length (target: DER_OCTET_SINK length: INTEGER_32)
		require
			length >= 0
			length <= 127
		do
			target.sink (length.to_natural_8)
		end

	definite_long_length (target: DER_OCTET_SINK length: INTEGER_32)
		require
			length >= 0
		do
			target.sink (0x84)
			target.sink ((length |>> 24).to_natural_8)
			target.sink ((length |>> 16).to_natural_8)
			target.sink ((length |>> 8).to_natural_8)
			target.sink ((length |>> 0).to_natural_8)
		end


	decode_length (source: DER_OCTET_SOURCE): INTEGER_X
		do
			if
				source.item <= 127
			then
				result := decode_short_length (source)
			else
				result := decode_long_length (source)
			end
		end

	decode_short_length (source: DER_OCTET_SOURCE): INTEGER_X
		do
			create result.make_from_integer (source.item.to_integer_32)
			source.process
		end

	decode_long_length (source: DER_OCTET_SOURCE): INTEGER_X
		local
			length_count: INTEGER_32
			current_byte: INTEGER_32
			current_bit: INTEGER_32
		do
			length_count := (source.item & 0x7f).to_integer_32
			if
				length_count = 127
			then
				(create {DER_ENCODING}.make ("Unacceptable long form length encoding")).raise
			end
			create result.default_create
			from
				current_byte := length_count
			until
				current_byte = 0
			loop
				from
					current_bit := 8
				until
					current_bit = 0
				loop
					if
						source.item.bit_test (current_bit - 1)
					then
						Result := Result.set_bit_value (True, (current_byte - 1) * 8 + (current_bit - 1))
					end
					current_bit := current_bit - 1
				variant
					current_bit + 1
				end
				source.process
				current_byte := current_byte - 1
			variant
				current_byte + 1
			end
		end

	encode_integer (target: DER_OCTET_SINK in: INTEGER_X)
		local
			bytes: INTEGER_32
			counter: INTEGER_32
		do
			if
				in.is_negative
			then
				bytes := (in + in.one).bytes
			else
				bytes := in.bytes
			end
			target.sink (integer)
			definite_length (target, bytes)
			from
				counter := bytes
			until
				counter = 0
			loop
				target.sink (byte_at (in, counter))
				counter := counter - 1
			variant
				counter + 1
			end
		end

	byte_at (in: INTEGER_X index: INTEGER_32): NATURAL_8
		require
			index >= 0
			index <= in.bytes
		local
			current_bit: INTEGER_32
		do
			from
				current_bit := 8
			until
				current_bit = 0
			loop
				result := result |<< 1
				if
					in.bit_test ((index - 1) * 8 + (current_bit - 1))
				then
					result := result | 0x01
				end
				current_bit := current_bit - 1
			variant
				current_bit + 1
			end
		end
end

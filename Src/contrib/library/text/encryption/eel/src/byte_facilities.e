note
	description: "Summary description for {ARRAY_FACILITIES}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The triumph of persuasion over force is the sign of a civilized society. - Mark Skousen"

deferred class
	BYTE_FACILITIES

inherit
	ARRAY_FACILITIES

feature -- Byte sinks
	sink_special (in: SPECIAL [NATURAL_8] in_lower: INTEGER_32 in_upper: INTEGER_32)
		require
			in.valid_index (in_lower)
			in.valid_index (in_upper)
		local
			index: INTEGER_32
		do
			from
				index := in_upper
			until
				index < in_lower
			loop
				byte_sink (in [index])
				index := index - 1
			variant
				index
			end
		end

	sink_special_lsb (in: SPECIAL [NATURAL_8]; in_lower: INTEGER_32; in_upper: INTEGER_32)
		require
			in.valid_index (in_lower)
			in.valid_index (in_upper)
		local
			index: INTEGER_32
		do
			from
				index := in_lower
			until
				index > in_upper
			loop
				byte_sink (in [index])
				index := index + 1
			variant
				in_upper - index + 2
			end
		end

	sink_character (in: CHARACTER_8)
		do
			byte_sink (in.code.to_natural_8)
		end

	sink_natural_32_be (in: NATURAL_32)
		do
			byte_sink ((in |>> 24).to_natural_8)
			byte_sink ((in |>> 16).to_natural_8)
			byte_sink ((in |>> 8).to_natural_8)
			byte_sink (in.to_natural_8)
		end

	sink_string (in: STRING)
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > in.count
			loop
				sink_character (in.item (i))
				i := i + 1
			variant
				in.area.upper - i + 1
			end
		end

	byte_sink (in: NATURAL_8)
		deferred
		end
end

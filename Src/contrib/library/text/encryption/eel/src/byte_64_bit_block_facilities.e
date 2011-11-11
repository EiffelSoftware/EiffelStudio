note
	description: "Summary description for {BYTE_64_BIT_BLOCK_FACILITIES}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The evils of tyranny are rarely seen but by him who resists it. - John Hay (1872)"

deferred class
	BYTE_64_BIT_BLOCK_FACILITIES

inherit
	BYTE_32_BIT_BLOCK_FACILITIES
		redefine
			bytes
		end

feature
	bytes: INTEGER = 8
end

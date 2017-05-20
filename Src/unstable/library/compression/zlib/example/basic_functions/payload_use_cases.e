note
	description: "Summary description for {PAYLOAD_USE_CASES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PAYLOAD_USE_CASES


feature -- Test cases


	payload_size_16384 : STRING
		do
			create Result.make_filled ('a', 16384)
		ensure
			Result.count = 16384
		end

	payload_size_32768 : STRING
		do
			create Result.make_filled ('a', 32768)
		ensure
			Result.count = 32768
		end

	payload_size_65536 : STRING
		do
			create Result.make_filled ('a', 65536)
		ensure
			Result.count = 65536
		end

	payload_size_131072 : STRING
		do
			create Result.make_filled ('a', 131072)
		ensure
			Result.count = 131072
		end
end


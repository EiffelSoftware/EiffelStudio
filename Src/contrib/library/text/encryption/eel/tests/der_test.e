note
	description: "Tests DER encoding facilities"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Nothing can destroy a government more quickly than its failure to observe its own laws, or worse, its disregard of the charter of its own existence - U.S. Supreme Court Justice Tom C. Clark - Mapp vs. Ohio"

class
	DER_TEST

inherit
	DER_FACILITIES
		undefine
			default_create
		end

	EQA_TEST_SET

feature
--	test_big_int
--		local
--			int: INTEGER_X
--			sink: ARRAY_DER_SINK
--			target: ARRAY [NATURAL_8]
--			answer: ARRAY [NATURAL_8]
--		do
--			create int.make_from_hex_string ("02F40E7E 2221F295 DE297117 B7F3D62F 5C6A97FF CB8CEFF1 CD6BA8CE 4A9A18AD 84FFABBD 8EFA5933 2BE7AD67 56A66E29 4AFD185A 78FF12AA 520E4DE7 39BACA0C 7FFEFF7F 2955727A 02F40E7E 2221F295 DE297117 B7F3D62F 5C6A97FF CB8CEFF1 CD6BA8CE 4A9A18AD 84FFABBD 8EFA5933 2BE7AD67 56A66E29 4AFD185A 78FF12AA 520E4DE7 39BACA0C 7FFEFF7F 2955727A")
--			create target.make (1, 0)
--			create sink.make (target)
--			create answer.make (1, 1 + 1 + 4 + 36 * 4)
--			encode_integer (sink, int)
--			assert ("test big int 1", target.count = answer.count)
--			assert ("test big int 2", target.same_items (answer))
--		end

--	test_small_int
--		local
--			int: INTEGER_X
--			sink: ARRAY_DER_SINK
--			target: ARRAY [NATURAL_8]
--			answer: ARRAY [NATURAL_8]
--		do
--			create int.make_from_natural (0x738243)
--			create target.make (1, 0)
--			create sink.make (target)
--			create answer.make (1, 1 + 1 + 3)
--			answer [1] := 0x2 answer [2] := 0x3 answer [3] := 0x73 answer [4] := 0x82 answer [5] := 0x43
--			encode_integer (sink, int)
--			assert ("test small int 1", target.count = answer.count)
--			assert ("test small int 2", target.same_items (answer))
--		end
end

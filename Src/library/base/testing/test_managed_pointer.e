note
	description: "Testing implementation of MANAGED_POINTER."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_MANAGED_POINTER

inherit
	EQA_TEST_SET

feature -- Testing Block memory reading

	test_block_of_characters
		local
			s: STRING_8
			s2, s3: SPECIAL [CHARACTER_8]
			m: MANAGED_POINTER
		do
			create m.make (10)
			s := "1234567890"

			m.put_special_character_8 (s.area, 2, 3, 4)
			m.read_into_special_character_8 (s.area, 0, 0, 10)
			assert ("content match", s.same_string ("%U%U%U3456%U%U%U"))

			s2 := m.read_special_character_8 (4, 5)
			s3 := (<< '4', '5', '6', '%U', '%U' >>).area
			assert ("content match", s2.same_items (s3, 0, 0, 5))
		end

	test_block_of_naturals
		local
			s1, s2: SPECIAL [NATURAL_8]
			m: MANAGED_POINTER
		do
			create m.make (10)
			s1 := (<< {NATURAL_8} 1, {NATURAL_8} 2, {NATURAL_8} 3, {NATURAL_8} 4, {NATURAL_8} 5, {NATURAL_8} 6, {NATURAL_8} 7, {NATURAL_8} 8, {NATURAL_8} 9, {NATURAL_8} 0 >>).area

			m.put_special_natural_8 (s1, 3, 2, 3)
			m.read_into_special_natural_8 (s1, 0, 0, 10)
			s2 := (<< {NATURAL_8} 0, {NATURAL_8} 0, {NATURAL_8} 4, {NATURAL_8} 5, {NATURAL_8} 6, {NATURAL_8} 0, {NATURAL_8} 0, {NATURAL_8} 0, {NATURAL_8} 0, {NATURAL_8} 0 >>).area
			assert ("content match", s1.same_items (s2, 0, 0, 10))

			s1 := m.read_special_natural_8 (1, 4)
			s2 := (<< {NATURAL_8} 0, {NATURAL_8} 4, {NATURAL_8} 5, {NATURAL_8} 6 >>).area
			assert ("content match", s1.same_items (s2, 0, 0, 4))
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

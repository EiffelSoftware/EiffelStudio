class
	TEST2 [G]

inherit
	TEST3 [G]
		redefine
			feature_with_old, expected_type
		end

feature

	make is
		local
			g: G
			l: LINKED_LIST [G]
			l_int: INTERNAL
			l_type: INTEGER
			l_name: STRING
		do
			feature_with_old (g)
			test (g)
			if g /= Void then
				print (g.generating_type)
				print ("%N")
			end
			create l.make
			print (l.generating_type)
			print ("%N")

			create l_int
			l_type := l_int.dynamic_type (Current)
			check
				valid_count: l_int.field_count_of_type (l_type) = 2
			end
				-- Print type of `f' and then type of `h'. Since we do not
				-- have any guarantees about the ordering, we have a small check
				-- to guarantee the order of display.
			l_name := l_int.field_name_of_type (1, l_type)
			if l_name.is_equal ("f") then
				print (l_int.field_name_of_type (1, l_type))
				print (": ")
				print (l_int.type_name_of_type (l_int.field_static_type_of_type (1, l_type)))
				print ("%N")
				print (l_int.field_name_of_type (2, l_type))
				print (": ")
				print (l_int.type_name_of_type (l_int.field_static_type_of_type (2, l_type)))
				print ("%N")
			else
				check expected_h: l_int.field_name_of_type (2, l_type).is_equal ("h") end
				print (l_int.field_name_of_type (2, l_type))
				print (": ")
				print (l_int.type_name_of_type (l_int.field_static_type_of_type (2, l_type)))
				print ("%N")
				print (l_int.field_name_of_type (1, l_type))
				print (": ")
				print (l_int.type_name_of_type (l_int.field_static_type_of_type (1, l_type)))
				print ("%N")
			end
		end

	test (g: G) is
			-- Test for cloning of arguments.
		do
			if g /= Void then
				print (g.generating_type)
				print ("%N")
			end
		end

	feature_with_old (g: G) is
			-- Test that old variables are properly instantiated in descendant.
		do
		ensure then
			same_g_2: old g = g
		end

	expected_type: STRING is
		local
			l_int: INTERNAL
			t: TEST2 [G]
		do
			create l_int
			create t
			Result := l_int.type_name_of_type (l_int.generic_dynamic_type (t, 1))
		end

feature {NONE} -- Attributes

	f: LINKED_LIST [G]

	h: G

end

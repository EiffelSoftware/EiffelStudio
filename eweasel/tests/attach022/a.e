class
	A [G -> X create default_create, do_nothing end]

feature -- Test: detachable variables

	detachable_a: ?X
	detachable_b: ?X
	detachable_c: ?X

	test_detachable
		local
			a: ?X
			b: ?X
			c: ?X
		do
			io.put_string ("Test detachable: 1")
			a := b
			io.put_character ('2')
			create c.do_nothing
			io.put_character ('3')
			a := c
			a := test_detachable_result_1
			a := test_detachable_result_2
			a := test_detachable_result_3
			io.put_character ('8')
			detachable_a := detachable_b
			io.put_character ('9')
			create detachable_c.do_nothing
			io.put_character ('0')
			detachable_a := detachable_c
			io.put_new_line
		end

	test_detachable_result_1: ?X
		do
			io.put_character ('4')
		end

	test_detachable_result_2: ?X
		local
			a: ?X
		do
			io.put_character ('5')
			a := Result
		end

	test_detachable_result_3: ?X
		local
			a: ?X
		do
			io.put_character ('6')
			create Result.do_nothing
			io.put_character ('7')
			a := Result
		end

feature -- Test: explicit variables

	explicit_a: !X
	explicit_b: !X
	explicit_c: !X

	test_explicit
		local
			a: !X
			b: !X
			c: !X
		do
			io.put_string ("Test explicit: 1")
			a := b
			io.put_character ('2')
			create c.do_nothing
			io.put_character ('3')
			a := c
			a := test_explicit_result_1
			a := test_explicit_result_2
			a := test_explicit_result_3
			io.put_character ('8')
			explicit_a := explicit_b
			io.put_character ('9')
			create explicit_c.do_nothing
			io.put_character ('0')
			explicit_a := explicit_c
			io.put_new_line
		end

	test_explicit_result_1: !X
		do
			io.put_character ('4')
		end

	test_explicit_result_2: !X
		local
			a: !X
		do
			io.put_character ('5')
			a := Result
		end

	test_explicit_result_3: !X
		local
			a: !X
		do
			io.put_character ('6')
			create Result.do_nothing
			io.put_character ('7')
			a := Result
		end

feature -- Test: anchored variables

	anchored_a: like f
	anchored_b: like f
	anchored_c: like f

	test_anchored
		local
			a: like f
			b: like f
			c: like f
		do
			io.put_string ("Test anchored: 1")
			a := b
			io.put_character ('2')
			create c.do_nothing
			io.put_character ('3')
			a := c
			a := test_anchored_result_1
			a := test_anchored_result_2
			a := test_anchored_result_3
			io.put_character ('8')
			anchored_a := anchored_b
			io.put_character ('9')
			create anchored_c.do_nothing
			io.put_character ('0')
			anchored_a := anchored_c
			io.put_new_line
		end

	test_anchored_result_1: like f
		do
			io.put_character ('4')
		end

	test_anchored_result_2: like f
		local
			a: like f
		do
			io.put_character ('5')
			a := Result
		end

	test_anchored_result_3: like f
		local
			a: like f
		do
			io.put_character ('6')
			create Result.do_nothing
			io.put_character ('7')
			a := Result
		end

feature -- Test: generic variables

	generic_a: G
	generic_b: G
	generic_c: G

	test_generic
		local
			a: G
			b: G
			c: G
		do
			io.put_string ("Test generic: 1")
			a := b
			io.put_character ('2')
			create c.do_nothing
			io.put_character ('3')
			a := c
			a := test_generic_result_1
			a := test_generic_result_2
			a := test_generic_result_3
			io.put_character ('8')
			generic_a := generic_b
			io.put_character ('9')
			create generic_c.do_nothing
			io.put_character ('0')
			generic_a := generic_c
			io.put_new_line
		end

	test_generic_result_1: G
		do
			io.put_character ('4')
		end

	test_generic_result_2: G
		local
			a: G
		do
			io.put_character ('5')
			a := Result
		end

	test_generic_result_3: G
		local
			a: G
		do
			io.put_character ('6')
			create Result.do_nothing
			io.put_character ('7')
			a := Result
		end

feature {NONE} -- Helpers

	f: ?X
		do
		end

end
class
	TEST

create
	make

feature

	make is
		local
			p1: PROCEDURE [TEST, TUPLE [ARRAY         [TEST]]]
$NA			p2: PROCEDURE [TEST, TUPLE [NATIVE_ARRAY  [TEST]]]
			p3: PROCEDURE [TEST, TUPLE [TUPLE         [TEST]]]
			p4: PROCEDURE [TEST, TUPLE [TYPED_POINTER [TEST]]]
		do
			p1 := agent test1
$NA			p2 := agent test2
			p3 := agent test3
			p4 := agent test4
		end

	anchor: TEST

	test1 (a: ARRAY         [like anchor]) is do end
$NA	test2 (a: NATIVE_ARRAY  [like anchor]) is do end
	test3 (a: TUPLE         [like anchor]) is do end
	test4 (a: TYPED_POINTER [like anchor]) is do end

end

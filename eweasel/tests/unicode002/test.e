class
	TEST

create
	make

feature -- Make

	make
		do
			test_free_op
		end

	test_free_op
		do
			(Current —— Current).do_nothing;
			(￥Current).do_nothing;
--			(前 Current).do_nothing;
--			(Current 中 Current).do_nothing;
		end

feature -- Free operators

	op1 alias "——" (other: like Current): like Current
		do
			Result := Current
			print ("`op1' called.%N")
		end

	op2 alias "￥": like Current
		do
			Result := Current
			print ("`op2' called.%N")
		end

--	infix "中" (other: like Current): like Current
--		do
--			Result := Current
--			print ("infix called.%N")
--		end

--	prefix "前": like Current
--		do
--			Result := Current
--			print ("prefix called.%N")
--		end
		
end

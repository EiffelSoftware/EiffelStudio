class TEST
create
	make
feature
	make
		local
			t1: TEST1
			t2: TEST2
		do
			create t1
			create t2
			t1 [1] := 's'
			t2 [1] := 's'
			t1 := t2
			t1 [1] := 's'
		end

	t3: detachable TEST3 [ANY, ANY]
	t5: detachable TEST5 [ANY]
	t6: detachable TEST6 [ANY]
end

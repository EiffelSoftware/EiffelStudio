class TEST 
create
	make
feature

	make is
		local
			t: INTEGER_REF
		do
				-- The next line was making the compiler crash on .NET
				-- code generation
			create t
			if (t.item = t.item.max_value) then
			end
		end

end

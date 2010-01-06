class TEST
create
	make

feature {NONE}

	make
		local
			t: T_TABLE [BOOLEAN, ANY]
		do
			create t
			t.first
		end

end

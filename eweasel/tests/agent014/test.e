class TEST
create
	make

feature {NONE}

	make
		do
			create t1.make
		end

	t1: detachable TEST1 [STRING, STRING, STRING, STRING, STRING, STRING]

end

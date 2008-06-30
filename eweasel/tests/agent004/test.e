class TEST
create
	make

feature

	make is
			--
		local
			a: ANY
		do
			a := agent {TEST1 [STRING, STRING]}.first
		end

end

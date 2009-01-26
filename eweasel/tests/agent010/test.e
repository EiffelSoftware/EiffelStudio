class TEST
create
	make

feature

	make is
		local
			l_any: ANY
		do
			l_any := agent {A [ANY]}.item
		end

end

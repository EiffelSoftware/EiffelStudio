class TEST
create
	make

feature

	make is
		local
			l_any: ANY
		do
			l_any := agent {A [ANY]}.item
			l_any := agent {A [ANY]}.item_det
			l_any := agent {A [ANY]}.item_att
		end

end

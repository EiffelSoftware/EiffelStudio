class TEST1 [G, H -> TEST2]
create
	make
feature
	t: TEST4 [H]

	make
		do
			create t.make (agent {like {H}.item}.foo)
		end

end


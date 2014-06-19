class TEST1 [G -> PARENT]
feature

	f
		do
			g (parent)
		end

	g (a_parent: like {G}.item)
		do
		end

	parent: PARENT
		do
			check False then end
		end
end

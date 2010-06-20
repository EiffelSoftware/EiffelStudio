
class TEST2 [G, H]
feature
	x: like {TEST2 [G, H]}.y.default

	y: like {TEST2 [like Current, like Current]}.default

end

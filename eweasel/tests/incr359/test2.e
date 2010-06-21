
class TEST2 [G, H]
feature
	x: like {like {TEST2 [like y, like Current]}.y.default}.default

	y: TEST2 [G, TEST2 [G, like Current]]

end

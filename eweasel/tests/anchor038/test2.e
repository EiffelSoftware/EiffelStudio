
class TEST2 [G, H]
feature
	x: like {TEST2 [like y, G]}.y.default

	y: like {like {TEST2 [like Current, TEST2 [like Current, H]]}.default}.default

end

class TEST2
inherit
	TEST1
		redefine
			anchor
		end
feature
	anchor: like Current

end

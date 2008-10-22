class A [G -> TEST]

feature

	f
		local
			g: G
			ga: !G
			gd: ?G
			t: TEST
			ta: !TEST
			td: ?TEST
		do
			t := gd
			ta := ga
			td := g
			td := ga
			td := gd
		end

end
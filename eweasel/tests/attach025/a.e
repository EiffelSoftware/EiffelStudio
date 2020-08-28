class A [G -> TEST]

feature

	f
		local
			g: G
			ga: attached G
			gd: detachable G
			t: TEST
			ta: attached TEST
			td: detachable TEST
		do
			t := gd
			ta := ga
			td := g
			td := ga
			td := gd
		end

end
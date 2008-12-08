class
	A [G]

create
	make

feature

	make (v: G) is
		do
			g := v
			if v /= Void then
				att_g := v
			end
			det_g := v
			create l1
			create l2
			create l3
			create l4
			create l5
			create l6
			create l7
			create l8
			create l9
		end

feature

	g: G
	att_g: !G
	det_g: ?G

	l1: B [G]
	l2: B [?G]
	l3: B [!G]
	l4: ?B [G]
	l5: ?B [?G]
	l6: ?B [!G]
	l7: !B [G]
	l8: !B [?G]
	l9: !B [!G]

end

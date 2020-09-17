class
	A [G]

create
	make

feature

	make (v: G)
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
	att_g: attached G
	det_g: detachable G

	l1: B [G]
	l2: B [detachable G]
	l3: B [attached G]
	l4: detachable B [G]
	l5: detachable B [detachable G]
	l6: detachable B [attached G]
	l7: attached B [G]
	l8: attached B [detachable G]
	l9: attached B [attached G]

end

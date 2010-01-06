class
	A [G, H]

create
	make

feature

	make (v: attached G) is
		do
			g := v
			g_att := v
			g_det := v
			create l
			create l_att
			create l_det
			create m
			create m_att
			create m_det
		end

feature

	g: G
	g_att: attached G
	g_det: detachable G

	l: attached B [G]
	l_att: attached B [attached G]
	l_det: attached B [detachable G]

	m: attached B [H]
	m_att: attached B [attached H]
	m_det: attached B [detachable H]

end

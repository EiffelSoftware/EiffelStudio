class
	A [G, H]

create
	make

feature

	make (v: attached G)
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
	g_att: $ATT G
	g_det: $DET G

	l: $ATT B [G]
	l_att: $ATT B [$ATT G]
	l_det: $ATT B [$DET G]

	m: $ATT B [H]
	m_att: $ATT B [$ATT H]
	m_det: $ATT B [$DET H]

end

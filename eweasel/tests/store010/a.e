class A

create
	make_reference,
	make_expanded

feature {NONE} -- Creation

	make_reference is
		do
			create b1
			create b2
			create r
		end

	make_expanded is
		do
			create {expanded B} b1
			create {expanded B} b2
			create r
		end

feature -- Access

	b1: B
	b2: B

feature {NONE} -- Implementation

	e: expanded B
	r: B

end

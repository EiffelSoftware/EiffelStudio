class X
create
	make

feature {NONE} -- Initialization

	make
		do
			create {STRING_32} val.make_empty
		end

feature -- Access

	val: ANY

end

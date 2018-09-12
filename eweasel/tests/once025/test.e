
class TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			a: A
			b: B
		do
				-- Once creation procedure must be immediate (i.e. not inherited).
			create a.make
			create b.make
		end

end

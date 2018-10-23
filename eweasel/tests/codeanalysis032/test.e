class TEST

create

	default_create,
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			t: TEST
		do
			t := t       -- OK, because source is detachable
			t := Current -- CA020
			t := Void    -- OK, because source is detachable
			create t     -- CA020
			t := Void
		end

end

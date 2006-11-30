class TEST

create

	make

feature {NONE} -- Creation

	make is
			-- Execute test.
		local
			s: STRING
		do
			s :=
				$LINE1
				$LINE2
		end

end
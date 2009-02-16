class
	TEST

create
	make

feature -- Initialization

	make is
			-- Tests
		local
			atta: ANY
			deta: detachable ANY
		do
			if attached deta then print ("1%N") end
			if attached {INTEGER_32} 1 then print ("2%N") end
			if attached {INTEGER_32}.max_value then print ("3%N") end

			if attached deta as y then print ("4%N") end
			if attached {INTEGER_32} 2 as y then print ("5%N") end
			if attached {INTEGER_32}.max_value as y then print ("6%N") end

			if attached {STRING} deta then print ("7%N") end
			if attached {STRING} deta as w then print ("8%N") end
			if attached {STRING} 1 as w then print ("9%N") end

			if attached {STRING} {INTEGER_32} 1 as w then print ("10%N") end
			if attached {STRING} {INTEGER_32}.max_value as w then print ("11%N") end

			deta := f

			if attached deta then print ("12%N") end
			if attached {PATH_NAME} deta then print ("13%N") end
			if attached {STRING} deta then print ("14%N") end
			if attached {PATH_NAME} deta as y then print ("15 - " + y + "%N") end
			if attached {STRING} deta as y then print ("16 - " + y + "%N") end
			if attached deta as y then print ("17 - " + y.out + "%N") end
			if attached deta as w then print ("18 - " + w.out + "%N") end
		end

	f: detachable STRING
		do
			create Result.make (10)
			Result.append ("TEST")
		end

end

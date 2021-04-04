class TEST

create

	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			if out ~ "" then
				check False end
			end
			print ("OK")
			if out ~ "" then
				check False end
			else
				print ("OK")
			end
			print ("OK")
			if out ~ "" then
				print ("OK")
			else
				check False end
			end
			print ("OK")
			if out ~ "" then
				check False end
			elseif out ~ "" then
			end
			print ("OK")
			if out ~ "" then
				check False end
			elseif out ~ "" then
				check False end
			end
			print ("OK")
			if out ~ "" then
				check False end
			elseif out ~ "" then
				print ("OK")
			else
				check False end
			end
			print ("OK")
			if out ~ "" then
				check False end
			elseif out ~ "" then
				check False end
			else
				check False end
			end
			print ("Unreachable")
		end

end

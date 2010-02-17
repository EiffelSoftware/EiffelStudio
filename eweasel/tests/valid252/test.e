
class TEST
create
	make
feature
	
	make
		do
			if value (attached {TEST2} Current as x and then attached {TEST3} Current as x) then
			end
			if attached {BOOLEAN} (attached {TEST2} Current as x and then attached {TEST3} Current as x) then
			end
		end

	value (b: BOOLEAN): BOOLEAN
		do
		end

end

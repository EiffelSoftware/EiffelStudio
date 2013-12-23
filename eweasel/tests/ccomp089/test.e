
class TEST

create
	make

feature {NONE}

	make
		do
			if angle = 0.0 then
				print (angle); io.new_line
			end
		end

	angle: REAL_64 = 0.0

end


class TEST
create
	make
feature
	
	make
		do
			y := Current
			try
		end

	try
		do
			if attached {STRING} value ("abc") as x then
				print (x);
			end
			if attached {STRING} Current.value ("abc") as x then
				print (x);
			end
			if attached {STRING} (Current + "abc") as x then
				print (x);
			end
			if attached {STRING} y.value ("abc") as x then
				print (x);
			end
			if attached {STRING} (y + "abc") as x then
				print (x);
			end
		end

	value alias "+" (n: INTEGER): STRING
		do
		end

	y: TEST
end

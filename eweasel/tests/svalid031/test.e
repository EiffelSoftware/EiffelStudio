
class TEST

create
	make

feature {NONE}

	make
		local
			x: ANY
		do
			x := Current [Current]
			try
		end
feature

	value alias "[]" (n: like Current): like Current
		do
			print ("In value%N")
		end

	try
		once
			create y.make
		end

	y: TEST1
end

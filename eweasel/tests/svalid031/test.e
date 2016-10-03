
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

	value alias "[]" (n: like Current): detachable  like Current
		do
			print ("In value%N")
		end

	try
		once
			create y.make
		end

	y: detachable TEST1
end

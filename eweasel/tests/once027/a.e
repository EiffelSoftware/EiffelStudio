
class
	A
create make

feature -- Implementation
	make
		once
		end

feature -- Access


	f
			-- can't be used in a call
		do
			make
		end
end

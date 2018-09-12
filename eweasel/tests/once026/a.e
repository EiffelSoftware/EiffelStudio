note
	description: "Once creation procedures can't be part of a Generic class."

class
	A [G]
create make

feature -- Implementation
	make
		once
		end
end

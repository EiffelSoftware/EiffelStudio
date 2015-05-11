note
	description: "Represents a node on the path graph ({MAP})"
	author: "Ganesh Ramanathan"
	date: "$Date$"
	revision: "$Revision$"

class
	VERTEX
create
	make
feature
	x : DOUBLE
	y : DOUBLE
	id : INTEGER

	make(i:INTEGER;px:DOUBLE; py:DOUBLE;)
			-- Initialization for `Current'.
		do
			id := i
			x := (px)
			y := (py)
		end

	dummy(i:INTEGER):INTEGER
		do
			result := i
		end
end


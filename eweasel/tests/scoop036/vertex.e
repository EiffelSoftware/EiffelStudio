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
	x : DOUBLE assign set_x
	y : DOUBLE assign set_y
	id : INTEGER assign set_id

	make(i:INTEGER;px:DOUBLE; py:DOUBLE;)
			-- Initialization for `Current'.
		do
			id := i
			x := (px)
			y := (py)
		end

	set_x(px:DOUBLE)
		do
			x := px
		end

	set_y(py:DOUBLE)
		do
			y := py
		end

	set_id(i:INTEGER)
		do
			id := i
		end

	dummy(i:INTEGER):INTEGER
		do
			result := i
		end
end


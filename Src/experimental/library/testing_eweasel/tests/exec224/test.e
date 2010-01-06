indexing
	description	: "System's root class"

class
	TEST

create
	make

feature
	t1: TUPLE [STRING, INTEGER]
	t2: TUPLE [s: STRING; i: INTEGER]
	t3: TUPLE [x1,x2,x3: STRING; y1,y2: INTEGER; z: BOOLEAN]
	t4: TUPLE []
	t5: TUPLE [x1: STRING; y1, y2: TUPLE[INTEGER, TUPLE[INTEGER]]]
	t6: TUPLE [y1, y2: TUPLE[INTEGER, TUPLE[INTEGER]]; x1: STRING]
	t7: TUPLE [y1, y2: TUPLE[z1:INTEGER; z2,z3: TUPLE[INTEGER]]; x1:TUPLE[z4,z5:INTEGER; z6,z7:STRING]]

	feature -- Initialization

	make is
			-- Creation procedure.
		do
			t2 := ["hello", 10]
			print ((equal ("hello", t2.s) and equal (10, t2.i)).out)
			io.new_line
			
			t3 := ["a", "b", "c", 1, 2, True]
			print ((equal ("a", t3.x1) and equal ("b", t3.x2) and equal ("c", t3.x3) and
					equal (1, t3.y1) and equal (2, t3.y2) and equal (True, t3.z)).out)
			io.new_line
					
			t7 := [[1, [2], [3]], [4, [5], [6]], [7, 8, "a", "b"]]
			print ((equal ([2], t7.y1.z2) and equal ([6], t7.y2.z3) and equal (8, t7.x1.z5)).out)
			io.new_line
		end

end -- class TUPLE_TEST

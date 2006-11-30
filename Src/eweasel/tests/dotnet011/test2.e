class
	TEST2

inherit
	SYSTEM_OBJECT

feature

	test1 is
		local
			dummy : BOOLEAN
			dummy_int : INTEGER
		do
				-- Leads to System.InvalidProgramException:
			color := feature {DRAWING_COLOR}.red
			dummy_int := color.to_argb + 12
			
				-- Leads to System.NullReferenceException:
			dummy := feature {DRAWING_COLOR}.red #== feature {DRAWING_COLOR}.green 
			dummy := feature {DRAWING_COLOR}.red #== feature {DRAWING_COLOR}.red 
		end      
		
	test2 is
		local
			math: MATH
			d: DRAWING_RECTANGLE
		do
			create d.make (math.min (pt_begin.x, pt_end.x),
			                    math.min (pt_begin.y, pt_end.y),
			                    math.abs (pt_end.x - pt_begin.x),
			                    math.abs (pt_end.y - pt_begin.y))
		end
		
feature {NONE}

	pt_begin, pt_end: DRAWING_POINT
		
	color : DRAWING_COLOR 		
end

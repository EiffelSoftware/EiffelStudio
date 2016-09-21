class 
	TEMPLATE_ARRAY_NUMERIC [T -> NUMERIC]

inherit
	
	TEMPLATE [ARRAY[T]]
	

feature 

	sum: T
			-- Sum of an array.
		note
			tags: "Algorithm, Array"
		do
			across target.lower |..| target.upper as c loop
				Result := Result + target [c.item]
			end
		end
end	
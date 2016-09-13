class 
	TEMPLATE_ARRAY_NUMERIC [T -> NUMERIC]

inherit
	
	TEMPLATE [ARRAY[T]]
	

feature 

	sum (a: ARRAY [T]): T
		note
			title:"Sum array"
			description:"Sum of the items of the array"
			tags: "Algorithm, Array"
		do
			across a.lower |..| a.upper as c loop
				Result := Result + a [c.item]
			end
		end
end	
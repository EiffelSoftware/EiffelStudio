class 
	TEMPLATE_ARRAY_NUMERIC [T -> NUMERIC]

inherit
	
	TEMPLATE [ARRAY[T]]
	

feature -- Templates

	sum: T
			-- Sum of `target' array.
		note
			title: "Array sum"	
			tags: "Algorithm, Array"
		do
			Result := target.lower
			across target.lower |..| target.upper as c loop
				Result := Result + target [c.item]
			end
		end
end	



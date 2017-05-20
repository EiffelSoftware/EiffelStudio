note
    description: "[
        Code templates for Arrays of COMPARABLES.
    ]"
    template_version: "1.0"

class ARRAY_TEMPLATE [T -> COMPARABLE]

inherit
    
    TEMPLATE [ARRAY [T]]

feature -- Templates

    maximum: T
            -- Maximum of `target' array.
        note
        	title: "Array maximum"
            tags: "Algorithm, Maximum, ARRAY"
        do
        	Result := target.lower 
			across target as element loop
                Result := Result.max (element.item)
            end
        end

	slice_maximum (low, high: INTEGER): T
			-- Maximum of `target' array, where the interval is defined by default by target.lower |..| target.upper.
		note
			title: "Array slice maximum"
			tags: "Algorithm, Maximum, ARRAY"
			default: "target.lower, target.upper"
		do
			Result := low
			across low |..| high as i loop
				Result := Result.max (target [i.item])
			end
		end	

	minimum: T
			-- Minimum of `target' array.
		note
			title: "Array minimum"
			tags: "Algorithm, Minimum, ARRAY"
		do
			Result := target.lower 
			across target as element loop
				Result := Result.min (element.item)
			end
		end
	

	slice_minimum (low, high: INTEGER): T
			-- Minimum of `target' array, where the interval is defined by default by target.lower |..| target.upper.
		note
			title: "Array slice minimum"
			tags: "Algorithm, Minimum, ARRAY"
			default: "target.lower, target.upper"
		do
			Result := low
			across low |..| high as i loop
				Result := Result.min (target [i.item])
			end
		end    

end

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
            -- Get the maximum of an array.
        note
            tags: "Algorithm, Maximum, ARRAY"
        do
			across target as element loop
                Result := Result.max (element.item)
            end
        end

	slice_maximum (low, high: INTEGER): T
			-- Get the maximum of an array, where the interval is defined by default by array.lower |..| array.upper.
		note
			title: "Slice Maximum of an array"
			tags: "Algorithm, Maximum, ARRAY"
			default: "target.lower, target.upper"
		do
			across low |..| high as i loop
				Result := Result.max (target [i.item])
			end
		end	

	minimum: T
			-- Get the minimum of an array.
		note
			title: "Minimum of an array"
			tags: "Algorithm, Minimum, ARRAY"
		do
			across target as element loop
				Result := Result.min (element.item)
			end
		end
	

	slice_minimum (low, high: INTEGER): T
			-- Get the minimum of an array, where the interval is defined by default by array.lower |..| array.upper.
		note
			title: "Slice Minimum of an array"
			tags: "Algorithm, Minimum, ARRAY"
			default: "target.lower, target.upper"
		do
			across low |..| high as i loop
				Result := Result.min (target [i.item])
			end
		end    

end

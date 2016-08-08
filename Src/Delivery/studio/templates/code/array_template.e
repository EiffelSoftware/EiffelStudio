note
    description: "[
        Code templates for Arrays of COMPARABLES.
    ]"

class ARRAY_TEMPLATE [T -> COMPARABLE]

inherit
    
    TEMPLATE [ARRAY [T]]

feature

    maximum (a: ARRAY [T]): T
        note
            title: "Maximum of an array"
            description: "Get the maximum of an array"
            tags: "Algorithm, Maximum, ARRAY"
        do
            across a as element loop
                Result := Result.max (element.item)
            end
        end

    slice_maximum (a: ARRAY [T]; low, high: INTEGER): T
        note
            title: "Slice Maximum of an array"
            description: "Get the maximum of an array, where the interval is defined by default by array.lower |..| array.upper"
            tags: "Algorithm, Maximum, ARRAY"
            default: "a.lower, a.upper"
        do
            across low |..| high as i loop
                Result := Result.max (a [i.item])
            end
        end    

    minimum (a: ARRAY [T]): T
        note
            title: "Minimum of an array"
            description: "Get the minimum of an array"
            tags: "Algorithm, Minimum, ARRAY"
        do
            across a as element loop
                Result := Result.min (element.item)
            end
        end
    

    slice_minimum (a: ARRAY [T]; low, high: INTEGER): T
        note
            title: "Slice Minimum of an array"
            description: "Get the minimum of an array, where the interval is defined by default by array.lower |..| array.upper"
            tags: "Algorithm, Minimum, ARRAY"
            default: "a.lower, a.upper"
        do
            across low |..| high as i loop
                Result := Result.min (a [i.item])
            end
        end

end

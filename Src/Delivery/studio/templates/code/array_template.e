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
    

end

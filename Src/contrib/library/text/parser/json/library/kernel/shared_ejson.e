note
    description: "[
				Shared factory class for creating JSON objects. Maps JSON
				objects to ELKS HASH_TABLEs and JSON arrays to ELKS
				LINKED_LISTs. Use non-conforming inheritance from this 
				class to ensure that your classes share the same 
				JSON_FACTORY instance.
		  ]"
    author: "Paul Cohen"
    date: "$Date$"
    revision: "$Revision$"
    file: "$HeadURL: $"

class SHARED_EJSON

feature

    json: EJSON
            -- A shared EJSON instance with default converters for
            --LINKED_LIST [ANY] and HASH_TABLE [ANY, HASHABLE]
        local
			jalc: JSON_ARRAYED_LIST_CONVERTER
            jllc: JSON_LINKED_LIST_CONVERTER
            jhtc: JSON_HASH_TABLE_CONVERTER
        once
            create Result

            create jalc.make
            Result.add_converter (jalc)

            create jllc.make
            Result.add_converter (jllc)

            create jhtc.make
            Result.add_converter (jhtc)
        end
        
end -- class SHARED_EJSON

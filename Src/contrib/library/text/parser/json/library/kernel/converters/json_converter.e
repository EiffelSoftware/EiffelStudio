note
	description: "A JSON converter"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	file: "$HeadURL: $"

deferred class JSON_CONVERTER

inherit
    SHARED_EJSON

feature -- Access

    object: ANY
            -- Eiffel object
        deferred
        end

feature -- Conversion

    from_json (j: attached like to_json): detachable like object
            -- Convert from JSON value. 
			-- Returns Void if unable to convert
        deferred
        end

    to_json (o: like object): detachable JSON_VALUE
            -- Convert to JSON value
        deferred
        end

invariant
    has_eiffel_object: object /= Void -- An empty object must be created at creation time!

end

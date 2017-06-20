note
	description: "[
		JSON_HAL_RESOURCE_CONVERTER  allow to go `from_json' and return a RESOURCE object and `to_json' convert an object RESOURCE into a JSON 
		representation
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_HAL_RESOURCE_CONVERTER

inherit
	HAL_ACCESS

create
	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Access

	from_json (j: JSON_VALUE): detachable HAL_RESOURCE
			-- Convert from JSON value. Returns Void if unable to convert
		local
			ser: HAL_RESOURCE_JSON_DESERIALIZER
			ctx: JSON_DESERIALIZER_CONTEXT
		do
			create ser
			create ctx
			Result := ser.from_json (j, ctx, Void)
		end

	to_json (o: HAL_RESOURCE): JSON_VALUE
			-- Convert to JSON value
		local
			ser: HAL_RESOURCE_JSON_SERIALIZER
			ctx: JSON_SERIALIZER_CONTEXT
		do
			create ser
			create ctx
			Result := ser.to_json (o, ctx)
		end

end

note
	description: "Removes all agent criteria from a composite criterion tree."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_AGENT_CRITERION_ELIMINATOR_PLUGIN

inherit
	PS_PLUGIN

feature -- Plugin operations

	before_write (object: PS_BACKEND_OBJECT; transaction: PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		do
		end

	before_retrieve (args: TUPLE [type: PS_TYPE_METADATA; criterion: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]]; transaction: PS_INTERNAL_TRANSACTION): like args
			-- <Precursor>
		do
			if attached args.criterion as crit then
				Result := [args.type, eliminator.visit (crit), args.attributes]
			else
				Result := args
			end
		end

	after_retrieve (object: PS_BACKEND_OBJECT; transaction:PS_INTERNAL_TRANSACTION)
			-- <Precursor>
		do
		end

feature {NONE} -- Implementation

	eliminator: PS_AGENT_CRITERION_ELIMINATOR
			-- An agent criterion eliminator instance.
		attribute
			create Result
		end

end

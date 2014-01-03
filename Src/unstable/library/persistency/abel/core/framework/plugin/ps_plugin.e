note
	description: "Main interface for connector plugins. %
		%A plugin can change the objects to store and retrieve, or adjust query parameters."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_PLUGIN

inherit
	PS_ABEL_EXPORT

feature -- Plugin operations

	before_write (object: PS_BACKEND_OBJECT; transaction: PS_INTERNAL_TRANSACTION)
			-- Action to be applied before `object' gets written.
		deferred
		end

	before_retrieve (args: TUPLE [type: PS_TYPE_METADATA; criterion: PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]]; transaction: PS_INTERNAL_TRANSACTION): like args
			-- Action to be applied to the query parameters.
			-- This feature is only called in `{PS_READ_REPOSITORY_CONNECTOR}.retrieve',
			-- but not in `{PS_READ_REPOSITORY_CONNECTOR}.specific_retrieve'
		deferred
		end

	after_retrieve (object: PS_BACKEND_OBJECT; transaction:PS_INTERNAL_TRANSACTION)
			-- Action to be applied to the freshly retrieved `object'.
		deferred
		end

end

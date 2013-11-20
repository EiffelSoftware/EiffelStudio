note
	description: "Main interface for backend plugins. A plugin can change the objects to store and retrieve, or adjust the query parameter."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_PLUGIN

inherit
	PS_ABEL_EXPORT

feature

	before_write (object: PS_BACKEND_OBJECT; transaction: PS_INTERNAL_TRANSACTION)
			-- Action to be applied before `object' gets written.
		deferred
		end

	before_retrieve (args: TUPLE[type: PS_TYPE_METADATA; criterion: detachable PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]]; transaction: PS_INTERNAL_TRANSACTION): like args
			-- Action to be applied to the query parameters.
		deferred
		ensure
			criterion_still_attached: old (attached args.criterion) implies attached Result.criterion
		end

	after_retrieve (object: PS_BACKEND_OBJECT; criterion: detachable PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction:PS_INTERNAL_TRANSACTION)
			-- Action to be applied to the freshly retrieved `object'.
		deferred
		end

end

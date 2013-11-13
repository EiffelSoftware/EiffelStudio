note
	description: "Summary description for {PS_PLUGIN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_PLUGIN

inherit
	PS_ABEL_EXPORT

feature

	before_write_compatibility (object: PS_SINGLE_OBJECT_PART; transaction:PS_INTERNAL_TRANSACTION)
		obsolete
			"Only for old backend interface."
		do
		end


	before_write (object: PS_BACKEND_OBJECT; transaction: PS_INTERNAL_TRANSACTION)
		deferred
		end

	before_retrieve (args: TUPLE[type: PS_TYPE_METADATA; criterion: detachable PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]]; transaction: PS_INTERNAL_TRANSACTION): like args
		deferred
		ensure
			criterion_still_attached: old (attached args.criterion) implies attached Result.criterion
		end

	after_retrieve (object: PS_BACKEND_OBJECT; criterion: detachable PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction:PS_INTERNAL_TRANSACTION)
		deferred
		end

end

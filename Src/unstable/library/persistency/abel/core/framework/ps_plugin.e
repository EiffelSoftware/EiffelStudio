note
	description: "Summary description for {PS_PLUGIN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_PLUGIN

inherit
	PS_EIFFELSTORE_EXPORT

feature

	before_write (object: PS_SINGLE_OBJECT_PART; transaction:PS_TRANSACTION)
		deferred
		end


	before_write_new (object: PS_RETRIEVED_OBJECT; transaction: PS_TRANSACTION)
		deferred
		end

			-- is this actually necessary?
--	after_write (object: PS_SINGLE_OBJECT_PART; transaction:PS_TRANSACTION)
--		deferred
--		end

	before_retrieve (args: TUPLE[type: PS_TYPE_METADATA; criterion: detachable PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]]; transaction: PS_TRANSACTION): like args
		deferred
		ensure
			criterion_still_attached: old (attached args.criterion) implies attached Result.criterion
		end

	after_retrieve (object: PS_RETRIEVED_OBJECT; transaction:PS_TRANSACTION)
		deferred
		end

end

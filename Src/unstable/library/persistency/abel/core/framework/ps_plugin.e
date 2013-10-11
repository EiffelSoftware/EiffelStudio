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

	before_retrieve (type: PS_TYPE_METADATA; criteria: detachable PS_CRITERION; attributes: LIST [STRING]; transaction: PS_TRANSACTION)
		deferred
		end

	after_retrieve (object: PS_RETRIEVED_OBJECT; transaction:PS_TRANSACTION)
		deferred
		end

end

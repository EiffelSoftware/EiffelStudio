indexing
	description: "[
		Shared assembly dependency resolver subscriber.
		]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	AR_SHARED_SUBSCRIBER
	
feature -- Access

	resolve_subscriber: AR_RESOLVE_SUBSCRIBER is
			-- Singleton access to a `AR_RESOLVE_SUBSCRIBER'
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

end -- class AR_SHARED_SUBSCRIBER

note
	description: "Abstract ancestor to all opaque ZMQ structures/objects."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WRAPPER_BASE

inherit
	DISPOSABLE

feature -- Initialization

	make (a_item: POINTER)
			-- Create.
		require
			a_item_not_null: a_item /= default_pointer
		do
			item := a_item
		ensure
			item_set: item = a_item
		end

feature {WRAPPER_BASE} -- Access

	item: POINTER
			-- Pointer to underlying C object.

end

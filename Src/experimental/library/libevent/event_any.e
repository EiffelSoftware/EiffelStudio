note
	description: "Summary description for {EVENT_ANY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EVENT_ANY

inherit
	DISPOSABLE

feature -- Access

	item: POINTER
			-- Structure pointer

feature -- Status report

	exists: BOOLEAN
			-- Does `item' exist?
		do
			Result := item /= default_pointer
		ensure
			result_correct: (item /= default_pointer)
		end

feature -- Removal

	dispose
			-- Destroy the inner structure of `Current'.
			--
			-- This function should be called by the GC when the
			-- object is collected or by the user if `Current' is
			-- no more usefull.
		do
			if exists then
				destroy_item
			end
		end

feature {NONE} -- Removal

	destroy_item
			-- Called by the `dispose' routine to
			-- destroy `item' by calling the
			-- corresponding Windows function and
			-- set `item' to `default_pointer'.
		require
			exists: exists
		deferred
		end

feature {NONE} -- Externals

	c_free (a_p: POINTER)
		external
			"C inline"
		alias
			"free($a_p);"
		end

end

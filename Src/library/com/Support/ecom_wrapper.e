indexing
	description: "Wrapper of C structures and Interfaces"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECOM_WRAPPER

inherit
	DISPOSABLE
	
	PLATFORM
		export
			{NONE} all
		end

feature -- Initialization

	make (a_pointer: POINTER) is
			-- Initialize
		require
			valid_pointer: a_pointer /= default_pointer
		do
			item := a_pointer
		ensure
			valid_item: item = a_pointer
		end

feature -- Access

	item: POINTER
			-- Pointer to COM structure

feature -- Basic Operations

	memory_free is
			-- Free memory pointed by `item'.
		deferred
		ensure
			item_null: item = default_pointer
		end

feature {NONE} -- Implementation

	dispose is
			-- Release memory pointed by `item'.
		do
			if item /= default_pointer then
				memory_free
				item := default_pointer
			end
		ensure then
			item_null: item = default_pointer
		end

invariant
	valid_item: item /= default_pointer

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ECOM_WRAPPER


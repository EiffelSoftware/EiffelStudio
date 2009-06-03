note
	description: "COM Stub."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECOM_STUB

inherit
	ECOM_INTERFACE

feature -- Access

	exists: BOOLEAN
			-- Is stub initialized?
		do
			Result := item /= default_pointer
		end

	item: POINTER
			-- Pointer to COM object stub.

feature -- Basic operations

	set_item (an_item: POINTER)
			-- Set `item' with `an_item'.
		do
			item := an_item
		ensure
			valid_item: item = an_item
		end

	create_item
			-- Create COM stub.
		require
			not_exists: not exists
		deferred
		ensure
			exists: exists
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ECOM_STUB


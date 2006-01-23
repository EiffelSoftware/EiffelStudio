indexing
	description: "COM Queriable"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECOM_QUERIABLE

inherit
	ECOM_INTERFACE

	DISPOSABLE

feature  {NONE} -- Initialization

	make_from_other (other: ECOM_INTERFACE) is
			-- Make from other Queriable.
		require
			non_void_other: other /= Void
		local
			a_stub: ECOM_STUB
		do
			if (other.item = default_pointer) then
				a_stub ?= other
				if a_stub /= Void then
					a_stub.create_item
				end
			end
			make_from_pointer (other.item)
		ensure
			valid_initializer: initializer /= default_pointer
			exists: exists
		end

	make_from_pointer (a_pointer: POINTER) is
			-- Make from interface pointer.
		require
			non_default_pointer: a_pointer /= default_pointer
		deferred
		ensure
			valid_initializer: initializer /= default_pointer
			exists: exists
		end

feature -- Access

	exists: BOOLEAN is
			-- Is wrapped structure initialized?
		do
			Result := item /= default_pointer
		end;

	item: POINTER
			-- Pointer to COM object wrapper.

feature {NONE} -- Implementation

	initializer: POINTER;
			-- Pointer to C++ wrapper.

	dispose is
			-- Delete C++ wrapper.
		do
			delete_wrapper
		end

	delete_wrapper is
			-- Delete C++ wrapper.
		deferred
		end

invariant
	queriable_invariant: initializer /= default_pointer and then exists

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




end -- class ECOM_QUERIABLE


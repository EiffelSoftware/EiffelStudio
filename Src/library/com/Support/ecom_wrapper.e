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

	ECOM_EXCEPTION_CODES
		export
			{NONE} all
		end

feature -- Initialization

	make_from_pointer (a_pointer: POINTER) is
			-- Initialize
		require
			valid_pointer: a_pointer /= default_pointer
		do
			initializer := create_wrapper (a_pointer)
			item := a_pointer
		ensure
			wrapper_exist: initializer /= default_pointer and then
					exists
			valid_item: item = a_pointer
		end

feature -- Access

	item: POINTER
			-- Pointer to COM structure

	exists: BOOLEAN is
			-- Is wrapped structure initialized?
		do
			Result := item /= default_pointer
		end

feature {NONE} -- Implementation

	initializer: POINTER
			-- Pointer to C++ wrapper

	dispose is
			-- Delete C++ wrapper
		do
			delete_wrapper
		end

	create_wrapper (a_pointer: POINTER): POINTER is
			-- Create C++ wrapper
		require 
			valid_pointer: a_pointer /= default_pointer
		deferred
		end

	delete_wrapper is
			-- Delete C++ wrapper
		deferred
		end

invariant
	wrapper_invariant: initializer /= default_pointer and then
					exists

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


indexing
	description:
		"Argument context facility"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ARGUMENT_CONTEXT inherit

	EXCEPTIONS
		export
			{NONE} all
		end

feature -- Access

	context: like actual_context is
			-- Argument context
		require
			available: is_context_set
		do
			Result := actual_context
		end
		
feature -- Status report

	is_context_set: BOOLEAN is
			-- Is argument context set?
		do
			Result := actual_context /= Void
		end

feature -- Status setting

	set_context (c: ANY) is
			-- Set context to `c'.
		require
			context_exists: c /= Void
		do
			actual_context ?= c
			if actual_context = Void then raise ("Non-conforming argument") end
		ensure
			context_set: context = c
		end

	clear_context is
			-- Clear context.
		do
			actual_context := Void
		ensure
			context_cleared: not is_context_set
		end

feature {NONE} -- Implementation

	actual_context: ANY
			-- Actual context
			-- (To be redefined in subclasses that use the facility.)
invariant

	context_set_definition: is_context_set = (actual_context /= Void)

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




end -- class ARGUMENT_CONTEXT


indexing
	description: "Eiffel call stack for the stopped application."
	date: "$Date$"
	revision: "$Revision $"

deferred class EIFFEL_CALL_STACK

--inherit
--
--	TWO_WAY_LIST [CALL_STACK_ELEMENT]
--		rename
--			make as list_make
--		end;


--create {RUN_INFO, APPLICATION_STATUS}
--
--	make, dummy_make
--

feature -- Fake inherit from TWO_WAY_LIST

	count: INTEGER is
		deferred
		end

	is_empty: BOOLEAN is
			-- Call Stack empty ?
		deferred
		end

	start is
		deferred
		end

	forth is
		deferred
		end

	after: BOOLEAN is
		deferred
		end

	item: CALL_STACK_ELEMENT is
		deferred
		end

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		deferred
		end

	i_th (i: INTEGER): like item is
		deferred
		end

feature -- Properties

	error_occurred: BOOLEAN is
			-- Did an error occurred when retrieving the eiffel stack?
		deferred
		end

feature -- Output

	display_stack (st: STRUCTURED_TEXT) is
			-- Display callstack in `st'.
		deferred
		end

invariant

	empty_if_error: error_occurred implies is_empty

end -- class EIFFEL_CALL_STACK

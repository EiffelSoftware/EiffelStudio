indexing
	description: "Error handler for Eiffel Query Language"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_ERROR_HANDLER

inherit
	EXCEPTIONS

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			create error_list.make
		end

feature -- Access

	error_list: LINKED_LIST [QL_ERROR]
			-- Error list

feature -- Status

	has_error: BOOLEAN is
			-- Has error handler detected an error so far?
		do
			Result := not error_list.is_empty
		end

feature -- Element change

	insert_interrupt_error is
			-- Insert an `interrup_error' so that current query language process
			-- can be stopped.
		local
			interrupt_error: QL_INTERRUPT_ERROR
		do
			create interrupt_error
			insert_error (interrupt_error)
			raise_error
		end

	insert_error (e: QL_ERROR) is
			-- Insert `e' in `error_list'.
		require
			good_argument: e /= Void
		do
			error_list.extend (e)
			error_list.finish
		end

	raise_error is
			-- Raise an exception.
		require
			has_error: has_error
		do
			raise ("Query language processing error")
		end

	checksum is
			-- Check if there are errors in `error_list' and raise
			-- an error if needed.
		do
			if has_error then
				raise_error
			end
		end

	wipe_out is
			-- Empty `error_list'.
		do
			error_list.wipe_out
		end

end

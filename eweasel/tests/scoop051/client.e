note
	description: "Test if nested separate callbacks are handled correctly."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CLIENT

create
	make

feature

	passed_string: detachable STRING

	make
			-- Entry point for the test.
		local
			retried: BOOLEAN
			supplier: separate SUPPLIER
		do
			create supplier
			pass_locks (supplier)
		end

	pass_locks (a_supplier: separate SUPPLIER)
			-- Pass on our locks to `a_supplier'.
		do
			a_supplier.perform_callback (Current)
			print (passed_string)
				-- Extra challenge: Does SCOOP behave correctly
				-- on separate callbacks when impersonation kicks
				-- in during a second synchronous call?
			a_supplier.perform_callback (Current)
			print (passed_string)
		end

	callback (a_string: separate STRING)
			-- Import `a_string'.
		do
				-- Note: This is the first callback, and we have the
				-- call stack lock of the supplier.

				-- By executing `make_from_string' we perform a lot of 
				-- nested (second-level) callbacks on SUPPLIER.
			create passed_string.make_from_separate (a_string)
		end

end

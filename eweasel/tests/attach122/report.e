class REPORT

feature -- Output

	put_test (n: NATURAL)
			-- Report current test number `n`.
		do
			io.put_string ("Test #")
			io.put_natural (n)
			io.put_string (": ")
		end

	put_ok
			-- Report success.
		do
			io.put_string ("OK")
			io.put_new_line
		end

	put_ok_attached (a: ANY)
			-- Report success with object `a`.
		do
			io.put_string ("OK")
			a.out.do_nothing
			io.put_new_line
		end

	put_fail
			-- Report failure.
		do
			io.put_string ("Failed")
			io.put_new_line
		end

	put_fail_attached (a: ANY)
			-- Report failure with attached object `a`.
		do
			io.put_string ("Failed: ")
			io.put_string (a.out)
			io.put_new_line
		end

end
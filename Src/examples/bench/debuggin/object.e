class OBJECT feature

	other: OBJECT;  some_value: INTEGER;

	operate is
			-- Do some operations.
		do
			create other;
			good_routine (333);
			bad_routine;
		end;

	good_routine (n: INTEGER) is
            -- Set the value of `some_value' to `n'
			-- and perform `n' loop iterations.
        require
            n >= 0
        local
            i: INTEGER; ten_times_i: INTEGER
        do
			some_value := n;
            from i := 0 until  i = n  loop
                i := i + 1;
                ten_times_i := 10 * i
            end
        end;	

	bad_routine is
			-- Produce an exception (call with void target).
		local
			void_reference: OBJECT;
		do
			void_reference.good_routine (0)
		end
end

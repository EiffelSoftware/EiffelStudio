expanded class
	VALUE

inherit
	COMPARABLE
		redefine
			default_create
		end

feature {NONE} -- Creation

	default_create
			-- Initialize with a default value.
		do
			create item
		end

feature {VALUE} -- Access

	item: TEST
			-- An object that is moved during GC.

feature -- Comparison

	is_less alias "<" (other: VALUE): BOOLEAN
			-- <Precursor>
		do
				-- Trigger GC to move `other.item`.
			;(create {MEMORY}).full_collect
				-- Access `other.item`.
			other.report
			other.item.f
		end

feature -- Output

	report
			-- Report whether `item` is a valid object rather than a forwarded reference.
		do
			io.put_boolean (not is_forwarded ($item))
			io.put_new_line
		end

feature {NONE} -- Run-time

	is_forwarded (p: POINTER): BOOLEAN
			-- Does `p` of type "EIF_REFERENCE *" have "B_FWD" flag set?
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"[
				#if defined(EIF_IL_DLL) || !defined(ISE_GC)
					return EIF_FALSE;
				#else
					return EIF_TEST(((union overhead *) $p - 1)->ov_size & B_FWD);
				#endif
			]"
		end

end

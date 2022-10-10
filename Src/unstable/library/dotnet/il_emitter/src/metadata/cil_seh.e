note
	description: "Summary description for {CIL_SEH}."
	date: "$Date$"
	revision: "$Revision$"

once class
	CIL_SEH

create
	seh_try, seh_catch, seh_finally, seh_fault, seh_filter, seh_filter_handler

feature {NONE} -- Creation

	seh_try once  end
	seh_catch once  end
	seh_finally once  end
	seh_fault once  end
	seh_filter once  end
	seh_filter_handler once  end

feature -- Access

	instances: ITERABLE [CIL_SEH]
			-- All known cil sehs
		do
			Result := <<{CIL_SEH}.seh_try, {CIL_SEH}.seh_catch, {CIL_SEH}.seh_finally, {CIL_SEH}.seh_fault, {CIL_SEH}.seh_filter, {CIL_SEH}.seh_filter_handler>>
		ensure
			instance_free: class
		end

end

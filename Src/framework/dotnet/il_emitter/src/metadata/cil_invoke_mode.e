note
	description: "A call to either managed or unmanaged code"
	date: "$Date$"
	revision: "$Revision$"

once class
	CIL_INVOKE_MODE

create
	CIL,
	PInvoke

feature {NONE} -- Creation

	CIL once  end

	PInvoke once  end

feature -- Access

	instances: ITERABLE [CIL_INVOKE_MODE]
			-- All known Invoke Modes
		once
			Result := << {CIL_INVOKE_MODE}.CIL, {CIL_INVOKE_MODE}.PInvoke >>
		ensure
			instance_free: class
		end

end

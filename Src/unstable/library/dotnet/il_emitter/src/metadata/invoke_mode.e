note
	description: "A call to either managed or unmanaged code"
	date: "$Date$"
	revision: "$Revision$"

once class
	INVOKE_MODE

create
	CIL,
	PInvoke

feature {NONE} -- Creation

	CIL once  end

	PInvoke once  end

feature -- Access

	instances: ITERABLE [INVOKE_MODE]
			-- All known Invoke Modes
		once
			Result := << {INVOKE_MODE}.CIL, {INVOKE_MODE}.PInvoke >>
		ensure
			instance_free: class
		end

end

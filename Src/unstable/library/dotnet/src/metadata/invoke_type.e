note
	description: "Linkage type for unmanaged call"
	date: "$Date$"
	revision: "$Revision$"

once class
	INVOKE_TYPE
create
	Cdecl,
	Stdcall

feature {NONE} -- Creation

	Cdecl once  end

	Stdcall once end

feature -- Access

	instances: ITERABLE [INVOKE_TYPE]
			-- All known invoke types
		do
			Result := << {INVOKE_TYPE}.Cdecl, {INVOKE_TYPE}.Stdcall >>
		ensure
			instance_free: class
		end
end

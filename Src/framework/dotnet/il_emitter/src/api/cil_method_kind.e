note
	description: "Summary description for {CIL_METHOD_KIND}."
	date: "$Date$"
	revision: "$Revision$"

once class
	CIL_METHOD_KIND

create
	Static, Primary, Instance, Virtual

feature {NONE} -- Initialization

	Static once end
	Primary once end
	Instance once end
	Virtual once end

feature -- Instances

	instances: ITERABLE [CIL_METHOD_KIND]
			-- All known method kinds
		do
			Result := <<{CIL_METHOD_KIND}.Static, {CIL_METHOD_KIND}.Primary, {CIL_METHOD_KIND}.Instance, {CIL_METHOD_KIND}.Virtual>>
		ensure
			instance_free: class
		end

end

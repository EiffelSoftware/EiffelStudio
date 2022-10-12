note
	description: "Summary description for {CIL_FIND_TYPE}."
	date: "$Date$"
	revision: "$Revision$"

once class
	CIL_FIND_TYPE

create
	s_notFound,
	s_ambiguous,
	s_namespace,
	s_class,
	s_enum,
	s_field,
	s_property,
	s_method

feature {NONE} -- Creation procedures

	s_notFound once end
	s_ambiguous once end
	s_namespace once end
	s_class once end
	s_enum once end
	s_field once end
	s_property once end
	s_method once end

feature -- Instances

	instances: ITERABLE [CIL_FIND_TYPE]
			-- All known find_types's.
		do
			Result := <<
					{CIL_FIND_TYPE}.s_notFound,
					{CIL_FIND_TYPE}.s_ambiguous,
					{CIL_FIND_TYPE}.s_namespace,
					{CIL_FIND_TYPE}.s_class,
					{CIL_FIND_TYPE}.s_enum,
					{CIL_FIND_TYPE}.s_field,
					{CIL_FIND_TYPE}.s_property,
					{CIL_FIND_TYPE}.s_method
				>>
		ensure
			instance_free: class
		end

end

note
	description: "Summary description for {PS_OBJECT_READ_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_OBJECT_READ_DATA

inherit
	PS_OBJECT_DATA

create
	make_with_primary_key

feature {PS_ABEL_EXPORT} -- Access

	to_initialize: ARRAYED_LIST [detachable PS_TYPE_METADATA]
			-- The pre-computed type of the items that still need to be initialized.
		do
			if attached internal_to_initialize as res then
				Result := res
			else
				create Result.make_filled (type.attribute_count)
				internal_to_initialize := Result
			end
		end

	internal_to_initialize: detachable like to_initialize

feature {NONE} -- Initialization

	make_with_primary_key (idx: INTEGER; a_primary_key: INTEGER; a_type: PS_TYPE_METADATA; a_level: INTEGER)
			-- Initialization for `Current'
		do
			index := idx
			type := a_type
			level := a_level
			primary_key := a_primary_key
--			create to_initialize.make_filled (a_type.attribute_count)
		end

end

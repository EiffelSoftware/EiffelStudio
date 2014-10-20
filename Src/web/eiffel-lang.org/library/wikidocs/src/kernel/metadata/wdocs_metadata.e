note
	description: "Summary description for {WDOCS_METADATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_METADATA

inherit
	TABLE_ITERABLE [READABLE_STRING_32, READABLE_STRING_GENERAL]

feature -- Access

	item (a_key: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		deferred
		end

end

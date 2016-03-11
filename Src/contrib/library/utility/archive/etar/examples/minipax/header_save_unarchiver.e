note
	description: "[
			UNARCHIVER that saves all headers it is initialized with
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER_SAVE_UNARCHIVER

inherit
	SKIP_UNARCHIVER
		redefine
			default_create,
			do_internal_initialization
		end

feature {NONE} -- Initialization

	default_create
			-- Create new instance.
		do
			create {ARRAYED_LIST [TAR_HEADER]} headers.make (10)

			Precursor
		end
feature -- Access

	headers: LIST [TAR_HEADER]
			-- All headers that this instance was initialized with.

feature {NONE} -- Implementation

	do_internal_initialization
			-- Setup internal structures.
		do
			if attached active_header as l_header then
				headers.force (l_header)
			end
		end

note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

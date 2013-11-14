note
	description: "Summary description for {LIBRARY_DATABASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_DATABASE

create
	make

feature {NONE} -- Initialization

	make (ctx: detachable LIBRARY_DATABASE_CONTEXT)
		do
			context := ctx
			create items.make (0)
			create ecf_files.make (0)
		end

feature -- Access

	context: detachable LIBRARY_DATABASE_CONTEXT
			-- Associated context

	items: STRING_TABLE [LIBRARY_INFO]
			-- Info indexed by UUID

	ecf_files: ARRAYED_LIST [PATH]
			-- Indexed ecf files

feature -- Change

	wipe_out
		do
			items.wipe_out
			ecf_files.wipe_out
		end

feature -- Status report

	has (a_uuid: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := items.has (a_uuid)
		end

	has_ecf_file (p: PATH): BOOLEAN
		do
			Result := across ecf_files as ic some p.same_as (ic.item) end
		end

feature -- Change

	put (i: LIBRARY_INFO)
		do
			items.put (i, i.uuid.out)
			ecf_files.force (i.location)
		end

	force (i: LIBRARY_INFO)
		do
			items.force (i, i.uuid.out)
			ecf_files.force (i.location)
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

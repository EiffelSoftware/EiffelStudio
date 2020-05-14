note
	description: "[
			Parameters used by CMS_HOOK_IMPORT subscribers.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_IMPORT_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (a_location: PATH)
		do
			location := a_location.absolute_path.canonical_path
			create logs.make (10)
		end

feature -- Access

	location: PATH
			-- Location of import folder.

	location_exists: BOOLEAN
			-- Does location of import folder exist?
		local
			ut: FILE_UTILITIES
		do
			Result := ut.directory_path_exists (location)
		end

feature -- Logs

	logs: ARRAYED_LIST [READABLE_STRING_8]
			-- Associated importation logs.

	log (m: READABLE_STRING_8)
			-- Add html message `m' into `logs'.
		do
			logs.force (m)
		end

invariant

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

note
	description: "Summary description for {WDOCS_TIMELINE_PATH_EVENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_TIMELINE_PATH_EVENT

inherit
	WDOCS_TIMELINE_EVENT

feature -- Access

	event_summary: STRING_32
		do
			create Result.make_empty
			if revision.id > 0 then
				Result.append_character ('#')
				Result.append_integer (revision.id)
				Result.append_character (' ')
			end
			Result.append_character ('%"')
			Result.append_string_general (title)
			Result.append_character ('%"')
		end

	base_dir: PATH

	location: PATH

	revision: WDOCS_REVISION_INFO

	date: DATE_TIME

	title: READABLE_STRING_GENERAL
		deferred
		end

feature -- Conversion

	relative_path: STRING_32
		local
			l_base: READABLE_STRING_32
		do
			l_base := base_dir.name
			Result := location.name
			if Result.starts_with_general (l_base) then
				Result.remove_head (l_base.count + 1)
			end
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := date < other.date
		end

end

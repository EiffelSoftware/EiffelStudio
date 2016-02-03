note
	description: "Summary description for {ECF_UPDATER_PATH_DETAILS}."
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_UPDATER_PATH_DETAILS

create
	make,
	make_error

feature {NONE} -- Initialization

	make (a_uuid: detachable READABLE_STRING_8; a_segments: like segments; a_dir, a_file: READABLE_STRING_GENERAL)
		do
			uuid := a_uuid
			segments := a_segments
			dir := a_dir
			file := a_file
		end

	make_error
		do
			make (Void, create {ARRAYED_LIST [READABLE_STRING_GENERAL]}.make (0), "", "")
			set_is_error (True)
		end

feature -- Access

	uuid: detachable READABLE_STRING_8

	segments: LIST [READABLE_STRING_GENERAL]

	dir,file: READABLE_STRING_GENERAL

	is_redirection: BOOLEAN

	is_error: BOOLEAN

feature -- Element change

	set_is_redirection (b: BOOLEAN)
		do
			is_redirection := b
		end

	set_is_error (b: BOOLEAN)
		do
			is_error := b
		end

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

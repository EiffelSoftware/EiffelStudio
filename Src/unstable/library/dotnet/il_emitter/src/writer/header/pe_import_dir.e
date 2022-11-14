note
	description: "Summary description for {PE_IMPORT_DIR}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_IMPORT_DIR


feature -- Access

	thunk_pos2: INTEGER assign set_thunk_pos2
			-- `address thunk'

	time: INTEGER assign set_time
			-- `time'

	version: INTEGER assign set_version
			-- `version'

	dll_name: INTEGER assign set_dll_name
			-- `dll_name'

	thunk_post: INTEGER assign set_thunk_post
			-- name thunk

feature -- Element change

	set_thunk_pos2 (a_thunk_pos2: like thunk_pos2)
			-- Assign `thunk_pos2' with `a_thunk_pos2'.
		do
			thunk_pos2 := a_thunk_pos2
		ensure
			thunk_pos2_assigned: thunk_pos2 = a_thunk_pos2
		end

	set_time (a_time: like time)
			-- Assign `time' with `a_time'.
		do
			time := a_time
		ensure
			time_assigned: time = a_time
		end

	set_version (a_version: like version)
			-- Assign `version' with `a_version'.
		do
			version := a_version
		ensure
			version_assigned: version = a_version
		end

	set_dll_name (a_dll_name: like dll_name)
			-- Assign `dll_name' with `a_dll_name'.
		do
			dll_name := a_dll_name
		ensure
			dll_name_assigned: dll_name = a_dll_name
		end

	set_thunk_post (a_thunk_post: like thunk_post)
			-- Assign `thunk_post' with `a_thunk_post'.
		do
			thunk_post := a_thunk_post
		ensure
			thunk_post_assigned: thunk_post = a_thunk_post
		end


feature -- Measurement

	size_of: INTEGER
		local
			l_internal: INTERNAL
			n: INTEGER
			l_obj: PE_IMPORT_DIR
			l_size: INTEGER
		do
			create l_obj
			create l_internal
			n := l_internal.field_count (l_obj)
			across 1 |..| n as ic loop
				if attached l_internal.field (ic, l_obj) as l_field then
					if attached {INTEGER_32} l_field then
						Result := Result + {PLATFORM}.integer_32_bytes
					end
				end
			end
		ensure
			instance_free: class
		end


end

note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_CONSTANTS


feature -- Id

	status_normal: INTEGER = 1
	status_modified: INTEGER = 2
	status_conflict: INTEGER = 4
	status_missing: INTEGER = 8
	status_added: INTEGER = 16
	status_deleted: INTEGER = 32
	status_unknown: INTEGER = 64
	status_obstructed: INTEGER = 128
	status_external: INTEGER = 256
	status_update: INTEGER = 512
	status_none: INTEGER = 1024
	status_error: INTEGER = 2048

	status_normal_id: STRING = "normal"
	status_modified_id: STRING = "modified"
	status_conflict_id: STRING = "conflicted"
	status_missing_id: STRING = "missing"
	status_added_id: STRING = "added"
	status_deleted_id: STRING = "deleted"
	status_unknown_id: STRING = "unversioned"
	status_error_id: STRING = "error"
	status_none_id: STRING = "none"
	status_update_id: STRING = "update"
	status_obstructed_id: STRING = "obstructed"
	status_external_id: STRING = "external"

	kind_file: NATURAL_8 = 1
	kind_dir: NATURAL_8 = 2

	kind_to_string (a_kind: NATURAL_8): STRING
		do
			inspect a_kind
			when kind_file then
				Result := "file"
			when kind_dir then
				Result := "dir"
			else
				Result := "UnknownKind"
			end
		end

	string_to_kind (a_kind_name: READABLE_STRING_GENERAL): NATURAL_8
		do
			if a_kind_name.same_string ("file") then
				Result := kind_file
			elseif a_kind_name.same_string ("dir") then
				Result := kind_dir
			else
				--| Result := 0
			end
		end

	status_code_name_entries: ARRAYED_LIST [TUPLE [code: INTEGER; name: STRING]]
		once
			create Result.make (11)
			Result.extend ([status_modified, status_modified_id])
			Result.extend ([status_added, status_added_id])
			Result.extend ([status_deleted, status_deleted_id])

			Result.extend ([status_unknown, status_unknown_id])
			Result.extend ([status_update, status_update_id])
			Result.extend ([status_missing, status_missing_id])
			Result.extend ([status_external, status_external_id])
			Result.extend ([status_normal, status_normal_id])

			Result.extend ([status_obstructed, status_obstructed_id])
			Result.extend ([status_error, status_error_id])
			Result.extend ([status_none, status_none_id])
		ensure
--			not Result.has (Void)
		end

	status_codes: HASH_TABLE [INTEGER, STRING]
		local
			lst: like status_code_name_entries
		once
			lst := status_code_name_entries
			create Result.make (lst.count)
			from
				lst.start
			until
				lst.after
			loop
				Result.put (lst.item.code, lst.item.name)
				lst.forth
			end
		end

	status_ids: HASH_TABLE [STRING, INTEGER]
		local
			lst: like status_code_name_entries
		once
			lst := status_code_name_entries
			create Result.make (lst.count)
			from
				lst.start
			until
				lst.after
			loop
				Result.put (lst.item.name, lst.item.code)
				lst.forth
			end
		end

note
	copyright: "Copyright (c) 2003-2015, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end

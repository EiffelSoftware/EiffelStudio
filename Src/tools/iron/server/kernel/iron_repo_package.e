note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IRON_REPO_PACKAGE

inherit
	DEBUG_OUTPUT
		redefine
			is_equal
		end

create
	make,
	make_empty

feature {NONE} -- Initialization

	make_empty
		do
			create id.make_empty
		end

	make (a_id: READABLE_STRING_8)
			-- Initialize `Current'.
		do
			create id.make_from_string (a_id)
		end

feature -- Status

	has_id: BOOLEAN
		do
			Result := not id.is_empty
		end

feature -- Comparison		

	is_equal (other: IRON_REPO_PACKAGE): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
			-- (from ANY)
		do
			Result := id ~ other.id
		end

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := human_identifier
		end

feature -- Access

	human_identifier: READABLE_STRING_32
		do
			if attached name as l_name then
				Result := l_name
			else
				Result := id.to_string_32
			end
		end

	id: IMMUTABLE_STRING_8

	owner: detachable IRON_REPO_USER

	name: detachable READABLE_STRING_32

	domain: detachable READABLE_STRING_32

	description: detachable READABLE_STRING_32

	has_archive: BOOLEAN
		do
			Result := archive_path /= Void
		end

	archive_path: detachable PATH

	archive_file_size: INTEGER

	archive_last_modified: detachable DATE_TIME

feature -- Access: items	

	items: detachable STRING_TABLE [detachable READABLE_STRING_32]
			-- Optional info

	item (n: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
			if attached items as tb then
				Result := tb.item (n)
			end
		end

feature {IRON_REPO_EXPORTER} -- Change

	update_id (a_id: READABLE_STRING_8)
		require
			valid_a_id: not a_id.is_empty
			has_no_id: not has_id
		do
			create id.make_from_string (a_id)
		ensure
			has_id: has_id
			id_set: id.is_case_insensitive_equal (a_id)
		end

	reset_id
		require
			has_id: has_id
		do
			create id.make_empty
		ensure
			has_no_id: not has_id
		end

feature -- Change

	put (v: detachable READABLE_STRING_32; k: READABLE_STRING_GENERAL)
		local
			tb: like items
		do
			tb := items
			if tb = Void then
				create tb.make (1)
				items := tb
			end
			tb.force (v, k)
		end

	set_name (v: detachable READABLE_STRING_GENERAL)
		do
			if v /= Void then
				name := v.to_string_32
			else
				name := Void
			end
		end

	set_domain (v: detachable READABLE_STRING_GENERAL)
		do
			if v /= Void then
				domain := v.to_string_32
			else
				domain := Void
			end
		end

	set_description (v: detachable READABLE_STRING_GENERAL)
		do
			if v /= Void then
				description := v.to_string_32
			else
				description := Void
			end
		end

	set_archive_path (v: detachable PATH)
		do
			archive_path := v
			get_archive_info
		end

	set_owner (u: like owner)
		do
			owner := u
		end

feature {NONE} -- Implementation

	get_archive_info
		local
			f: RAW_FILE
		do
			if attached archive_path as p then
				create f.make_with_path (p)
				archive_file_size := f.count
				create archive_last_modified.make_from_epoch (f.change_date)
			else
				archive_file_size := 0
				archive_last_modified := Void
			end
		end

end

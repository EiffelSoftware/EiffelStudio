note
	description: "[
				This represents a package on the iron node (i.e server)
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_PACKAGE

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
			make (create {IMMUTABLE_STRING_8}.make_empty)
		end

	make (a_id: READABLE_STRING_8)
			-- Initialize `Current'.
		do
			if attached {IMMUTABLE_STRING_8} a_id as imm_id then
				id := imm_id
			else
				create id.make_from_string (a_id)
			end
			create {ARRAYED_LIST [READABLE_STRING_32]} tags.make (0)
		end

feature -- Status

	has_id: BOOLEAN
		do
			Result := not id.is_empty
		end

feature -- Comparison		

	is_equal (other: IRON_NODE_PACKAGE): BOOLEAN
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

	owner: detachable IRON_NODE_USER

	name: detachable READABLE_STRING_32

	description: detachable READABLE_STRING_32

	last_modified: detachable DATE_TIME

feature -- Tags

	tags: LIST [READABLE_STRING_32]

feature -- Access: archive

	is_named (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is Current package named `a_name' ?
		do
			Result := attached name as n and then a_name.is_case_insensitive_equal (n)
		end

	has_archive: BOOLEAN
--		do
--			Result := archive_path /= Void
--		end

--	archive_path: detachable PATH

--	archive_file_size: INTEGER

--	archive_last_modified: detachable DATE_TIME

feature -- Access: items	

	items: detachable STRING_TABLE [detachable READABLE_STRING_32]
			-- Optional info

	item (n: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
			if attached items as tb then
				Result := tb.item (n)
			end
		end

feature {IRON_NODE_EXPORTER} -- Change

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

	set_description (v: detachable READABLE_STRING_GENERAL)
		do
			if v /= Void then
				description := v.to_string_32
			else
				description := Void
			end
		end

--	set_archive_path (v: detachable PATH)
--		do
--			archive_path := v
--			get_archive_info
--		end

	set_owner (u: like owner)
		do
			owner := u
		end

	set_last_modified (dt: like last_modified)
		do
			last_modified := dt
		end

	set_last_modified_now
		do
			create last_modified.make_now_utc
		end

feature -- Visitor

	accept (vis: IRON_NODE_VISITOR)
		do
			vis.visit_package (Current)
		end

--feature {NONE} -- Implementation

--	get_archive_info
--		local
--			f: RAW_FILE
--		do
--			if attached archive_path as p then
--				create f.make_with_path (p)
--				archive_file_size := f.count
--				create archive_last_modified.make_from_epoch (f.change_date)
--			else
--				archive_file_size := 0
--				archive_last_modified := Void
--			end
--		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

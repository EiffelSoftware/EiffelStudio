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

	COMPARABLE
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
		end

feature -- Status

	has_id: BOOLEAN
		do
			Result := not id.is_empty
		end

	is_less alias "<" (other: like Current): BOOLEAN
			-- <Precursor>.
		do
			Result := identifier.as_lower < other.identifier.as_lower
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

	identifier: READABLE_STRING_32
			-- Safe package name
		do
			if attached name as l_name then
				Result := l_name
			else
				Result := id.to_string_32
			end
		end

	human_identifier: READABLE_STRING_32
		local
			s32: STRING_32
		do
			if attached name as l_name then
				create s32.make_from_string (l_name)
			else
				create s32.make_empty
			end
			if attached title as l_title then
				if s32.is_empty then
					s32.append (l_title)
				else
					s32.append (": ")
					s32.append (l_title)
				end
			elseif s32.is_empty then
				create s32.make_from_string_general (id)
			end
			Result := s32
		end

	id: IMMUTABLE_STRING_8

	owner: detachable IRON_NODE_USER

	name: detachable READABLE_STRING_32

	title: detachable READABLE_STRING_32

	description: detachable READABLE_STRING_32

	last_modified: detachable DATE_TIME

feature -- Tags

	tags: detachable LIST [READABLE_STRING_32]

	links: detachable STRING_TABLE [IRON_NODE_LINK]

feature -- Query

	is_named (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is Current package named `a_name' ?
		do
			Result := attached name as n and then a_name.is_case_insensitive_equal (n)
		end

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

	set_title (v: detachable READABLE_STRING_GENERAL)
		do
			if v /= Void then
				title := v.to_string_32
			else
				title := Void
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

	add_tag (t: READABLE_STRING_GENERAL)
		local
			l_tags: like tags
			s: STRING_32
		do
			l_tags := tags
			if l_tags = Void then
				create {ARRAYED_LIST [READABLE_STRING_32]} l_tags.make (1)
				l_tags.compare_objects
				tags := l_tags
			end
			create s.make_from_string_general (t)
			s.left_adjust
			s.right_adjust
			if not l_tags.has (s) then
				l_tags.force (s)
			end
		end

	remove_tag (t: READABLE_STRING_GENERAL)
		local
			l_tags: like tags
		do
			l_tags := tags
			if l_tags /= Void then
				from
					l_tags.start
				until
					l_tags.after
				loop
					if l_tags.item.is_case_insensitive_equal_general (t) then
						l_tags.remove
					else
						l_tags.forth
					end
				end
				if l_tags.is_empty then
					tags := Void
				end
			end
		end

	add_link (a_name: READABLE_STRING_GENERAL; a_link: IRON_NODE_LINK)
		local
			l_links: like links
		do
			l_links := links
			if l_links = Void then
				create l_links.make_caseless (1)
				links := l_links
			end
			l_links.force (a_link, a_name)
		end

	remove_link (a_name: READABLE_STRING_GENERAL)
		local
			l_links: like links
		do
			l_links := links
			if l_links /= Void then
				l_links.remove (a_name)
				if l_links.is_empty then
					links := Void
				end
			end
		end

feature -- Visitor

	accept (vis: IRON_NODE_VISITOR)
		do
			vis.visit_package (Current)
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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

note
	description: "[
		Sets all the uids of the {XP_TAG_ELEMENT} tree.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_UID_TAG_VISITOR

inherit
	XP_TAG_ELEMENT_VISITOR

create
	make_with_uid

feature -- Initialization

	make_with_uid (a_uid: STRING)
			-- `a_uid': The unique controller identifier
		require
			a_uid_valid: attached a_uid and not a_uid.is_empty
		do
			uid := a_uid
		ensure
			uid_attached: attached uid
			uid_set: uid = a_uid
		end

feature -- Access

	uid: STRING
		-- The unique controller identifier

feature -- Access

	visit_tag_element (tag: XP_TAG_ELEMENT)
			-- Precursor
		do
			set_uid_tag_if_not_set(uid, tag)
		end

	visit_include_tag_element (tag: XP_INCLUDE_TAG_ELEMENT)
			-- Precursor
		do
			set_uid_tag_if_not_set(uid, tag)
		end

	visit_region_tag_element (tag: XP_REGION_TAG_ELEMENT)
			-- Precursor
		do
			set_uid_tag_if_not_set(uid, tag)
		end

	set_uid_tag_if_not_set (a_uid: STRING; a_tag: XP_TAG_ELEMENT)
		require
			a_uid_valid: attached a_uid and not a_uid.is_empty
		do
			if (not attached a_tag.controller_id) or a_tag.controller_id.is_empty then
				a_tag.set_controller_id (a_uid)
			end
		end

invariant
	uid_attached: attached uid

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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

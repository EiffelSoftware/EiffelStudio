note
	description: "Summary description for {TAG_GENERATOR}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XTAG_TAG_SERIALIZER

feature -- Initialization

	make_base
			-- Initialization of variables
			-- Call this constructor, if you inherit
		do
			create {ARRAYED_LIST [TAG_SERIALIZER]} children.make (3)
		end

feature {NONE} -- Access

	children: LIST [TAG_SERIALIZER]
			-- All the children tags of the tag

feature -- Access

	add_to_body (a_child: TAG_SERIALIZER)
			-- Adds a TAG to the body.
		do
			children.extend (a_child)
		ensure
			child_has_been_added: children.count = old children.count + 1
		end

	put_attribute (id: STRING; a_attribute: STRING)
		require
			id_is_not_empty: not id.is_empty
		deferred
		end

feature -- Implementation

	generate_children (a_feature: FEATURE_ELEMENT)
		do
			from
				children.start
			until
				children.after
			loop
				children.item.generate (a_feature)
				children.forth
			end
		end

	generate (a_feature: FEATURE_ELEMENT)
		deferred
		end

	write_string_to_result (a_text: STRING; a_feature: FEATURE_ELEMENT)
			--
		do
			a_feature.append_expression ("Result.append(%"[%N" + a_text + "%N]%")")
		end

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

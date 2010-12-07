note
	description: "Objects that provides tags ..."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAGS_PROVIDER

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
			-- Instanciate Current
		do
			create immediate_tags.make (nb)
			immediate_tags.compare_objects
		end

feature -- Access

	tags: ARRAYED_LIST [STRING_32]
			-- List of Tags.
			-- note: this means Immediate tags + tags from attached `providers'.
		local
			ltags: like tags
			lid: STRING_32
			p: detachable STRING_32
			t: STRING_32
			l_providers: like providers
		do
			l_providers := providers
			if l_providers = Void then
				Result := immediate_tags
			else
				create Result.make (immediate_tags.count)
				Result.fill (immediate_tags)
				from
					l_providers.start
				until
					l_providers.after
				loop
					ltags := l_providers.item_for_iteration.tags
					lid := l_providers.key_for_iteration
					if lid.is_empty then
						p := Void
					else
						create p.make (lid.count)
						p.append (lid)
						p.append_character (':')
					end
					if ltags /= Void then
						from
							ltags.start
						until
							ltags.after
						loop
							t := ltags.item_for_iteration
							if p = Void then
								Result.force (t)
							else
								Result.force (p + t)
							end
							ltags.forth
						end
					end
					l_providers.forth
				end
			end
		end

	immediate_tags: ARRAYED_LIST [STRING_32]
			-- Immediate list of tags.

	providers: detachable HASH_TABLE [TAGS_PROVIDER, STRING_32]
			-- Other tags provider aggregated into Current

feature -- Status

	is_valid_tag (t: STRING_32): BOOLEAN
			-- Is `t' a valid tag value ?
		do
			Result := attached formatted_tag (t) as s and then s.is_equal (t)
		end

feature -- Change

	wipe_out
			-- Wipe out tags
		do
			tags.wipe_out
		end

	sort
			-- Sort tags
		do
			tags_sorter.sort (tags)
		end

	add_tags (a: ARRAY [STRING_32])
			-- Add array of tags `a' to `tags'
		local
			i: INTEGER
		do
			if a /= Void and then not a.is_empty then
				from
					i := a.lower
				until
					i > a.upper
				loop
					add_tag (a[i])
					i := i + 1
				end
			end
		end

	add_tag (a_tag: STRING_32)
			-- Add `a_tag' to `tags' is not already inserted
		require
			is_valid_tag: is_valid_tag (a_tag)
		do
			if not tags.has (a_tag) then
				tags.force (a_tag)
			end
		end

	remove_tag (a_tag: STRING_32)
			-- Remove `a_tag' from `tags'
		require
			is_valid_tag: is_valid_tag (a_tag)
		do
			if tags.has (a_tag) then
				tags.prune (a_tag)
			end
		end

feature -- Change providers

	add_provider (a_p: TAGS_PROVIDER; a_id: STRING_32)
			-- Add `a_p' to `providers' identified by `a_id'
		require
			a_p_not_void: a_p /= Void
			a_id_not_void: a_id /= Void
		local
			p: like providers
		do
			p := providers
			if p = Void then
				create p.make (3)
				p.compare_objects
				providers := p
			end
			p.force (a_p, a_id)
		end

	remove_provider (a_id: STRING_32)
			-- Remove  provider identified by `a_id' from `providers'
		require
			a_id_not_void: a_id /= Void
		do
			if attached providers as p then
				p.remove (a_id)
				if p.is_empty then
					p.wipe_out
					providers := Void
				end
			end
		end

feature {NONE} -- Implementation

	tags_sorter: SORTER [STRING_32]
			-- Sorter of tags.
		once
			create {QUICK_SORTER [STRING_32]} Result.make (create {COMPARABLE_COMPARATOR [STRING_32]})
		end

	formatted_tag (t: STRING_32): detachable STRING_32
			-- Formatted tag
		local
			s32: STRING_32
		do
			if t /= Void then
				create s32.make_from_string (t)
				s32.left_adjust
				s32.right_adjust
				if s32.is_empty then
					Result := Void
				else
					Result := s32
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

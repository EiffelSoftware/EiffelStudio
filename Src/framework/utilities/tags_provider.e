indexing
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

	make (nb: INTEGER) is
			-- Instanciate Current
		do
			create immediate_tags.make_equal (nb)
		end

feature -- Access

	tags: DS_ARRAYED_LIST [STRING_32] is
			-- List of Tags.
			-- note: this means Immediate tags + tags from attached `providers'.
		local
			ltags: like tags
			lid: STRING_32
			p: STRING_32
			t: STRING_32
		do
			if providers = Void then
				Result := immediate_tags
			else
				create Result.make_from_linear (immediate_tags)
				from
					providers.start
				until
					providers.after
				loop
					ltags := providers.item_for_iteration.tags
					lid := providers.key_for_iteration
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
								Result.force_last (t)
							else
								Result.force_last (p + t)
							end
							ltags.forth
						end
					end
					providers.forth
				end
			end
		end

	immediate_tags: DS_ARRAYED_LIST [STRING_32]
			-- Immediate list of tags.

	providers: DS_HASH_TABLE [TAGS_PROVIDER, STRING_32]
			-- Other tags provider aggregated into Current

feature -- Status

	is_valid_tag (t: STRING_32): BOOLEAN is
			-- Is `t' a valid tag value ?
		local
			s: like formatted_tag
		do
			s := formatted_tag (t)
			Result := s /= Void and then s.is_equal (t)
		end

feature -- Change

	wipe_out is
			-- Wipe out tags
		do
			tags.wipe_out
		end

	sort is
			-- Sort tags
		local
			s: DS_SORTER [STRING_32]
		do
			tags.sort (tags_sorter)
		end

	add_tags (a: ARRAY [STRING_32]) is
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

	add_tag (a_tag: STRING_32) is
			-- Add `a_tag' to `tags' is not already inserted
		require
			is_valid_tag: is_valid_tag (a_tag)
		do
			if not tags.has (a_tag) then
				tags.force_last (a_tag)
			end
		end

	remove_tag (a_tag: STRING_32) is
			-- Remove `a_tag' from `tags'
		require
			is_valid_tag: is_valid_tag (a_tag)
		do
			if tags.has (a_tag) then
				tags.delete (a_tag)
			end
		end

feature -- Change providers

	add_provider (a_p: TAGS_PROVIDER; a_id: STRING_32) is
			-- Add `a_p' to `providers' identified by `a_id'
		require
			a_p_not_void: a_p /= Void
			a_id_not_void: a_id /= Void
		do
			if providers = Void then
				create providers.make_equal (3)
			end
			providers.put_last (a_p, a_id)
		end

	remove_provider (a_id: STRING_32) is
			-- Remove  provider identified by `a_id' from `providers'
		require
			a_id_not_void: a_id /= Void
		do
			if providers /= Void then
				providers.remove (a_id)
				if providers.is_empty then
					providers.wipe_out
					providers := Void
				end
			end
		end

feature {NONE} -- Implementation

	tags_sorter: DS_SORTER [STRING_32] is
			-- Sorter of tags.
		once
			create {DS_QUICK_SORTER [STRING_32]} Result.make (create {KL_COMPARABLE_COMPARATOR [STRING_32]}.make)
		end

	formatted_tag (t: STRING_32): STRING_32 is
			-- Formatted tag
		do
			if t /= Void then
				create Result.make_from_string (t)
				Result.left_adjust
				Result.right_adjust
				if Result.is_empty then
					Result := Void
				end
			end
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

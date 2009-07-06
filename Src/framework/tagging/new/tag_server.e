note
	description: "[
		Objects that associate generic items G with tags, represented by strings. The tags are validated
		by an instance of {TAG_FORMATTER}.
		
		A observer pattern is provided to inform clients when tags are added/removed from items.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_SERVER [G -> TAG_ITEM]

inherit
	EVENT_CONNECTION_POINT_I [TAG_SERVER_OBSERVER [G], TAG_SERVER [G]]

	TAG_SHARED_EQUALITY_TESTER

create
	make_default, make_with_formatter

feature {NONE} -- Initialization

	make_default
			-- Initialize `Current' with default formatter.
		do
			make_with_formatter (create {TAG_FORMATTER})
		end

	make_with_formatter (a_formatter: like formatter)
			-- Initialize `Current' using given formatter.
			--
			-- `a_formatter': Formatter for validating/modifying tags.
		require
			a_formatter_attached: a_formatter /= Void
		local
			l_tag_table: like tag_table
		do
			formatter := a_formatter

			create item_to_tags_table.make_default
			create l_tag_table.make_default
			l_tag_table.set_key_equality_tester (equality_tester)
			tag_table := l_tag_table

			create tag_added_event
			create tag_remove_event
		ensure
			formatter_set: formatter = a_formatter
		end

feature -- Access

	formatter: TAG_FORMATTER
			-- Formatter used to validate/modify tags

	items: DS_ARRAYED_LIST [attached G]
			-- All items currently tagged in `Current'
		do
			create Result.make_from_linear (item_to_tags_table.keys)
		ensure
			result_attached: Result /= Void
		end

	tags: DS_ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- Arrayed list of all tags currently used to tag `items'
		do
			create Result.make_from_linear (tag_table.keys)
		end

	tags_of_item (an_item: G): DS_ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- All tags with which an item is tagged
			--
			-- `an_item': Tagged item.
			-- `Result': Tags with which `Current' is tagged.
		require
			an_item_attached: an_item /= Void
			has_an_item: has_item (an_item)
		local
			l_list: DS_LINEAR [READABLE_STRING_GENERAL]
		do
			l_list := item_to_tags_table.item (an_item)
			create Result.make_from_linear (l_list)
		ensure
			result_attached: Result /= Void
			results_attached: not Result.has_void
			results_valid: Result.for_all (agent (a_tag: STRING): BOOLEAN
				do
					Result := formatter.is_valid_tag (a_tag)
				end)
		end

feature {NONE} -- Access

	tag_table: DS_HASH_TABLE [NATURAL, READABLE_STRING_GENERAL]
			-- Table containing all tags currently used to tag an item together with a reference counter
			--
			-- keys: Tags
			-- values: Reference counter indicating how many times a tag is used

	item_to_tags_table: DS_HASH_TABLE [DS_HASH_SET [READABLE_STRING_GENERAL], G]
			-- Table associating items with their corresponding tags
			--
			-- keys: Generic items
			-- values: Set of tags

	connection_cache: detachable like connection
			-- Cache for `connection'
			--
			-- Note: do not access this directly, use `connection' instead.

	lock_count: NATURAL
			-- Number of locks applied to `Current'

feature -- Status report

	is_locked: BOOLEAN
			-- Is it currently not possible to add/remove tags?
		do
			Result := lock_count > 0
		ensure
			count_positive_implies_result: lock_count > 0 implies Result
		end

feature -- Status report: Event

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature {NONE} -- Status setting

	lock
			-- Increase `lock_count', disallowing any tag adding/removal until `unlock' is called.
		do
			lock_count := lock_count + 1
		ensure
			locked: is_locked
		end

	unlock
			-- Decrase `lock_count'.
		require
			locked: is_locked
		do
			lock_count := lock_count - 1
		end

feature -- Query

	is_valid_tag_for_item (an_item: G; a_tag: READABLE_STRING_GENERAL): BOOLEAN
			-- Can item be tagged with given tag?
			--
			-- `an_item': Item to be tagged.
			-- `a_tag': Tag with which `an_item' should be tagged.
			-- `Result': True if item can be tagged with `a_tag', False otherwise.
		require
			an_item_attached: an_item /= Void
			a_tag_attached: a_tag /= Void
		do
			if formatter.is_valid_tag (a_tag) then
				Result := not has_item_with_tag (an_item, a_tag)
			end
		ensure
			result_implies_valid_tag: Result implies formatter.is_valid_tag (a_tag)
			result_implies_not_used: Result implies not has_item_with_tag (an_item, a_tag)
		end

	is_valid_tag (a_tag: READABLE_STRING_GENERAL): BOOLEAN
			-- Is tag a valid tag to be added?
			--
			-- `a_tag': Tag to be added.
			-- `Result': True if `a_tag' is a valid tag, False otherwise.
		do
			Result := formatter.is_valid_tag (a_tag)
		ensure
			result_implies_valid_tag: Result implies formatter.is_valid_tag (a_tag)
		end

--	has_tag (a_tag: READABLE_STRING_GENERAL): BOOLEAN
--			-- Is tag currently used to tag an item?
--			--
--			-- `a_tag': Some tag.
--			-- `Result': True if there is an item tagged with `a_tag', False otherwise.
--		require
--			a_tag_attached: a_tag /= Void
--		local
--			l_table: like tag_to_item_table
--		do
--			l_table := tag_to_item_table
--			check l_table /= Void end
--			Result := l_table.has (a_tag)
--		ensure
--			result_valid: Result = (attached tag_to_item_table as l_t and then l_t.has (a_tag))
--			result_implies_valid: Result implies formatter.is_valid_tag (a_tag)
--		end

	has_item (an_item: G): BOOLEAN
			-- Is item currently tagged in `Current'?
			--
			-- `an_item': Some item.
			-- `Result': True is `an_item' is tagged in `Current', False otherwise.
		require
			an_item_attached: an_item /= Void
		do
			Result := item_to_tags_table.has (an_item)
		ensure
			definition: Result = item_to_tags_table.has (an_item)
		end

	has_item_with_tag (an_item: G; a_tag: READABLE_STRING_GENERAL): BOOLEAN
			-- Is item tagged with given tag?
			--
			-- `an_item': Some item.
			-- `a_tag': Some tag.
			-- `Result': True if `an_item' is tagged with `a_tag', False otherwise.
		require
			an_item_attached: an_item /= Void
			a_tag_attached: a_tag /= Void
		local
			l_table: like item_to_tags_table
		do
			l_table := item_to_tags_table
			l_table.search (an_item)
			if l_table.found then
				Result := l_table.found_item.has (a_tag)
			end
		ensure
			result_correct: Result = (has_item (an_item) and then
				item_to_tags_table.item (an_item).has (a_tag))
		end

feature -- Element change

	add_tag (an_item: G; a_tag: READABLE_STRING_GENERAL)
			-- Tag item with given tag and notify observers through `tag_added_event'.
			--
			-- `an_item': Item to be tagged.
			-- `a_tag': Tag with which item should be tagged.
		require
			an_item_attached: an_item /= Void
			a_tag_attached: a_tag /= Void
			not_updating: not is_locked
			a_tag_valid: is_valid_tag_for_item (an_item, a_tag)
		local
			l_set: DS_HASH_SET [READABLE_STRING_GENERAL]
			l_new: detachable READABLE_STRING_GENERAL
			l_count: NATURAL
			l_tag_table: like tag_table
		do
			lock
			if item_to_tags_table.has (an_item) then
				l_set := item_to_tags_table.item (an_item)
			else
				l_set := new_tag_set
				item_to_tags_table.force (l_set, an_item)
			end
			l_tag_table := tag_table
			if l_tag_table.has (a_tag) then
				l_new := l_tag_table.key (a_tag)
				l_count := l_tag_table.item (l_new) + 1
			else
				l_new := formatter.immutable_string (a_tag)
				l_count := 1
			end
			l_tag_table.force (l_count, l_new)
			l_set.force (l_new)
			tag_added_event.publish ([Current, an_item, l_new])
			unlock
		ensure
			has_tag: has_item_with_tag (an_item, a_tag)
		end

	remove_tag (an_item: G; a_tag: READABLE_STRING_GENERAL)
			-- Remove tag from item and notify observer through `tag_remove_event'.
			--
			-- `an_item': Item from which tag should be removed.
			-- `a_tag': Tag to be removed from `an_item'.
		require
			an_item_attached: an_item /= Void
			a_tag_attached: a_tag /= Void
			not_updating: not is_locked
			has_an_item: has_item (an_item)
			has_a_tag: has_item_with_tag (an_item, a_tag)
		local
			l_set: DS_HASH_SET [READABLE_STRING_GENERAL]
			l_count: NATURAL
			l_table: like tag_table
		do
			lock
			l_set := item_to_tags_table.item (an_item)
			tag_remove_event.publish ([Current, an_item, l_set.item (a_tag)])
			if l_set.count = 1 then
				item_to_tags_table.remove (an_item)
			else
				l_set.remove (a_tag)
			end
			l_table := tag_table
			l_count := l_table.item (a_tag)
			if l_count = 1 then
				l_table.remove (a_tag)
			else
				l_table.force (l_count - 1, a_tag)
			end
			unlock
		ensure
			not_has_tag: not has_item (an_item) or else not has_item_with_tag (an_item, a_tag)
		end

	remove_all_tags (an_item: G)
			-- Remove all tags associated with given item and notify observer through `tag_remove_event'.
			--
			-- `an_item': Item for which all tags should be removed.
		require
			an_item_attached: an_item /= Void
			not_updating: not is_locked
			has_an_item: has_item (an_item)
		local
			l_cursor: DS_LINEAR_CURSOR [READABLE_STRING_GENERAL]
		do
			from
				l_cursor := tags_of_item (an_item).new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				remove_tag (an_item, l_cursor.item)
				l_cursor.forth
			end
		ensure
			item_removed: not has_item (an_item)
			not_updating: not is_locked
		end

feature -- Events

	tag_added_event: EVENT_TYPE [TUPLE [server: TAG_SERVER [G]; tagged_item: G; added_tag: READABLE_STRING_GENERAL]]
			-- Events called when an item have been tagged which was already tagged before.

	tag_remove_event: EVENT_TYPE [TUPLE [server: TAG_SERVER [G]; remove_item: G; remove_tag: READABLE_STRING_GENERAL]]
			-- Events called before a tag is removed from an item containing more than one tags.

	connection: EVENT_CONNECTION [TAG_SERVER_OBSERVER [G], TAG_SERVER [G]]
			-- <Precursor>
		local
			l_cache: like connection_cache
		do
			l_cache := connection_cache
			if l_cache = Void then
				create l_cache.make (
					agent (a_observer: TAG_SERVER_OBSERVER [G]): attached ARRAY [TUPLE [event: attached EVENT_TYPE [TUPLE]; action: attached PROCEDURE [ANY, TUPLE]]]
						do
							Result := <<
								[tag_added_event, agent a_observer.on_tag_added],
								[tag_remove_event, agent a_observer.on_tag_removed]
							>>
						end)
				connection_cache := l_cache
			end
			Result := l_cache
		end

feature {NONE} -- Implementation

	new_tag_set: DS_HASH_SET [READABLE_STRING_GENERAL]
			-- New set for storing tags.
		do
			create Result.make_default
			Result.set_equality_tester (equality_tester)
		ensure
			result_attached: Result /= Void
			result_uses_equality_tester: Result.equality_tester = equality_tester
		end

invariant
	item_table_attached: item_to_tags_table /= Void
	item_table_valid: item_to_tags_table.for_all (
		agent (a_item: DS_HASH_SET [READABLE_STRING_GENERAL]): BOOLEAN
			do
				Result := a_item.equality_tester = equality_tester
			end)
	tag_added_event_attached: tag_added_event /= Void
	tag_removed_event_attached: tag_remove_event /= Void
	tag_table_attached: tag_table /= Void

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

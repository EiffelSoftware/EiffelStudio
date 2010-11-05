note
	description: "[
			Table containing the info for once per object
			in the list, for each routine_id, we find first information of immediate onces,
			then inherited onces
			This is important, so that inherited does not overwrite immediate onces
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	OBJECT_RELATIVE_ONCE_INFO_TABLE

inherit
	ARRAYED_LIST [detachable OBJECT_RELATIVE_ONCE_INFO]

	DEBUG_OUTPUT
		undefine
			is_equal, copy
		end

create
	make

feature -- Access

	has_info_intersecting_with_rout_id_set (a_rout_id_set: ROUT_ID_SET): BOOLEAN
		local
			c: like cursor
		do
			c := cursor
			from
				start
			until
				after or Result
			loop
				if item.rout_id_set.intersect (a_rout_id_set) then
					Result := True
				else
					forth
				end
			end
			go_to (c)
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "count=" + count.out
			if count > 0 then
				across
					Current as c
				loop
					Result.append_string (" ")
					Result.append_string (c.item.debug_output)
				end
			end
		end

feature -- Element change

	add_or_replace_first_item_intersecting_with_rout_id_set (a_info: like item; a_rout_id_set: ROUT_ID_SET)
			-- Replace entry associated with id from `a_rout_id_set' if it exists
			-- otherwise add `a_info' and associate it to `a_rout_id_set'
		local
			c: like cursor
			done: BOOLEAN
		do
			c := cursor
			from
				start
			until
				after
			loop
				if item.rout_id_set.intersect (a_rout_id_set) then
					replace (a_info)
					done := True
				end
				forth
			end
			if not done then
				force (a_info)
			end
			go_to (c)
		ensure
			has_info: has_info_intersecting_with_rout_id_set (a_rout_id_set)
			a_info_set: first_item_intersecting_with_rout_id_set (a_rout_id_set) = a_info
			count: old count + 1 <= count
		end

	add_after_item_intersecting_with_rout_id_set (a_info: like item; a_rout_id_set: ROUT_ID_SET)
			-- Add `a_info' and associate it to `a_rout_id_set'
		local
			c: like cursor
			done: BOOLEAN
		do
			c := cursor
			from
				start
			until
				after or done
			loop
				if item.rout_id_set.intersect (a_rout_id_set) then
					put_right (a_info)
					done := True
				end
				forth
			end
			if not done then
				force (a_info)
			end
			go_to (c)
		ensure
			has_info: has_info_intersecting_with_rout_id_set (a_rout_id_set)
			count: old count + 1 = count
		end

	add_after_last_item_intersecting_with_rout_id_set (a_info: like item; a_rout_id_set: ROUT_ID_SET)
			-- Add `a_info' and associate it to `a_rout_id_set'
		local
			c: like cursor
			done: BOOLEAN
		do
			c := cursor
			from
				finish
			until
				before or done
			loop
				if item.rout_id_set.intersect (a_rout_id_set) then
					put_right (a_info)
					done := True
				end
				back
			end
			if not done then
				force (a_info)
			end
			go_to (c)
		ensure
			has_info: has_info_intersecting_with_rout_id_set (a_rout_id_set)
			count: old count + 1 = count
		end

	merge (other: OBJECT_RELATIVE_ONCE_INFO_TABLE)
			-- Merge Current with other
		do
			append (other)
		end

	remove_items_intersecting_with_rout_id_set (a_rout_id_set: ROUT_ID_SET)
			-- Remove all info about object relative once associated with Current and an item of `a_rout_id_set'
		require
			a_rout_id_set_not_void: a_rout_id_set /= Void
		local
			c: like cursor
		do
			c := cursor
			from
				start
			until
				after
			loop
				if item.rout_id_set.intersect (a_rout_id_set) then
					remove
				else
					forth
				end
			end
			if valid_cursor (c) then
				go_to (c)
			end
		ensure
			count: old count >= count
		end

	remove_items_with_same_rout_id_set (a_rout_id_set: ROUT_ID_SET)
			-- Remove info about object relative once associated with Current and an item of `a_rout_id_set'
		require
			a_rout_id_set_not_void: a_rout_id_set /= Void
		local
			c: like cursor
		do
			c := cursor
			from
				start
			until
				after
			loop
				if item.rout_id_set.same_as (a_rout_id_set) then
					remove
				else
					forth
				end
			end
			if valid_cursor (c) then
				go_to (c)
			end
		ensure
			count: old count = count or old count = count + 1
		end

feature -- Access

	item_of_body_index (bid: INTEGER): like item
			-- Info about object relative once associated with Current and `bid'
		local
			c: like cursor
		do
			c := cursor
			from
				start
			until
				after or Result /= Void
			loop
				Result := item
				if Result.routine.body_index /= bid then
					Result := Void
				end
				forth
			end
			go_to (c)
		end

	attribute_of_body_index (bid: INTEGER): detachable ATTRIBUTE_I
			-- Info about object relative once associated with Current and `bid'
		local
			c: like cursor
			l_info: like item
		do
			c := cursor
			from
				start
			until
				after or Result /= Void
			loop
				l_info := item
				if l_info.called_body_index = bid then
					Result := l_info.called_attribute_i
				elseif l_info.exception_body_index = bid then
					Result := l_info.exception_attribute_i
				elseif l_info.result_body_index = bid then
					check has_result: l_info.has_result end
					Result := l_info.result_attribute_i
				end
				forth
			end
			go_to (c)
		end

	item_of_rout_id (rid: INTEGER): like item
			-- Info about object relative once associated with Current and `a_once_routine_id'
		local
			c: like cursor
		do
			c := cursor
			from
				start
			until
				after or Result /= Void
			loop
				Result := item
				if not Result.rout_id_set.has (rid) then
					Result := Void
				end
				forth
			end
			go_to (c)
		end

	first_item_with_same_rout_id_set (a_rout_id_set: ROUT_ID_SET): like item
			-- Item associated with object relative once with routine ID in `rout_id_set'.
		local
			c: like cursor
		do
			c := cursor
			from
				start
			until
				after or Result /= Void
			loop
				if item.rout_id_set.same_as (a_rout_id_set) then
					Result := item
				else
					forth
				end
			end
			go_to (c)
		ensure
			single_matched: Result /= Void implies items_with_same_rout_id_set (a_rout_id_set).count = 1
		end

	items_with_same_rout_id_set (a_rout_id_set: ROUT_ID_SET): LINKED_LIST [like item]
			-- All items associated with object relative once with routine ID in `rout_id_set'.
		local
			c: like cursor
		do
			c := cursor
			create Result.make
			from
				start
			until
				after
			loop
				if item.rout_id_set.same_as (a_rout_id_set) then
					Result.extend (item)
				end
				forth
			end
			go_to (c)
		end

	first_item_intersecting_with_rout_id_set (a_rout_id_set: ROUT_ID_SET): like item
			-- First info associated with object relative once with routine ID in `rout_id_set'.
		require
			a_rout_id_set_not_void: a_rout_id_set /= Void
		local
			c: CURSOR
		do
			c := cursor
			from
				start
			until
				after or Result /= Void
			loop
				if item.rout_id_set.intersect (a_rout_id_set) then
					Result := item
				else
					forth
				end
			end
			go_to (c)
		end

	items_intersecting_with_rout_id_set (a_rout_id_set: ROUT_ID_SET): LINKED_LIST [like item]
			-- All info associated with object relative once with routine ID in `rout_id_set'.
		require
			a_rout_id_set_not_void: a_rout_id_set /= Void
		local
			c: CURSOR
		do
			c := cursor
			create Result.make
			from
				start
			until
				after
			loop
				if item.rout_id_set.intersect (a_rout_id_set) then
					Result.extend (item)
				end
				forth
			end
			go_to (c)
		end

	attribute_of_feature_name_id (a_feature_name_id: INTEGER): detachable ATTRIBUTE_I
			-- Attribute of feature name id `a_feature_name_id'
		local
			c: like cursor
		do
			c := cursor
			from
				start
			until
				after or Result /= Void
			loop
				Result := item.attribute_of_feature_name_id (a_feature_name_id)
				forth
			end
			go_to (c)
		end

	attribute_of_feature_id (a_feature_id: INTEGER): detachable ATTRIBUTE_I
			-- Attribute of feature id `a_feature_id'
		local
			c: like cursor
		do
			c := cursor
			from
				start
			until
				after or Result /= Void
			loop
				Result := item.attribute_of_feature_id (a_feature_id)
				forth
			end
			go_to (c)
		end

	attribute_of_routine_id (a_routine_id: INTEGER): detachable ATTRIBUTE_I
			-- Attribute of routine id `a_routine_id'
		local
			c: like cursor
		do
			c := cursor
			from
				start
			until
				after or Result /= Void
			loop
				Result := item.attribute_of_routine_id (a_routine_id)
				forth
			end
			go_to (c)
		end

feature -- Element changes

	update_items_intersecting_with_rout_id_set (a_rout_id_set: ROUT_ID_SET; fi: FEATURE_I)
			-- Replace all items associated with `a_rout_id_set'
		require
			a_rout_id_set_not_void: a_rout_id_set /= Void
		local
			c: CURSOR
		do
			c := cursor
			from
				start
			until
				after
			loop
				if item.rout_id_set.intersect (a_rout_id_set) then
					if item.routine /= fi then
						replace (item.updated_with (fi))
					end
				end
				forth
			end
			go_to (c)
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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

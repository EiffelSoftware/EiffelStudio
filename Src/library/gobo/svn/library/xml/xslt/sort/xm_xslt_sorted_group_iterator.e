indexing

	description:

		"Objects that render a sorted iteration of groups"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class	XM_XSLT_SORTED_GROUP_ITERATOR

inherit

	XM_XSLT_GROUP_ITERATOR [XM_XPATH_ITEM]
		undefine
			is_last_position_finder, last_position
		end

	XM_XSLT_SORTED_ITERATOR
		redefine
			make, build_array, another
		end

create

	make

feature {NONE} -- Initialization

	make (a_context: XM_XSLT_EVALUATION_CONTEXT;
			a_base_iterator: XM_XSLT_GROUP_ITERATOR [XM_XPATH_ITEM];
			some_sort_keys: DS_ARRAYED_LIST [XM_XSLT_FIXED_SORT_KEY_DEFINITION]) is
			-- Establish invariant
		do
			group_iterator := a_base_iterator
			Precursor (a_context, a_base_iterator, some_sort_keys)
		end

feature -- Access

	current_grouping_key: XM_XPATH_ATOMIC_VALUE is
			-- Grouping key for current group;
			-- (or `Void' for group-starting/ending-with)
		do
			Result := node_keys.item (index).as_group_sort_record.current_grouping_key
		end

feature -- Evaluation

	current_group_iterator: XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM] is
			-- Iterator over the members of the current group, in population order.
		do
			check
				group_sort_record: node_keys.item (index).is_group_sort_record
				-- `build_array' assures this
			end
			Result := node_keys.item (index).as_group_sort_record.current_group_iterator.another
		end

feature -- Duplication

	another: like Current is
			-- Another iterator that iterates over the same items as the original
		do

			-- Make sure the sort has been done, so that multiple iterators over the
			--  same sorted data only do the sorting once.

			if not count_determined then perform_sorting end

			-- The new iterator is the same as the old one,
			--  except for its start position.

			create Result.make (context, group_iterator.another, sort_keys)
			Result.set_count (count)
			Result.set_node_keys (node_keys)
		ensure then
			not is_error implies count_determined			
		end

feature {NONE} -- Implementation

	group_iterator: XM_XSLT_GROUP_ITERATOR [XM_XPATH_ITEM]
			-- Sequence to be sorted

	build_array is
			-- Build `node_keys'.
		local
			l_item: DS_CELL [XM_XPATH_ITEM]
			l_cursor: DS_ARRAYED_LIST_CURSOR [XM_XSLT_FIXED_SORT_KEY_DEFINITION]
			l_sort_record: XM_XSLT_GROUP_SORT_RECORD
			l_key_list: DS_ARRAYED_LIST [XM_XPATH_ATOMIC_VALUE]
			l_sort_key: XM_XPATH_ATOMIC_VALUE
			l_new_context: like context
		do
			create node_keys.make_default

			-- This provides the context for evaluating the sort key:
			-- Note that current() must return the node being sorted.

			l_new_context := context.new_context
			l_new_context.set_current_iterator (base_iterator)
			l_new_context.set_current_group_iterator (group_iterator)
			
			-- Initialize the array with data.

			from
				group_iterator.start
			until
				group_iterator.is_error or else group_iterator.after
			loop
				if node_keys.is_full then
					node_keys.resize (node_keys.count * 2)
				end
				from
					create l_key_list.make (sort_keys.count)
					l_cursor := sort_keys.new_cursor; l_cursor.start
				until
					l_cursor.after
				loop
					create l_item.make (Void)
					l_cursor.item.sort_key.evaluate_item (l_item, l_new_context)
					if l_item.item /= Void then
						l_sort_key := l_item.item.as_atomic_value
					else
						l_sort_key := Void  -- = () - an empty sequence
					end
					l_key_list.put_last (l_sort_key)
					l_cursor.forth
				end

				-- Make the sort stable by adding the record number.

				count := count + 1

				-- next line is the only difference from the Precursor
				-- (apart from the type of `l_sort_record',
				--  the use of `group_iterator' for `base_iterator' throughout)
				--  and the setting and saving of the current group iterator).

				create l_sort_record.make (group_iterator.item, l_key_list, count,group_iterator.current_grouping_key, group_iterator.current_group_iterator)
				node_keys.put_last (l_sort_record)
				group_iterator.forth
			end
			if group_iterator.is_error then
				context.transformer.report_fatal_error (group_iterator.error_value)
			end
			count_determined := True
		end

invariant

	group_iterator: group_iterator = base_iterator

end
	

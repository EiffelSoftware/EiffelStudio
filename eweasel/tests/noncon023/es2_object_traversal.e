note
	description: "Summary description for {ES2_OBJECT_TRAVERSAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES2_OBJECT_TRAVERSAL

inherit {NONE}
	INTERNAL

feature {NONE} -- Basic operations

	traverse_object (an_object: ANY)
		require
			an_object_attached: an_object /= Void
		do
			if attached {SPECIAL [detachable ANY]} an_object as l_special then
				traverse_special (l_special)
			elseif attached {TUPLE} an_object as l_tuple then
				traverse_tuple (l_tuple)
			else
				traverse_fields (an_object)
			end
		end

	process_field (an_object: ANY; a_field_index: INTEGER)
		require
			an_object_attached: an_object /= Void
			an_object_not_special: not is_special (an_object)
			valid_field_index: 1 <= a_field_index and a_field_index <= field_count (an_object)
		deferred
		end

	process_special_field (a_special: SPECIAL [detachable ANY]; a_field: INTEGER)
		require
			a_special_attached: a_special /= Void
			valid_field: 0 <= a_field and a_field < a_special.count
		deferred
		end

	process_tuple_field (a_tuple: TUPLE; a_field: INTEGER)
			--
		require
			a_tuple_attached: a_tuple /= Void
			valid_field: 1 <= a_field and a_field <= a_tuple.count
		deferred
		end

feature {NONE} -- Implementation

	traverse_special (a_special: SPECIAL [detachable ANY])
		local
			i, l_count: INTEGER
		do
			from
				i := 0
				l_count := a_special.count
			until
				i >= l_count
			loop
				process_special_field (a_special, i)
				i := i + 1
			end
		end

	traverse_tuple (a_tuple: TUPLE)
		local
			i, l_count: INTEGER
		do
			from
				i := 1
				l_count := a_tuple.count
			until
				i > l_count
			loop
				process_tuple_field (a_tuple, i)
				i := i + 1
			end
		end

	traverse_fields (an_object: ANY)
			--
		require
			an_object_attached: an_object /= Void
		local
			l_count, i: INTEGER
		do
			from
				i := 1
				l_count := field_count (an_object)
			until
				i > l_count
			loop
				process_field (an_object, i)
				i := i + 1
			end
		end

end

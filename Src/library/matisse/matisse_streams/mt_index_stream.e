indexing
	description: "MATISSE-Eiffel Binding";
	date: "$Date$";
	revision: "$Revision$"

class 
	MT_INDEX_STREAM 

inherit 
	MT_STREAM

	MT_INDEX_STREAM_EXTERNAL

	MT_CONSTANTS
	
Creation 
	make, make_from_index

feature {MT_ENTRYPOINT} -- Implementation

	make (index_name: STRING; one_class: MT_CLASS; direction: INTEGER;
			crit_start_array, crit_end_array: ARRAY [ANY]) is
			-- Open Stream.
		require
			index_name_not_void: index_name /= Void
			index_name_not_empty: not index_name.is_empty
			direction_is_direct_or_reverse: direction = Mt_Direct or else direction = Mt_Reverse
			index_criteria_supplied: crit_start_array /= Void and crit_end_array /= Void
		local
			c_index_name, c_class_name: ANY
			c_crit_start_array, c_crit_end_array: ARRAY [POINTER]
			one_string: STRING
			c_one_string: ANY
			i: INTEGER
		do
			c_index_name := index_name.to_c
			c_class_name := one_class.name.to_c

			!! c_crit_start_array.make (crit_start_array.lower, crit_start_array.upper)
			!! c_crit_end_array.make (crit_end_array.lower, crit_end_array.upper)

			from 
				i:= crit_start_array.lower 
			until 
				i=crit_start_array.upper + 1 
			loop
				if crit_start_array.item (i) /= Void then
					one_string ?= crit_start_array.item (i)
					if one_string /= Void then
					c_one_string := one_string.to_c
					c_crit_start_array.put ($c_one_string, i)
				else
					-- should be cases for other types, e.g. DATE
				end
			end
			if crit_end_array.item (i) /= Void then
				one_string ?= crit_end_array.item (i)
				if one_string /= Void then
					c_one_string := one_string.to_c
					c_crit_end_array.put($c_one_string,i)
				else
					-- should be cases for other types, e.g. DATE
				end
			end
			i := i + 1
		end
		c_stream := c_open_index_entries_stream_by_name ($c_index_name, $c_class_name,
						direction, $c_crit_start_array, $c_crit_end_array, 0)
	end


	make_from_index (an_index: MT_INDEX) is
		require
			index_not_void: an_index /= Void
		local
			c_crit_start_array, c_crit_end_array: ARRAY [POINTER];
			sv, ev: ANY
			one_string: STRING
			i, class_oid: INTEGER
			c_one_string: ANY
		do
			!! c_crit_start_array.make (0, an_index.criteria_count - 1)
			!! c_crit_end_array.make (0, an_index.criteria_count - 1)
			from
				i := 0
			until
				i = an_index.criteria_count
			loop
				sv := an_index.criteria.item (i).start_value
				if sv /= void then
					one_string ?= sv
					if one_string /= void then
						c_one_string := one_string.to_c
						c_crit_start_array.put ($c_one_string, i)
					else
						c_crit_start_array.put ($sv, i)
					end
				end
				ev := an_index.criteria.item (i).end_value
				if ev /= void then
					one_string ?= ev
					if one_string /= void then
						c_one_string := one_string.to_c
						c_crit_end_array.put ($c_one_string, i)
					else
						c_crit_end_array.put ($ev, i)
					end
				end
				i := i + 1
			end

			if an_index.constraint_class /= Void then
				class_oid := an_index.constraint_class.oid
			end
			
			c_stream := c_open_index_entries_stream (an_index.oid, class_oid, 
					an_index.scan_direction, an_index.criteria_count,
					$c_crit_start_array, $c_crit_end_array, 0)
		end
		
end -- class MT_INDEX_STREAM

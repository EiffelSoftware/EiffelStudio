class MT_INDEX_STREAM 

inherit 

	MT_STREAM
		export {ANY} mtdirect,mtreverse
		end

	MT_INDEX_STREAM_EXTERNAL

Creation 

	make

feature -- Access

	next_object : MT_OBJECT is
		-- Get Next object in stream
		local
			noid : INTEGER
		do
			noid := c_next_object(sid) 
			!!Result.make(noid)
		end -- next object

feature {MT_ENTRYPOINT} -- Implementation

	make(index_name : STRING;one_class : MT_CLASS;direction : INTEGER;
crit_start_array, crit_end_array:ARRAY[ANY]) is
		-- Open Stream
		require
			index_name_not_void : index_name /= Void
			index_name_not_empty : not index_name.empty
			direction_is_direct_or_reverse : direction = MTDIRECT or else direction = MTREVERSE
Index_criteria_supplied: crit_start_array /= Void and crit_end_array /= Void
		local
			c_index_name,c_class_name : ANY
c_crit_start_array, c_crit_end_array:ARRAY[POINTER]
one_string:STRING
c_one_string:ANY
i:INTEGER
		do
			c_index_name := index_name.to_c
			c_class_name := one_class.name.to_c

!!c_crit_start_array.make(crit_start_array.lower, crit_start_array.upper)
!!c_crit_end_array.make(crit_end_array.lower, crit_end_array.upper)

-- convert ARRAY[ANY] to ARRAY[POINTER]
from i:= crit_start_array.lower until i=crit_start_array.upper+1 loop
	if crit_start_array.item(i) /= Void then
		one_string ?= crit_start_array.item(i)
		if one_string /= Void then
			c_one_string := one_string.to_c
			c_crit_start_array.put($c_one_string,i)
		else
			-- should be cases for other types, e.g. DATE
		end
	end
	if crit_end_array.item(i) /= Void then
		one_string ?= crit_end_array.item(i)
		if one_string /= Void then
			c_one_string := one_string.to_c
			c_crit_end_array.put($c_one_string,i)
		else
			-- should be cases for other types, e.g. DATE
		end
	end
	i:= i+1
end

			sid := c_open_index_stream($c_index_name,$c_class_name,direction,
$c_crit_start_array, $c_crit_end_array)
		end -- make

end -- class MT_INDEX_STREAM

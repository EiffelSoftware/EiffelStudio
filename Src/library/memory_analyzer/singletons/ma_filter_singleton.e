indexing
	description: "[
					Objects that is a filter that filter out the
					information (classes, memory cost) we don't care.
																			]"
	date: "$Date$"
	revision: "$Revision$"
	
class
	MA_FILTER_SINGLETON 

create
	make
	
feature {NONE} -- Initialization
	
	make is
			-- Creation method.
		do
			create item_and_filter_names.make (1)
		end
	
feature  -- Filter

	filter_class (a_class_name: STRING): BOOLEAN is
			-- Filter for Classs which we don't care, if we don't want the class then return True, else False.
		require
			a_class_name_valid: a_class_name.count > 0
		do
			from 
				item_and_filter_names.start
			until
				item_and_filter_names.after or
				Result = True
			loop
				if (item_and_filter_names.item_for_iteration [1]).is_equal (a_class_name) and
					 item_and_filter_names.item_for_iteration.boolean_item (2) then
					Result := True	
				end
					
				debug ("larry")
					if a_class_name.is_equal ("XML_GRAPH_ROUTINES") then
						io.put_string ("%N MA_FILTER_SINGLETON a_class_name is: " + (item_and_filter_names.item_for_iteration [1]).out + " " + a_class_name.out + " RESULT IS:" + Result.out)
						io.put_string ("%N MA_FILTER_SINGLETON: " + (item_and_filter_names.item_for_iteration [1]).out + " " + item_and_filter_names.item_for_iteration.boolean_item (2).out)
					end
				end
				item_and_filter_names.forth
			end
		end

feature {MA_FILTER_WINDOW} -- Implementation

	item_and_filter_names: DS_HASH_TABLE [TUPLE [STRING, BOOLEAN, STRING], INTEGER]
			-- The hash table of grid items and filter datas. The second argument is the grid item index.
			-- In the tuple, first argument is Class Name, second is Selected to Filter, third is the Description.
		
invariant

	item_and_filter_names_not_void: item_and_filter_names /= Void

end

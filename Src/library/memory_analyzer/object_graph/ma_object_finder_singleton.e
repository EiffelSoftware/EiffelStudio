indexing
	description: "singleton for find objects in the system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_OBJECT_FINDER_SINGLETON
	
inherit
	MA_SINGLETON_FACTORY
	
feature 

	find_objects_by_object_name (a_object_name:STRING): ANY is
			-- Only the field name can be found (not include local instance names).
		require
			a_object_name_not_void: a_object_name /= Void or not a_object_name.is_equal ("")
		local
			l_ht:HASH_TABLE [ARRAYED_LIST[ANY],INTEGER]
			l_list:ARRAYED_LIST[ANY]
			l_inter :INTERNAL
			l_field_count,i:INTEGER
			l_item: ANY
		do
			create l_inter
				l_ht:=	memory.memory_map
			from 
				l_ht.start
			until
				l_ht.after
			loop
				l_list := l_ht.item_for_iteration
				
				from 
					l_list.start
				until
					l_list.after
				loop
					l_item := l_list.item
					if  l_item /= Void then
						--show item's field name
						l_field_count:=l_inter.field_count (l_item)
						
						from 
							i := 1
						until
							i > l_field_count
						loop
							if a_object_name.is_equal(l_inter.field_name (i, l_item)) then
								-- the class with a_object_name founded
							Result := l_inter.field (i, l_item)
							l_list.finish

							end
							i := i + 1
						end
					end
					l_list.forth
				end
				l_ht.forth
			end
		end
	
	find_key_for_type (a_type_name: STRING): INTEGER is
			-- Calculate the key of a class base on the type name.
		local
			l_inter : INTERNAL
			l_hash : HASH_TABLE [INTEGER,INTEGER]
			l_end_loop : BOOLEAN
		do
			l_hash := 	memory.memory_count_map
			from 
				create l_inter
				l_end_loop := False
				l_hash.start
			until
				l_hash.after or l_end_loop
			loop
				if l_inter.type_name_of_type (l_hash.key_for_iteration).is_equal(a_type_name) then
					Result := l_hash.key_for_iteration	
					l_end_loop := True
				end
				l_hash.forth
			end
		end
	
	find_objects_by_type_name(a_type_name: STRING):ANY is
			--Find the SPECIAL[ANY] which represent a group of object have the same type.
		local
			l_ht: HASH_TABLE [ARRAYED_LIST[ANY], INTEGER]
			l_list: ARRAYED_LIST[ANY]
		do
				l_ht:=	memory.memory_map
				from 
					l_ht.start
				until
					l_ht.after
				loop
				
					l_list := l_ht.item_for_iteration
					
					from 
						l_list.start
					until
						l_list.after or Result /= Void
					loop
						if l_list.item /= Void and then l_list.item.generating_type.is_equal (a_type_name) then
							Result := l_list.item
						end
	
						l_list.forth
					end
					l_ht.forth
				end
		end	
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

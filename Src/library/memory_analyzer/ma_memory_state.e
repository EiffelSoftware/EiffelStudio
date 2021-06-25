note
	description: "Represent a memory state, it contain the informations of all type names and the count of them."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_MEMORY_STATE

create
	make_with_memory_map

feature {NONE} -- Initialization

	make_with_memory_map (a_memory_map: HASH_TABLE [INTEGER, INTEGER])
			-- Initialize `Current'.
			--| a_memory_map:  type_id -> number of instances of type_id present in system
		require
			a_memory_map_not_void: a_memory_map /= Void
		local
			l_inter: INTERNAL
			l_mem: MEMORY
		do
			from
				create l_inter
				create l_mem
				create objects_states.make (100)
				a_memory_map.start
			until
				a_memory_map.after
			loop
				objects_states.extend ([l_inter.type_name_of_type (a_memory_map.key_for_iteration), a_memory_map.item_for_iteration])
				a_memory_map.forth
			end
			objects_count_number := objects_count (a_memory_map)
			memory_eiffel_used := l_mem.memory_statistics ({MEM_CONST}.eiffel_memory).used
			memory_c_used := l_mem.memory_statistics ({MEM_CONST}.c_memory).used
		ensure
			objects_state_set: objects_states /= Void
			objects_count_number_set: True
			memory_eiffel_used_set: True
			memory_c_used_set: True
		end

feature -- Measurrment

	item_found_count: INTEGER
			-- after routine found_type, return the count of founded item
		require
			founded_type_not_void: founded_type /= Void
		do
			if attached item_founded as l_item_founded then
				Result := l_item_founded.count_in_system
			end
		end

	memory_used_eiffel: INTEGER
			-- used eiffel memory of this state
		do
			Result := memory_eiffel_used
		end

	memory_used_c: INTEGER
			-- used c memory of this state
		do
			Result := memory_c_used
		end

feature -- Status report

	found_type (a_type_name: STRING): BOOLEAN
			-- if the state have the type of type_name
		do
			from
				objects_states.start
			until
				objects_states.after or Result = True
			loop
				if objects_states.item.type_name.is_equal (a_type_name) then
					Result := True
					item_founded := objects_states.item
				end
				objects_states.forth
			end
		end

	founded_type: like item_founded
			-- the founded type by routine found_type
		do
			Result := item_founded
		ensure
			Result = item_founded
		end

	objects_total_count: INTEGER
			-- the total number of objects
		do
			Result := objects_count_number
		end

feature -- Compare

	compare (a_state: like Current): ARRAYED_LIST [like state]
			-- compare Current with a_state
			-- result indicate type name and changed amount
		require
			a_state_not_void: a_state /= Void
		local
			l_count_change: INTEGER
		do
			create Result.make (10)
			across
				objects_states as ic
			loop
				if attached ic as l_item then
					if a_state.found_type (l_item.type_name) then
						l_count_change := a_state.item_found_count - l_item.count_in_system
						if l_count_change /= 0 then
							Result.extend ([l_item.type_name, l_count_change])
						end
					else
						Result.extend ([l_item.type_name, - l_item.count_in_system])
					end
				end
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	objects_count (a_table: HASH_TABLE [INTEGER, INTEGER]): INTEGER
			-- count the total objects
		require
			a_table_not_void: a_table /= Void
		do
			⟳ i: a_table ¦ Result := Result + i ⟲
		end

	objects_count_number: INTEGER
			-- the total number of objects in current state

	memory_eiffel_used: INTEGER
			-- eiffel memory used of this state

	memory_c_used: INTEGER
			-- c memory used of this state

	item_founded: detachable like state
			-- the founded item by routine found_type

	state: TUPLE [type_name: STRING; count_in_system: INTEGER]
			-- [type_name_of_type, number of instances of type_name_of_type present in system]
		require
			callable: False
		do
				-- Used as anchor type!
			check False then end
		end

	objects_states: ARRAYED_LIST [like state];
	-- The count the objects, first argument is type name, second argument is the object instances count

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

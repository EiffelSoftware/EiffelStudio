indexing
	description: "Class which redefine the notion of hash_table%
				%in order to be able to use it in a Matisse database.%
				%If you have an attribute of type HASH_TABLE and you want%
				%to store/retreive from the database, you must%
				%switch to MT_HASH_TABLE."
	note: "Look at the example about hash_table."
	date: "$Date$"
	revision: "$Revision$"

class
	MT_HASH_TABLE [G, H -> HASHABLE]

inherit
	HASH_TABLE [G, H]
		rename
			put as ht_put,
			force as ht_force,
			extend as ht_extend,
			replace as ht_replace,
			replace_key as ht_replace_key,
			remove as ht_remove,
			clear_all as ht_clear_all
		end

	HASH_TABLE [G, H]
		redefine
			put, force, extend,
			replace, replace_key,
			remove, clear_all
		select
			put, force, extend,
			replace, replace_key,
			remove, clear_all
		end

	MT_RS_CONTAINABLE
		undefine 
			is_equal, copy,	load_successors
		end

	MT_CONTAINER_OBJECT
	
creation
	make

feature -- Redefinition of HASH_TABLE API

	put (new: G; key: H) is
		local
			mt_obj: MT_STORABLE
		do
			relationship.database.mark_container_modified (oid)
			ht_put (new, key)
				-- ht_put is necessary for 'load_successors'
			if is_persistent and then inserted then
				mt_obj ?= new
				if mt_obj /= Void then
					check_persistence (mt_obj)
				end
				mt_obj ?= key
				if mt_obj /= Void then
					check_persistence (mt_obj)
				end
			end
		end
	
	force (new: G; key: H) is
		local
			mt_obj: MT_STORABLE
		do
			relationship.database.mark_container_modified (oid)
			ht_force (new, key)
			if is_persistent then
				mt_obj ?= new
				if mt_obj /= Void then
					check_persistence (mt_obj)
				end
				mt_obj ?= key
				if mt_obj /= Void then
					check_persistence (mt_obj)
				end
			end
		end
	
	extend (new: G; key: H) is
		local
			mt_obj: MT_STORABLE
		do
			relationship.database.mark_container_modified (oid)
			ht_extend (new, key)
			if is_persistent then
				mt_obj ?= new
				if mt_obj /= Void then
					check_persistence (mt_obj)
				end
				mt_obj ?= key
				if mt_obj /= Void then
					check_persistence (mt_obj)
				end
			end
		end
	
	replace (new: G; key: H) is
		local
			mt_obj: MT_STORABLE
		do
			relationship.database.mark_container_modified (oid)
			ht_replace (new, key)
			if is_persistent and then replaced then
				mt_obj ?= new
				if mt_obj /= Void then
					check_persistence (mt_obj)
				end
				mt_obj ?= key
				if mt_obj /= Void then
					check_persistence (mt_obj)
				end
			end
		end
	
	replace_key (new_key: H; old_key: H) is
		local
			mt_obj: MT_STORABLE
		do
			relationship.database.mark_container_modified (oid)
			ht_replace_key (new_key, old_key)
			if is_persistent and then replaced then
				mt_obj ?= new_key
				if mt_obj /= Void then
					check_persistence (mt_obj)
				end
				mt_obj ?= old_key
				if mt_obj /= Void then
					check_persistence (mt_obj)
				end
			end
		end
	
	remove (key: H) is
		do
			relationship.database.mark_container_modified (oid)
			ht_remove (key)
		end
	
	clear_all is
		do
			relationship.database.mark_container_modified (oid)
			ht_clear_all
		end
	
feature {MT_STORABLE} -- Persistence

	become_persistent (a_db: MATISSE; a_predecessor: MT_STORABLE; field_position: INTEGER) is
		local
			a_mt_class: MT_CLASS
			rs: MT_MULTI_RELATIONSHIP
		do
			oid := a_db.create_new_container ("HASH_TABLE")
			a_db.register_container (Current)
			a_mt_class := a_db.mt_class_from_object (a_predecessor)
			rs ?= a_mt_class.get_relationship_by_position (field_position, a_predecessor)
			set_predecessor (a_predecessor)
			set_relationship (rs)
			a_db.append_successor (a_predecessor, field_position, Current)
			successors_loaded := True
		end

feature
	
	load_successors is
		local
			all_keys: ARRAY [H]
			all_values: ARRAY [G]
			value_indexes: ARRAY [INTEGER]
			i: INTEGER
			default_value: G
		do
	--		SM, 01/25/99: do not see the use of this line and worst, it implies errors
	--		relationship.database.clear_all_properties_when_obsolete_wo_class (predecessor)
			if not successors_loaded then
				successors_loaded := True
				if is_persistent then
					from
						start_loading
						all_keys := get_all_keys
						all_values := get_all_values
						value_indexes := get_value_indexes
						i := all_keys.lower
					until
						i > all_keys.upper
					loop
						if value_indexes.item (i) = 0 then
							ht_force (default_value, all_keys.item (i))
						else
							ht_force (all_values.item (value_indexes.item (i)), all_keys.item (i))
						end
						i := i + 1
					end
				end
			end
		end

feature {NONE} -- Loading & storing successors	

	start_loading is
		do
			oid  := c_get_single_successor (predecessor.oid, relationship.oid)
			relationship.database.register_container (Current)
		end
	
	get_all_keys: ARRAY [H] is
		local
			att, has_default_att: MT_ATTRIBUTE
			rel: MT_RELATIONSHIP
			a_default_key: H
		do
			!! att.make ("att_keys")
			Result ?= att.get_value (Current)
			if Result = Void then
				!! rel.make ("obj_keys")
				Result ?= successors (rel)
			end
		end
	
	get_all_values: ARRAY [G] is
		local
			att, has_default_att: MT_ATTRIBUTE
			rel: MT_RELATIONSHIP
			succ: ARRAY [G]
			default_key: H
			a_value, default_value: G
			att_type: INTEGER
			a_cell: CELL [G];
			any_cell: CELL [ANY]
			int_cell: CELL [INTEGER]
			float_cell: CELL [REAL]
			double_cell: CELL [DOUBLE]
		do
			!! has_default_att.make ("has_default")
			!! att.make ("att_values")
			Result ?= att.get_value (Current)
			if Result = Void then
				!! rel.make ("obj_values")
				Result ?= successors (rel)
				if has_default_att.get_boolean (Current) then
					!! rel.make ("void_key_obj_value")
					succ ?= successors (rel)
					if succ.is_empty then
						ht_put (default_value, default_key)
					else
						ht_put (succ.item (succ.lower), default_key)
					end
				end
			else
				if has_default_att.get_boolean (Current) then
					!! att.make ("void_key_att_value")
					att_type := att.dynamic_att_type (Current)
					if att_type /= Mt_nil then
						inspect att_type
						when mt_s32 then 
							!!  int_cell.put (att.get_integer (Current));
							a_cell ?= int_cell
						when mt_u32 then 
							!!  int_cell.put (att.get_unsigned_int (Current));
							a_cell ?= int_cell
						when mt_s16 then 
							!!  int_cell.put (att.get_short (Current));
							a_cell ?= int_cell
						when mt_u16 then 
							!!  int_cell.put (att.get_unsigned_short (Current));
							a_cell ?= int_cell
						when mt_float then 
							!!  float_cell.put (att.get_real (Current));
							a_cell ?= float_cell
						when mt_double then 
							!!  double_cell.put (att.get_double (Current));
							a_cell ?= double_cell
						else
							a_cell ?= any_cell;
							!!  any_cell.put (att.get_value (Current))
						end;
						ht_put (a_cell.item, default_key)
					end
				end
			end
		end

	get_value_indexes: ARRAY [INTEGER] is
		local
			att: MT_ATTRIBUTE
		do
			!! att.make ("value_index")
			Result ?= att.get_value (Current)
		end

feature {MT_HASH_TABLE} -- Loading & storing successors	

	store_updates is
		local
			keys_type, values_type: INTEGER
			all_keys: ARRAY [H]
			all_values: ARRAY [G]
			key_att, value_att, index_att, att, has_default_att: MT_ATTRIBUTE
			key_rs, value_rs, rs: MT_RELATIONSHIP
			default_key: H
			default_value: G
			i, values_count, index, key_count: INTEGER
			indexes: ARRAY [INTEGER]
			mt_keys_type, mt_values_type: INTEGER
			a_linear: ARRAYED_LIST [MT_OBJECT]
			mt_obj: MT_OBJECT
		do
			mt_keys_type := mt_property_type_of_keys
			mt_values_type := mt_property_type_of_values
			
			!! all_keys.make (1, count)
			!! all_values.make (1, count)
			!! indexes.make (1, count)
			from 
				values_count := 0
				i := keys.lower
			until 
				i = keys.upper 
			loop
				if keys.item (i) /= default_key then
					key_count := key_count + 1
					all_keys.put (keys.item (i), key_count)
					if content.item (i) = default_value then
						indexes.put (0, key_count)
					else
						index := first_index_of (content.item (i), all_values)
						if index = 0 then
							values_count := values_count + 1
							indexes.put (values_count, key_count)
							all_values.put (content.item (i), values_count)
						else
							indexes.put (index, key_count)
						end
					end
				end
				i := i + 1
			end
			
			!! has_default_att.make ("has_default")
			if has_default then
				has_default_att.set_boolean_value (Current, True)
				if is_attribute (mt_keys_type) then
					all_keys.put (default_key, count)
					if default_key_value = default_value then
						indexes.put (0, count)
					else
						index := first_index_of (default_key_value, all_values)
						if index = 0 then
							values_count := values_count + 1
							indexes.put (values_count, count)
							all_values.put (default_key_value, values_count)
						else
							indexes.put (index, count)
						end
					end
				else -- keys are relationship
					if is_attribute (mt_values_type) then 
						!! att.make ("void_key_att_value")
						if default_key_value = Void then
							att.set_string_value (Current, Mt_string, Void)
						else
							att.set_dynamic_value (Current, default_key_value)
						end
					else
						!! rs.make ("void_key_obj_value")
						!! a_linear.make (1)
						if default_key_value /= default_value then
							mt_obj ?= default_key_value
							if mt_obj /= Void then
								a_linear.extend (mt_obj)
							end
						end
						rs.set_successors (Current, a_linear)
					end
				end
			else
				has_default_att.set_boolean_value (Current, False)
			end
			
			!! index_att.make ("value_index")
			index_att.set_integer_array_value (Current, indexes)
			
			if is_attribute (mt_keys_type) then
				!! key_att.make ("att_keys")
				key_att.set_dynamic_value (Current, all_keys)
			else
				!! key_rs.make ("obj_keys")
				a_linear ?= all_keys.linear_representation
				if has_default then
					a_linear.finish
					a_linear.remove
				end
				if a_linear /= Void then
					key_rs.set_successors (Current, a_linear)
				end
			end
			
			if is_attribute (mt_values_type) then
				!! value_att.make ("att_values")
				if values_count = 0 then
					!! all_values.make (1, 0)
					value_att.set_dynamic_value (Current, all_values)
				else
					value_att.set_dynamic_value (Current, all_values.subarray (1, values_count))
				end
			else
				!! value_rs.make ("obj_values")
				if values_count = 0 then
					!! all_values.make (1, 0)
					a_linear ?= all_values.linear_representation
				else
					a_linear ?= all_values.subarray (1, values_count).linear_representation
				end
				if a_linear /= Void then
					value_rs.set_successors (Current, a_linear)
				end
			end
		end

feature {NONE} -- Implementation

	first_index_of (v: G; an_array: ARRAY [G]): INTEGER is
			-- Index of first occurence of 'v'. 
			-- 0 if none.
		require
			one_start_index: an_array.lower = 1
		local
			i, upper_bound: INTEGER
		do
			upper_bound := an_array.upper
			if an_array.object_comparison then
				if v = Void then
					Result := 0
				else
					from 
						i := an_array.lower
					until 
						i > upper_bound or else 
						  (an_array.item (i) /= Void and then an_array.item (i).is_equal (v))
					loop
						i := i + 1
					end
					if i > upper_bound then
						Result := 0
					else
						Result := i
					end
				end
			else
				from
					i := an_array.lower
				until
					i > upper_bound or else (an_array.item (i) = v)
				loop
					i := i + 1
				end
				if i > upper_bound then
					Result := 0
				else
					Result := i
				end
			end
		end
	
	mt_property_type_of_keys: INTEGER is
			-- Is the keys of the current object stored as MATISSE attribute
			-- or relationship? Return 'A' for attribute or 'R' for relationship.
		local
			keys_type: INTEGER
			str: STRING
			a_date: DATE
			default_key: H
			i: INTEGER
		do
			keys_type := dynamic_type (keys)
			if keys_type = Eif_integer_array_type then
				Result := Mt_s32_array
			elseif keys_type = Eif_real_array_type then
				Result := Mt_float_array
			elseif keys_type = Eif_double_array_type then
				Result := Mt_double_array
			else
				from
					i := keys.lower
				until
					i > keys.upper or keys.item (i) /= default_key
				loop
					i := i + 1
				end

				if i > keys.upper then
					Result := -1  -- relationship
				else
					str ?= keys.item (i)
					if str /= Void then
						Result := Mt_string_array
					else
						a_date ?= keys.item (i)
						if a_date /= Void then
							-- to be done
						else
							Result := -1 -- relationship
						end
					end
				end
			end
		end
	
	mt_property_type_of_values: INTEGER is
		-- Is the values of the current object stored as MATISSE attribute
		-- or relationship? Return 'A' for attribute or 'R' for relationship.
		local
			values_type: INTEGER
			str: STRING
			a_date: DATE
			default_value: G
			i: INTEGER
		do
			values_type := dynamic_type (content)
			if values_type = Eif_integer_array_type then
				Result := Mt_s32_array
			elseif values_type = Eif_real_array_type then
				Result := Mt_float_array
			elseif values_type = Eif_double_array_type then
				Result := Mt_double_array
			else
				from
					i := content.lower
				until
					i > content.upper or content.item (i) /= default_value
				loop
					i := i + 1
				end

				if i > content.upper then
					Result := -1
				else
					str ?= content.item (i)
					if str /= Void then
						Result := Mt_string_array
					else
						a_date ?= content.item (i)
						if a_date /= Void then
							-- to be done
						else
							Result := -1
						end
					end
				end
			end
		end
	
	is_attribute (a_mt_type: INTEGER): BOOLEAN is
		do
			Result := a_mt_type > 0
		end
		
	wipe_out_at_reverting is
		do
			ht_clear_all
		end
	
end -- class MT_HASH_TABLE



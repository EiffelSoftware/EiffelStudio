indexing
	description: "HASH_TABLE for the binding. %
				%Value is attribute type and key is relationship type"
	date: "$Date$"
	revision: "$Revision$"

class
	MT_AR_HASH_TABLE [G, H -> HASHABLE]

inherit
	MT_HASH_TABLE [G, H]
		redefine
			load_successors,
			store_updates,
			get_all_keys,
			get_all_values,
			put, force, extend, replace, replace_key
		end

creation
	make

feature -- Redefinition of HASH_TABLE API

	put (new: G; key: H) is
		local
			mt_obj: MT_STORABLE
		do
			relationship.database.mark_container_modified (oid)
			ht_put (new, key)
			if is_persistent and then inserted then
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
			end
		end
	
feature

	load_successors is
		local
			all_keys: ARRAY [H]
			all_values: ARRAY [G]
			value_indexes: ARRAY [INTEGER]
			i: INTEGER
			att, has_default_att: MT_ATTRIBUTE
			att_type: INTEGER
			a_cell: CELL [G]
			any_cell: CELL [ANY]
			int_cell: CELL [INTEGER]
			float_cell: CELL [REAL]
			double_cell: CELL [DOUBLE]
			void_key_value: G
			default_value: G
			default_key: H
			an_array: ARRAY [G]
			any_array: ARRAY [ANY]
		do
			relationship.database.clear_all_properties_when_obsolete_wo_class (predecessor)
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


					!! has_default_att.make ("HASH_TABLE__has_default")
					if has_default_att.get_boolean (Current) then
						!! att.make ("HASH_TABLE__void_key_att_value")
						att_type := att.dynamic_att_type (Current)
						if att_type /= Mt_nil then
							inspect att_type
							when Mt_s32 then
								!! int_cell.put (att.get_integer (Current))
								a_cell ?= int_cell
							when Mt_u32 then
								!! int_cell.put (att.get_unsigned_int (Current))
								a_cell ?= int_cell
							when Mt_s16 then
								!! int_cell.put (att.get_short (Current))
								a_cell ?= int_cell
							when Mt_u16 then
								!! int_cell.put (att.get_unsigned_short (Current))
								a_cell ?= int_cell
							when Mt_float then
								!! float_cell.put (att.get_real (Current))
								a_cell ?= float_cell
							when Mt_double then
								!! double_cell.put (att.get_double (Current))
								a_cell ?= double_cell
							else
								!! any_cell.put (att.get_value (Current))
								a_cell ?= any_cell
							end
							ht_force (a_cell.item, default_key)
						end
					end -- if has_default_att
				end
			end
		end

	store_updates is
		local
			all_keys: ARRAY [H]
			all_values: ARRAY [G]
			value_att, index_att, att, has_default_att: MT_ATTRIBUTE
			key_rs: MT_RELATIONSHIP
			default_key: H
			default_value: G
			i, values_count, index, key_count: INTEGER
			indexes: ARRAY [INTEGER]
			mt_keys_type, mt_values_type: INTEGER
			a_linear: ARRAYED_LIST [MT_OBJECT]
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
			
			!! has_default_att.make ("HASH_TABLE__has_default")
			if has_default then
				has_default_att.set_boolean_value (Current, True)
				!! att.make ("HASH_TABLE__void_key_att_value")
				if default_key_value = Void then
					-- this attribute should be string
					att.set_string_value (Current, Mt_string, Void)
				else
					att.set_dynamic_value (Current, default_key_value)
				end
			else
				has_default_att.set_boolean_value (Current, False)
			end
			
			!! index_att.make ("HASH_TABLE__value_index")
			index_att.set_integer_array_value (Current, indexes)
			
			!! key_rs.make ("HASH_TABLE__obj_keys")
			a_linear ?= all_keys.linear_representation
			if has_default then
				a_linear.finish
				a_linear.remove
			end
			if a_linear /= Void then
				key_rs.set_successors (Current, a_linear)
			end
			
			!! value_att.make ("HASH_TABLE__att_values")
			if values_count = 0 then
				!! all_values.make (1, 0)
				value_att.set_dynamic_value (Current, all_values)
			else
				value_att.set_dynamic_value (Current, all_values.subarray (1, values_count))
			end
		end

feature {NONE}

	get_all_keys: ARRAY [H] is
		local
			rel: MT_MULTI_RELATIONSHIP
		do
			!! rel.make ("HASH_TABLE__obj_keys")
			Result ?= successors (rel)
		end
	
	get_all_values: ARRAY [G] is
		local
			att: MT_ATTRIBUTE
		do
			!! att.make ("HASH_TABLE__att_values")
			Result ?= att.get_value (Current)
		end
end -- class MT_AR_HASH_TABLE

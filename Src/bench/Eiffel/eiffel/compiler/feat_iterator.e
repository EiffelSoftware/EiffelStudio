
-- Iterator on features

deferred class FEAT_ITERATOR

inherit

	SHARED_SERVER;
	COMPILER_EXPORTER

feature

	used_table: ARRAY [BOOLEAN]
				-- table of used body_ids

	marked_table: ARRAY [ROUT_ID_SET]
				-- table of marked body_ids

	body_index_table: BODY_INDEX_TABLE	
				-- to find a body_id from a body_index
	
	make is
			-- Initialization
		do
			body_index_table := System.body_index_table
			!! used_table.make (1, System.body_id_counter.total_count)
			!! marked_table.make (1, System.body_id_counter.total_count)
		end;

	mark_dispose is
			-- mark all the dispose functions of the system
		local
			dispose_rout_id: ROUTINE_ID
			table: ROUT_TABLE
			unit: ROUT_ENTRY
			old_position: INTEGER
			body_id: BODY_ID
		do
			dispose_rout_id := System.memory_dispose_id
			table ?= Tmp_poly_server.item (dispose_rout_id);
			from
				table.start
			until
				table.after
			loop
				unit := table.item;
				body_id := body_index_table.item (unit.body_index)
				if unit.is_attribute then
					mark_alive (body_id.id);
				else
					old_position := table.position
					mark (unit.feature_id, unit.body_index, body_id, unit.id, unit.written_in, dispose_rout_id);
					table.go_to (old_position)	
				end;
				table.forth
			end
		end
			
feature {NONE}

	mark (f: INTEGER;body_index: BODY_INDEX; body_id: BODY_ID; static_class_id: CLASS_ID; original_class_id: CLASS_ID; rout_id_val: ROUTINE_ID) is
			-- Mark feature and its redefinitions
		local
			table: ROUT_TABLE;
			old_position: INTEGER;
			unit: ROUT_ENTRY;
			body_id_unit: BODY_ID
		do
			mark_and_record (f, body_index, body_id, static_class_id, original_class_id);

			if Tmp_poly_server.has (rout_id_val) then
					-- If routine id available: this is not a deferred feature
					-- without any implementation
				table ?= Tmp_poly_server.item (rout_id_val);
				check
					table_exists: table /= Void;
				end;
				from
					table.start
				until
					table.after
				loop
					unit := table.item;
					if unit.id.associated_class.simple_conform_to (original_class_id.associated_class) then
						old_position := table.position;
						if not is_alive (unit.body_id.id) then
DEBUG ("DEAD_CODE")
	io.putstring ("marking for rout_id: ")
	io.putint (rout_id_val.id)
	io.putstring ("%N")
end
								body_id_unit := body_index_table.item (unit.body_index)
								mark (unit.feature_id, unit.body_index, body_id_unit, unit.id, unit.written_in, rout_id_val);
						end;
						table.go_to (old_position);
					end;
					table.forth
				end;
			end;
		end;

	mark_and_record (feature_id: INTEGER; body_index: BODY_INDEX; body_id: BODY_ID; actual_class_id: CLASS_ID; written_class_id: CLASS_ID) is
			-- Mark feature `feat' alive.
		local
			depend_list: FEATURE_DEPENDANCE;
			original_dependances: CLASS_DEPENDANCE
			just_born: BOOLEAN;
			like_feature: LIKE_FEATURE;
			like_Feat: FEATURE_I;
			feature_name: STRING
			static_class, written_class: CLASS_C
			depend_feature, original_feature: FEATURE_I
			-- DEBUG
			a_class: CLASS_C
		do
			just_born := not is_alive (body_id.id);
				-- Mark feature alive



DEBUG("DEAD_CODE")
	------------------------------------------
	--		DEBUG			--
	
	io.putstring ("MARKING: ")			
	a_class := actual_class_id.associated_class
	io.putstring (a_class.feature_table.feature_of_body_id (body_id).feature_name)
	io.putstring (" (bid: ")
	io.putint (body_id.id)
	io.putstring ("; fid: ")
	io.putint (feature_id)
	io.putstring (") of ")
	io.putstring (a_class.lace_class.name)
	io.putstring (" (")
	io.putint (a_class.id.id)
	io.putstring (") originally in ")
	a_class := written_class_id.associated_class
	io.putstring (a_class.lace_class.name)
	io.putstring (" (")
	io.putint (a_class.id.id)
	io.putstring (")%N")
	------------------------------------------
end

			if just_born then
				mark_alive (body_id.id);

					-- Take care of dependances
				original_dependances := Depend_server.item (written_class_id)
				depend_list := original_dependances.item (body_id)
				if depend_list /= Void then
					propagate_feature (written_class_id, body_index, body_id, depend_list);
				end;
DEBUG ("DEAD_CODE")
	io.putstring ("La depend_list contient ")
	if depend_list /= Void then
		io.putint (depend_list.count)
	else
		io.putstring ("aucun")
	end
	io.putstring (" elements.%N")
	io.putstring ("-----------------------------------------------------%N%N%N")
end
			end
DEBUG ("DEAD_CODE")
	if not just_born then
		io.putstring ("already alive%N")
	end
end
		end

	propagate_feature (written_class_id: CLASS_ID; original_body_index: BODY_INDEX; original_body_id: BODY_ID; dep: FEATURE_DEPENDANCE) is
		deferred
		end

feature

	mark_alive (body_id: INTEGER) is
			-- record feature of body_id body_id
		do
			used_table.put (True, body_id)
		end

	mark_dead (body_id: INTEGER) is
			-- forget feature of body_id body_id
		do
			used_table.put (False, body_id)
		end

	mark_treated (body_id: INTEGER; rout_id: ROUTINE_ID) is
			-- record feature of body_id body_id
		local
			tmp: ROUT_ID_SET
		do
			tmp := marked_table.item (body_id)
			if tmp = Void then
				!! tmp.make (1);
				marked_table.put (tmp, body_id)
			end
			tmp.force (rout_id)
		end

	is_alive (body_id: INTEGER): BOOLEAN is
		do
			Result := used_table.item (body_id) 
		end

	is_treated (body_id: INTEGER; rout_id: ROUTINE_ID): BOOLEAN is
		local
			tmp: ROUT_ID_SET
		do
			tmp := marked_table.item (body_id)
			Result := tmp /= Void and then tmp.has (rout_id)
		end

end

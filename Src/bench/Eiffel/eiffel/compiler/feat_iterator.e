
-- Iterator on features

deferred class FEAT_ITERATOR

inherit

	SHARED_SERVER;
	COMPILER_EXPORTER

feature

	used_table: ARRAY [BOOLEAN]
				-- table of used body_indexes

	marked_table: ARRAY [ROUT_ID_SET]
				-- table of marked rout_ids indexed by body_indexes

	make is
			-- Initialization
		do
			create used_table.make (1, System.body_index_counter.count)
			create marked_table.make (1, System.body_index_counter.count)
		end;

	mark_dispose is
			-- mark all the dispose functions of the system
		local
			dispose_rout_id: INTEGER
			table: ROUT_TABLE
			unit: ROUT_ENTRY
			old_position: INTEGER
		do
			dispose_rout_id := System.memory_dispose_id
			table ?= Tmp_poly_server.item (dispose_rout_id);
			from
				table.start
			until
				table.after
			loop
				unit := table.item;
				old_position := table.position
				mark (unit.feature_id, unit.body_index, unit.class_id, unit.written_in, dispose_rout_id);
				table.go_to (old_position)	
				table.forth
			end
		end
			
feature {NONE}

	mark (f: INTEGER;body_index: INTEGER; static_class_id: INTEGER; original_class_id: INTEGER; rout_id_val: INTEGER) is
			-- Mark feature and its redefinitions
		local
			table: ROUT_TABLE;
			old_position: INTEGER;
			unit: ROUT_ENTRY;
		do
			mark_and_record (f, body_index, static_class_id, original_class_id);

			if Tmp_poly_server.has (rout_id_val) then
debug ("DEAD_CODE")
	print ("%NMarking Poly_table `")
	print (rout_id_val)
	print ("'; for feature written in ")
	print (System.class_of_id (original_class_id).name)
	print ("%N")
end
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
					if System.class_of_id (unit.class_id).simple_conform_to (System.class_of_id (original_class_id)) then
						old_position := table.position;
						if not is_alive (unit.body_index) then
DEBUG ("DEAD_CODE")
	io.putstring ("marking for rout_id: ")
	io.putint (rout_id_val)
	io.putstring ("%N")
end
								mark (unit.feature_id, unit.body_index, unit.class_id, unit.written_in, rout_id_val);
						end;
						table.go_to (old_position);
					end;
					table.forth
				end;
debug ("DEAD_CODE")
	print ("End of marking Poly_table `")
	print (rout_id_val)
	print ("'; for feature written in ")
	print (System.class_of_id (original_class_id).name)
	print ("%N%N")
end
			end;
		end;

	mark_and_record (feature_id: INTEGER; body_index: INTEGER; actual_class_id: INTEGER; written_class_id: INTEGER) is
			-- Mark feature `feat' alive.
		local
			depend_list: FEATURE_DEPENDANCE
			original_dependances: CLASS_DEPENDANCE
			just_born: BOOLEAN
			-- DEBUG
			a_class: CLASS_C
		do
			just_born := not is_alive (body_index);
				-- Mark feature alive



DEBUG("DEAD_CODE")
	------------------------------------------
	--		DEBUG			--
	
	io.putstring ("MARKING: ")			
	a_class := System.class_of_id (actual_class_id)
	io.putstring (a_class.feature_table.feature_of_body_index (body_index).feature_name)
	io.putstring (" (bid: ")
	io.putint (body_index)
	io.putstring ("; fid: ")
	io.putint (feature_id)
	io.putstring (") of ")
	io.putstring (a_class.lace_class.name)
	io.putstring (" (")
	io.putint (a_class.class_id)
	io.putstring (") originally in ")
	a_class := System.class_of_id (written_class_id)
	io.putstring (a_class.lace_class.name)
	io.putstring (" (")
	io.putint (a_class.class_id)
	io.putstring (")%N")
	------------------------------------------
end

			if just_born then
				mark_alive (body_index);

					-- Take care of dependances
				original_dependances := Depend_server.item (written_class_id)
				depend_list := original_dependances.item (body_index)
				if depend_list /= Void then
					propagate_feature (written_class_id, body_index, depend_list);
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

	propagate_feature (written_class_id: INTEGER; original_body_index: INTEGER; dep: FEATURE_DEPENDANCE) is
		deferred
		end

feature

	mark_alive (body_index: INTEGER) is
			-- record feature of body_index
		do
			used_table.put (True, body_index)
		end

	mark_dead (body_index: INTEGER) is
			-- forget feature of body_index
		do
			used_table.put (False, body_index)
		end

	mark_treated (body_index: INTEGER; rout_id: INTEGER) is
			-- record feature of body_index
		local
			tmp: ROUT_ID_SET
		do
			tmp := marked_table.item (body_index)
			if tmp = Void then
				!! tmp.make (1);
				marked_table.put (tmp, body_index)
			end
			tmp.force (rout_id)
		end

	is_alive (body_index: INTEGER): BOOLEAN is
		do
			Result := used_table.item (body_index) 
		end

	is_treated (body_index: INTEGER; rout_id: INTEGER): BOOLEAN is
		local
			tmp: ROUT_ID_SET
		do
			tmp := marked_table.item (body_index)
			Result := tmp /= Void and then tmp.has (rout_id)
		end

end

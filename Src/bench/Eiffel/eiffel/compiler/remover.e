-- Dead code removal

class REMOVER

inherit
	FEAT_ITERATOR
		rename
			make as old_make
		redefine
			mark_alive
		end

	SHARED_EIFFEL_PROJECT

creation
	make

feature

	make is
			-- Initialization
		do
			old_make
			!! control.make
			!! array_optimizer.make
			!! inliner.make
		end

feature

	record (feat: FEATURE_I; in_class: CLASS_C) is
			-- Record Eiffel routines reachable by feature `feat' from
			-- static type `in_class'.
		local
			dep: DEPEND_UNIT
		do
			from
				!! dep.make (in_class.class_id, feat)
				control.extend (dep)
			until
				control.is_empty
			loop
				dep := control.item
				if
					not System.routine_id_counter.is_attribute (dep.rout_id) and then
					not is_treated (dep.body_index, dep.rout_id)
				then
					mark_treated (dep.body_index, dep.rout_id)
					mark (dep.body_index, dep.class_id, dep.written_in, dep.rout_id)
				end
				control.remove
			end
		ensure
			control_empty: control.is_empty
		end

feature -- Array optimization

	record_array_descendants is
		do
			array_optimizer.record_array_descendants
		end

	array_optimizer: ARRAY_OPTIMIZER

feature -- Inlining

	inliner: INLINER

feature -- Control

	control: LINKED_QUEUE [DEPEND_UNIT]
			-- Control structure for traversal in breadth first order

feature {NONE}

	propagate_feature (written_class_id: INTEGER; original_body_index: INTEGER; depend_list: FEATURE_DEPENDANCE) is
		local
			depend_unit: DEPEND_UNIT
			rout_id: INTEGER
		do
			from
				depend_list.start
			until
				depend_list.after
			loop
				depend_unit := depend_list.item
DEBUG ("DEAD_CODE")
	if depend_unit.is_special then
		io.putstring ("special%N")
	end
end
				if not depend_unit.is_special then
DEBUG ("DEAD_CODE")
	print_dep (depend_unit)
	if is_treated (depend_unit.body_index, depend_unit.rout_id) then
		io.putstring ("previously treated%N")
	end
end
					rout_id := depend_unit.rout_id
					if
						not System.Routine_id_counter.is_attribute (rout_id) and then
						not is_treated (depend_unit.body_index, rout_id)
					then
						control.extend (depend_unit)
					end

				end
				depend_list.forth
			end
				-- Array optimization
			array_optimizer.process (System.class_of_id (written_class_id), original_body_index, depend_list)
		end

	features: INTEGER
		-- Number of features for the current dot

	features_per_message: INTEGER is 50
	
	mark_alive (body_index: INTEGER) is
			-- Record feature `feat'
		do
			{FEAT_ITERATOR} Precursor (body_index)

			features := features + 1
			if features = features_per_message then
				Degree_output.put_dead_code_removal_message (features, control.count)
debug ("COUNT")
	io.error.putstring ("[")
	io.error.putint (control.count)
	io.error.putstring ("]%N")
end
				features := 0
			end
		end

feature -- for debug purpose

	print_dep (dep: DEPEND_UNIT) is
		local
			a_class: CLASS_C
		do
			a_class := System.class_of_id (dep.class_id)
			io.putstring (a_class.feature_table.feature_of_body_index (dep.body_index).feature_name)
			io.putstring (" (bid: ")
			io.putint (dep.body_index)
			io.putstring ("; rid: ")
			io.putint (dep.rout_id)
			io.putstring (") of ")
			io.putstring (a_class.lace_class.name)
			io.putstring (" (")
			io.putint (a_class.class_id)
			io.putstring (") originally in ")
			a_class := System.class_of_id (dep.written_in)
			io.putstring (a_class.lace_class.name)
			io.putstring (" (")
			io.putint (a_class.class_id)
			io.putstring (")%N")
		end
			
	dump_alive is
		local
			i, j: INTEGER
		do
			io.putstring ("Used Table:%N")
			from
				i := 1
			until
				i = used_table.upper
			loop
				io.putint (i)
				io.putstring (" : ")
				io.putbool (used_table.item (i))
				if used_table.item (i) then
					j := j + 1
				end
				io.putstring ("%N")
				i := i + 1
			end
			io.putstring ("END OF USED TABLE%N")
			io.putstring ("nb of body_index alive: ")
			io.putint (j)
			io.putstring ("%N")
		end

	dump_marked is
		local
			i, j: INTEGER
			marked: BOOLEAN
		do
			io.putstring ("Marked Table:%N")
			from
				i := 1
			until
				i = used_table.upper
			loop
				io.putint (i)
				io.putstring (" : ")
				marked := marked_table.item (i) /= Void
				io.putbool (marked)
				if marked then
					j := j + 1
				end
				io.putstring ("%N")
				i := i + 1
			end
			io.putstring ("END OF Marked TABLE%N")
			io.putstring ("nb of body_index marked: ")
			io.putint (j)
			io.putstring ("%N%N%N")
		end		

end

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
			next: FEATURE_I
			traversal_unit: TRAVERSAL_UNIT
			a_feature: FEATURE_I
			dep: DEPEND_UNIT
			static_class: CLASS_C
			body_id: BODY_ID
		do
			from
				!! dep.make (in_class.id, feat)
				control.extend (dep)
			until
				control.empty
			loop
				dep := control.item
				body_id := body_index_table.item (dep.body_index)
				if not (dep.rout_id.is_attribute or else is_alive (body_id.id)) then
					mark (dep.feature_id, dep.body_index, body_id, dep.id, dep.written_in, dep.rout_id)
				end
				control.remove
			end
		ensure
			control_empty: control.empty
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

	propagate_feature (written_class_id: CLASS_ID; original_body_index: BODY_INDEX; original_body_id: BODY_ID; depend_list: FEATURE_DEPENDANCE) is
		local
			depend_unit: DEPEND_UNIT
			body_id: BODY_ID
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
					body_id := body_index_table.item (depend_unit.body_index)
DEBUG ("DEAD_CODE")
	if is_treated (body_id.id, depend_unit.rout_id) then
		io.putstring ("previously treated%N")
	else
		print_dep (depend_unit)
	end
end
					if not is_treated (body_id.id, depend_unit.rout_id) then
						mark_treated (body_id.id, depend_unit.rout_id)
							-- we mark dead because if it was already alive and not
							-- treated then we are in the case of a double inheritance
							-- with one redefine, one rename (cf the doc I MAY write 
							-- about it)
						mark_dead (body_id.id)
debug ("DEAD_CODE")
	print ("Since it was not treated, we marked bid: ")
	print (body_id.id)
	print (" dead%N")
end
						control.extend (depend_unit)
					end

				end
				depend_list.forth
			end
				-- Array optimization
			array_optimizer.process (written_class_id.associated_class, original_body_index, original_body_id, depend_list)
		end

	features: INTEGER
		-- Number of features for the current dot

	features_per_message: INTEGER is 50
	
	mark_alive (body_id: INTEGER) is
			-- Record feature `feat'
		do
			{FEAT_ITERATOR} Precursor (body_id)

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
			body_id: BODY_ID
			a_class: CLASS_C
		do
			body_id := body_index_table.item (dep.body_index)
			a_class := dep.id.associated_class
			io.putstring (a_class.feature_table.feature_of_body_id (body_id).feature_name)
			io.putstring (" (bid: ")
			io.putint (body_id.id)
			io.putstring ("; fid: ")
			io.putint (dep.feature_id)
			io.putstring ("; rid: ")
			io.putint (dep.rout_id.id)
			io.putstring (") of ")
			io.putstring (a_class.lace_class.name)
			io.putstring (" (")
			io.putint (a_class.id.id)
			io.putstring (") originally in ")
			a_class := dep.written_in.associated_class
			io.putstring (a_class.lace_class.name)
			io.putstring (" (")
			io.putint (a_class.id.id)
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
			io.putstring ("nb of body_id alive: ")
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
			io.putstring ("nb of body_id marked: ")
			io.putint (j)
			io.putstring ("%N%N%N")
		end		

end

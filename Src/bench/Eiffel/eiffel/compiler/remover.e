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

	make (system_array_optimizer: ARRAY_OPTIMIZER; system_inliner: INLINER) is
			-- Initialization
		do
			old_make
			!! control.make
			array_optimizer := system_array_optimizer
			inliner := system_inliner
		end

feature

	record (feat: FEATURE_I; in_class: CLASS_C) is
			-- Record Eiffel routines reachable by feature `feat' from
			-- static type `in_class'.
		require
			good_argument: feat /= Void and in_class /= Void
			control_empty: control.empty
		local
			next: FEATURE_I
			traversal_unit: TRAVERSAL_UNIT
			a_feature: FEATURE_I
		do
			from
				!! traversal_unit.make (feat, in_class)
				control.extend (traversal_unit)
			until
				control.empty
			loop
				traversal_unit := control.item
				next := traversal_unit.a_feature
				if not (next.is_attribute or else is_marked (next)) then
					mark (next, traversal_unit.static_class, next.rout_id_set.first)
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

	control: LINKED_QUEUE [TRAVERSAL_UNIT]
			-- Control structure for traversal in breadth first order

feature {NONE}

	propagate_feature (written_class: CLASS_C; original_feature: FEATURE_I
						depend_list: FEATURE_DEPENDANCE) is
		local
			depend_unit: DEPEND_UNIT
			depend_feature: FEATURE_I
			static_class: CLASS_C
			unit_to_traverse: TRAVERSAL_UNIT
		do
			from
				depend_list.start
			until
				depend_list.after
			loop
				depend_unit := depend_list.item
				if not depend_unit.is_special then
					static_class := System.class_of_id (depend_unit.id)
					depend_feature := static_class.feature_table.feature_of_feature_id (depend_unit.feature_id)
					if not is_marked (depend_feature) then
debug ("DEAD_CODE_REMOVAL")
	io.error.putstring ("Propagated to ")
	io.error.putstring (depend_feature.feature_name)
	io.error.putstring (" from ")
	io.error.putstring (static_class.name)
	io.error.new_line
end
						!! unit_to_traverse.make (depend_feature, static_class)
						control.extend (unit_to_traverse)
					end
				end
				depend_list.forth
			end

			if array_optimizer /= Void then
					-- Array optimization
				array_optimizer.process (written_class, original_feature, depend_list)
			end

			if inliner /= Void then
					-- Inlining
				inliner.process (original_feature)
			end
		end

	features: INTEGER
		-- Number of features for the current dot

	features_per_message: INTEGER is 10

	mark_alive (feat: FEATURE_I; rout_id_val: ROUTINE_ID) is
			-- Record feature `feat'
		local
			deg_output: DEGREE_OUTPUT
		do
			{FEAT_ITERATOR} precursor (feat, rout_id_val)

			features := features + 1
			if features = features_per_message then
				deg_output := Degree_output
				degree_output.put_dead_code_removal_message (features, control.count)
debug ("COUNT")
	io.error.putstring ("[")
	io.error.putint (control.count)
	io.error.putstring ("]%N")
end
				features := 0
			end
		end

feature -- DLE

	dle_clean is
			-- Get rid of data structures not needed when keeping track
			-- of removed features from the extendible system.
		do
			control := Void
			array_optimizer := Void
			inliner := Void
		end

end

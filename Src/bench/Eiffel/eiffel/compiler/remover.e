
-- Dead code removal

class REMOVER

inherit

	FEAT_ITERATOR
		rename
			make as old_make,
			mark_alive as old_mark_alive
		end
	FEAT_ITERATOR
		redefine
			make, mark_alive
		select
			make, mark_alive
		end

creation

	make

feature

	make is
			-- Initialization
		do
			old_make;

			!!control.make;

			!!array_optimizer.make;

			!!inliner.make
		end;

feature

	record (feat: FEATURE_I; in_class: CLASS_C) is
			-- Record Eiffel routines reachable by feature `feat' from
			-- static type `in_class'.
		do
			iterate (feat, in_class)
		end;

feature -- Array optimization

	record_array_descendants is
		do
			array_optimizer.record_array_descendants
		end;

	array_optimizer: ARRAY_OPTIMIZER;

feature -- Inlining

	inliner: INLINER;

feature {NONE}

	control: LINKED_QUEUE [TRAVERSAL_UNIT];
			-- Control structure for traversal in breadth first order

	iterate (feat: FEATURE_I; a_class: CLASS_C) is
			--  Mark feature `feat' and dependends alive.
		require
			good_argument: feat /= Void and a_class /= Void;
			control_empty: control.empty
		local
			next: FEATURE_I;
			traversal_unit: TRAVERSAL_UNIT;
			a_feature: FEATURE_I;
		do
			from
				!!traversal_unit.make (feat, a_class);
				control.extend (traversal_unit)
			until
				control.empty
			loop
				traversal_unit := control.item;
				next := traversal_unit.a_feature;
				if not (next.is_attribute or else is_marked (next)) then
					mark (next, traversal_unit.static_class)
				end;
				control.remove
			end;
		ensure
			control_empty: control.empty
		end;

	propagate_feature (written_class: CLASS_C; original_feature: FEATURE_I;
						depend_list: FEATURE_DEPENDANCE) is
		local
			depend_unit: DEPEND_UNIT;
			depend_feature: FEATURE_I;
			static_class: CLASS_C;
			unit_to_traverse: TRAVERSAL_UNIT;
		do
			from
				depend_list.start
			until
				depend_list.after
			loop
				depend_unit := depend_list.item;
				if not depend_unit.is_special then
					static_class := System.class_of_id (depend_unit.id);
					depend_feature := static_class.feature_table.feature_of_feature_id
												(depend_unit.feature_id);
					if not is_marked (depend_feature) then
debug ("DEAD_CODE_REMOVAL")
	io.error.putstring ("Propagated to ");
	io.error.putstring (depend_feature.feature_name);
	io.error.putstring (" from ");
	io.error.putstring (static_class.class_name);
	io.error.new_line;
end;
						!!unit_to_traverse.make (depend_feature, static_class);
						control.extend (unit_to_traverse);
					end;
				end;
				depend_list.forth
			end;

				-- Array optimization
			array_optimizer.process (written_class, original_feature, depend_list);

				-- Inlining
			inliner.process (original_feature)
		end;

	dots: INTEGER;
		-- Number of dots on the current line

	features: INTEGER;
		-- Number of features for the current dot

	dots_per_line: INTEGER is 79;

	features_per_dot: INTEGER is 100;

	mark_alive (feat: FEATURE_I) is
			-- Record feature `feat'
		local
			class_name: STRING;
			temp: ROUT_ID_SET
		do
			old_mark_alive (feat);

			features := features + 1;
			if features = features_per_dot then
				io.error.putchar ('.');
debug ("COUNT")
	io.error.putstring ("[");
	io.error.putint (control.count);
	io.error.putstring ("]%N");
end
				features := 0;
				dots := dots + 1;
				if dots = dots_per_line then
					io.error.new_line;
					dots := 0
				end;
			end;
		end;

end

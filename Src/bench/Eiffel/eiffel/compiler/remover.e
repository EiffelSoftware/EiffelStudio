
-- Dead code removal

class REMOVER

inherit

	SHARED_SERVER

creation

	make

feature

	used_table: USED_TABLE;
			-- Table of used body ids

	make is
			-- Initialization
		do
			!!control.make;
			!!used_table.make;
		end;

feature

	record (feat: FEATURE_I; in_class: CLASS_C)_ is
			-- Record Eiffel routines reachable by feature `feat' from
			-- static type `in_class'.
		do
			iterate (feat, in_class)
		end;

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
				control.add (traversal_unit)
			until
				control.empty
			loop
				traversal_unit := control.item;
				next := traversal_unit.a_feature;
				if not (next.is_attribute or else is_alive (next)) then
					mark (traversal_unit)
				end;
				control.remove
			end
		ensure
			control_empty: control.empty
		end;

	mark (traversal_unit: TRAVERSAL_UNIT) is
			-- Mark feature and its redefinitions
		require
			good_argument: traversal_unit /= Void;
			not_is_attribute: not traversal_unit.a_feature.is_attribute;
		local
			rout_id_val, other_body_id: INTEGER;
			descendant_class, static_class: CLASS_C;
			f, descendant_feature: FEATURE_I;
			des_feat_table: FEATURE_TABLE;
			des_orig_table: SELECT_TABLE;
			table: ROUT_UNIT_TABLE;
			body_table: BODY_INDEX_TABLE;
			unit: ROUT_UNIT;
			c: BI_LINKABLE [ROUT_UNIT];
			redef_unit: TRAVERSAL_UNIT;
		do
			f := traversal_unit.a_feature;
			static_class := traversal_unit.static_class;
			mark_and_record (f, static_class);

			rout_id_val := f.rout_id_set.first;

			check
				(not Poly_server.has (rout_id_val)) implies f.is_deferred;
					-- Case for an non existing routine table: a deferred
					-- feature without any implementation in descendant classes
					-- leads to NO routine table.
			end;
			if Poly_server.has (rout_id_val) then
					-- If routine id available: this is not a deferred feature
					-- without any implementation
				table ?= Poly_server.item (rout_id_val);
				check
					table_exists: table /= Void;
				end;
				from
					body_table := System.body_index_table;
					c := table.first_element;
				until
					c = Void
				loop
					unit := c.item;
					if System.class_of_id (unit.id).conform_to (static_class) then
						other_body_id := body_table.item (unit.body_index);
						if not used_table.has (other_body_id) then
							descendant_class := System.class_of_id (unit.id);
							des_feat_table := descendant_class.feature_table;
							des_orig_table := des_feat_table.origin_table;
							descendant_feature := des_orig_table.item(rout_id_val);
							if not  (descendant_feature.is_none_attribute
									or else
									descendant_class.is_basic)
							then
								if descendant_feature.is_attribute then
									mark_alive (descendant_feature);
								else
									mark_and_record
										(descendant_feature, descendant_class);
								end;
							end;
						end;
					end;
					c := c.right;
				end;
			end;
		end;

	mark_and_record (feat: FEATURE_I; actual_class: CLASS_C) is
			-- Mark feature `feat' alive.
		require
			feat_exists: feat /= Void;
			actual_class_exists: actual_class /= Void;
			consistency: actual_class.conform_to (feat.written_class);
		local
			class_depend: CLASS_DEPENDANCE;
			depend_list: SORTED_TWO_WAY_LIST [DEPEND_UNIT];
			feature_table: FEATURE_TABLE;
			depend_unit: DEPEND_UNIT;
			depend_feature, original_feature: FEATURE_I;
			unit_to_traverse: TRAVERSAL_UNIT;
			static_class, written_class: CLASS_C;
			feature_name: STRING;
		do
				-- Mark feature alive
			mark_alive (feat);

				-- Take care of dependances
			written_class := feat.written_class;
			if actual_class = written_class then
				original_feature := feat;
			else
				original_feature :=
					written_class.feature_table.feature_of_body_id
															(feat.body_id);
				check
					original_feature_exists: original_feature /= Void
				end;
			end;
			feature_name := original_feature.feature_name;
			class_depend := Depend_server.item (written_class.id);
--debug ("DEAD_CODE_REMOVAL")
    io.error.putstring (feature_name);
    io.error.putstring (" from ");
    io.error.putstring (written_class.class_name);
    io.error.new_line;
--end;
			if class_depend.has (feature_name) then
				from
					depend_list := class_depend.item (feature_name);
					depend_list.start
				until
					depend_list.after
				loop
					depend_unit := depend_list.item;
					static_class := System.class_of_id (depend_unit.id);
					feature_table := static_class.feature_table;
					depend_feature := feature_table.feature_of_feature_id
													(depend_unit.feature_id);
					if not is_alive (depend_feature) then
						!!unit_to_traverse.make (depend_feature, static_class);
						control.add (unit_to_traverse);
					end;
					depend_list.forth
				end;
			end;
		ensure
			is_alive: is_alive (feat)
		end;

	mark_alive (feat: FEATURE_I) is
			-- Record feature `feat'
		require
			good_argument: feat /= Void
		do
			used_table.put (feat.body_id);
		ensure
			is_alive: is_alive (feat)
		end;

feature

	is_alive (feat: FEATURE_I): BOOLEAN is
			-- Is the feature `feat' already recorded ?
		require
			good_argument: feat /= Void
		do
			Result := used_table.has (feat.body_id)
		ensure
			is_used: Result implies used_table.has (feat.body_id)
		end;

end

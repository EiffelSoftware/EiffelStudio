-- Access for the address operator

class ACCESS_ADDRESS_AS

inherit

	ACCESS_ID_AS
		redefine
			feature_access_type, format,
			fill_calls_list, replicate
		end

creation

	make

feature

	make (s: ID_AS) is
			-- Initialization
		do
			feature_name := s;
		end;

feature -- Type check

	feature_access_type: TYPE_A is
			-- Access type for a feature
		local
			last_type, last_constrained: TYPE_A;
			last_class: CLASS_C;
			last_id: INTEGER;
			a_feature: FEATURE_I;
			access_b: ACCESS_B;
			depend_unit: DEPEND_UNIT;
		do
			last_type := context.item;
			last_constrained := context.last_constrained_type;
			last_class := last_constrained.associated_class;
			last_id := last_class.id;

			a_feature := last_class.feature_table.item (feature_name);

			if a_feature /= Void then
				if a_feature.is_attribute then
					Result ?= a_feature.type;
					Result := Result.conformance_type;
					Result := Result.instantiation_in
										(last_type, last_id).actual_type;
			   else
					Result := Pointer_type;
				end;

					-- Dependance
				!!depend_unit.make (last_id, a_feature.feature_id);
				context.supplier_ids.add (depend_unit);

					-- Access managment
				access_b := a_feature.access (Result.type_i);
				context.access_line.insert (access_b);
			end;
		end;

	

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.new_expression;
			ctxt.prepare_for_feature (feature_name, void);
			ctxt.put_special("$");
			ctxt.put_current_feature;
			if ctxt.last_was_printed then
				ctxt.commit;
			else
				ctxt.rollback
			end
		end;

feature	-- Replication
	
	fill_calls_list (l: CALLS_LIST) is
 		do
			l.add (feature_name);
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
		do
			Result := twin;
			ctxt.adapt_name (feature_name);
			Result.set_feature_name (ctxt.adapted_name);
			ctxt.stop_adaptation;
		end;

end

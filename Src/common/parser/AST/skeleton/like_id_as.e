-- Abstract description for "like id" type

class LIKE_ID_AS

inherit

	TYPE
		redefine
			has_like, format
		end;
	SHARED_LIKE_CONTROLER;

feature -- Attributes

	anchor: ID_AS;
			-- Anchor name

feature -- Initialization

	set is
			-- Yacc initialization
		do
			anchor ?= yacc_arg (0);
		ensure then
			anchor_exists: anchor /= Void
		end;

feature -- Implementation of inherited deferred features

	has_like: BOOLEAN is
			-- Has the type anchored type in its definition ?
		do
			Result := True;
		end;

	actual_type: TYPE_A is
			-- Useless
		do
			-- Do nothing
		ensure then
			False
		end;

	dump: STRING is
            -- Dump string
        do
            !!Result.make (5 + anchor.count);
            Result.append ("like ");
            Result.append (anchor);
        end;
	
	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): TYPE_A is
			-- Calculated type in function of the feauure `f' which has
			-- the type Current and the feautre table `feat_table'
			-- Case of errors: Result is Void if anchored type cannot be
			-- evaluated. If the anchor itself has anchored type in its
			-- type definition, then attribute `actual_type' of Result is Void.
		local
			anchor_feature: FEATURE_I;
			like_feature: LIKE_FEATURE;
			anchor_type, argument_type: TYPE;
			argument_position, rout_id: INTEGER;
			like_argument: LIKE_ARGUMENT;
			depend_unit: DEPEND_UNIT;
			s: STRING;
		do
			anchor_feature := feat_table.item (anchor);
			if anchor_feature /= Void then
					-- It is an anchored type on a feature: check if the
					-- anchor feature has not an anchor type itself.
				anchor_type := anchor_feature.type;
				rout_id := anchor_feature.rout_id_set.first;
				if rout_id < 0 then
						-- Anchor on attribute
					rout_id := - rout_id;
				end;

					-- Set the like controler on
				Like_control.on;
					-- Check if there is a cycle
				if Like_control.has (rout_id) or else anchor_type.is_void then
						-- Error because of cycle
					Error_handler.raise ("Like cycle");
				else
						-- Update anchored type controler
					Like_control.put (rout_id);
						-- Create instance of LIKE_FEATURE
					!!like_feature.make (anchor_feature);
					like_feature.set_rout_id (rout_id);
					like_feature.set_actual_type 
			(anchor_type.solved_type (feat_table, anchor_feature).actual_type);
					Result := like_feature;
						-- There is a dependance between `f' and the `anchor_feature'
						-- Record it for the propagation of the recompilations
					!!depend_unit.make (anchor_feature.written_in, anchor_feature.feature_id);
					context.supplier_ids.add (depend_unit);
				end;
			else
				argument_position := f.argument_position (anchor);
				if argument_position /= 0 then
						-- Found argument
					if Like_control.is_on then
							-- There cannot be any like argument targeted
							-- direclty or indirectly by a type anchored on a
							-- feature
						Error_handler.raise ("Like cycle");
					else
						if
							Like_control.arguments.has (argument_position)
						then
								-- Cycle involving anchors on arguments
							Error_handler.raise ("Like cycle");
						end;
						Like_control.arguments.put (argument_position);	
						anchor_type := f.arguments.i_th (argument_position);
						!!like_argument;
						like_argument.set_position (argument_position);
						like_argument.set_actual_type
						(anchor_type.solved_type (feat_table, f).actual_type);
						like_argument.set_argument_position
														(argument_position);
						Result := like_argument;
					end;
				else
						-- No anchor found
					Error_handler.raise ("Like_cycle");
				end;
				check
					Result_actual_type_exists: Result.actual_type /= Void
				end;
			end;
		end;


	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_keyword("like ");
			ctxt.put_string(anchor);
				-- should be changed: name adaptations, and 
				-- effective type if anchor is hidden 
				-- careful with like argument
			ctxt.commit;
		end;
end

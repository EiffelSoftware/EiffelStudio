indexing

	description:
		"Abstract description of an access to an Eiffel feature (note %
		%that this access can not be the first call of a nested %
		%expression). Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class ACCESS_FEAT_AS_B

inherit

	ACCESS_FEAT_AS
		redefine
			feature_name, parameters
		end;

	ACCESS_AS_B
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end
	SHARED_CONFIGURE_RESOURCES

feature -- Attributes

	feature_name: ID_AS_B;
			-- Name of the feature called

	parameters: EIFFEL_LIST_B [EXPR_AS_B];
			-- List of parameters

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an access to a feature
		local
			id_type: TYPE_A;
			veen: VEEN;
		do
			id_type := access_type;
			Error_handler.checksum;
			if id_type = Void then
					-- Undeclared identifier
				!!veen;
				context.init_error (veen);
				veen.set_identifier (feature_name);
				Error_handler.insert_error (veen);
					-- Cannot go on here.
				Error_handler.raise_error;
			end;
			check
				id_type_exists: id_type /= Void;
			end;
				-- Update the type stack
			context.replace (id_type);
		end;

	is_export_valid (feat: FEATURE_I): BOOLEAN is
			-- Is the call export-valid ?
		require
			good_argument: feat /= Void;
		do
			Result := feat.is_exported_for (context.a_class);
		end;

	access_type: TYPE_A is
			-- Type check an the access to an id
		local
			arg_type: TYPE_A;
			a_feature: FEATURE_I;
			i, count, argument_position: INTEGER;
				-- Id of the class type on the stack
			current_item: TYPE_A;
			last_type, last_constrained: TYPE_A;
				-- Type onto the stack
			last_id: CLASS_ID;
			context_count: INTEGER;
				-- Id of the class correponding to `last_type'
			last_class: CLASS_C;
			depend_unit: DEPEND_UNIT;
			access_b: ACCESS_B;
			vuar1: VUAR1;
			vuar2: VUAR2;
			vuex: VUEX;
			vhne: VHNE;
			vkcn3: VKCN3;
			obs_warn: OBS_FEAT_WARN;
			context_export: EXPORT_I;
			feature_export: EXPORT_I;
			like_argument_detected, vape_check: BOOLEAN;
			vape: VAPE;
			formal_type: FORMAL_A
		do
			last_type := context.item;
			if last_type.is_multi_type then
				last_type := System.instantiator.array_type_a;
				context.replace (last_type);
			end;
			last_constrained := context.last_constrained_type;

			if last_constrained.is_void then
					-- No call when target is a procedure
				!!vkcn3;
				context.init_error (vkcn3);
				Error_handler.insert_error (vkcn3);
					-- Cannot go on here
				Error_handler.raise_error;
			elseif last_constrained.is_none then
				!!vhne;
				context.init_error (vhne);
				Error_handler.insert_error (vhne);
					-- Cannot go on here
				Error_handler.raise_error;
			end;

			last_class := last_constrained.associated_class;
			last_id := last_class.id;

				-- Look for a feature in the class associated to the
				-- last actual type onto the context type stack. If it
				-- is a generic take the associated constraint.
			a_feature := last_class.feature_table.item (feature_name);
			if a_feature /= Void then
					-- Supplier dependances update
				!!depend_unit.make (last_id, a_feature.feature_id);
				context.supplier_ids.extend (depend_unit);
				
					-- Attachments type check
				count := parameter_count;
				if count /= a_feature.argument_count then
					!!vuar1;
					context.init_error (vuar1);
					vuar1.set_called_feature (a_feature);
					vuar1.set_argument_count (count);
					Error_handler.insert_error (vuar1);
						-- Cannot go on here: too dangerous
					Error_handler.raise_error;
				elseif parameters /= Void then
						-- Type check on parameters
					if context.level4 then
						vape_check := context.check_for_vape;
							-- Do not want check for vape
							-- for parameters
						context.set_check_for_vape (False);
						parameters.type_check;
						context.set_check_for_vape (vape_check);
					else
						parameters.type_check;
					end;
						-- Conformance initialization
					Argument_types.init2 (a_feature);
					from
						i := count;
						context_count := context.count - count;
					until
						i < 1
					loop
						arg_type ?= a_feature.arguments.i_th (i);
							-- Evaluation of the actual type of the
							-- argument declaration
						if arg_type.is_like_argument then
							arg_type := arg_type.conformance_type;
							arg_type := arg_type.instantiation_in
											(last_type, last_id).actual_type;
							if metamorphosis_disabled then
								like_argument_detected := arg_type.is_basic
							else
								like_argument_detected := True
							end
						else
								-- Instantiation of it in the context of
								-- the context of the target
							arg_type := arg_type.instantiation_in
											(last_type, last_id).actual_type;
						end;
							-- Conformance: take care of constrained
							-- genericity
						current_item := context.i_th (context_count + i); 
						if not current_item.conform_to (arg_type) then
							!!vuar2;
							context.init_error (vuar2);
							vuar2.set_called_feature (a_feature);
							vuar2.set_argument_position (i);
							vuar2.set_argument_name (a_feature.argument_names.i_th (i));
							vuar2.set_formal_type (arg_type);
							vuar2.set_actual_type (current_item);
							Error_handler.insert_error (vuar2);
						end;
	
							-- Insert the attachment type in the
							-- parameters line for byte code
						Attachments.insert (arg_type);
						i := i - 1;
					end;
					if like_argument_detected then
						update_argument_type (a_feature);
					end;
				end;

					-- Get the type of Current feature.
				Result ?= a_feature.type;

					-- If the declared target type is formal
					-- and if the corresponding generic parameter is
					-- constrained to a class which is also generic
					-- Result id a FORMAL_A object with no more information
					-- than the position of the formal in the generic parameter
					-- list of the class in which the feature "feature_name" is 
					-- declared.
					-- Example:
					--
					-- 	class TEST [G -> ARRAY [STRING]]
					--	...
					--	x: G
					-- 		x.item (1)
					--
					-- For the evaluation of `item', last_type is "Generic #1" (of TEST)
					-- `last_constrained_type' is ARRAY [STRING], `a_feature.type'
					-- is "Generic #1" (of ARRAY)
					-- We need to convert the type to the constrained type for proper
					-- type evaluation of remote calls.
					-- "Generic #1" (of ARRAY) is thus replaced by the corresponding actual
					-- type in the declaration of the constraint class type (in this case
					-- class STRING).
					-- Note: the following conditional instruction will not be executed
					-- if the class type of the constraint id not generic since in that
					-- case `Result' would not be formal.
				if last_type.is_formal and then Result.is_formal then
					formal_type ?= Result;
					Result := last_constrained.generics.item (formal_type.position)
				end;
				Result := Result.conformance_type;
				context.pop (count);
				Result := Result.instantiation_in (last_type, last_id).actual_type;
					-- Export validity
				if not is_export_valid (a_feature) then
					!!vuex;
					context.init_error (vuex);
					vuex.set_static_class (last_class);
					vuex.set_exported_feature (a_feature);
					Error_handler.insert_error (vuex);
				end;
				if
					a_feature.is_obsolete
						-- If the obsolete call is in an obsolete class,
						-- no message is displayed
					and then not context.a_class.is_obsolete
						-- The current feature is whether the invariant or
						-- a non obsolete feature
					and then (context.a_feature = Void or else
						not context.a_feature.is_obsolete)
				then
					!!obs_warn;
					obs_warn.set_class (context.a_class);
					obs_warn.set_obsolete_class (context.last_class);
					obs_warn.set_obsolete_feature (a_feature);
					obs_warn.set_feature (context.a_feature);
					Error_handler.insert_warning (obs_warn);
				end;
				if
					not System.do_not_check_vape and then
					context.level4 and then
					context.check_for_vape
				then
					-- In precondition and checking for vape
					context_export := context.a_feature.export_status;
					feature_export := a_feature.export_status;
debug
	io.error.putstring ("feature ");
	io.error.putstring (context.a_feature.feature_name);
	io.error.putstring (" export ");
	io.error.new_line;
	context_export.trace;
	io.error.new_line;
	io.error.putstring ("feature ");
	io.error.putstring (a_feature.feature_name);
	io.error.putstring (" export ");
	io.error.new_line;
	feature_export.trace;
	io.error.new_line;
end;
					if 
						not a_feature.feature_name.is_equal (Void_feature_name) and then
						not context_export.is_subset (feature_export) 
					then
						!!vape;
						context.init_error (vape);
						vape.set_exported_feature (a_feature);
						Error_handler.insert_error (vape);
						Error_handler.raise_error;
					end;
				end;

					-- Access managment
				access_b := a_feature.access (Result.type_i);
				context.access_line.insert (access_b);
			end;
		end;

	byte_node: ACCESS_B is
			-- Associated byte code
		local
			access_line: ACCESS_LINE;
			params: BYTE_LIST [PARAMETER_B];
			p: PARAMETER_B;
			t: TYPE_I;
			i, nb: INTEGER;
		do
			if parameters /= Void then
				from
					nb := parameters.count;
					!! params.make_filled (nb);
					i := 1;
				until
					i > nb
				loop
					!!p;
					p.set_expression (parameters.i_th (i).byte_node);
					params.put_i_th (p, i);
					i := i + 1	
				end;
					-- Attachment types are inserted in the reversal
					-- order in `Attachments' during type check
				from
					i := nb
				until
					i < 1
				loop
					params.i_th (i).set_attachment_type (Attachments.item.type_i);
					Attachments.forth;
					i := i - 1;
				end;
			end;

			access_line := context.access_line;
			Result := access_line.access;
			Result.set_parameters (params);
			access_line.forth;
		end;

	update_argument_type (feat: FEATURE_I) is
			-- Update the argument types for like_argument.
			-- Retrieve the corresponding argument type for the like
			-- argument and update the like_argument type
		local
			args: FEAT_ARG;
			arg_pos, i, nbr: INTEGER;
			type_a: TYPE_A;
			like_arg: LIKE_ARGUMENT;
			pos: INTEGER;
		do
			args := feat.arguments;
				-- Attachment types are inserted in the reversal
				-- order in `Attachments' during type check
			pos := Attachments.cursor;
			from
				i := 1;
				nbr := args.count; 
			until
				i > nbr
			loop
				like_arg ?= args.i_th (i);
				if like_arg /= Void then
					arg_pos := pos - like_arg.position + 1;
						--| Retrieve type in which like_argument is
						--| referring to.
					Attachments.go_i_th (arg_pos);
					type_a := Attachments.item;
						--| Replace item in like argument
					Attachments.go_i_th (pos - i + 1);
					if metamorphosis_disabled then
						if Attachments.item.is_basic then
								--| Replace item in like argument
							Attachments.change_item (type_a);
						end;
					else
							--| Replace item in like argument
						Attachments.change_item (type_a);
					end
				end;
				i := i + 1
			end;	
			Attachments.go_i_th (pos);
		end;
		
	Attachments: LINE [TYPE_A] is
			-- Atachement types line
		once
			Result := Context.parameters;
		end;

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.begin;
			simple_format (ctxt);
			if ctxt.last_was_printed then
				ctxt.commit
			else
				ctxt.rollback
			end;
		end;

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		local
			new_list: like l;
		do
			if l.is_new then
				l.add (feature_name);
			end;
			if parameters /= void then
			 	!!new_list.make;
				parameters.fill_calls_list (new_list);
				l.merge (new_list);
			end;
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			-- Adapt to replication
		do
			Result := clone (Current);
debug ("REPLICATION")
	io.error.putstring ("feature name before: ");
	io.error.putstring (feature_name);
	io.error.new_line;
end;
			ctxt.adapt_name (feature_name);
			Result.set_feature_name (ctxt.adapted_name);
debug ("REPLICATION")
	io.error.putstring ("feature name after: ");
	io.error.putstring (ctxt.adapted_name);
	io.error.new_line;
end;
			if parameters /= void then
				Result.set_parameters (
					parameters.replicate (ctxt.new_ctxt))
			end
		end;

feature {NONE} -- Implementation

	Void_feature_name: STRING is "void"

end -- class ACCESS_FEAT_AS_B

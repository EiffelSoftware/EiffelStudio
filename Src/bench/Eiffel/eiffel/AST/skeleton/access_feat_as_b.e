
-- Abstract description of an access to an Eiffel feature (note that this
-- access can not be the first call of a nested expression).

class ACCESS_FEAT_AS

inherit

	ACCESS_AS
		redefine
			type_check, byte_node, format
		end

feature -- Attributes

	feature_name: ID_AS;
			-- Name of the feature called

	parameters: EIFFEL_LIST [EXPR_AS];
			-- List of parameters

	parameter_count: INTEGER is
			-- Count of parameters
		do
			if parameters /= Void then
				Result := parameters.count;
			end;
		end;

feature -- Initialization

	set is
			-- Yacc initialization
		do
			feature_name ?= yacc_arg (0);
			parameters ?= yacc_arg (1);
		ensure then
			feature_name_exists: feature_name /= Void;
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an access to a feature
		local
			id_type: TYPE_A;
			veen: VEEN;
		do
			id_type := access_type;
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
			context.change_item (id_type);
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
			last_id, context_count: INTEGER;
				-- Id of the class correponding to `last_type'
			last_class: CLASS_C;
			depend_unit: DEPEND_UNIT;
			access_b: ACCESS_B;
			vuar1: VUAR1;
			vuar2: VUAR2;
			vuex: VUEX;
			vhne: VHNE;
			vkcn: VKCN;
		do
			last_type := context.item;
			last_constrained := context.last_constrained_type;

			if last_constrained.is_void then
					-- No call when target is a procedure
				!!vkcn;
				context.init_error (vkcn);
				vkcn.set_node (Current);
				Error_handler.insert_error (vkcn);
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
				context.supplier_ids.add (depend_unit);
				
					-- Attachments type check
				count := parameter_count;
				if count /= a_feature.argument_count then
					!!vuar1;
					context.init_error (vuar1);
					vuar1.set_call_body_id (a_feature.body_id);
					vuar1.set_call_written_in (a_feature.written_in);
					Error_handler.insert_error (vuar1);
						-- Cannot go on here: too dangerous
					Error_handler.raise_error;
				elseif parameters /= Void then
						-- Type check on parameters
					parameters.type_check;
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
						arg_type := arg_type.conformance_type;
							-- Instantiation of it in the context of
							-- the context of the target
						arg_type := arg_type.instantiation_in
											(last_type, last_id).actual_type;
							-- Conformance: take care of constrained
							-- genericity
						current_item := context.i_th (context_count + i); 
						if not current_item.conform_to (arg_type) then
							!!vuar2;
							context.init_error (vuar2);
							vuar2.set_call_body_id (a_feature.body_id);
							vuar2.set_call_written_in(a_feature.written_in);
							vuar2.set_argument_name
									(a_feature.argument_names.i_th (i));
							vuar2.set_formal_type (arg_type);
							vuar2.set_actual_type (current_item);
							Error_handler.insert_error (vuar2);
						end;
	
							-- Insert the attachment type in the
							-- parameters line for byte code
						Attachments.insert (arg_type);
						i := i - 1;
					end;
				end;
				Result ?= a_feature.type;
				Result := Result.conformance_type;
				context.pop (count);
				Result :=
					Result.instantiation_in (last_type, last_id).actual_type;
					-- Export validity
				if not is_export_valid (a_feature) then
					!!vuex;
					context.init_error (vuex);
					vuex.set_static_class (context.last_class);
					vuex.set_feature_name (feature_name);
					Error_handler.insert_error (vuex);
				end;
				if a_feature.is_obsolete then
					io.error.putstring ("%TWarning: ");
					io.error.putstring (a_feature.feature_name);
					io.error.putstring (" is obsolete: ");
					io.error.putstring (a_feature.obsolete_message);
					io.error.new_line;
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
					!!params.make (nb);
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
					params.i_th (i).set_attachment_type
											(Attachments.item.type_i);
					Attachments.forth;
					i := i - 1;
				end;
			end;

			access_line := context.access_line;
			Result := access_line.access;
			Result.set_parameters (params);
			access_line.forth;
		end;
		
	Attachments: LINE [TYPE_A] is
			-- Atachement types line
		once
			Result := Context.parameters;
		end;
	

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.prepare_for_feature (feature_name, parameters);
			ctxt.put_current_feature;
			if ctxt.last_was_printed then
				ctxt.commit
			else
				ctxt.rollback
			end;
	end;
					
end

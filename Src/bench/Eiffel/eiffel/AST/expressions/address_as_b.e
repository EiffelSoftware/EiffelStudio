-- Abstract description of an Eiffel function pointer

class ADDRESS_AS

inherit

	EXPR_AS
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attribute

	feature_name: FEATURE_NAME;
			-- Feature name to address

feature -- Initialization

	set is
			-- Yacc initialization
		do
			feature_name ?= yacc_arg (0);
		ensure then
			feature_name_exists: feature_name /= Void
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an address access
		local
			internal_name: ID_AS;
			vzaa1: VZAA1;
			access_address: ACCESS_ADDRESS_AS;
			hector_type: HECTOR_A;
			id_type: TYPE_A;
		do
				-- Initialization of the type stack
			context.begin_expression;

			internal_name := feature_name.internal_name;

			!!access_address.make (internal_name);
			id_type := access_address.access_type;

			if id_type = Void then
				!!vzaa1;
				context.init_error (vzaa1);
				vzaa1.set_address_name (internal_name);
				Error_handler.insert_error (vzaa1);
					-- Cannot go on here...
				Error_handler.raise_error;
			end;

			if not context.access_line.access.is_feature then
				!!hector_type.make (id_type);
				id_type := hector_type;
			end;

				-- Update the type stack
			context.change_item (id_type);
		end;

	byte_node: EXPR_B is
			-- Associated byte code
		local
			access_line: ACCESS_LINE;
			access: ACCESS_B;
			address: ADDRESS_B;
			hector: HECTOR_B;
			a_feature: FEATURE_I;
		do
			access_line := context.access_line;
			access := access_line.access;
			access_line.forth;

			if access.is_feature then
				a_feature :=
					context.feature_table.item(feature_name.internal_name);
				!!address;
				address.init (a_feature);
				Result := address;
			else
				!!hector.make (access);
				Result := hector;
			end;
		end;


	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.prepare_for_feature (feature_name.internal_name, void);
			if ctxt.is_feature_visible then
				ctxt.put_special("$");
				ctxt.put_current_feature; 	-- treat infix and prefix
				ctxt.commit;
			else
				ctxt.rollback;
			end;
		end;

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
		do
			l.add (feature_name.internal_name);
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
		do
			Result := twin;
			ctxt.adapt_name (feature_name.internal_name);
			Result.feature_name.set_name (ctxt.adapted_name);
		end;


end

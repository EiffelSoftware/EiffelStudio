-- Abstract description of an access to an Eiffel feature (note that this
-- access can not be the first call of a nested expression).

class ACCESS_FEAT_AS

inherit

	ACCESS_AS
		redefine
			simple_format
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
			if parameters /= Void then
				parameters.start
			end
		ensure then
			feature_name_exists: feature_name /= Void;
		end;

feature -- Formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.prepare_for_feature (feature_name, parameters);
			ctxt.put_current_feature;
			if ctxt.last_was_printed then
				ctxt.commit
			end;
		end;

	access_name: STRING is
		do
			Result := feature_name
		end;

feature -- Replication {ACCESS_FEAT_AS, USER_CMD, CMD}

	set_feature_name (name: like feature_name) is
		require
			valid_arg: name /= Void
		do
			feature_name := name;
		end;

	set_parameters (p: like parameters) is
		do
			parameters := p
		end;

end

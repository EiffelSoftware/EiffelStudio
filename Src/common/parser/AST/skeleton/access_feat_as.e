indexing
	description:
		"AST representation of an access to an Eiffel feature (note %
		%that this access cannot be the first call of a nested %
		%expression).";
	date: "$Date$";
	revision: "$Revision$"

class ACCESS_FEAT_AS

inherit
	ACCESS_AS
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (f: like feature_name; p: like parameters) is
			-- Create a new FEATURE_ACCESS AST node.
		require
			f_not_void: f /= Void
		do
			feature_name := f
			parameters := p
			if parameters /= Void then
				parameters.start
			end
		ensure
			feature_name_set: feature_name = f
			parameters_set: parameters = p
		end

feature {NONE} -- Initialization

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

feature -- Properties

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

	access_name: STRING is
		do
			Result := feature_name
		end;

feature -- Delayed calls

	is_delayed : BOOLEAN is
			-- Is this access delayed?
		do
			-- Default: No
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name) and
				equivalent (parameters, other.parameters)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_feature (feature_name, parameters);
			ctxt.put_current_feature;
		end;

feature {COMPILER_EXPORTER} -- Replication {ACCESS_FEAT_AS, USER_CMD, CMD}

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

end -- class ACCESS_FEAT_AS

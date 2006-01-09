indexing
	description:
		"Abstract description of an access to an Eiffel feature (note %
		%that this access cannot be the first call of a nested %
		%expression)."
	date: "$Date$"
	revision: "$Revision$"

class ACCESS_FEAT_AS

inherit
	ACCESS_AS
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like feature_name; p: like parameters) is
			-- Create a new FEATURE_ACCESS AST node.
		require
			f_not_void: f /= Void
		do
			feature_name := f
			internal_parameters := p
			if parameters /= Void then
				parameters.start
			end
		ensure
			feature_name_set: feature_name = f
			internal_parameters_set: internal_parameters = p
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_access_feat_as (Current)
		end

feature -- Attributes

	feature_name: ID_AS
			-- Name of the feature called

	parameters: EIFFEL_LIST [EXPR_AS] is
			-- List of parameters
		do
			if internal_parameters = Void or else internal_parameters.is_empty then
				Result := Void
			else
				Result := internal_parameters
			end
		end

	parameter_count: INTEGER is
			-- Count of parameters
		do
			if parameters /= Void then
				Result := parameters.count
			end
		end

	access_name: STRING is
		do
			Result := feature_name
		end

feature -- Roundtrip

	internal_parameters: EIFFEL_LIST [EXPR_AS]
			-- Internal list of parameters

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := feature_name.complete_start_location (a_list)
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if parameters /= Void then
					Result := parameters.complete_end_location (a_list)
				else
					Result := feature_name.complete_end_location (a_list)
				end
			else
				if internal_parameters /= Void then
					Result := internal_parameters.complete_end_location (a_list)
				else
					Result := feature_name.complete_end_location (a_list)
				end
			end
		end

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
				equivalent (parameters, other.parameters) and
				is_delayed = other.is_delayed
		end

feature -- Setting

	set_feature_name (name: like feature_name) is
		require
			valid_arg: name /= Void
		do
			feature_name := name
		end

	set_parameters (p: like parameters) is
		do
			internal_parameters := p
		end

end -- class ACCESS_FEAT_AS

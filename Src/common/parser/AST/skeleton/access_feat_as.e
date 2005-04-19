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
			parameters := p
			if p /= Void then
				p.start
			end
		ensure
			feature_name_set: feature_name = f
			parameters_set: parameters = p
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

	parameters: EIFFEL_LIST [EXPR_AS]
			-- List of parameters

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

feature -- Location

	start_location: LOCATION_AS is
			-- Start location of Current
		do
			Result := feature_name.start_location
		end

	end_location: LOCATION_AS is
			-- End location of Current
		do
			if parameters /= Void then
				Result := parameters.end_location
			else
				Result := feature_name.end_location
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
			parameters := p
		end

end -- class ACCESS_FEAT_AS

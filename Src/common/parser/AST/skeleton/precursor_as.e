indexing
	description:
		"Abstract description of an access to the precursor of%
		%an Eiffel feature. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class PRECURSOR_AS

inherit
	ACCESS_AS
		redefine
			is_equivalent
		end

	CLICKABLE_AST
		redefine
			is_precursor
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (pk: like precursor_keyword; n: like parent_base_class; p: like parameters) is
			-- Create a new PRECURSOR AST node.
		require
			pk_not_void: pk /= Void
			valid_n: n /= Void implies n.generics = Void
		do
			precursor_keyword := pk
			parent_base_class := n
			parameters := p
			if parameters /= Void then
				parameters.start
			end
		ensure
			precursor_keyword_set: precursor_keyword = pk
			parent_base_class_set: parent_base_class = n
			parameters_set: parameters = p
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_precursor_as (Current)
		end

feature -- Attributes

	precursor_keyword: LOCATION_AS
			-- Position of Precursor keyword

	parent_base_class: CLASS_TYPE_AS
			-- Optional name of the parent

	parameters: EIFFEL_LIST [EXPR_AS]
			-- List of parameters

	parameter_count: INTEGER is
			-- Number of parameters
		do
			if parameters /= Void then
				Result := parameters.count
			end
		end

	access_name: STRING is
		do
			-- Void because a Precursor call is like a client call but without
			-- a client, so there is no variable which is accessing the feature.
		end

	is_precursor: BOOLEAN is True
			-- Precursor makes reference to a class

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := precursor_keyword
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if parameters /= Void then
				Result := parameters.end_location
			elseif parent_base_class /= Void then
				Result := parent_base_class.start_location
			else
				Result := precursor_keyword
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (parent_base_class, other.parent_base_class) and
				equivalent (parameters, other.parameters)
		end

invariant
	precursor_keyword_not_void: precursor_keyword /= Void
	valid_parent_base_class: parent_base_class /= Void implies parent_base_class.generics = Void

end -- class PRECURSOR_AS

indexing
	description: "AST representation of a formal generic parameter. %
				%Instances produced by Yacc."
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAL_DEC_AS

inherit
	FORMAL_AS
		rename
			initialize as initialize_formal_as
		redefine
			is_equivalent,
			process
		end

feature {AST_FACTORY} -- Initialization

	initialize (f: FORMAL_AS; c: like constraint; cf: like creation_feature_list) is
			-- Create a new FORMAL_DECLARATION AST node.
		require
			f_not_void: f /= Void
		do
			name := f.name
			constraint := c
			creation_feature_list := cf
			position := f.position
			is_reference := f.is_reference
		ensure
			name_set: name = f.name
			constraint_set: constraint = c
			creation_feature_list_set: creation_feature_list = cf
			position_set: position = f.position
			is_reference_set: is_reference = f.is_reference
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_formal_dec_as (Current)
		end

feature -- Attributes

	constraint: TYPE_AS
			-- Constraint of the formal generic

	creation_feature_list: EIFFEL_LIST [FEATURE_NAME]
			-- Constraint on the creation routine

feature -- Status

	has_constraint: BOOLEAN is
			-- Does the formal generic parameter have a constraint?
		do
			Result := constraint /= Void
		end

	has_creation_constraint: BOOLEAN is
			-- Does the construct have a creation constraint?
		do
			Result := creation_feature_list /= Void
				and then not creation_feature_list.is_empty
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (name, other.name)
				and then equivalent (constraint, other.constraint)
				and then equivalent (creation_feature_list, other.creation_feature_list)
				and then Precursor {FORMAL_AS} (other)
		end

feature -- Output

	constraint_string: STRING is
			-- Produce a STRING version of the CONSTRAINT
		local
			feature_name: FEAT_NAME_ID_AS
		do
			create Result.make (50)
			if is_reference then
				Result.append ("reference ")
			elseif is_expanded then
				Result.append ("expanded ")
			end
			Result.append (name)
			if has_constraint then
				Result.append (" -> ")
				Result.append (constraint.dump)
				Result.to_upper
				if has_creation_constraint then
					from
						creation_feature_list.start
						Result.append (" create ")
						feature_name ?= creation_feature_list.item
						Result.append (feature_name.feature_name)
						creation_feature_list.forth
					until
						creation_feature_list.after
					loop
						Result.append (", ")
						feature_name ?= creation_feature_list.item
						Result.append (feature_name.feature_name)
						creation_feature_list.forth
					end
					Result.append (" end")
				end
			end
		end

end -- class FORMAL_DEC_AS

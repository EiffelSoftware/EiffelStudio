indexing
	description: "Abstract description of a formal generic parameter. %
				%Instances produced by Yacc. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_DEC_AS

inherit
	FORMAL_AS
		rename
			initialize as initialize_formal_as
		redefine
			is_equivalent, format, simple_format
		end

	SHARED_SERVER
		export
			{NONE} all
		end

feature {AST_FACTORY} -- Initialization

	initialize (n: like formal_name; c: like constraint;
		cf: like creation_feature_list; p: INTEGER) is
			-- Create a new FORMAL_DECLARATION AST node.
		require
			n_not_void: n /= Void
		do
			formal_name := n
			constraint := c
			creation_feature_list := cf
			position := p
		ensure
			formal_name_set: formal_name = n
			constraint_set: constraint = c
			creation_feature_list_set: creation_feature_list = cf
			position_set: position = p
		end

feature -- Attributes

	formal_name: ID_AS
			-- Formal generic parameter name

	constraint: TYPE
			-- Constraint of the formal generic
	
	creation_feature_list: EIFFEL_LIST [FEATURE_NAME]
			-- Constraint on the creation routines of the constraint

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

	has_default_create: BOOLEAN
			-- Does the construct list `default_create' has creation procedure?
			-- Set after a call to `constraint_creation_list'.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (formal_name, other.formal_name)
				and then equivalent (constraint, other.constraint)
				and then equivalent (creation_feature_list, other.creation_feature_list)
				and then position = other.position
		end

	equiv (other: like Current): BOOLEAN is
			-- Is `other' equivalent to `Current'
			-- Incrementality of the generic parameters
		require
			good_argument: other /= Void
		local
			ct, o_ct: TYPE_A
		do
				-- Test on void is done only to
				-- protect incorrect generic constraints
			ct := constraint_type
			o_ct := other.constraint_type
			if ct /= Void then
				if o_ct /= Void then
					Result := ct.same_as (o_ct)
				end
				Result := Result and then equivalent (creation_feature_list, other.creation_feature_list)
			else
				Result := o_ct = Void
			end
		end

feature -- Status

	constraint_type: TYPE_A is
			-- Actual type of the constraint.
		do
			if constraint = Void then
					-- Default constraint to ANY
				Result := Any_constraint_type
			else
				Result := constraint.actual_type
			end
		end

	constraint_creation_list: LINKED_LIST [FEATURE_I] is
			-- Actual creation routines from a constraint clause
		require
			has_creation_constraint: has_creation_constraint
			has_computed_feature_table: has_computed_feature_table
		local
			class_type: CL_TYPE_A
			class_id: INTEGER
			feature_name: STRING
			feat_table: FEATURE_TABLE
		do
			class_type ?= constraint_type
			if class_type /= Void then
				class_id := class_type.base_class_id
				feat_table := Feat_tbl_server.item (class_id)
				check
						-- A feature table associated to `base_class_id' should
						-- always be in the system
					feature_table_exists: feat_table /= Void
				end
				from
					creation_feature_list.start
					!! Result.make
				until
					creation_feature_list.after
				loop
					feature_name := creation_feature_list.item.internal_name
					feat_table.search (feature_name)
					Result.extend (feat_table.found_item)
					Result.forth

					if not has_default_create then
						has_default_create := feat_table.found_item.rout_id_set.first =
													System.default_create_id
					end
					creation_feature_list.forth
				end
			end
		end

	has_computed_feature_table: BOOLEAN is
			-- Check that we can retrieve a FEATURE_TABLE from the class
			-- on which we want to check the validity rule about creation
			-- constraint.
			--| Basically, sometimes (degree 4) for example, we need to access
			--| the information on a class which has not been yet compiled, because
			--| of the order of the compilation which does not take into account
			--| the constraint part.
		local
			class_type: CL_TYPE_A
		do
			if creation_feature_list /= Void then
				class_type ?= constraint_type
				if class_type /= Void then
					Result := Feat_tbl_server.item (class_type.base_class_id) /= Void
				end
			end
		end

	has_creation_feature_name (feature_name: STRING): BOOLEAN is
			-- Check in `creation_feature_list' if it contains `feature_name'.
		local
			creation_list: EIFFEL_LIST [FEATURE_NAME]
		do
			from
				creation_list := creation_feature_list
				creation_list.start
			until
				Result or else creation_list.after
			loop
				Result := creation_list.item.internal_name.string_value.is_equal (feature_name)
				creation_list.forth
			end
		end

feature {NONE} -- Access

	Any_constraint_type: CL_TYPE_A is
			-- Default constraint actual type
		once
			!!Result
			Result.set_base_class_id (System.any_id)
		end

feature -- creation feature check

	check_constraint_creation (current_class: CLASS_C; current_type: TYPE) is
			-- Check validity of the creation clause in the constraint
		require
			current_class_exists: current_class /= Void
			current_type_exists: current_type /= Void
			has_creation_constraint: has_creation_constraint
		local
			associated_class: CLASS_C
			class_i: CLASS_I
			cluster: CLUSTER_I
			matched: BOOLEAN
			feature_name: STRING
			feat_table: FEATURE_TABLE
			class_type: CLASS_TYPE_AS
			vtcg6: VTCG6
		do
			cluster := current_class.cluster
			class_type ?= current_type
			
			check
				-- The assignement attempt should return a non-Void value since
				-- we are sure that we are effectively passing a CLASS_TYPE_AS
				class_type_validity: class_type /= Void
			end

			class_i := universe.class_named (class_type.class_name, cluster)

				-- We handle only the case where `class_i' is a valid reference
				-- because the case has been handled in `check_constraint_type'
				-- from CLASS_TYPE_AS which is called just before this feature.
			if class_i /= Void then
					-- Here we assume that the class is correct (cad `check_constraint_type'
					-- from CLASS_TYPE_AS did not add any error items to `Error_handler'.
					
					-- Here we will just check that the feature listed in the creation
					-- constraint part are effectively features of the constraint.
				from
					creation_feature_list.start
					associated_class := class_i.compiled_class	
					feat_table := associated_class.feature_table
					matched := True
				until
					not matched or else creation_feature_list.after	
				loop
					feature_name := creation_feature_list.item.internal_name
					feat_table.search (feature_name)
					if feat_table.found then
						matched := is_valid_creation_routine (feat_table.found_item)
					else
						matched := False
					end
					creation_feature_list.forth
				end

				if not matched then
						-- The feature listed in the creation constraint have not been
						-- declared in the constraint class.
					!! vtcg6
					vtcg6.set_class (current_class)
					vtcg6.set_constraint_class (associated_class)
					vtcg6.set_feature_name (feature_name)
					Error_handler.insert_error (vtcg6)
				end
			end
		end

feature -- Output

	constraint_string: STRING is
			-- Produce a STRING version of the CONSTRAINT
		local
			feature_name: FEAT_NAME_ID_AS
		do
			!! Result.make (50)
			Result.append (formal_name)
			Result.to_upper
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

	append_signature (st: STRUCTURED_TEXT) is
			-- Append the signature of current class in `st'
			--| We do not produce the creation constraint clause since
			--| it is useless in this case.
		require
			non_void_st: st /= Void
		local
			c_name: STRING
			eiffel_name: STRING
		do
			c_name := clone (formal_name)
			c_name.to_upper
			st.add (create {GENERIC_TEXT}.make (c_name))
			if has_constraint then
				st.add_space
				st.add (ti_Constraint)
				st.add_space
				constraint.append_to (st)
				if has_creation_constraint then
					from
						creation_feature_list.start
						st.add_space
						st.add (ti_Create_keyword)
					until
						creation_feature_list.after
					loop
						st.add_space
						eiffel_name := creation_feature_list.item.internal_name
						st.add_default_string (eiffel_name)
						creation_feature_list.forth
						if not creation_feature_list.after then
							st.add (ti_Comma)
						end
					end
					st.add_space
					st.add (ti_End_keyword)
				end
			end
		end

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			s: STRING
			feature_name: FEAT_NAME_ID_AS
			l_a: LOCAL_FEAT_ADAPTATION
			new_type: TYPE_A
		do
			l_a := ctxt.local_adapt
			if l_a /= Void then
				new_type := l_a.adapted_type (Current)
			end

			if new_type = Void then
				s := clone (formal_name)
				s.to_upper
				ctxt.put_text_item (create {GENERIC_TEXT}.make (s))
				if has_constraint then
					ctxt.put_space
					ctxt.put_text_item_without_tabs (ti_Constraint)
					ctxt.put_space
					constraint.format (ctxt)
					if has_creation_constraint then
						from
							creation_feature_list.start
							ctxt.put_space
							ctxt.put_text_item (ti_Create_keyword)
							ctxt.put_space
							feature_name ?= creation_feature_list.item
							ctxt.put_string (feature_name.feature_name)
							creation_feature_list.forth
						until
							creation_feature_list.after
						loop
							ctxt.put_text_item (ti_Comma)
							ctxt.put_space
							feature_name ?= creation_feature_list.item
							ctxt.put_string (feature_name.feature_name)
							creation_feature_list.forth
						end
						ctxt.put_space
						ctxt.put_text_item (ti_End_keyword)
					end
				end
			else
				new_type.format (ctxt)
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			s: STRING
			feature_name: FEAT_NAME_ID_AS
		do
			s := clone (formal_name)
			s.to_upper
			ctxt.put_string (s)
			if has_constraint then
				ctxt.put_space
				ctxt.put_text_item_without_tabs (ti_Constraint)
				ctxt.put_space
				constraint.simple_format (ctxt)
				if has_creation_constraint then
					from
						creation_feature_list.start
						ctxt.put_space
						ctxt.put_text_item (ti_Create_keyword)
						ctxt.put_space
						feature_name ?= creation_feature_list.item
						ctxt.put_string (feature_name.feature_name)
						creation_feature_list.forth
					until
						creation_feature_list.after
					loop
						ctxt.put_text_item (ti_Comma)
						ctxt.put_space
						feature_name ?= creation_feature_list.item
						ctxt.put_string (feature_name.feature_name)
						creation_feature_list.forth
					end
					ctxt.put_space
					ctxt.put_text_item (ti_End_keyword)
				end
			end
		end

feature {NONE} -- Implementation

	is_valid_creation_routine (f: FEATURE_I): BOOLEAN is
			-- Does `f' have all the needed requirement to be
			-- used a creation routine for the future creation
			-- of the generic parameter.
		require
			feature_exists: f /= Void
		local
			p: PROCEDURE_I
		do
			p ?= f
			Result := p /= Void
		end

end -- class FORMAL_DEC_AS

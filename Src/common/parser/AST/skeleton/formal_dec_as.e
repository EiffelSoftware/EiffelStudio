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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_formal_dec_as (Current)
		end

feature -- Attributes

	formal_name: ID_AS
			-- Formal generic parameter name

	constraint: EIFFEL_TYPE
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
			Result := equivalent (formal_name, other.formal_name)
				and then equivalent (constraint, other.constraint)
				and then equivalent (creation_feature_list, other.creation_feature_list)
				and then position = other.position
		end

feature -- Output

	constraint_string: STRING is
			-- Produce a STRING version of the CONSTRAINT
		local
			feature_name: FEAT_NAME_ID_AS
		do
			!! Result.make (50)
			Result.append (formal_name)
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

--	append_signature (st: STRUCTURED_TEXT) is
--			-- Append the signature of current class in `st'
--			--| We do not produce the creation constraint clause since
--			--| it is useless in this case.
--		require
--			non_void_st: st /= Void
--		local
--			c_name: STRING
--			feature_name: FEAT_NAME_ID_AS
--		do
--			c_name := clone (formal_name)
--			c_name.to_upper
--			st.add_string (c_name)
--			if has_constraint then
--				st.add (ti_Space)
--				st.add (ti_Constraint)
--				st.add (ti_Space)
--				constraint.append_to (st)
--				if has_creation_constraint then
--					from
--						creation_feature_list.start
--						st.add (ti_Space)
--						st.add (ti_Create_keyword)
--						st.add (ti_Space)
--						feature_name ?= creation_feature_list.item
--						st.add_string (feature_name.feature_name)
--						creation_feature_list.forth
--					until
--						creation_feature_list.after
--					loop
--						st.add (ti_Comma)
--						st.add (ti_Space)
--						feature_name ?= creation_feature_list.item
--						st.add_string (feature_name.feature_name)
--						creation_feature_list.forth
--					end
--					st.add (ti_Space)
--					st.add (ti_End_keyword)
--				end
--			end
--		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		local
--			s: STRING
--			feature_name: FEAT_NAME_ID_AS
--		do
--			s := clone (formal_name)
--			s.to_upper
--			ctxt.put_string (s)
--			if has_constraint then
--				ctxt.put_space
--				ctxt.put_text_item_without_tabs (ti_Constraint)
--				ctxt.put_space
--				ctxt.format_ast (constraint)
--				if has_creation_constraint then
--					from
--						creation_feature_list.start
--						ctxt.put_space
--						ctxt.put_text_item (ti_Create_keyword);
--						ctxt.put_space
--						feature_name ?= creation_feature_list.item
--						ctxt.put_string (feature_name.feature_name)
--						creation_feature_list.forth
--					until
--						creation_feature_list.after
--					loop
--						ctxt.put_text_item (ti_Comma)
--						ctxt.put_space
--						feature_name ?= creation_feature_list.item
--						ctxt.put_string (feature_name.feature_name)
--						creation_feature_list.forth
--					end
--					ctxt.put_space
--					ctxt.put_text_item (ti_End_keyword);
--				end
--			end
--		end

end -- class FORMAL_DEC_AS

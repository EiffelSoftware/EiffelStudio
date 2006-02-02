indexing
	description: "Abstract description of a formal generic parameter."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_DEC_AS

inherit
	FORMAL_AS
		rename
			initialize as initialize_formal_as
		redefine
			process, is_equivalent, last_token
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (f: FORMAL_AS; c: like constraint; cf: like creation_feature_list; c_as: like constrain_symbol; ck_as: like create_keyword; ek_as: like end_keyword) is
			-- Create a new FORMAL_DECLARATION AST node.
		require
			f_not_void: f /= Void
		do
			name := f.name
			constraint := c
			creation_feature_list := cf
			position := f.position
			is_reference := f.is_reference
			is_expanded := f.is_expanded
			constrain_symbol := c_as
			formal_para := f
			create_keyword := ck_as
			end_keyword := ek_as
		ensure
			name_set: name = f.name
			constraint_set: constraint = c
			creation_feature_list_set: creation_feature_list = cf
			position_set: position = f.position
			is_reference_set: is_reference = f.is_reference
			is_expanded_set: is_expanded = f.is_expanded
			constrain_symbol_set: constrain_symbol = c_as
			formal_para_set: formal_para = f
			create_keyword_set: create_keyword = ck_as
			end_keyword_set: end_keyword = ek_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_formal_dec_as (Current)
		end

feature -- Roundtrip

	constrain_symbol: SYMBOL_AS
			-- Symbol "->" associated with this structure

	formal_para: FORMAL_AS
			-- Formal generic parameter associated with this structure		

	create_keyword: KEYWORD_AS
			-- Keyword "create" associated with this structure

	end_keyword: KEYWORD_AS
			-- Keyword "end" associated with this structure


feature -- Attributes

	constraint: TYPE_AS
			-- Constraint of the formal generic

	creation_feature_list: EIFFEL_LIST [FEATURE_NAME]
			-- Constraint on the creation routines of the constraint

feature -- Roundtrip/Token

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				Result := Precursor (a_list)
			else
				if rcurly_symbol /= Void then
					Result := rcurly_symbol.last_token (a_list)
				elseif end_keyword /= Void then
					Result := end_keyword.last_token (a_list)
				elseif constraint /= Void then
					Result := constraint.last_token (a_list)
				else
					Result := Precursor (a_list)
				end
			end
		end

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
			Result := equivalent (name, other.name)
				and then equivalent (constraint, other.constraint)
				and then equivalent (creation_feature_list, other.creation_feature_list)
				and then Precursor {FORMAL_AS} (other)
		end

	equiv (other: like Current): BOOLEAN is
			-- Is `other' equivalent to `Current'
			-- Incrementality of the generic parameters
		require
			good_argument: other /= Void
		local
			ct, o_ct: like constraint
		do
			Result := position = other.position and then
				is_reference = other.is_reference and then
				is_expanded = other.is_expanded
			if Result then
				ct := constraint
				o_ct := other.constraint
				if ct = Void then
					Result := o_ct = Void
				else
					Result := o_ct /= Void and then ct.is_equivalent (o_ct)
					Result := Result and then
						equivalent (creation_feature_list, other.creation_feature_list)
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
			Result.append (name.as_upper)
			if has_constraint then
				Result.append (" -> ")
				Result.append (constraint.dump.as_upper)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class FORMAL_DEC_AS

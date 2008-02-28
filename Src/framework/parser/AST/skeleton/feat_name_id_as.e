indexing
	description: "Node for Eiffel feature name. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FEAT_NAME_ID_AS

inherit
	FEATURE_NAME
		rename
			internal_name as feature_name
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like feature_name) is
			-- Create a new FEAT_NAME_ID AST node.
		require
			f_not_void: f /= Void
		do
			feature_name := f
		ensure
			feature_name_set: feature_name = f
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_feat_name_id_as (Current)
		end

feature -- Access

	feature_name: ID_AS
			-- Feature name

	internal_alias_name: ID_AS is
			-- Operator associated with the feature (if any)
			-- augmented with information about its arity
		do
				-- Void here
		end

	alias_name: STRING_AS is
			-- Operator name associated with the feature (if any)
		do
				-- Void here
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_frozen = other.is_frozen and then
				equivalent (feature_name, other.feature_name)
		end

	infix "<" (other: FEATURE_NAME): BOOLEAN is
		local
			normal_feature: FEAT_NAME_ID_AS
			infix_feature: INFIX_PREFIX_AS
		do
			normal_feature ?= other
			infix_feature ?= other
			check
				Void_normal_feature: normal_feature = Void implies infix_feature /= Void
				Void_infix_feature: infix_feature = Void implies normal_feature /= Void
			end

			if infix_feature /= Void then
				Result := True
			else
				Result := feature_name.name < normal_feature.feature_name.name
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and frozen_keyword_index /= 0 then
				Result := frozen_keyword (a_list)
			end
			if Result = Void or else Result.is_null then
				Result := feature_name.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := feature_name.last_token (a_list)
		end

invariant
	feature_name_not_void: feature_name /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class FEAT_NAME_ID_AS

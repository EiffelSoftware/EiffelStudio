indexing
	description: "Data structure for checking feature adaptation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FEATURE_ADAPTATION 

feature {NONE} -- Initialization

	make (old_feats: INHERIT_FEAT; new_feat: FEATURE_I) is
			-- Creation
		require
			good_argument: not (old_feats = Void or else new_feat = Void)
			consistency: is_valid_old_features (old_feats)
		do
			old_features := old_feats
			new_feature := new_feat
		end

feature -- Access 

	old_features: INHERIT_FEAT
			-- Inherited features

	new_feature: FEATURE_I
			-- Adapted feature

feature -- Status report

	is_valid_old_features (old_feats: like old_features): BOOLEAN is
			-- Is `old_feats' valid for current Context?
			-- Redefined in JOIN.
		require
			old_feats_not_void: old_feats /= Void
		deferred
		end

feature -- Checking

	check_adaptation (feat_tbl: FEATURE_TABLE) is
			-- Chec adaptation with computed new feature table `feat_tbl'.
		require
			good_context: not (new_feature = Void or else old_features = Void)
		deferred
		end

	check_redeclaration (feat_tbl, old_tbl: FEATURE_TABLE
			pattern_list: LIST [INTEGER]
			origin_table: ORIGIN_TABLE)
		is
			-- Chec adaptation with computed new feature table `feat_tbl'.
		do
			-- Do nothing
		end

feature -- Debugging

	trace is
		do
			io.error.put_string ("Adapted feature: ")
			io.error.put_string (new_feature.feature_name)
			io.error.put_new_line
			io.error.put_string ("inherited features%N")
			old_features.trace
			io.error.put_new_line
		end

invariant
	old_features_exists: old_features /= Void
	new_feature_exists: new_feature /= Void
	deferred_to_join: is_valid_old_features (old_features)
	
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

end -- class FEATURE_ADAPTATION

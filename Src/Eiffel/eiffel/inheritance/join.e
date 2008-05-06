indexing
	description: "Join of deferred features"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	JOIN

inherit
	COMPILER_EXPORTER
	FEATURE_ADAPTATION
	SHARED_ERROR_HANDLER
	SHARED_WORKBENCH

create
	make

feature -- Status Report

	is_valid_old_features (old_feats: INHERIT_FEAT): BOOLEAN is
			-- Is `old_feats' valid for a JOIN?
		do
			Result := old_feats.deferred_features.count > 1
		end

feature -- Checking

	check_adaptation (feat_tbl: FEATURE_TABLE) is
			-- Check if the signature of feature `new_feature' is
			-- identical to the signatures of the deferred features
			-- contained in `old_features'
		local
			deferred_features: LINKED_LIST [INHERIT_INFO]
			old_feat: FEATURE_I
			info: INHERIT_INFO
			feature_with_assigner: FEATURE_I
		do
				-- The signature of the chosen feature in the
				-- context of `feat_tbl' has ben already evluated by
				-- feature `check_types' of FEATURE_TABLE. (See class
				-- INHERIT_TABLE).
			from
				deferred_features := old_features.deferred_features
					-- The first deferred feature is skipped since it is
					-- `new_feature'
				check
					deferred_features.first.a_feature = new_feature
				end
				if new_feature.assigner_name_id /= 0 then
						-- Record assigner command for comparison with other features
					feature_with_assigner := new_feature
				end
					-- Go to the second item in the list
				deferred_features.start
				deferred_features.forth
			until
				deferred_features.after
			loop
				info := deferred_features.item
				old_feat := info.a_feature

					-- Evaluates signature of the old feature in the
					-- context of the new feature table
				old_feat.solve_types (feat_tbl)

					-- Check same signature for different features
				new_feature.check_same_signature (old_feat)

					-- Check assigner procedure.
				if old_feat.assigner_name_id /= 0 then
					if feature_with_assigner = Void then
							-- Record assigner command for comparison with other features
						feature_with_assigner := old_feat
					elseif not feature_with_assigner.is_same_assigner (old_feat, feat_tbl) then
							-- Report that assigner commands are not the same.
						Error_handler.insert_error
							(create {VDJR3_NEW}.make (system.current_class, feature_with_assigner, old_feat))
					end
				end

				deferred_features.forth
			end
		end

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

end

indexing
	description	: "Server for pre and post conditions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class ASSERTION_SERVER

inherit
	SHARED_SERVER

	COMPILER_EXPORTER

create
	make, 
	make_for_class_only, 
	make_for_feature

feature -- Initialization

	make (count: INTEGER) is
			-- Initialize Current assertion server with
			-- features from feature_table `f' that is exported to 
			-- `client'.
		do
			create feature_adapter_table.make (count)
		end

	make_for_class_only is 
			-- Initialize structures for processing one class.
		do
			create feature_adapter_table.make (0)
		end

	make_for_feature (f: FEATURE_I; ast: FEATURE_AS) is
			-- Initialize structures for processing feature `f'
			-- with ast structure `ast'.
		require
			valid_feat: f /= Void
			valid_ast: ast /= Void
		local
			assert_id_set	: ASSERT_ID_SET
			i				: INTEGER
			inh_f			: INH_ASSERT_INFO
			body_index		: INTEGER
			chained_assert	: CHAINED_ASSERTIONS
			other_feat_as	: FEATURE_AS
			f_table			: FEATURE_TABLE
			feat			: FEATURE_I
			assertion		: ROUTINE_ASSERTIONS
			written_in		: INTEGER
			processed_features: ARRAYED_LIST [INTEGER]
				-- feature already processed. To avoid displaying the same
				-- pre/postcondition several times if there was a repeated
				-- inheritance.
		do
			assert_id_set := f.assert_id_set
			if assert_id_set /= Void then
				written_in := f.written_in
				create processed_features.make (5)
				from
					create chained_assert.make
					i := 1
				until
					i > assert_id_set.count
				loop
						-- Retrieve the inherited assertion info, the body_index and
						-- the feature table
					inh_f := assert_id_set.item (i)
					body_index := inh_f.body_index
					f_table := Feat_tbl_server.item (inh_f.written_in)

					if f_table /= Void then
						feat := f_table.feature_of_body_index (body_index)
						if feat /= Void then
							other_feat_as := feat.body
							if
								other_feat_as /= Void and then
								not processed_features.has (feat.body_index)
							then
								create assertion.make_for_feature (feat, other_feat_as)
								chained_assert.extend (assertion)
								processed_features.extend (feat.body_index)
							end
						end
					end
							-- Prepare next iteration
					i := i + 1
				end
				if f.has_assertion and then (not processed_features.has (f.body_index)) then
					create assertion.make_for_feature (f, ast)
					chained_assert.extend (assertion)
				end
				current_assertion := chained_assert
			end
		end

feature -- Properties
						
	current_assertion: CHAINED_ASSERTIONS
			-- Chained assertion for a feature 

	feature_adapter_table: HASH_TABLE [FEATURE_ADAPTER, INTEGER]
			-- Feature adapters hash on `body_index'

feature -- Element change

	register_adapter (feat_adapter: FEATURE_ADAPTER) is
			-- Register adapter `feat_adapter'.
		require
			valid_adapter: feat_adapter /= Void
		do
			if feat_adapter.body_index /= 0 then
				feature_adapter_table.put (feat_adapter, feat_adapter.body_index)
			end
		end

	update_current_assertion (feat_adapter: FEATURE_ADAPTER) is
			-- Update `current_assertion' from `feat_adapter'.
		require
			valid_adapter: feat_adapter /= Void
			valid_body_index: feat_adapter.body_index /= 0
		local
			assert_id_set		: ASSERT_ID_SET
			i					: INTEGER
			inh_f				: INH_ASSERT_INFO
			chained_assert		: CHAINED_ASSERTIONS
			other_feat_as		: FEATURE_AS
			feat				: FEATURE_I
			source_feature		: FEATURE_I
			assertion			: ROUTINE_ASSERTIONS
			target_feat			: FEATURE_I
			inh_feat_adapter	: FEATURE_ADAPTER
			processed_features: ARRAYED_LIST [INTEGER]
				-- feature already processed. To avoid displaying the same
				-- pre/postcondition several times if there was a repeated
				-- inheritance.
		do
			if feat_adapter.body_index /= 0 then

				target_feat := feat_adapter.target_feature
				assert_id_set := target_feat.assert_id_set
				create chained_assert.make
				create processed_features.make (5)
				if assert_id_set /= Void then
					from
						i := 1
					until
						i > assert_id_set.count
					loop
							-- Retrieve the inherited assertion info.
						inh_f := assert_id_set.item (i)
						
						if inh_f.body_index /= 0 then
				
							inh_feat_adapter := feature_adapter_table.item (inh_f.body_index)
	
							if inh_feat_adapter /= Void then
								feat := inh_feat_adapter.source_feature
								other_feat_as := inh_feat_adapter.ast
								if
									other_feat_as /= Void and then
									not processed_features.has (feat.body_index)
								then
									create assertion.make_for_feature (feat, other_feat_as)
									chained_assert.extend (assertion)
									processed_features.extend (feat.body_index)
								end
							end
							
						end
						
							-- Prepare next iteration
						i := i + 1
					end
				end
				source_feature := feat_adapter.source_feature
				if
					source_feature.has_assertion and then
					not processed_features.has (source_feature.body_index)
				then
					create assertion.make_for_feature (source_feature, feat_adapter.ast)
					chained_assert.extend (assertion)
				end
				current_assertion := chained_assert
			end
		end

	reset_current_assertion is
			-- Reset `current_assertion' to Void.
		do
			current_assertion := Void
		end

feature -- Debug

	trace is
		do	
			io.error.put_string ("*** Feature Table ***%N")
			from
				feature_adapter_table.start
			until
				feature_adapter_table.after
			loop
				io.error.put_string ("body_index: ")
				io.error.put_string (feature_adapter_table.key_for_iteration.out)
				io.error.put_new_line
				feature_adapter_table.forth
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

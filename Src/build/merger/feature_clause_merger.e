class FEATURE_CLAUSE_MERGER

inherit
	COMPILER_EXPORTER
end

feature
	
	merge3 (old_tmp, user, new_cl: EIFFEL_LIST [EXT_FEATURE_CLAUSE_AS]) is
			-- Merge feature clauses `old_tmp', `user' and `new_cl'.
			-- No further abstraction possible, because
			-- features can appear in different clauses, i.e.
			-- feature `x' can appear in clause `a' in user-file and
			-- in clause `b' in template file.
		do
			old_template_features := features_in_list (old_tmp)
			user_features := features_in_list (user)

			merge_keeping_order (user, new_cl)
			add_user_features (old_tmp, user, new_cl)
		end;

	merge_result: EIFFEL_LIST [EXT_FEATURE_CLAUSE_AS]

feature {NONE} -- Internal

	features_in_list (l: EIFFEL_LIST [EXT_FEATURE_CLAUSE_AS]): ARRAYED_LIST [EXT_FEATURE_AS] is
	 	   -- Construct an arrayed list of features from clause list `l'.
		local
			features: EIFFEL_LIST [EXT_FEATURE_AS]
		do
			!! Result.make_filled (0)

			if l /= Void then
				from
					Result.start
					l.start
				until
					l.after
				loop
					features := l.item.features

					if features /= Void then
	
						from
							features.start
						until
							features.after
						loop
							Result.put_left (features.item)
							if not Result.after then
								Result.forth
							end
							features.forth
						end
					end

					l.forth
				end
			end
		end;

	merge_keeping_order (user_cl_list, new_cl_list: EIFFEL_LIST [EXT_FEATURE_CLAUSE_AS]) is
			-- Merge two lists of feature clauses. Order of features and
			-- clauses will be the order of `new_cl_list'.
		local
			ordered_result: EIFFEL_LIST [EXT_FEATURE_CLAUSE_AS]
			result_features, features: EIFFEL_LIST [EXT_FEATURE_AS]
			result_clause: EXT_FEATURE_CLAUSE_AS
			u_feature, old_feature: EXT_FEATURE_AS	
			feature_as_merger: FEATURE_AS_MERGER
			user_clause: EXT_FEATURE_CLAUSE_AS
		do
			if not new_cl_list.empty or not user_cl_list.empty then
				if not new_cl_list.empty then
					new_cl_list.start
					!! ordered_result.make_filled (new_cl_list.count)
				else
					user_cl_list.start
					!! ordered_result.make_filled (user_cl_list.count)
				end
			else
				!! ordered_result.make_filled (new_cl_list.count)
			end
					
			from
				new_cl_list.start;
				ordered_result.start
			until
				ordered_result.after
			loop
				
				!! feature_as_merger;
				features := new_cl_list.item.features
				!! result_features.make_filled (features.count);
			
				from
					result_features.start
					features.start
				until
					features.after
				loop
					if has_feature (features.item, user_cl_list) then
						u_feature := matching_feature (features.item, user_features)
						old_feature := matching_feature (features.item, old_template_features)
						feature_as_merger.merge3 (old_feature, u_feature, features.item)
						result_features.replace (feature_as_merger.merge_result)

						if not has_feature (features.item, new_cl_list) then
							-- User added feature, get feature clause
							user_clause := feature_clause_of (u_feature, user_cl_list)
						end
					else
						result_features.replace (features.item)
					end;
					result_features.forth
					features.forth
				end;
				-- Make new clause
				!! result_clause.make_from_other_and_features (new_cl_list.item, result_features)
				-- Add comments
				if user_clause /= Void then
					result_clause.set_comments (user_clause.comments)
				end
	
				ordered_result.replace (result_clause);
				new_cl_list.forth;
				ordered_result.forth
				user_clause := Void
			end

			merge_result := ordered_result
		end;

	matching_feature (f: EXT_FEATURE_AS; fl: ARRAYED_LIST [FEATURE_AS]): EXT_FEATURE_AS is
			-- Occurrence of feature `f' that matches a feature in feature list `fl'.
		local
			f_names: EIFFEL_LIST [FEATURE_NAME]
		do
			from
				fl.start
			until
				fl.after or else Result /= Void
			loop
				from
					f_names := f.feature_names
					f_names.start
				until
					f_names.after or else Result /= Void
				loop
					if fl.item.has_feature_name (f_names.item) then
						Result ?= fl.item
					end
					f_names.forth
				end
				fl.forth
			end
		end;

    feature_clause_of (feat: EXT_FEATURE_AS; clauses: EIFFEL_LIST [EXT_FEATURE_CLAUSE_AS]): EXT_FEATURE_CLAUSE_AS is
                -- Feature clause of feature `feat'.
            require
                has_feature (feat, clauses)
            local
                clause_cur, feat_cur, name_cur: CURSOR
				found: BOOLEAN
                features: EIFFEL_LIST [EXT_FEATURE_AS]
                names: EIFFEL_LIST [FEATURE_NAME]
            do
                from
                    clause_cur := clauses.cursor
                    names := feat.feature_names
                    clauses.start
                until
                    clauses.after or else Result /= Void
                loop
                    features := clauses.item.features
                    from
                        feat_cur := features.cursor
                        features.start
                    until
                        features.after or else Result /= Void
                    loop
                        from
                            name_cur := names.cursor
                            names.start
                        until
                            names.after or else found
                        loop
							found := features.item.has_feature_name (names.item)
                            names.forth
                        end
						if found then
							Result := clauses.item
						end
                        features.forth
                    end
                    features.go_to (feat_cur)
                    clauses.forth
                end
                clauses.go_to (clause_cur)
            end;


	add_user_features (old_tmp, user,  new_cl: EIFFEL_LIST [EXT_FEATURE_CLAUSE_AS]) is
		local
			merged_features: ARRAYED_LIST [EXT_FEATURE_AS]
			current_feature_names: EIFFEL_LIST [FEATURE_NAME]
			current_features: EIFFEL_LIST [FEATURE_AS]
			temp_features: LINKED_LIST [EXT_FEATURE_AS]
			temp_clauses: LINKED_LIST [EXT_FEATURE_CLAUSE_AS]
			new_features: EIFFEL_LIST [EXT_FEATURE_AS]
			nw_features: EIFFEL_LIST [EXT_FEATURE_AS]
			nr_items: INTEGER
			new_clause: EXT_FEATURE_CLAUSE_AS
			feature_found: BOOLEAN
			user_clause, last_user_clause, templ_clause: EXT_FEATURE_CLAUSE_AS
			temp_result: EIFFEL_LIST [EXT_FEATURE_CLAUSE_AS]
		do
			merged_features := features_in_list (merge_result)
			from
				user_features.start
				merged_features.start
			until
				user_features.after
			loop
				if not merged_features.after then
					if has_feature (merged_features.item, merge_result) then
						templ_clause := feature_clause_of (merged_features.item, merge_result)
					end
				end;
				if has_feature (user_features.item, new_cl) then
					-- Feature already in new template clauses.
					-- Search for it.
					current_feature_names := user_features.item.feature_names
					from
						feature_found := False
						merged_features.start
					until
						merged_features.after or else feature_found
					loop
						from
							current_feature_names.start
						until
							current_feature_names.after or else feature_found
						loop
							feature_found := merged_features.item.has_feature_name (current_feature_names.item)
							if feature_found then
								templ_clause := feature_clause_of (merged_features.item, merge_result)
							end
							current_feature_names.forth
						end
						merged_features.forth
					end
				else
					if not has_feature (user_features.item, old_tmp) then
						-- Not a feature removed from the old template, but
						-- a feature added by the user.
						-- Feature should be kept.
                        if temp_clauses = Void then
                            !! temp_clauses.make
                            temp_clauses.start
						end
						last_user_clause := user_clause
						user_clause := feature_clause_of (user_features.item, user)

						if not user_clause.has_equiv_declaration (templ_clause) and then not user_clause.has_equiv_declaration (last_user_clause) then
							temp_clauses.put_left (user_clause)
						else
							-- Add to current
							if user_clause.has_equiv_declaration (templ_clause) then
								merged_features.put_left (user_features.item)
							else
								if temp_clauses.empty then
									temp_clauses.put_left (user_clause)
								else
									temp_clauses.back
									new_clause := temp_clauses.item
									if new_clause.features = Void then
										nr_items := 1
									else
										nr_items := new_clause.features.count + 1
									end
									!! nw_features.make_filled (nr_items)
									if nr_items > 1 then
										nw_features.merge_after_position (0, new_clause.features)
									end
									nw_features.go_i_th (nr_items)
									nw_features.replace (user_features.item)
									new_clause.set_features (nw_features)
									temp_clauses.replace (new_clause)
									temp_clauses.forth
								end
							end
						end

					end
				end
				user_features.forth
			end
	
			-- `merged_features' contains all features, now put them
			-- in `merge_result'.
			from
				merge_result.start
				merged_features.start
			until
				merge_result.after or else merged_features.after
			loop
				!! temp_features.make
				temp_features.start
				current_features := merge_result.item.features
				from
					current_features.start
				until
					current_features.after or else merged_features.after
				loop
					temp_features.put_left (merged_features.item)
					if current_features.item.is_equiv (merged_features.item) then
						-- Feature already in result.
						current_features.forth
					end
					merged_features.forth
				end

				if merge_result.index = merge_result.count and then not merged_features.after then
					-- Feature(s) added at the end.
					from
					until
						merged_features.after
					loop
						temp_features.put_left (merged_features.item)
						merged_features.forth
					end
				end

				!! new_features.make_filled (temp_features.count)
				from
					temp_features.start
					new_features.start
				until
					new_features.after
				loop
					new_features.replace (temp_features.item)
					temp_features.forth
					new_features.forth
				end
				!! new_clause.make_from_other_and_features (merge_result.item, new_features)

				-- Add comments
				new_clause.set_comments (merge_result.item.comments)

				merge_result.replace (new_clause)
				merge_result.forth
			end

			if temp_clauses /= Void then
				temp_result := merge_result
				if not temp_result.empty then
					temp_result.start
					!! merge_result.make_filled (temp_result.count + temp_clauses.count)
				else
					if not temp_clauses.empty then
						temp_clauses.start
						!! merge_result.make_filled (temp_result.count + temp_clauses.count)
					else
						!! merge_result.make_filled (temp_result.count + temp_clauses.count)
					end
				end
				merge_result.merge_after_position (0, temp_result)
				merge_result.go_i_th (temp_result.count + 1)
				from
					temp_clauses.start
				until	
					temp_clauses.after
				loop
					merge_result.replace (temp_clauses.item)
					merge_result.forth
					temp_clauses.forth
				end
			end
		end;

	has_feature (f: FEATURE_AS; fl: EIFFEL_LIST [FEATURE_CLAUSE_AS]): BOOLEAN is
			-- Does feature clause list `fl' contain feature `f'?
		local
			names: EIFFEL_LIST [FEATURE_NAME]
			cursor: CURSOR
		do
			if fl /= Void then 
				from
					names := f.feature_names
					names.start
					cursor := fl.cursor
				until
					names.after or else Result
				loop
					from
						fl.start
					until
						fl.after or else Result
					loop
						Result := fl.item.has_feature_name (names.item)
						fl.forth
					end
					names.forth
				end
				fl.go_to (cursor)
			end
		end;
	 		   
	old_template_features: ARRAYED_LIST [FEATURE_AS]

	user_features: ARRAYED_LIST [EXT_FEATURE_AS]

end -- class FEATURE_CLAUSE_MERGER

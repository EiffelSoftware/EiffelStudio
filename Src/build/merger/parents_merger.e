class PARENTS_MERGER

inherit
    COMPILER_EXPORTER

feature
	
	merge3 (old_tmp, user, new_tmp: EIFFEL_LIST [PARENT_AS]) is
			-- Merge `user' and `new_tmp'.
			-- Merge parents of `u' and `n'.
			-- User ADDED parents will be kept,
			-- user changed parents will be overwritten.
		local
			temp_parents: LINKED_LIST [PARENT_AS]
			prev_user, previous_parent, parent_diffs: PARENT_AS;
			exact_parent_found, parent_found: BOOLEAN;
			new_tmp_nbr, nbr_of_same_parent_type, user_same_type_count: INTEGER
			new_parent: PARENT_AS;
			old_new_parents: LINKED_LIST [PARENT_AS]				
		do
			if user /= Void then
				if new_tmp /= Void or else old_tmp /= Void then
					!! old_new_parents.make;
					if old_tmp = Void then
						old_new_parents.append (new_tmp)
							-- compare it with the new template
					else
						old_new_parents.append (old_tmp)
							-- compare it with the old template
					end
					from
						!! temp_parents.make
						temp_parents.start
						user.start
					until
						user.after
					loop
						if prev_user /= Void then
							if deep_equal (prev_user.type, user.item.type) then
								user_same_type_count := user_same_type_count + 1
							else
								user_same_type_count := 1
							end;	
						else
							user_same_type_count := 1
						end
						from
							nbr_of_same_parent_type := 0;
							old_new_parents.start
							parent_found := False
							exact_parent_found := False
						until
							old_new_parents.after or else parent_found
							or else exact_parent_found
						loop
							if deep_equal (old_new_parents.item,
												user.item) 
							then
								exact_parent_found := True;
							elseif deep_equal (old_new_parents.item.type, user.item.type) then
								nbr_of_same_parent_type := nbr_of_same_parent_type + 1;
								if old_new_parents.item.is_subset_of (user.item) then
									parent_found := nbr_of_same_parent_type 
											= user_same_type_count
								end
							end;
							if not parent_found then
								old_new_parents.forth
							end;
						end
		
						if parent_found then
							new_parent := Void;
								-- Need to merge with new parent template
								-- If can not find a parent of the same
								-- type then discard diff.
							parent_diffs := user_parent_diffs 
												(old_new_parents.item, user.item);
							if old_tmp = Void then
								new_parent := new_tmp.item;
							else
									-- Find equivalent parent in new template
									-- `nbr_of_same_parent_type' indicated which
									-- parent number it is (for repeated inheritance)
									-- If cannot find an equivalent parent then 
									-- user.item is a new entry
								from
									previous_parent := Void;
									parent_found := False;
									new_tmp_nbr := 0;
									new_tmp.start
								until
									new_tmp.after or else parent_found
								loop
									parent_found := deep_equal (new_tmp.item.type, user.item.type);
									if parent_found then
											-- Record previous_parent just in case that
											-- `nbr_of_same_parent_type' can't
											-- be met.
										new_tmp_nbr := new_tmp_nbr + 1
										if nbr_of_same_parent_type /= new_tmp_nbr then
											parent_found := False;
											previous_parent := new_tmp.item;
										end
									end;
									if not parent_found then
										new_tmp.forth
									end
								end;
								if parent_found then
									new_parent := new_tmp.item
								elseif previous_parent /= Void then
										-- Resort to using the previous parent with
										-- the same type
									new_parent := previous_parent
								end
							end;
							if new_parent /= Void then	
									-- If parent is there then
									-- merge the diffs 
								merge_parent_with_diff (new_parent, parent_diffs);
							end
						elseif not exact_parent_found then
							temp_parents.put_left (user.item)
						end	
						prev_user := user.item;
						user.forth
					end

					!! merge_result.make (temp_parents.count + new_tmp.count)

					-- First template parents

					merge_result.merge_after_position (0, new_tmp)

					-- User added parents
					merge_result.go_i_th (new_tmp.count + 1)

					from
						temp_parents.start
					until
						temp_parents.after
					loop
						merge_result.put_i_th (temp_parents.item, merge_result.index)
						merge_result.forth
						temp_parents.forth
					end
				else
					-- Otherwise merge result will be the 
					-- same as previous merge result.
					merge_result := user
				end
			else
				--!! merge_result.make (new_tmp.count)
				--merge_result.merge_after_position (0, new_tmp)
				merge_result := new_tmp
			end
		end;

	merge_result: EIFFEL_LIST [PARENT_AS]

feature {NONE} -- Diffs

	merge_parent_with_diff (new_tmp, diff: PARENT_AS) is
			-- Merge `diff' with new_old_temp .
		require
			valid_args: new_tmp /= Void and then diff /= Void
			same_type: deep_equal (new_tmp.type, diff.type) 
		local
			e: EIFFEL_LIST [EXPORT_ITEM_AS];
			fn: EIFFEL_LIST [FEATURE_NAME];
			rn: EIFFEL_LIST [RENAME_AS];
		do
			e ?= merge_list (new_tmp.exports, diff.exports);
			new_tmp.set_exports (e);
			fn ?= merge_list (new_tmp.redefining, diff.redefining);
			new_tmp.set_redefining (fn);
			rn ?= merge_list (new_tmp.renaming, diff.renaming);
			new_tmp.set_renaming (rn);
			fn ?= merge_list (new_tmp.selecting, diff.selecting);
			new_tmp.set_selecting (fn);
			fn ?= merge_list (new_tmp.undefining, diff.undefining);
			new_tmp.set_undefining (fn);
		end;

	user_parent_diffs (old_new_temp, user: PARENT_AS): PARENT_AS is
			-- User parent diffs (what the user entered)
		require
			valid_args: old_new_temp.is_subset_of (user)
		local
			e: EIFFEL_LIST [EXPORT_ITEM_AS];
			fn: EIFFEL_LIST [FEATURE_NAME];
			rn: EIFFEL_LIST [RENAME_AS];
		do
			!! Result;
			Result.set_type (user.type);
			e ?= diff_list (old_new_temp.exports, user.exports);
			Result.set_exports (e);
			fn ?= diff_list (old_new_temp.redefining, user.redefining);
			Result.set_redefining (fn);
			rn ?= diff_list (old_new_temp.renaming, user.renaming);
			Result.set_renaming (rn);
			fn ?= diff_list (old_new_temp.selecting, user.selecting);
			Result.set_selecting (fn);
			fn ?= diff_list (old_new_temp.undefining, user.undefining);
			Result.set_undefining (fn);
		end;

	diff_list (list, user_list: EIFFEL_LIST [AST_EIFFEL]): EIFFEL_LIST [AST_EIFFEL] is
			-- Diffs between `user_list' with `list'?
		local
			item: AST_EIFFEL;
			temp_list: LINKED_LIST [AST_EIFFEL];
			new_list: EIFFEL_LIST [AST_EIFFEL];
			found: BOOLEAN
		do
			if list = Void then
				Result := user_list
			elseif user_list = Void then
				Result := Void
			else
				!! temp_list.make;
				temp_list.start;
				from
					user_list.start
				until
					user_list.after 
				loop
					item := user_list.item
					from
						found := False;
						list.start
					until
						list.after or else found
					loop
						found := deep_equal (item, list.item);
						list.forth
					end;
					if not found then
						temp_list.put_left (item);
					end;
					user_list.forth
				end;
				if not temp_list.empty then
					!! Result.make (temp_list.count)
					Result.merge_after_position (0, temp_list);
				end;
			end
		end;

	merge_list (list, diff_l: EIFFEL_LIST [AST_EIFFEL]): EIFFEL_LIST [AST_EIFFEL] is
			-- Merge `diff_l' with `list' into Result?
		do
			if list = Void then
				Result := diff_l
			elseif diff_l = Void then
				Result := list
			elseif diff_l.empty then
				Result := list
			else
				!! Result.make (diff_l.count + list.count)
				Result.merge_after_position (0, list);
				Result.merge_after_position (list.count, diff_l);
			end
		end;

end -- class PARENTS_MERGER

class PARENTS_MERGER

feature
	
	merge3 (old_p, user_p, new_p: EIFFEL_LIST [PARENT_AS]) is
			-- Merge `user_p' and `new_p'.
			-- Merge parents of `u' and `n'.
			-- User ADDED parents will be kept,
			-- user changed parents will be overwritten.
		local
			temp_parents: LINKED_LIST [PARENT_AS]
			previous_parent, parent_diffs: PARENT_AS;
			exact_parent_found, parent_found: BOOLEAN;
			new_p_nbr, nbr_of_same_parent_type: INTEGER
			new_parent: PARENT_AS;
			old_new_parents: EIFFEL_LIST [PARENT_AS]				
		do
			if user_p /= Void then
				if new_p /= Void or else old_p /= Void then
					if old_p = Void then
						old_new_parents := new_p
							-- compare it with the new template
					else
						old_new_parents := old_p
							-- compare it with the old template
					end
					from
						!! temp_parents.make
						temp_parents.start
						user_p.start
					until
						user_p.after
					loop
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
												user_p.item) 
							then
								exact_parent_found := True;
							elseif deep_equal (old_new_parents.item.type, user_p.item.type) then
								nbr_of_same_parent_type := nbr_of_same_parent_type + 1;
								parent_found := old_new_parents.item.is_subset_of (user_p.item);
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
												(old_new_parents.item, user_p.item);
							if old_new_parents = new_p then
								new_parent := new_p.item;
							else
									-- Find equivalent parent in new template
									-- `nbr_of_same_parent_type' indicated which
									-- parent number it is (for repeated inheritance)
									-- If cannot find an equivalent parent then 
									-- user_p.item is a new entry
								from
									previous_parent := Void;
									parent_found := False;
									new_p_nbr := 0;
									new_p.start
								until
									new_p.after or else parent_found
								loop
									parent_found := deep_equal (new_p.item.type, user_p.item.type);
									if parent_found then
											-- Record previous_parent just in case that
											-- `nbr_of_same_parent_type' can't
											-- be met.
										new_p_nbr := new_p_nbr + 1
										if nbr_of_same_parent_type /= new_p_nbr then
											parent_found := False;
											previous_parent := new_p.item;
										end
									end;
									if not parent_found then
										new_p.forth
									end
								end;
								if parent_found then
									new_parent := new_p.item
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
							temp_parents.put_left (user_p.item)
						end	
						user_p.forth
					end

					!! merge_result.make (temp_parents.count + new_p.count)

					-- First template parents

					merge_result.merge_after_position (0, new_p)

					-- User added parents
					merge_result.go_i_th (new_p.count + 1)

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
					merge_result := user_p
				end
			else
				--!! merge_result.make (new_p.count)
				--merge_result.merge_after_position (0, new_p)
				merge_result := new_p
			end
		end;

	merge_result: EIFFEL_LIST [PARENT_AS]

feature {NONE} -- Diffs

	merge_parent_with_diff (new_p, diff: PARENT_AS) is
			-- Merge `diff' with new_old_temp .
		require
			valid_args: new_p /= Void and then diff /= Void
			same_type: deep_equal (new_p.type, diff.type) 
		local
			e: EIFFEL_LIST [EXPORT_ITEM_AS];
			fn: EIFFEL_LIST [FEATURE_NAME];
			rn: EIFFEL_LIST [RENAME_AS];
		do
			e ?= merge_list (new_p.exports, diff.exports);
			new_p.set_exports (e);
			fn ?= merge_list (new_p.redefining, diff.redefining);
			new_p.set_redefining (fn);
			rn ?= merge_list (new_p.renaming, diff.renaming);
			new_p.set_renaming (rn);
			fn ?= merge_list (new_p.selecting, diff.selecting);
			new_p.set_selecting (fn);
			fn ?= merge_list (new_p.undefining, diff.undefining);
			new_p.set_undefining (fn);
		end;

	user_parent_diffs (old_new_temp, user_p: PARENT_AS): PARENT_AS is
			-- User parent diffs (what the user entered
		require
			valid_args: old_new_temp.is_subset_of (user_p)
		local
			e: EIFFEL_LIST [EXPORT_ITEM_AS];
			fn: EIFFEL_LIST [FEATURE_NAME];
			rn: EIFFEL_LIST [RENAME_AS];
		do
			!! Result;
			Result.set_type (user_p.type);
			e ?= diff_list (old_new_temp.exports, user_p.exports);
			Result.set_exports (e);
			fn ?= diff_list (old_new_temp.redefining, user_p.redefining);
			Result.set_redefining (fn);
			rn ?= diff_list (old_new_temp.renaming, user_p.renaming);
			Result.set_renaming (rn);
			fn ?= diff_list (old_new_temp.selecting, user_p.selecting);
			Result.set_selecting (fn);
			fn ?= diff_list (old_new_temp.undefining, user_p.undefining);
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

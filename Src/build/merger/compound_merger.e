class COMPOUND_MERGER

inherit
    COMPILER_EXPORTER
end

feature

	merge3 (old_c, user_c, new_c: EIFFEL_LIST [INSTRUCTION_AS]) is
			-- Merge compounds `new_c' and `user_c', depending on `old_c'.
			-- `new_c' has to be inserted at position of first 
			-- occurrence of an instruction from `old_c'. User added
			-- instructions after that position will appear 
			-- AFTER the inserted compound. Instructions
			-- only appearing in the old compound `old_c' 
			-- will be lost.
		local
			before_template, after_template, list: LINKED_LIST [INSTRUCTION_AS]
			merged_compound: EIFFEL_LIST [INSTRUCTION_AS]
			old_template_found_list: LINKED_LIST [INSTRUCTION_AS];
			removed_old_template_list: LINKED_LIST [INSTRUCTION_AS];
			final_template_list: LINKED_LIST [INSTRUCTION_AS];
			new_c_count, size: INTEGER;
			found: BOOLEAN;
			inst: INSTRUCTION_AS
		do
			-- Try to merge something

			!! before_template.make 
			!! after_template.make 
			before_template.start
			after_template.start

			if old_c /= Void then
				-- If `old_c' exists it is possible that
				-- the user added something BEFORE the
				-- template compound.
				-- Start to fill `before_template'-list.
				list := before_template
			else
				-- If `old_c' doesn't exist it isn't possible
				-- that the user added something BEFORE the
				-- template compound, simply because this
				-- compound was empty. It is possible though
				-- that the user added something and that
				-- should be kept.
				-- Start to fill `after_template'-list.
				list := after_template
			end;
			if user_c /= Void then
				!! old_template_found_list.make;
				from
					user_c.start
				until
					user_c.after
				loop
					if old_c /= Void then
						inst := user_c.item;
						from
							old_c.start
						until
							old_c.after or else (old_c.item.conforms_to (inst) and then old_c.item.is_equivalent (inst))
						loop
							old_c.forth
						end;

						if not old_c.after then
							-- Found a match between the user compound and
							-- the old template compound. Now start filling 
							-- `after_template'.
							list := after_template;
							old_template_found_list.put_front (old_c.item)
						else
							-- User entry
							list.extend (user_c.item)
						end
					else
						list.extend (user_c.item)
					end;
					user_c.forth
				end

				-- Now construct a list of instructions
				-- that are removed by the user.

				if old_c /= Void then
					!! removed_old_template_list.make;
					from
						old_c.start
					until
						old_c.after
					loop
						inst := old_c.item;
						from
							found := False;
							old_template_found_list.start
						until
							found or else old_template_found_list.after 
						loop
							found := (old_template_found_list.item
										= inst);
							old_template_found_list.forth
						end;
						if not found then
							removed_old_template_list.put_front (inst)
						end
						old_c.forth
					end
				end

				!! final_template_list.make;
				if 
					removed_old_template_list /= Void 
				and then not 
					removed_old_template_list.empty 
				and then 
					new_c /= Void 
				then
					-- User removed entries from old template,
					-- so we have to remove them from the new
					-- template as well.

					from 
						new_c.start
					until
						new_c.after
					loop
						inst := new_c.item;
						from
							found := False;
							removed_old_template_list.start
						until
							found or else removed_old_template_list.after
						loop
							found := (inst.is_equivalent (removed_old_template_list.item))
							removed_old_template_list.forth
						end;

						if not found then
							-- User didn't remove from old template
							-- or new entry in new template.
							final_template_list.finish
							final_template_list.put_right (inst)
						end
						new_c.forth
					end
				else
					-- Nothing has been removed by user, so the final
					-- template list is the complete new template.
					if new_c /= Void then
						from
							new_c.start
						until	
							new_c.after
						loop
							final_template_list.finish
							final_template_list.put_right (new_c.item)
							new_c.forth
						end
					end
				end

				-- `old_c' removed from `new_c'.
				-- User removed template statements taken into acccount.
				-- `user_c' has to be inserted between `before_template' and
				-- `after_template'-list

				new_c_count := final_template_list.count

				-- Compute total size of user entry compound
				size := before_template.count + after_template.count;

				if size > 0 then
					-- Compute total size of new compound
					size := size + new_c_count;
					!! merge_result.make_filled (size)

					-- Now fill with `before_template'.
					merge_result.merge_after_position 
									(0, before_template)

					-- Insert new template.
					merge_result.merge_after_position 
									(before_template.count, final_template_list);

					-- Fill with `after_template'.
					merge_result.merge_after_position 
									(merge_result.count - after_template.count,
									 after_template)
				elseif new_c /= Void then
					-- Nothing added by user
					!! merge_result.make_filled (new_c.count)
					merge_result.merge_after_position (0, new_c)
				else
					-- Nothing to merge
					merge_result := Void
				end
			else
				if new_c /= Void then
					-- Keeping new template compound
					!! merge_result.make_filled (new_c.count)
					merge_result.merge_after_position (0, new_c)
				else
					-- Nothing to merge
					merge_result := Void
				end
			end
		end;

		merge_result: EIFFEL_LIST [INSTRUCTION_AS]

end -- class COMPOUND_MERGER

class COMPOUND_MERGER

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
			new_c_count, size: INTEGER;
			inst: INSTRUCTION_AS
		do
			-- Try to merge something

			!! before_template.make 
			!! after_template.make 
			before_template.start
			after_template.start

			if old_c /= Void then
				-- Start to fill `before_template'-list.
				list := before_template
			else
				-- Start to fill `after_template'-list.
				list := after_template
			end;
			if user_c /= Void then
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
							old_c.after or else old_c.item.is_equiv (inst)
						loop
							old_c.forth
						end;

						if not old_c.after then
								-- Match found. Now start filling after_template
							list := after_template;
						else
								-- User entry
							list.extend (user_c.item)
						end
					else
						list.extend (user_c.item)
					end
					user_c.forth
				end

				-- `old_c' removed from `new_c'.
				-- `user_c' has to be inserted between `before_template' and
				-- `after_template'-list

				if new_c /= Void then
					new_c_count := new_c.count
				end;

						-- Compute total size of user entry compound
				size := before_template.count + after_template.count;

				if size > 0 then
					
						-- Compute total size of new compound
					size := size + new_c_count;
					!! merge_result.make (size)

					-- Now fill with `before_template'.

					merge_result.merge_after_position 
									(0, before_template)

					if new_c /= Void then
							-- Insert new template.
						merge_result.merge_after_position 
									(before_template.count, new_c)
					end;

					-- Fill with `after_template'.

					merge_result.merge_after_position 
									(merge_result.count - after_template.count,
									 after_template)

				elseif new_c /= Void then
					!! merge_result.make (new_c.count)
					merge_result.merge_after_position (0, new_c)
				else
					merge_result := Void
				end
			else
				if new_c /= Void then
					!! merge_result.make (new_c.count)
					merge_result.merge_after_position (0, new_c)
				else
					merge_result := Void
				end
			end
		end;

		merge_result: EIFFEL_LIST [INSTRUCTION_AS]

end -- class COMPOUND_MERGER

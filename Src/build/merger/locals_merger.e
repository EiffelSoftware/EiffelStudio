class LOCALS_MERGER

inherit
    COMPILER_EXPORTER

feature

	merge3 (old_tmp, user, new_tmp: EIFFEL_LIST [TYPE_DEC_AS]) is
			-- Merge locals `user' and `new_tmp'.
			-- Locals from `user' appearing
			-- in the list of locals `new_tmp' 
			-- are overwritten.
		local
			comp_locals, new_locals, temp_locals: EIFFEL_LIST [TYPE_DEC_AS]
			u_id_list, n_id_list, temp_id_list: EIFFEL_LIST [ID_AS]
			current_id_list: LINKED_LIST [ID_AS]
			--locals: LINKED_LIST [TYPE_DEC_AS]
			local_found: BOOLEAN
			new_type_dec: TYPE_DEC_AS
			current_type: TYPE
		do
			if user /= Void then
				if new_tmp /= Void or else old_tmp /= Void then
					if old_tmp = Void then
						comp_locals := new_tmp
							-- compare it with the new template
					else
						comp_locals := old_tmp
							-- compare it with the old template
					end;
					from
						user.start
					until
						user.after
					loop
						u_id_list := user.item.id_list
						current_type := user.item.type
						!! current_id_list.make
						current_id_list.start
						from
							u_id_list.start
						until
							u_id_list.after
						loop
							from
								comp_locals.start
								local_found := False
							until
								comp_locals.after or else local_found
							loop
								n_id_list := comp_locals.item.id_list
								from
									n_id_list.start
								until
									n_id_list.after or else local_found
								loop
									local_found := comp_locals.item.has_id (u_id_list.item)
									n_id_list.forth
								end;

								comp_locals.forth
							end

							if not local_found then
								current_id_list.put_left (u_id_list.item)
							end

							u_id_list.forth
						end;

						-- Keeping locals from `user', not appearing in `comp_locals'.

						!! temp_id_list.make_filled (current_id_list.count)
						from
							temp_id_list.start
							current_id_list.start
						until
							temp_id_list.after
						loop
							temp_id_list.put_i_th (current_id_list.item, temp_id_list.index)
							temp_id_list.forth
							current_id_list.forth
						end

						!! new_type_dec
						new_type_dec.set_id_list (temp_id_list)
						new_type_dec.set_type (current_type)

						if new_locals = Void then
							if not new_type_dec.id_list.empty then
								!! temp_locals.make_filled (1)
								temp_locals.put_i_th (new_type_dec, 1)
							end
						else
							if not new_type_dec.id_list.empty then
								!! temp_locals.make_filled (new_locals.count + 1)
								temp_locals.put_i_th (new_type_dec, temp_locals.count)
							end
							temp_locals.merge_after_position (0, new_locals)
						end

						new_locals := temp_locals
						user.forth
					end

					if new_locals = Void then
							-- No new locals were found.
							-- Use the locals from the new template
						merge_result := new_tmp
					elseif new_tmp = Void then	
							-- Return the new_locals
						merge_result := new_locals;
					else
							-- Adding locals to new_template
						!! merge_result.make_filled (new_locals.count + 
										new_tmp.count)
                       	merge_result.merge_after_position (0, new_tmp)
                       	merge_result.merge_after_position (new_tmp.count, new_locals)
					end
				else
					merge_result := user
				end
			else
				merge_result := new_tmp
			end
		end;

	merge_result: EIFFEL_LIST [TYPE_DEC_AS]

end -- class LOCALS_MERGER

class CREATORS_MERGER

inherit
	COMPILER_EXPORTER
end

feature

	merge2 (user, new_tmp: EIFFEL_LIST [CREATE_AS]) is
			-- Merge creators `user' and `new_tmp'.
			-- Clients of creators `user' appearing
			-- in creators `new_tmp' are overwritten.
			-- Result of merge will be stored in
			-- `merge_result'.
		local
			new_creators, temp_creators: EIFFEL_LIST [CREATE_AS]
			user_features, temp_feature_list: EIFFEL_LIST [FEATURE_NAME]
			current_feature_list: LINKED_LIST [FEATURE_NAME]
			current_clients: CLIENT_AS
			new_create_as: CREATE_AS
			creator_found: BOOLEAN
		do
			if user /= Void then
				from
					user.start
				until
					user.after
				loop
					user_features := user.item.feature_list
					current_clients := user.item.clients
					!! current_feature_list.make
					current_feature_list.start

					from
						user_features.start
					until
						user_features.after
					loop
						from
							new_tmp.start
							creator_found := False
						until
							new_tmp.after or else creator_found
						loop
							creator_found := new_tmp.item.has_feature_name (user_features.item)
							new_tmp.forth
						end

						if not creator_found then
							current_feature_list.put_left (user_features.item)
						end
							
						user_features.forth
					end

					-- Keeping creators from `user', not appearing in `new_tmp'.

					!! temp_feature_list.make_filled (current_feature_list.count)
					from
						temp_feature_list.start
						current_feature_list.start
					until
						temp_feature_list.after
					loop
						temp_feature_list.put_i_th (current_feature_list.item, temp_feature_list.index)
						temp_feature_list.forth
						current_feature_list.forth
					end
					
					!! new_create_as
					new_create_as.set_feature_list (temp_feature_list)
					new_create_as.set_clients (current_clients)

					if new_creators = Void then
						if not new_create_as.feature_list.empty then
							!! temp_creators.make_filled (1)
							temp_creators.put_i_th (new_create_as, 1)
						end
					else
						if not new_create_as.feature_list.empty then
							!! temp_creators.make_filled (new_creators.count + 1)
							temp_creators.put_i_th (new_create_as, temp_creators.count)
						else
							!! temp_creators.make_filled (new_creators.count)
						end
						temp_creators.merge_after_position (0, new_creators)
					end

					new_creators := temp_creators
					user.forth
				end

				-- Now adding creators from `new_tmp'.
	
				if new_creators = Void then
					!! temp_creators.make_filled (new_tmp.count)
					temp_creators.merge_after_position (0, new_tmp)
				else
					!! temp_creators.make_filled (new_creators.count + new_tmp.count)
					temp_creators.merge_after_position (0, new_tmp)
					temp_creators.merge_after_position (new_tmp.count, new_creators)
				end
				merge_result := temp_creators
			else
				if new_tmp /= Void then
					!! merge_result.make_filled (new_tmp.count)
					merge_result.merge_after_position (0, new_tmp)
				else
					merge_result := Void
				end
			end
		end;

	merge_result: EIFFEL_LIST [CREATE_AS]

end -- class CREATORS_MERGER

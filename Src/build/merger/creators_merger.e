class CREATORS_MERGER

feature

	merge2 (c1, c2: EIFFEL_LIST [CREATE_AS]) is
			-- Merge creators `c1' and `c2'.
			-- Clients of creators `c1' appearing
			-- in creators `c2' are overwritten.
			-- Result of merge will be stored in
			-- `merge_result'.
		local
			new_creators, temp_creators: EIFFEL_LIST [CREATE_AS]
			c1_features, temp_feature_list: EIFFEL_LIST [FEATURE_NAME]
			current_feature_list: LINKED_LIST [FEATURE_NAME]
			current_clients: CLIENT_AS
			new_create_as: CREATE_AS
			creator_found: BOOLEAN
		do
			if c1 /= Void then
				from
					c1.start
				until
					c1.after
				loop
					c1_features := c1.item.feature_list
					current_clients := c1.item.clients
					!! current_feature_list.make
					current_feature_list.start

					from
						c1_features.start
					until
						c1_features.after
					loop
						from
							c2.start
							creator_found := False
						until
							c2.after or else creator_found
						loop
							creator_found := c2.item.has_feature_name (c1_features.item)
							c2.forth
						end

						if not creator_found then
							current_feature_list.put_left (c1_features.item)
						end
							
						c1_features.forth
					end

					-- Keeping creators from `c1', not appearing in `c2'.

					!! temp_feature_list.make (current_feature_list.count)
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
							!! temp_creators.make (1)
							temp_creators.put_i_th (new_create_as, 1)
						end
					else
						if not new_create_as.feature_list.empty then
							!! temp_creators.make (new_creators.count + 1)
							temp_creators.put_i_th (new_create_as, temp_creators.count)
						else
							!! temp_creators.make (new_creators.count)
						end
						temp_creators.merge_after_position (0, new_creators)
					end

					new_creators := temp_creators
					c1.forth
				end

				-- Now adding creators from `c2'.
	
				if new_creators = Void then
					!! temp_creators.make (c2.count)
					temp_creators.merge_after_position (0, c2)
				else
					!! temp_creators.make (new_creators.count + c2.count)
					temp_creators.merge_after_position (0, c2)
					temp_creators.merge_after_position (c2.count, new_creators)
				end
				merge_result := temp_creators
			else
				if c2 /= Void then
					!! merge_result.make (c2.count)
					merge_result.merge_after_position (0, c2)
				else
					merge_result := Void
				end
			end
		end;

	merge_result: EIFFEL_LIST [CREATE_AS]

end -- class CREATORS_MERGER

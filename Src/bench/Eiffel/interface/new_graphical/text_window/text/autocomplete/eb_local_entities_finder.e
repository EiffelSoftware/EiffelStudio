indexing
	description: "Objects that build the list of local variables and arguments corresponding to a location in a class text"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_LOCAL_ENTITIES_FINDER

inherit
	EB_TOKEN_TOOLKIT
		export
			{NONE} All
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- initialize `Current'.
		do
				create found_names.make
				create found_class_names.make
				create name_list.make
				create class_list.make
		end

feature -- Basic Operations

	build_entities_list (line: EDITOR_LINE;token: EDITOR_TOKEN; build_classes_list:BOOLEAN) is
			-- Build list of locals and arguments (`found_names') corresponding to a position 
			-- in a text defined by `line' and `token'.
			-- If `build_class_list', the list of class names that correspond to `found_names', 
			--	`found_class_names' is generated too.
		do
			internal_token := token.previous
			internal_line := line
			create found_names.make
			create found_class_names.make
			search_for_local_clause
			if found_local_keyword then
				look_for_locals := True
				build_lists (build_classes_list)
				if not name_list.after then
					found_names.merge_right (name_list)
				end
				if not class_list.after then
					found_class_names.merge_right (class_list)
				end
			else
				internal_token := token.previous
				internal_line := line
			end
			search_for_arguments
			if found_arguments then
				look_for_locals := False
				build_lists (build_classes_list)
				if not name_list.after then
					found_names.merge_right (name_list)
				end
				if not class_list.after then
					found_class_names.merge_right (class_list)
				end
			end
			name_list.wipe_out
			name_list := Void
			class_list.wipe_out
			class_list := Void
		end
		
	reset is
			-- Wipe lists out .
		do
			found_names.wipe_out
			found_class_names.wipe_out
		end
		
	found_names: LINKED_LIST [STRING]
			-- list of found entities.
			
	found_class_names: LINKED_LIST [STRING]
			-- list of class names that correspond to `found_names'.
			
feature {NONE} -- Implementation

	internal_token: EDITOR_TOKEN

	internal_line: EDITOR_LINE

	name_list: LINKED_LIST [STRING]

	class_list: LINKED_LIST [STRING]

	found_local_keyword: BOOLEAN

	found_arguments: BOOLEAN

	found_end_of_class_name: BOOLEAN

	search_for_local_clause is
			-- Try to set `internal_token' and `internal_line' so that they point to
			-- the local clause that correspond to their initial value.
			-- set `found_local_keyword' to True if successful
		local
			stop: BOOLEAN
			kw: EDITOR_TOKEN_KEYWORD
			lgth: INTEGER
		do
			from
			until
				stop
			loop
				if internal_token = Void then
					internal_line := internal_line.previous
					if internal_line /= Void then
						internal_token := internal_line.eol_token
					else
						stop := True
					end
				else
					kw ?= internal_token
					if
						kw /= Void
					then
						lgth := kw.length
						if lgth = 5 and then token_image_is_same_as_word (kw, local_word) then
							stop := True
							found_local_keyword := True
						elseif
							(lgth = 2 and then token_image_is_same_as_word (kw, is_word))
								or else
							(lgth = 7 and then token_image_is_same_as_word (kw, feature_word))
						then
							stop := True
						end
					end
					internal_token := internal_token.previous
				end
			end			
		end

	search_for_arguments is
			-- Try to set `internal_token' and `internal_line' so that they point to
			-- the beginning of the argument list of the feature that correspond to their initial value.
			-- set `found_arguments' to True if successful
		local
			stop: BOOLEAN
			kw: EDITOR_TOKEN_KEYWORD
			lgth: INTEGER
			par_found: BOOLEAN
			img: STRING
		do
			from
			until
				stop
			loop
				if internal_token = Void then
					internal_line := internal_line.previous
					if internal_line /= Void then
						internal_token := internal_line.eol_token
					else
						stop := True
					end
				else
					kw ?= internal_token
					if
						kw /= Void
					then
						lgth := kw.length
						if lgth = 2 and then token_image_is_same_as_word (kw, is_word) then
							go_to_previous_non_blank_token
							if internal_token /= Void then
								img := internal_token.image
								if img.is_equal (closing_parenthesis) then
									par_found := True
								elseif not img.is_equal (closing_bracket) then
										-- most common cases : 
										--          feature_name arguments : non_generic_class_name is (1)
										--          feature_name : non_generic_class_name is (2)
										--          feature_name is (3)
										-- we eliminate (2) and (3)
									go_to_previous_non_blank_token
									if internal_token /= Void then
										if internal_token.image.is_equal (like_word) then
											go_to_previous_non_blank_token
										end
										if internal_token /= Void then
												-- In case (3) there is no colon
											if internal_token.image.is_equal (colon) then
												go_to_previous_non_blank_token
													-- in case (2) there is no parenthesis
												if internal_token /= Void and then internal_token.image.is_equal (closing_parenthesis) then
													par_found := True
													stop := False
												end
											end
										end
									end
									stop := not par_found
								end
								from
									
								until
									stop
								loop
									go_to_previous_non_blank_token
									if internal_token /= Void then
										img := internal_token.image
										lgth := img.count
										if 
											(lgth = 3 and then img.is_equal (end_word))
												or else
											(lgth = 7 and then img.is_equal (feature_word))
										then
											stop := True
										elseif par_found then
											if internal_token.image.is_equal (opening_parenthesis) then
												found_arguments := True
												stop := True
											end
										elseif internal_token.image.is_equal (colon) then
											go_to_previous_non_blank_token
											if internal_token /= Void then
												if internal_token.image.is_equal (closing_parenthesis) then
													par_found := True
												else
													stop := True
												end
											end
										end
									else
										stop := True
									end
								end -- loop
							end
						elseif
							lgth = 7 and then token_image_is_same_as_word (kw, feature_word)
						then
							stop := True
						end
					end
					internal_token := internal_token.previous
				end
			end			
		end
	
	build_lists (build_classes_list: BOOLEAN) is
			-- Build a list of locals or arguments starting at `internal_line' and
			-- `internal_token'. Results are stored in `name_list' and `class_list'.
		local
			stop: BOOLEAN
			state, count: INTEGER
		do
			state := 1
			create name_list.make
			create class_list.make
			from
				internal_token := internal_token.next.next
			until
				stop
			loop
				from
				
				until
					stop or else internal_token = internal_line.eol_token
				loop
					inspect state
					when 1 then
							-- expecting local name
						if is_stopping (internal_token) then
							stop := True
						elseif not is_skippable (internal_token) then
							state := 2
							name_list.extend (internal_token.image)
							count := count + 1
						end
						internal_token := internal_token.next
					when 2 then
							-- expecting comma or colon
						if internal_token.image.is_equal (comma) then
							state := 1
						elseif internal_token.image.is_equal (colon) then
							state := 3
						elseif not is_skippable (internal_token) then
							stop := True
						end
						internal_token := internal_token.next
					when 3 then
							-- expecting class name
						if token_image_is_same_as_word (internal_token, like_word) then
							-- FIXME
							internal_token := internal_token.next
						elseif is_stopping (internal_token) then
							stop := True
						elseif not is_skippable (internal_token) then
							state := 4
							from
							until
								count = 0 or else not build_classes_list
							loop
								count := count - 1
								class_list.extend (internal_token.image)
							end
							go_to_end_of_class_name
							if found_end_of_class_name then
								internal_token := internal_token.next
							else
								stop := True
							end
						else
							internal_token := internal_token.next
						end
					when 4 then
							-- expecting semi-colon or local name
						if not is_skippable (internal_token) and then not internal_token.image.is_equal (semi_colon) then
							state := 1
						else
							internal_token := internal_token.next
						end
					else
						-- Not reached
					end
				end
				if not stop then
					internal_line := internal_line.next
					if internal_line /= Void then
						internal_token := internal_line.first_token
					else
						stop := True
					end
				end
			end
			if state /= 1 then
					-- Error state : reset lists
				name_list.wipe_out
				class_list.wipe_out
			end
		end

	is_stopping (tok: EDITOR_TOKEN): BOOLEAN is
			-- Should we stop list building if we encounter `tok'?
		do
			if look_for_locals then
				Result := is_keyword (tok) and then not token_image_is_same_as_word (tok, current_word)
			else
				Result := tok.image.is_equal (closing_parenthesis)
			end
		end

	look_for_locals: BOOLEAN
			-- Looking for locals (not arguments)?
	
	go_to_end_of_class_name is
			-- If `internal_token' and `internal_line' point to the beginning of a class name.
			-- modify them so that they point to the end of the name.
			-- Set `found_end_of_class_name' to True if successful.
		local
			brackets: INTEGER
			starting_token: EDITOR_TOKEN
			starting_line: EDITOR_LINE
			img: STRING
		do
			starting_token := internal_token
			starting_line := internal_line
			found_end_of_class_name := True
			from
				internal_token := internal_token.next
			until
				not (found_end_of_class_name and then (is_skippable (internal_token) or else is_eol (internal_token)))
			loop
				if is_skippable (internal_token) then
					internal_token := internal_token.next
				elseif is_eol (internal_token) then
					internal_line := internal_line.next
					if internal_line /= Void then
						internal_token := internal_line.first_token
					else
						found_end_of_class_name := False
					end
				end
			end
			if found_end_of_class_name and then internal_token.image.is_equal (opening_bracket) then
				from
					brackets := 1
					internal_token := internal_token.next
				until
					brackets = 0 or else not found_end_of_class_name
				loop
					if is_skippable (internal_token) then
						internal_token := internal_token.next
					elseif is_eol (internal_token) then
						internal_line := internal_line.next
						if internal_line /= Void then
							internal_token := internal_line.first_token
						else
							found_end_of_class_name := False
						end
					else
						img := internal_token.image
						if img.is_equal (opening_bracket) then
							brackets := brackets + 1
						elseif img.is_equal (closing_bracket) then
							brackets := brackets - 1
						end
						internal_token := internal_token.next
					end
				end
			end
			if found_end_of_class_name then
				internal_token := internal_token.previous
			else
				internal_line := starting_line
				internal_token := starting_token
			end
			
		end
	
	go_to_next_non_blank_token is
			-- Starting from `internal_token' and `internal_line', move forward to the first next text token.
		do
			from
				
			until
				internal_token = Void or else not (is_skippable (internal_token) or else is_eol (internal_token))
			loop
				if is_skippable (internal_token) then
					internal_token := internal_token.next
				else
					internal_line := internal_line.next
					if internal_line /= Void then
						internal_token := internal_line.first_token
					else
						internal_token := Void
					end
				end
			end
		end

	go_to_previous_non_blank_token is
			-- Starting from `internal_token' and `internal_line', move backward to the first previous text token.
		do
			from
				internal_token := internal_token.previous
			until
				internal_token = Void or else not (is_skippable (internal_token) or else internal_token = internal_line.real_first_token)
			loop
				if is_skippable (internal_token) then
					internal_token := internal_token.previous
				else
					internal_line := internal_line.previous
					if internal_line /= Void then
						internal_token := internal_line.eol_token.previous
					else
						internal_token := Void
					end
				end
			end
		end
	
	is_skippable (a_token: EDITOR_TOKEN): BOOLEAN is
			-- Can we skip this token?
		do
			Result := is_blank (a_token) or else is_comment (a_token)
		end
		

end -- class EB_LOCAL_ANALYZER

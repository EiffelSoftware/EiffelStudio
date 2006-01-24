indexing
	description: "Objects that build the list of local variables and arguments corresponding to a location in a class text"
	author: "author"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_LOCAL_ENTITIES_FINDER_FROM_TEXT

inherit
	ANY

	EB_TOKEN_TOOLKIT
		export
			{NONE} All
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} All
		end

	SHARED_NAMES_HEAP
		export
			{NONE} All
		end

	EB_LOCAL_ENTITIES_FINDER

create
	make

feature {NONE} -- Initialization

	make is
			-- initialize `Current'.
		do
			create found_entities.make (2)
			create found_locals_list.make (2)
			create found_arguments_list.make (2)
		end

feature -- Basic Operations

	build_entities_list (line: EDITOR_LINE; token: EDITOR_TOKEN) is
			-- Build list of locals and argument types (`found_entities') corresponding to a position
			-- in a text defined by `line' and `token'.		
		do
			reset
			build_local_entities_list (line, token)
			build_argument_entities_list (line, token)
			found_entities := found_locals_list
			found_entities.append (found_arguments_list)
			search_for_return_type
		end

	reset is
			-- Wipe lists out .
		do
			has_return_type := False
			found_entities.wipe_out
			found_locals_list.wipe_out
			found_arguments_list.wipe_out
		ensure then
			found_entities_empty: found_entities.is_empty
			found_locals_list_empty: found_locals_list.is_empty
			found_arguments_list_empty: found_arguments_list.is_empty
		end

feature -- Access

	found_names: LINKED_LIST [STRING] is
			-- List of found entity names.
		local
			id_list: ARRAYED_LIST [INTEGER]
		do
			create Result.make
			if found_entities /= Void and not found_entities.is_empty then
				from
					found_entities.start
				until
					found_entities.after
				loop
					from
						id_list := found_entities.item.id_list
						id_list.start
					until
						id_list.after
					loop
						Result.extend (Names_heap.item (id_list.item))
						id_list.forth
					end
					found_entities.forth
				end
			end
		end

	found_locals_list: EIFFEL_LIST [TYPE_DEC_AS]
			-- List of found locals for current routine

	has_return_type: BOOLEAN
			-- Does feature have a return type?

feature {NONE} -- Implementation

	build_local_entities_list (line: EDITOR_LINE; token: EDITOR_TOKEN) is
			-- Build list of local types corresponding to a position a text defined by `line' and `token'.
			-- Resulting local nodes will be put in `found_locals_list'.
		require
			found_locals_list_empty: found_locals_list.is_empty
		local
			l_local_string: STRING
			retried: BOOLEAN
			l_found_locals: like found_locals_list
		do
			if not retried then
				internal_token := token.previous
				internal_line := line
				search_for_local_clause
				if found_local_keyword then
					look_for_locals := True
					l_local_string := local_string
					if not l_local_string.is_empty then
						entity_declaration_parser.parse_from_string (l_local_string)
					end
					l_found_locals := entity_declaration_parser.entity_declaration_node
				else
					internal_token := token.previous
					internal_line := line
				end
			end
			if l_found_locals /= Void then
				found_locals_list := l_found_locals
			end
		rescue
			retried := True
			retry
		end

	build_argument_entities_list (line: EDITOR_LINE; token: EDITOR_TOKEN) is
			-- Build list of argument types corresponding to a position a text defined by `line' and `token'.
			-- Resulting local nodes will be put in `found_arguments_list'.
		require
			found_arguments_list_empty: found_arguments_list.is_empty
		local
			l_arguments_string: STRING
			retried: BOOLEAN
			l_found_args: like found_arguments_list
		do
			if not retried then
				internal_token := token.previous
				internal_line := line
				search_for_arguments
				if found_arguments then
					look_for_locals := False
					l_arguments_string := arguments_string
					if not l_arguments_string.is_empty then
						entity_declaration_parser.parse_from_string (l_arguments_string)
					end
					l_found_args := entity_declaration_parser.entity_declaration_node
				else
					internal_token := token.previous
					internal_line := line
				end
			end
			if l_found_args /= Void then
				found_arguments_list := l_found_args
			end
		rescue
			retried := True
			retry
		end

	build_return_type (line: EDITOR_LINE; token: EDITOR_TOKEN) is
			-- Attempts to locate a return type for the feature where `token' resides
		local
			retried: BOOLEAN
		do
			if not retried then
				internal_token := token.previous
				internal_line := line
				search_for_return_type
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation: Access	

	found_entities: EIFFEL_LIST [TYPE_DEC_AS]

	found_arguments_list: EIFFEL_LIST [TYPE_DEC_AS]

feature {NONE} -- Implementation

	internal_token: EDITOR_TOKEN

	internal_line: EDITOR_LINE

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
			found_local_keyword := False
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
			found_arguments := False
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
						end
					end
					internal_token := internal_token.previous
				end
			end
		end

	search_for_return_type is
			-- Examines the editor tokens to attempt to infer if the feature
		local
			stop: BOOLEAN
			kw: EDITOR_TOKEN_KEYWORD
			cls: EDITOR_TOKEN_CLASS
			lgth: INTEGER
		do
			has_return_type := False
			from
			until
				stop or has_return_type
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
								cls ?= internal_token
								has_return_type := cls /= Void
							end
						end
					end
					internal_token := internal_token.previous
				end
			end
		end

	local_string: STRING is
			-- Build a string of locals starting at `internal_line' and `internal_token'.
			-- Results will be of form `local ...locals..'
		local
			stop: BOOLEAN
		do
			create Result.make_from_string (local_word + "%N")
			from
				internal_token := internal_token.next.next
			until
				stop
			loop
				from
				until
					stop or else internal_token = internal_line.eol_token
				loop
							-- expecting local name
					if is_stopping (internal_token) then
						stop := True
					else
						Result.append (internal_token.image)
					end
					internal_token := internal_token.next
				end

				if not stop then
					Result.append ("%N")
						-- Go to the next line
					internal_line := internal_line.next
					if internal_line /= Void then
						internal_token := internal_line.first_token
					else
						stop := True
					end
				end
			end
		end

	arguments_string: STRING is
			-- Build a string of locals starting at `internal_line' and `internal_token'.
			-- Results will be of form `local ...locals..'
		local
			stop: BOOLEAN
		do
			create Result.make_from_string (local_word + "%N")
			from
				internal_token := internal_token.next.next
			until
				stop
			loop
				from
				until
					stop or else internal_token = internal_line.eol_token
				loop
							-- expecting local name
					if is_stopping (internal_token) then
						stop := True
					else
						Result.append (internal_token.image)
					end
					internal_token := internal_token.next
				end

				if not stop then
					Result.append ("%N")
						-- Go to the next line
					internal_line := internal_line.next
					if internal_line /= Void then
						internal_token := internal_line.first_token
					else
						stop := True
					end
				end
			end
		end

	is_stopping (tok: EDITOR_TOKEN): BOOLEAN is
			-- Should we stop list building if we encounter `tok'?
		do
			if look_for_locals then
				Result := is_keyword (tok) and then not token_image_is_same_as_word (tok, current_word) and then not token_image_is_same_as_word (tok, like_word)
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

invariant
	found_locals_list_not_void: found_locals_list /= Void
	found_entities_not_void: found_entities /= Void
	found_arguments_list_not_void: found_arguments_list /= Void

end -- class EB_LOCAL_ANALYZER

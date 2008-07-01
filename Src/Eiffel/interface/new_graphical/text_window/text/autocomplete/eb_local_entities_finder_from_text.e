indexing
	description: "Objects that build the list of local variables and arguments corresponding to a location in a class text"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	build_entities_list (line: EDITOR_LINE; token: EDITOR_TOKEN; a_class_c: CLASS_C) is
			-- Build list of locals and argument types (`found_entities') corresponding to a position
			-- in a text defined by `line' and `token'.		
		do
			reset
			set_up_parser (a_class_c)
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

	found_names: LINKED_LIST [STRING_32] is
			-- List of found entity names.
		local
			id_list: IDENTIFIER_LIST
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

	set_up_parser (a_class: CLASS_C) is
			-- Set up formal generic parameters for `entity_declaration_parser'.
		local
			formal_dec_list: EIFFEL_LIST [FORMAL_DEC_AS]
		do
			if a_class /= Void then
				formal_dec_list := a_class.generics
				if formal_dec_list /= Void then
					from
						entity_declaration_parser.formal_parameters.wipe_out
						formal_dec_list.start
					until
						formal_dec_list.after
					loop
						entity_declaration_parser.formal_parameters.extend (formal_dec_list.item.formal.twin)
						formal_dec_list.forth
					end
				end
			end
		end

	build_local_entities_list (line: EDITOR_LINE; token: EDITOR_TOKEN) is
			-- Build list of local types corresponding to a position a text defined by `line' and `token'.
			-- Resulting local nodes will be put in `found_locals_list'.
		require
			line_not_void: line /= Void
			found_locals_list_empty: found_locals_list.is_empty
		local
			l_local_string: STRING_32
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
			l_arguments_string: STRING_32
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
			img: STRING_32
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
								if token_equal (internal_token, closing_parenthesis) then
									par_found := True
								elseif not token_equal (internal_token, closing_bracket) then
										-- most common cases :
										--          feature_name arguments : non_generic_class_name is (1)
										--          feature_name : non_generic_class_name is (2)
										--          feature_name is (3)
										-- we eliminate (2) and (3)
									go_to_previous_non_blank_token
									if internal_token /= Void then
										if token_equal (internal_token, like_word) then
											go_to_previous_non_blank_token
										end
										if internal_token /= Void then
												-- In case (3) there is no colon
											if token_equal (internal_token, colon) then
												go_to_previous_non_blank_token
													-- in case (2) there is no parenthesis
												if internal_token /= Void and then token_equal (internal_token, closing_parenthesis) then
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
										img := internal_token.wide_image
										lgth := img.count
										if
											(lgth = 3 and then token_equal (internal_token, end_word))
										then
											stop := True
										elseif par_found then
											if token_equal (internal_token, opening_parenthesis) then
												found_arguments := True
												stop := True
											end
										elseif token_equal (internal_token, colon) then
											go_to_previous_non_blank_token
											if internal_token /= Void then
												if token_equal (internal_token, closing_parenthesis) then
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
						-- Test here is needed as reported in bug#10974 `internal_token'
						-- can be Void.
					if internal_token /= Void then
						internal_token := internal_token.previous
					end
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

	local_string: STRING_32 is
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
						Result.append (internal_token.wide_image)
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

	arguments_string: STRING_32 is
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
						Result.append (internal_token.wide_image)
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
				Result := token_equal (tok, closing_parenthesis)
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
			if found_end_of_class_name and then token_equal (internal_token, opening_bracket) then
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
						if token_equal (internal_token, opening_bracket) then
							brackets := brackets + 1
						elseif token_equal (internal_token, closing_bracket) then
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
				if internal_token = Void then
					if internal_line /= Void then
						internal_line := internal_line.previous
						if internal_line /= Void then
							internal_token := internal_line.eol_token.previous
						end
					end
				end
			until
				internal_token = Void or else not is_skippable (internal_token)
			loop
				internal_token := internal_token.previous
				if internal_token = Void then
					if internal_line /= Void then
						internal_line := internal_line.previous
						if internal_line /= Void then
							internal_token := internal_line.eol_token.previous
						end
					end
				end
			end
		end

	is_skippable (a_token: EDITOR_TOKEN): BOOLEAN is
			-- Can we skip this token?
		do
			if a_token = Void then
				Result := True
			else
				Result := not a_token.is_text or else is_comment (a_token)
			end
		end

invariant
	found_locals_list_not_void: found_locals_list /= Void
	found_entities_not_void: found_entities /= Void
	found_arguments_list_not_void: found_arguments_list /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class EB_LOCAL_ANALYZER

indexing
	description: "[
			Encapsulates a completion stack frame, containing stacked local data.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_ANALYZER_FRAME

inherit
	ANY

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

create
	make,
	make_parented

feature {NONE} -- Initialization

	make (a_class: !like context_class; a_feature: !like context_feature)
			-- Initialize a new context frame.
			--
			-- `a_class'  : A context class to use to resolve type information from.
			-- `a_feature': A context feature used to resolve type information.
		do
			context_class := a_class
			context_feature := a_feature
		ensure
			context_class_set: context_class = a_class
			context_feature_set: context_feature = a_feature
		end

	make_parented (a_class: !like context_class; a_feature: !like context_feature; a_parent: !like parent)
			-- Initialize a context frame with a parent frame.
			--
			-- `a_class'  : A context class to use to resolve type information from.
			-- `a_feature': A context feature used to resolve type information.
			-- `a_parent' : A parent frame, used for merging local entities.
		require
			non_circular_parent: not is_parented_to_current (a_parent)
		do
			parent := a_parent
			make (a_class, a_feature)
		ensure
			context_feature_set: context_feature = a_feature
			parent_set: parent = a_parent
		end

feature -- Access

	context_class: !CLASS_C
			-- The context class of the current frame, used to resolve type information.

	context_feature: !FEATURE_I
			-- The context feature of the current frame, used to resolve type information.

feature {ES_EDITOR_ANALYZER_FRAME} -- Access

	parent: ES_EDITOR_ANALYZER_FRAME
			-- A parent context frame.

feature {NONE} -- Access

	string_local_declarations: !HASH_TABLE [!STRING_32, !STRING_32]
			-- Table of raw string local declarations, ones the were added through `add_local'
			--
			-- value: Class type description.
			-- key: Entity name.
		local
			l_result: ?like internal_string_local_declarations
		do
			l_result := internal_string_local_declarations
			if l_result = Void then
				create Result.make (1)
				Result.compare_objects
				internal_string_local_declarations := Result
			else
				Result := l_result
			end
		ensure
			result_consistent: Result = string_local_declarations
			result_compares_objects: Result.object_comparison
		end

	ast_local_declarations: !HASH_TABLE [!TYPE_AS, !STRING_32]
			-- Table of AST local declarations, ones the were added through `add_local'
			--
			-- value: Class type description.
			-- key: Entity name.
		local
			l_result: ?like internal_ast_local_declarations
		do
			l_result := internal_ast_local_declarations
			if l_result = Void then
				create Result.make (1)
				Result.compare_objects
				internal_ast_local_declarations := Result
			else
				Result := l_result
			end
		ensure
			result_consistent: Result = ast_local_declarations
			result_compares_objects: Result.object_comparison
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Indicates if the current frame has an local entities.
		do
			Result := (internal_locals = Void or else internal_locals.is_empty) and then
				(internal_string_local_declarations = Void or else internal_string_local_declarations.is_empty) and then
				(internal_ast_local_declarations = Void or else internal_ast_local_declarations.is_empty)

			if Result and then not is_stop_frame then
				Result := parent.is_empty
			end
		end

	is_stop_frame: BOOLEAN
			-- Indicates if the current frame is a "new" frame, meaning any merging of parent information
			-- should stop at this frame.
		do
			Result := not has_parent
		ensure
			has_parent: not Result implies has_parent
		end

	is_parented_to_current (a_parent: !ES_EDITOR_ANALYZER_FRAME): BOOLEAN
			-- Determines if a parent has Current has a parent.
		local
			l_next_parent: ?like parent
		do
			if not a_parent.is_stop_frame then
				Result := a_parent.parent = Current
				if not Result and then has_parent then
					l_next_parent := parent
					if l_next_parent /= Void then
						Result := is_parented_to_current (l_next_parent)
					end
				end
			end
		end

feature {NONE} -- Status report

	has_parent: BOOLEAN
			-- Indicates if the current frame has a parent frame
		do
			Result := parent /= Void
		ensure
			parent_attached: Result implies parent /= Void
		end

feature -- Query

	locals: !HASH_TABLE [TYPE_A, !STRING_32]
			-- Type evaluated local entities of the Current frame.
			--
			-- value: Class type description.
			-- key: Local entity name.
		local
			l_result: ?like internal_locals
			l_class: !like context_class
			l_feature: !like context_feature
			l_ast_locals: ?like internal_ast_local_declarations
			l_string_locals: ?like internal_string_local_declarations
			l_parsed_locals: !HASH_TABLE [!TYPE_AS, !STRING_32]
			l_locals: !HASH_TABLE [!TYPE_AS, !STRING_32]
			l_generator: like type_a_generator
			l_checker: like type_a_checker
			l_name: !STRING_32
			l_type: TYPE_A
		do
			create Result.make (7)

			l_result := internal_locals
			if l_result = Void then
				create l_locals.make (13)
				l_ast_locals := internal_ast_local_declarations
				if l_ast_locals /= Void and then not l_ast_locals.is_empty then
					l_locals.merge (l_ast_locals)
				end
				l_string_locals := internal_string_local_declarations
				if l_string_locals /= Void and then not l_string_locals.is_empty then
					l_parsed_locals := parsed_string_local_declarations
					if not l_parsed_locals.is_empty then
						l_locals.merge (l_parsed_locals)
					end
				end

				l_feature := context_feature
				l_class := context_class
				l_generator := type_a_generator
				l_checker := type_a_checker
				l_checker.init_with_feature_table (l_feature, l_class.feature_table, Void, Void)
				from l_locals.start until l_locals.after loop
					l_name := l_locals.key_for_iteration.as_attached
					l_type := l_generator.evaluate_type_if_possible (l_locals.item_for_iteration, l_class)
					if l_type /= Void then
						l_type := l_checker.solved (l_type, l_locals.item_for_iteration)
					end
					if l_type /= Void and then l_type.is_valid then
						Result.force (l_type, l_name)
					elseif not Result.has (l_name) then
						Result.force (Void, l_name)
					end
					l_locals.forth
				end

				internal_locals := Result
			else
				Result := l_result
			end
		ensure
			result_is_consitent: Result = locals
		end

	all_locals: !HASH_TABLE [TYPE_A, !STRING_32]
			-- Complete list of entities, including parent frames.
			--
			-- value: Class type description.
			-- key: Local entity name.
		do
			if is_stop_frame then
				create Result.make (29)
			else
				Result := parent.all_locals
			end
			if not is_empty then
				Result.merge (locals)
			end
		end

feature {NONE} -- Query

	parsed_string_local_declarations: !HASH_TABLE [!TYPE_AS, !STRING_32]
			-- Parses the string local declarations to retrieve a list of parsed AST declarations, similar
			-- to `ast_local_declarations'.
			--
			-- value: Type abstract syntax node.
			-- key: Local entity name.
		require
			internal_string_local_declarations_attached: internal_string_local_declarations /= Void
			not_internal_string_local_declarations_is_empty: not internal_string_local_declarations.is_empty
		local
			l_string_locals: !like string_local_declarations
			l_local_string: !STRING_32
			l_parser: EIFFEL_PARSER
			l_entities: EIFFEL_LIST [TYPE_DEC_AS]
			l_declarations: ARRAYED_LIST [TYPE_DEC_AS]
			l_entity_name_map: !HASH_TABLE [!STRING_32, !STRING_32]
			l_entity_name: !STRING_32
			l_prefix: !STRING_32
			l_type_dec: TYPE_DEC_AS
			l_type: TYPE_AS
			l_ids: IDENTIFIER_LIST
			l_name: STRING_32
		do
			l_string_locals := string_local_declarations
			create l_entity_name_map.make (l_string_locals.count)
			create l_prefix.make (25)
			l_prefix.append ("local_declaration_prefix_")

				-- Build a local string declaration
			create l_local_string.make ((200))
			l_local_string.append ({EIFFEL_KEYWORD_CONSTANTS}.local_keyword)
			from l_string_locals.start until l_string_locals.after loop
					-- Create an entity name map entry because the entity name might be a reserved word, whic
					-- cannot be parsed by the local entity parser.
				create l_entity_name.make (l_prefix.count + 20)
				l_entity_name.append (l_prefix)
				l_entity_name.append (l_string_locals.key_for_iteration)
				l_entity_name.to_lower
				l_entity_name_map.force (l_string_locals.key_for_iteration, l_entity_name)

				l_local_string.append_character ('%N')
				l_local_string.append (l_entity_name)
				l_local_string.append_character (':')
				l_local_string.append (l_string_locals.item_for_iteration)
				l_string_locals.forth
			end

				-- Parse local string declaration
			l_parser := entity_declaration_parser
			l_parser.parse_from_string (l_local_string)
			l_entities := l_parser.entity_declaration_node
			if l_entities = Void then
					-- There is a syntax error, try parsing one by one.
				from l_string_locals.start until l_string_locals.after loop
						-- Create an entity name map entry because the entity name might be a reserved word, whic
						-- cannot be parsed by the local entity parser.
					create l_entity_name.make (l_prefix.count + 20)
					l_entity_name.append (l_prefix)
					l_entity_name.append (l_string_locals.key_for_iteration)
					l_entity_name.to_lower
					check l_entity_name_map_has_l_entity_name: l_entity_name_map.has (l_entity_name) end

					l_local_string.wipe_out
					l_local_string.append ({EIFFEL_KEYWORD_CONSTANTS}.local_keyword)
						-- Wont work, need to recreate the name.
					l_local_string.append (l_entity_name)
					l_local_string.append_character (':')
					l_local_string.append (l_string_locals.item_for_iteration)

					l_parser.parse_from_string (l_local_string)
					l_entities := l_parser.entity_declaration_node
					if l_entities /= Void then
						l_declarations.extend (l_entities.first)
					end

					l_string_locals.forth
				end
			else
				l_declarations := l_entities
			end

				-- Build result, assigning the type declartation to an index local entity name.
			create Result.make (l_declarations.count * 2)
			from l_declarations.start until l_declarations.after loop
				l_type_dec := l_declarations.item
				if l_type_dec /= Void then
					l_ids := l_type_dec.id_list
					if l_ids /= Void then
							-- Iterate all ids.
						from l_ids.start until l_ids.after loop
							l_name := l_type_dec.item_name (l_ids.index)
							l_type := l_type_dec.type
							if l_type /= Void and then l_name /= Void and then not l_name.is_empty then
								check
										-- If this fails then conver the name to local case, the compiler must have changed.
										-- Or remove the two `l_entity_name.to_lower' called when extending `l_entity_name_map'.
									l_entity_name_map_has_l_name: l_entity_name_map.has (l_name)
								end
								Result.force (l_type, l_entity_name_map.item (l_name))
								internal_locals := Void
							else
								check False end
							end
							l_ids.forth
						end
					end
				end
				l_declarations.forth
			end
		end

feature -- Extension

	add_local (a_type: !TYPE_DEC_AS)
			-- Adds a local entity to the frame, from an AST local declaration.
			--
			-- `a_type': The local type declaration.
		local
			l_ids: IDENTIFIER_LIST
			l_name: STRING_32
			l_type: TYPE_AS
		do
			l_ids := a_type.id_list
			if l_ids /= Void then
				l_type := a_type.type
				if l_type /= Void then
					from l_ids.start until l_ids.after loop
						l_name := a_type.item_name (l_ids.index)
						if l_name /= Void and then not l_name.is_empty then
							ast_local_declarations.force (l_type, l_name)
							internal_locals := Void
						else
							check False end
						end
						l_ids.forth
					end
				end
			end
		ensure
			internal_locals_detached: internal_locals = Void
			not_is_empty: not is_empty
		end

	add_local_string (a_name: !STRING_32; a_type_name: !STRING_32)
			-- Adds a local entity to the frame.
			--
			-- `a_name'     : The name of the local entity.
			-- `a_type_name': The name of type for the local entity.
		require
			not_a_name_is_empty: not a_name.is_empty
			not_a_type_name_is_empty: not a_type_name.is_empty
		do
			string_local_declarations.force (a_type_name, a_name)
			internal_locals := Void
		ensure
			string_local_declarations_a_name: string_local_declarations.has (a_name)
			internal_locals_detached: internal_locals = Void
			not_is_empty: not is_empty
		end

feature {NONE} -- Implementation: Internal cache

	internal_string_local_declarations: ?like string_local_declarations
			-- Cached version of `string_local_declarations'.
			-- Note: Do not use directly!

	internal_ast_local_declarations: ?like ast_local_declarations
			-- Cached version of `ast_local_declarations'.
			-- Note: Do not use directly!

	internal_locals: ?like locals
			-- Cached version of `locals'.
			-- Note: Do not use directly!

invariant
	--non_circular_parent: has_parent implies parent /= Void and then not is_parented_to_current (parent)

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end

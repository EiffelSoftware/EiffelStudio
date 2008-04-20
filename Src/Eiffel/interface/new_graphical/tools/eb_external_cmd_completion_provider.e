indexing
	description: "[
			Auto-completion provider for external command
			Allow four kinds of completaions:
			1) Class name: {SOME -> {SOME_CLASS}
			2) Feature name: {SOME_CLASS}.some -> {SOME_CLASS}.some_feature
			3) Tool name: [Met -> [Metrics]
			4) placeholder: $pa -> $path, $fil -> $file (list not complete)
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_CMD_COMPLETION_PROVIDER

inherit
	COMPLETION_POSSIBILITIES_PROVIDER
		redefine
			code_completable,
			completion_possibilities,
			prepare_completion
		end

	QL_SHARED

	EB_SHARED_PREFERENCES

	SHARED_WORKBENCH

create
	make

feature{NONE} -- Initialization

	make (a_possibilities: like completion_possibilities) is
			-- Initialize `completion_possibilities' with `a_possibilities'.
		do
			completion_possibilities := a_possibilities
			create factory
			create scanner.make (factory, create {YY_BUFFER}.make (""))
		ensure
			completion_possibilities_set: completion_possibilities = a_possibilities
		end

feature -- Access

	code_completable: EB_EXTERNAL_CMD_COMBO_BOX
			-- A code completable.

	completion_possibilities: SORTABLE_ARRAY [like name_type]
			-- Completions proposals found by `prepare_auto_complete'

feature {CODE_COMPLETABLE} -- Basic operation

	prepare_completion is
			-- Prepare completion possibilities.
		local
			l_text_before_caret: STRING_32
			l_class_name: STRING
			l_feature: TUPLE [class_name: STRING; feature_name: STRING]
			l_done: BOOLEAN
			l_placeholder: STRING
			l_class_i: CLASS_I
		do
			if workbench.system_defined and then workbench.is_already_compiled then
				l_text_before_caret := code_completable.text.substring (1, code_completable.caret_position - 1)
				l_class_name := extracted_class_part_at_end (l_text_before_caret)
				if l_class_name /= Void then
					l_done := True
					completion_possibilities := class_possibilities
					insertion_internal := l_class_name
				end
				if not l_done then
					l_feature := extracted_feature_part_at_end (l_text_before_caret)
					if l_feature /= Void then
						l_class_i := factory.class_with_name (l_feature.class_name)
						if l_class_i /= Void and then l_class_i.is_compiled then
							completion_possibilities := feature_possibilities (l_class_i.compiled_class)
							insertion_internal := l_feature.feature_name
							l_done := True
						end
					end
				end
				if not l_done then
					l_placeholder := extracted_placeholder_part_at_end (l_text_before_caret)
					if l_placeholder /= Void then
						l_done := True
						completion_possibilities := placeholder_possibilities
						insertion_internal := l_placeholder
					end
				end
			end
			if not l_done then
				completion_possibilities := Void
			end
			Precursor
		end

feature{NONE} -- Implementation

	insertion_internal: STRING

	insertion: STRING is
			-- String to be partially completed

		do
			if insertion_internal /= Void then
				Result := insertion_internal
			else
				Result := ""
			end
		end

	insertion_remainder: INTEGER is
			-- The number of characters in the insertion remaining from the cursor position to the
			-- end of the token
		do
			Result := 0
		end

	class_possibilities: like completion_possibilities is
			-- Class possibilities
		local
			l_generator: QL_CLASS_DOMAIN_GENERATOR
			l_class_domain: QL_CLASS_DOMAIN
			l_index: INTEGER
			l_count: INTEGER
		do
			create l_generator.make (Void, True)
			l_class_domain ?= system_target_domain.new_domain (l_generator)

			l_count := l_class_domain.count
			create Result.make (1, l_count)
			from
				l_class_domain.start
				l_index := 1
			until
				l_class_domain.after
			loop
				Result.put (create {EB_CLASS_FOR_COMPLETION}.make (l_class_domain.item.class_i), l_index)
				l_index := l_index + 1
				l_class_domain.forth
			end
			Result.sort
		ensure
			result_attached: Result /= Void
		end

	feature_possibilities (a_class: CLASS_C): like completion_possibilities is
			-- Feature possibilities from `a_class'
		require
			a_class_attached: a_class /= Void
		local
			l_feature_table: FEATURE_TABLE
			l_index: INTEGER
			l_feature: E_FEATURE
			l_feature_item: EB_FEATURE_FOR_COMPLETION
		do
			if a_class.has_feature_table then
				l_feature_table := a_class.feature_table
				create Result.make (1, l_feature_table.count)
				from
					l_feature_table.start
					l_index := 1
				until
					l_feature_table.after
				loop
					l_feature := l_feature_table.item_for_iteration.e_feature
					create l_feature_item.make (l_feature, Void, False, is_upper_required (l_feature))
					l_feature_item.set_insert_name (l_feature.name)
					Result.put (l_feature_item, l_index)
					l_index := l_index + 1
					l_feature_table.forth
				end
				Result.sort
			else
				create Result.make (1, 0)
			end
		ensure
			result_attached: Result /= Void
		end

	is_upper_required (a_feat: E_FEATURE): BOOLEAN is
			-- Did user configured his system to have once and constants with an upper case?
		require
			a_feat_not_void: a_feat /= Void
		do
			Result := not (a_feat.is_infix or a_feat.is_prefix) and (a_feat.is_once or a_feat.is_constant) and preferences.editor_data.once_and_constant_in_upper
		end

	placeholder_possibilities: like completion_possibilities is
			-- Possibilities for placeholders such as $file, $path
		do
			create Result.make (1, 13)
			Result.put (create {NAME_FOR_COMPLETION}.make ("$file_name"), 1)
			Result.put (create {NAME_FOR_COMPLETION}.make ("$path"), 2)
			Result.put (create {NAME_FOR_COMPLETION}.make ("$file"), 3)
			Result.put (create {NAME_FOR_COMPLETION}.make ("$class_name"), 4)
			Result.put (create {NAME_FOR_COMPLETION}.make ("$directory_name"), 5)
			Result.put (create {NAME_FOR_COMPLETION}.make ("$group_name"), 6)
			Result.put (create {NAME_FOR_COMPLETION}.make ("$group_directory"), 7)
			Result.put (create {NAME_FOR_COMPLETION}.make ("$line"), 8)
			Result.put (create {NAME_FOR_COMPLETION}.make ("$project_directory"), 9)
			Result.put (create {NAME_FOR_COMPLETION}.make ("$target_directory"), 10)
			Result.put (create {NAME_FOR_COMPLETION}.make ("$f_code"), 11)
			Result.put (create {NAME_FOR_COMPLETION}.make ("$w_code"), 12)
			Result.put (create {NAME_FOR_COMPLETION}.make ("$target_name"), 13)
			Result.sort
		ensure
			result_attached: Result /= Void
		end

	extracted_class_part_at_end (a_text: STRING): STRING is
			-- Class part of `a_text' at the end, if not found, return Void
		require
			a_text_attached: a_text /= Void
		local
			l_text: STRING
			l_scanner: like scanner
			l_last_fragment: EB_TEXT_FRAGMENT
			l_data: INTEGER_REF
			l_fragment_type: INTEGER
		do
			if not a_text.is_empty then
				if a_text.item (a_text.count) = '{' then
					Result := ""
				else
					l_text := a_text.twin
					l_text.append_character ('}')
					l_scanner := scanner
					l_scanner.wipe_text_fragments
					l_scanner.reset
					l_scanner.set_input_buffer (create {YY_BUFFER}.make (l_text))
					l_scanner.scan
					if not l_scanner.text_fragments.is_empty then
						l_last_fragment := l_scanner.text_fragments.last
						if l_last_fragment.location + l_last_fragment.text.count - 1 = l_text.count then
							l_data ?= l_last_fragment.data
							if l_data /= Void then
								l_fragment_type := l_data.item
								if
									l_fragment_type = {EB_COMMAND_SCANNER_SKELETON}.t_class_buffer or else
									l_fragment_type = {EB_COMMAND_SCANNER_SKELETON}.t_class_buffer_selected
								then
									Result := l_last_fragment.normalized_text
								end
							end
						end
					end
				end
			end
		end

	extracted_feature_part_at_end (a_text: STRING): TUPLE [class_name: STRING; feature_name: STRING] is
			-- Feature part from `a_text' in form of {CLASS}.feat, result will be ["CLASS", "feat"]
			-- Void if no suitable format is found
		require
			a_text_attached: a_text /= Void
		local
			l_text: STRING
			l_fake_feature: BOOLEAN
			l_scanner: like scanner
			l_last_fragment: EB_TEXT_FRAGMENT
			l_data: INTEGER_REF
			l_fragment_type: INTEGER
			l_normalized_text: STRING
			l_dot_index: INTEGER
			l_class_name: STRING
			l_feature_name: STRING
		do
			if a_text.count > 2 then
				l_text := a_text.twin
				if a_text.substring (a_text.count - 1, a_text.count).is_equal ("}.") then
					l_text.append_character ('a')
					l_fake_feature := True
				end
				l_scanner := scanner
				l_scanner.wipe_text_fragments
				l_scanner.reset
				l_scanner.set_input_buffer (create {YY_BUFFER}.make (l_text))
				l_scanner.scan
				if not l_scanner.text_fragments.is_empty then
					l_last_fragment := l_scanner.text_fragments.last
					if l_last_fragment.location + l_last_fragment.text.count -1 = l_text.count then
						l_data ?= l_last_fragment.data
						if l_data /= Void then
							l_fragment_type := l_data.item
							if
								l_fragment_type = {EB_COMMAND_SCANNER_SKELETON}.t_feature_buffer
							then
								l_normalized_text := l_last_fragment.normalized_text
								l_dot_index := l_normalized_text.index_of ('.', 1)
								l_class_name := l_normalized_text.substring (1, l_dot_index - 1)
								if l_fake_feature then
									l_feature_name := ""
								else
									l_feature_name := l_normalized_text.substring (l_dot_index + 1, l_normalized_text.count)
								end
								Result := [l_class_name, l_feature_name]
							end
						end
					end
				end
			end
		end

	extracted_placeholder_part_at_end (a_text: STRING): STRING is
			-- Placeholder part at end of `a_text'
			-- Void if not found
		require
			a_text_attached: a_text /= Void
		local
			l_index: INTEGER
			l_char: CHARACTER
			l_str: STRING
			l_done: BOOLEAN
			l_dollar: CHARACTER
		do
			l_dollar := '$'
			if not a_text.is_empty then
				if a_text.item (a_text.count) = l_dollar then
					Result := ""
				else
					from
						create l_str.make (20)
						l_index := a_text.count
					until
						l_index = 0 or l_done
					loop
						l_char := a_text.item (l_index)
						if l_char = l_dollar then
							Result := l_str
							l_done := True
						elseif not (l_char.is_alpha or l_char = '_') then
							l_done := True
						else
							l_str.prepend_character (l_char)
						end
						l_index := l_index - 1
					end
				end
			end
			if Result /= Void then
				Result.prepend_character (l_dollar)
			end
		end

	scanner: EB_COMMAND_SCANNER
			-- Scanner used to scan external command

	factory: EB_EXTERNAL_COMMAND_TEXT_FRAGMENT_FACTORY
			-- Factory used in `scanner'

invariant
	scanner_attached: scanner /= Void
	factory_attached: factory /= Void

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

end


note
	description: "A template to be inserted into the auto-complete list."
	author: "javierv"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TEMPLATE_FOR_COMPLETION

inherit

	EB_NAME_FOR_COMPLETION
		rename
			make as make_old,
			code as code_completion
		redefine
			icon,
			tooltip_text,
			is_class,
			insert_name,
			grid_item,
			is_obsolete
		end

	PREFIX_INFIX_NAMES
		undefine
			out,
			copy,
			is_equal
		end

	EB_SHARED_EDITOR_TOKEN_UTILITY
		undefine
			out,
			copy,
			is_equal
		end

	EB_SHARED_PIXMAPS
		undefine
			out,
			copy,
			is_equal
		end

create
	make

create {EB_TEMPLATE_FOR_COMPLETION}
	make_old

feature {NONE} -- Initialization

	make (a_template: ES_CODE_TEMPLATE_DEFINITION_ITEM; a_stone: FEATURE_STONE; a_target: STRING_32)
			-- Create and initialize a new completion template using `a_template' ...
		require
			a_stone_not_void: a_stone /= Void
			a_template_not_void: a_template /= Void
		do
			template := a_template
			if attached a_template.title as l_title then
				make_old (l_title)
			end
			internal_stone := a_stone.twin
			target_name := a_target

				-- Initialize linked tokens
			create linked_tokens.make_caseless (0)

		ensure
			template_set: template = a_template
			target_set: target_name = a_target
		end

feature -- Access

	target_name: STRING_32
			-- Target name where we want to apply code completion.

	is_class: BOOLEAN = False
			-- Is completion feature a class, of course not.

	insert_name: STRING_32
			-- Name to insert in editor
		do
			if attached template.title as l_title then
				Result := l_title
			end
		end

	template: ES_CODE_TEMPLATE_DEFINITION_ITEM
			-- Full template to insert in editor

	code_texts: TUPLE [locals: STRING_32; code: STRING_32; linked_tokens: ARRAY [READABLE_STRING_GENERAL]]
			-- Locals declaration text and code text from template, and also the linked token strings to be linked.
		local
			l_tuple: TUPLE [a_locals: STRING_32; a_code: STRING_32]
			l_code: STRING_32
			l_locals: STRING_32
		do
				-- Initialize linked token with locals, if any.
			if attached template.locals then
				linked_tokens.copy (template.locals)
			end
			l_tuple := update_locals_and_code
			l_code := l_tuple.a_code
			l_locals := l_tuple.a_locals
--			add_comments (l_code)

			if attached update_tokens (l_code, l_locals) as l_new_code then
				Result := [l_locals, l_new_code, linked_tokens.current_keys]
			else
				Result := [l_locals, l_code, linked_tokens.current_keys]
			end
		end

	template_declarations: STRING_TABLE [STRING_32]
			-- Formal arguments and Local variables definitions for the given template.
		do
			Result := template.declarations
			if not attached Result then
				create Result.make (0)
			end
		end

	icon: EV_PIXMAP
			-- Associated icon based on data
		do
			Result := icon_pixmaps.information_affected_resource_icon
		end

	tooltip_text: STRING_32
			-- Text for tooltip of Current.  The tooltip shall display information which is not included in the
			-- actual output of Current.
		do
			create Result.make_empty
			if attached template.description as l_description then
				Result.append_string_general (l_description)
			end
			if Result.is_empty then
				Result.append_string_general ("Template with empty description.")
			end
		end

	grid_item: EB_GRID_EDITOR_TOKEN_ITEM
			-- Corresponding grid item
		do
			create Result
			Result.set_overriden_fonts (label_font_table, label_font_height)
			Result.set_pixmap (icon)
			Result.set_text (insert_name)
		end

feature {NONE} -- String Utility

	new_name (a_string: STRING_32; i: INTEGER): STRING_32
			-- Create a new name
		do
			create Result.make_from_string (a_string)
			Result.append (i.out)
		end

feature {NONE} -- Template implementation.

	code: STRING_32
			-- template code.
		do
			if attached template.code as l_code then
				create Result.make_from_string (l_code)
				Result.append_character ('%N')
			else
				Result := ""
			end
		end

	local_text: STRING_32
		do
			create Result.make_empty
			if attached template_declarations as l_locals then
				across
					l_locals as ic
				loop
					Result.append_string_general ("%T%T%T")
					Result.append_string_general (ic.key)
					Result.append (": ")
					Result.append_string_general (ic.item)
					Result.append_character ('%N')
				end
			end
		end

	update_locals_and_code: TUPLE [locals: STRING_32; code: STRING_32]
			-- Update local and code definitions.
		local
			l_scanner: EDITOR_EIFFEL_SCANNER
			l_token: EDITOR_TOKEN
			l_locals: STRING_TABLE [TYPE_AS]
			l_arguments: STRING_TABLE [TYPE_A]
			l_read_only_locals: STRING_TABLE [STRING]
			l_code_tb: ES_CODE_TEMPLATE_BUILDER
			l_name: STRING_32
			i: INTEGER
			l_rename_table: STRING_TABLE [STRING_32]
			l_local_text: STRING_32
			l_code_text: STRING_32
			l_template_declarations: STRING_TABLE [STRING_32]
			l_default_value: STRING_32
			l_str: STRING_32
		do
			--| TODO refactor code.
			l_template_declarations := template_declarations.twin

				-- retrieve locals variables
				-- and read only locals variables
				-- for the target feature where
				-- we will include our template.

			create l_code_tb
			l_locals := l_code_tb.locals (e_feature)
			l_arguments := l_code_tb.arguments (e_feature)
			l_code_tb.process_read_only_locals (e_feature)
			l_read_only_locals := l_code_tb.read_only_locals



			create l_rename_table.make_caseless (2)

			across
				l_template_declarations as ic
			loop
				if l_arguments /= Void and then l_arguments.has (ic.key) then
					if not l_code_tb.string_type_a_conformance (ic.item, l_arguments.item (ic.key), class_c) then
							-- the current argument variable does not conforms to the variable in the template
							-- for example b: STRING; b: INTEGER
							-- we generate a new variable name for the template.
						from
							i := 1
							l_name := new_name (ic.key.as_string_32, i)
						until
							not l_locals.has (l_name) and then
							not l_arguments.has (l_name) and then
							(l_read_only_locals = Void or else not l_read_only_locals.has (l_name)) and then
							not l_rename_table.has (l_name)
						loop
							i := i + 1
							l_name := new_name (ic.key.as_string_32, i)
						end
						l_rename_table.force (l_name, ic.key)

							-- Update linked tokens
						if linked_tokens.has (ic.key) then
							linked_tokens.replace_key (l_name, ic.key)
						end
					end
				elseif l_locals.has (ic.key) then
						-- the current local variable conforms to the variable in the template
					if not l_code_tb.string_type_as_conformance (ic.item, l_locals.item (ic.key), class_c) then
							-- the current local variable does not conforms to the variable in the template
							-- for example b: STRING; b: INTEGER
							-- we generate a new variable name for the template.
						from
							i := 1
							l_name := new_name (ic.key.as_string_32, i)
						until
							not l_locals.has (l_name) and then
							not l_arguments.has (l_name) and then
							(l_read_only_locals = Void or else not l_read_only_locals.has (l_name)) and then
							not l_rename_table.has (l_name)
						loop
							i := i + 1
							l_name := new_name (ic.key.as_string_32, i)
						end
						l_rename_table.force (l_name, ic.key)

							-- Update linked tokens
						if linked_tokens.has (ic.key) then
							linked_tokens.replace_key (l_name, ic.key)
						end
					end
				elseif l_read_only_locals /= Void and then l_read_only_locals.has (ic.key) then
						-- The current local variable from the template has the same name as a read only variable
						-- We need to generate a new variable for the template.
					from
						i := 1
						l_name := new_name (ic.key.as_string_32, i)
					until
						not l_locals.has (l_name) and then
						not l_arguments.has (l_name) and then
						not l_read_only_locals.has (l_name) and then
						not l_rename_table.has (l_name)
					loop
						i := i + 1
						l_name := new_name (ic.key.as_string_32, i)
					end
					l_rename_table.force (l_name, ic.key)
						-- Update linked tokens
					if linked_tokens.has (ic.key) then
						linked_tokens.replace_key (l_name, ic.key)
					end
				end
			end
				-- Is the current template a query?
			if template.is_query then
				from
					i := 0
					l_name := "l_result"
				until
					not l_locals.has (l_name) and then
					not l_arguments.has (l_name) and then
					(l_read_only_locals = Void or else not l_read_only_locals.has (l_name)) and then
					not l_rename_table.has (l_name)
				loop
					i := i + 1
					l_name := new_name ("l_result", i)
				end
				l_rename_table.force (l_name, "Result")

					-- Add a new token to linked tokens
				linked_tokens.force ("", l_name)

			end

				-- Rename code and declarations if needed

			if not l_rename_table.is_empty then

					-- Update template declaration with context variable name
					-- iff we have a context.
				if attached template.context and attached template.arguments as ll_arguments then
					across ll_arguments as ic loop
						if l_template_declarations.has (ic.key) and then not ic.key.is_case_insensitive_equal ("Result") then
							l_template_declarations.remove (ic.key)
							l_rename_table.force (target_name, ic.key)
						end
					end
				end

					-- update default input values and check if they
					-- need to be ranamed.
				if attached template.default_input_values as l_input_values then
					across l_input_values as ic loop
						l_default_value := ic.item
						create l_str.make_empty
						l_str := l_default_value.substring (1, l_default_value.index_of ('.', 1) - 1)
						if l_rename_table.has (l_str) and then
						   attached {STRING_32} l_rename_table.item (l_str) as l_new_src then
							create l_str.make_from_string (l_new_src)
							l_str.append (l_default_value.substring (l_default_value.index_of ('.', 1), l_default_value.count))
							l_rename_table.force (l_str, ic.key)
								-- Add the new read only local name to the linked tokens.
							linked_tokens.force ("", l_str)
						end
					end
				end

					-- update declarations
				across
					l_rename_table as ic
				loop
					if l_template_declarations.has (ic.key) then
						l_template_declarations.replace_key (ic.item, ic.key)
					end
				end

					-- Generate local_text
				create l_local_text.make_empty
				across
					l_template_declarations as ic
				loop
					l_local_text.append_string_general ("%T%T%T")
					l_local_text.append_string_general (ic.key)
					l_local_text.append (": ")
					l_local_text.append_string_general (ic.item)
					l_local_text.append_string_general ("%N")
				end

					-- Generate new code
				create l_code_text.make_empty
				create l_scanner.make
				from
					l_scanner.execute (code)
					l_token := l_scanner.first_token
				until
					l_token = Void
				loop
					if l_rename_table.has (l_token.wide_image) then
						l_code_text.append (l_rename_table.item (l_token.wide_image))
					else
						l_code_text.append (l_token.wide_image)
					end
					l_token := l_token.next
				end
			else
				l_local_text := local_text
				l_code_text := code
			end
			Result := [l_local_text, l_code_text]
		end

feature -- Feature

	class_c: CLASS_C
			-- Compiled class
		do
			Result := internal_stone.e_class
		end

	class_i: CLASS_I
			-- Internal representation.

	e_feature: E_FEATURE
			--  Feature associated with stone.
		do
			Result := internal_stone.e_feature
		end

	stone: FEATURE_STONE
		do
			Result := internal_stone
		end

feature -- Status report

	set_class_i (a_class_i: like class_i)
		do
			class_i := a_class_i.twin
		end

	is_obsolete: BOOLEAN
			-- Is item obsolete?
		do
			Result := False
		end

feature -- Setting

	set_insert_name (a_name: like insert_name)
			-- Set `insert_name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			insert_name_internal := a_name.twin
		ensure
			insert_name_set: insert_name /= Void and then insert_name.is_equal (a_name)
		end

feature -- Implementation: Update tokens


	update_tokens (a_code: STRING_32; a_locals: STRING_32): STRING_32
			-- Update tokens: read only locals token found in
			-- the template.
			--! For example if we have a template like this
			--! across
			--!		element as i
			--!	from
			--!		....
			--!	loop
			--!		....
			--!	end
			--! and if the variable i is already used in the context (ie the feature target)
			--! we rename it.
		local
			l_scanner: EDITOR_EIFFEL_SCANNER
			l_token: EDITOR_TOKEN
			l_code_tb: ES_CODE_TEMPLATE_BUILDER
			l_locals: STRING_TABLE [TYPE_AS]
			l_arguments: STRING_TABLE [TYPE_A]
			l_rename_table: STRING_TABLE [STRING_32]
			l_name: STRING_32
			i: INTEGER
		do
				-- Prepare table with renaming read only locals.
			create l_code_tb
			l_locals := l_code_tb.locals (e_feature)
			l_arguments := l_code_tb.arguments (e_feature)
			l_code_tb.process_only_locals_template (feature_template_code (a_code, a_locals))
			create l_rename_table.make_caseless (2)

			if attached l_code_tb.read_only_locals_template as l_read_only_locals_template then
				across
					l_read_only_locals_template as ic
				loop
					if l_locals.has (ic.key) or else l_arguments.has (ic.key) then
						from
							i := 1
							l_name := new_name (ic.key.as_string_32, i)
						until
							not l_locals.has (l_name) and then not l_arguments.has (l_name)
						loop
							i := i + 1
							l_name := new_name (ic.key.as_string_32, i)
						end
						l_rename_table.force (l_name, ic.key)
						linked_tokens.force ("", l_name)
					else
						-- Add a new token to linked tokens
						--! (read only local variables.)
						linked_tokens.force ("", ic.key)
					end
				end
			end

				-- Rename locals if needed
			if not l_rename_table.is_empty then
				create Result.make_empty
				create l_scanner.make
				from
					l_scanner.execute (a_code)
					l_token := l_scanner.first_token
				until
					l_token = Void
				loop
					if l_rename_table.has (l_token.wide_image) then
						Result.append (l_rename_table.item (l_token.wide_image))
					else
						Result.append (l_token.wide_image)
					end
					l_token := l_token.next
				end
			end
		end


feature {NONE} -- Implementation: STONE

	internal_stone: FEATURE_STONE

feature {NONE} -- Implementation

	linked_tokens: STRING_TABLE [STRING_32]
			-- Linked tokens by name.

	add_comments (a_code: STRING_32)
			-- Add comments to the code `a_code' iff
			-- the tag description is filled in the
			-- Template definition in the metada section.
			-- In other case just add default
			-- start comments for the template.
			--! <metadata> ... <description>Some description</description> ....</metadata>
		local
			l_string: STRING
		do
			if attached template.description as l_description then
				if attached l_description.split ('%N') as l_lines and then l_lines.count > 1 then
					create l_string.make_from_string ("%N%T%T%T")
					across
						l_lines as ic
					loop
						l_string.append ("%N%T%T%T%T-- ")
						l_string.append (ic.item)
					end
					l_string.append (" `" + target_name + "'")
					a_code.prepend (l_string)
				else
					if l_description.is_empty then
						a_code.prepend ("%T%T%T")
						a_code.prepend ("%N%T%T%T%T-- start of template%N")
					else
						a_code.prepend ("%N%T%T%T")
						a_code.prepend (" `" + target_name + "'")
						a_code.prepend (l_description)
						a_code.prepend ("--")
						a_code.prepend ("%N%T%T%T%T")
					end
				end
			else
				a_code.prepend ("%N%T%T%T")
				a_code.prepend ("%T%T%T%T-- start of template%N")
			end
		end

	insert_name_internal: STRING_32

	feature_template_code (a_template: STRING_32; a_locals: STRING_32): STRING_32
			-- Wrap template `a_template' into a feature.
		do
			create Result.make_from_string ("f_567")
			Result.append_string ("%Nlocal")
			Result.append_string ("%N" + a_locals)
			Result.append_string ("%Ndo")
			Result.append_string ("%N" + a_template)
			Result.append_string ("%Nend")
			Result.adjust
		end;

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

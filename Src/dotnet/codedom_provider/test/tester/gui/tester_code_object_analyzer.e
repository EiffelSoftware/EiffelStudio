indexing
	description: "Analyze codedom member attributes to infer icon index and description"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_CODE_OBJECT_ANALYZER

inherit
	TESTER_ICONS_INDICES
		export
			{NONE} all
		end

	TESTER_CODEDOM_TYPES
		export
			{NONE} all
		end

feature -- Access

	image_index: INTEGER
			-- Image index of last analyzed member
	
	description: STRING
			-- Description of last analyzed member

	object_type: INTEGER
			-- Codedom object type
			-- See class {TESTER_CODEDOM_TYPES} for possible values.

feature -- Basic Operation

	analyze (a_object: ANY) is
			-- Analyze `a_object'.
			-- Set `image_index' and `description' accordingly.
		require
			non_void_member: a_object /= Void
		local
			l_constructor: SYSTEM_DLL_CODE_CONSTRUCTOR
			l_method: SYSTEM_DLL_CODE_MEMBER_METHOD
			l_event: SYSTEM_DLL_CODE_MEMBER_EVENT
			l_field: SYSTEM_DLL_CODE_MEMBER_FIELD
			l_property: SYSTEM_DLL_CODE_MEMBER_PROPERTY
			l_base_index: INTEGER
			l_type: SYSTEM_DLL_CODE_TYPE_DECLARATION
			l_attributes: SYSTEM_DLL_MEMBER_ATTRIBUTES
			l_snippet_member: SYSTEM_DLL_CODE_SNIPPET_TYPE_MEMBER
			l_type_attributes: TYPE_ATTRIBUTES
			l_compile_unit: SYSTEM_DLL_CODE_COMPILE_UNIT
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
			l_namespace: SYSTEM_DLL_CODE_NAMESPACE
			l_statement: SYSTEM_DLL_CODE_STATEMENT
			l_type_ref: SYSTEM_DLL_CODE_TYPE_REFERENCE
			l_comment: SYSTEM_DLL_CODE_COMMENT
			l_import: SYSTEM_DLL_CODE_NAMESPACE_IMPORT
			l_member: SYSTEM_DLL_CODE_TYPE_MEMBER
			l_base_types: SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION
			i, l_count: INTEGER
		do
			l_compile_unit ?= a_object
			if l_compile_unit /= Void then
				image_index := Compile_unit_icon
				description := "Compile unit"
				object_type := Codedom_compile_unit_type
			else
				l_expression ?= a_object
				if l_expression /= Void then
					image_index := Expression_icon
					description := "Expression"
					object_type := Codedom_expression_type
				else
					l_namespace ?= a_object
					if l_namespace /= Void then
						image_index := Namespace_icon
						description := "Namespace " + l_namespace.name
						object_type := Codedom_namespace_type
					else
						l_statement ?= a_object
						if l_statement /= Void then
							image_index := Statement_icon
							description := "Statement"
							object_type := Codedom_statement_type
						else
							l_type_ref ?= a_object
							if l_type_ref /= Void then
								image_index := Class_group
								description := "Type reference to " + l_type_ref.to_string
								object_type := Codedom_type_reference_type
							else
								l_comment ?= a_object
								if l_comment /= Void then
									image_index := primitive_icon
									description := "Comment: " + l_comment.text
									object_type := Codedom_comment_type
								else
									l_import ?= a_object
									if l_import /= Void then
										image_index := primitive_icon
										description := "Namespace import: " + l_import.namespace
										object_type := Codedom_import_type
									else
										l_type ?= a_object
										if l_type /= Void then
											object_type := Codedom_type_type
											if l_type.is_class then
												l_base_index := Class_group
												description := "class " + l_type.name
											elseif l_type.is_enum then
												l_base_index := Enum_group
												description := "enum " + l_type.name
											elseif l_type.is_interface then
												l_base_index := Interface_group
												description := "interface " + l_type.name
											elseif l_type.is_struct then
												l_base_index := Struct_group
												description := "struct " + l_type.name
											end
											l_base_types := l_type.base_types
											if l_base_types /= Void then
												from
													l_count := l_base_types.count
													if l_count > 0 then
														description.append (" : ")
														description.append (l_base_types.item (0).base_type)
														i := 1
													end
												until
													i = l_count
												loop
													description.append (", ")
													description.append (l_base_types.item (i).base_type)
													i := i + 1
												end
											end
											l_type_attributes := l_type.type_attributes
											if l_type_attributes & {TYPE_ATTRIBUTES}.Nested_assembly = {TYPE_ATTRIBUTES}.Nested_assembly then
												image_index := l_base_index + Internal_offset
												description.prepend ("internal ")
											elseif l_type_attributes = {TYPE_ATTRIBUTES}.Public or l_type_attributes = {TYPE_ATTRIBUTES}.Nested_public then
												image_index := l_base_index
												description.prepend ("public ")
											elseif l_type_attributes = {TYPE_ATTRIBUTES}.Nested_private then
												image_index := l_base_index + Private_offset
												description.prepend ("private ")
											elseif l_type_attributes = {TYPE_ATTRIBUTES}.Nested_family then
												image_index := l_base_index + Protected_offset
												description.prepend ("protected ")
											elseif l_type_attributes = {TYPE_ATTRIBUTES}.Nested_fam_and_assem then
												image_index := l_base_index + Internal_and_protected_offset
												description.prepend ("internal and protected ")
											elseif l_type_attributes = {TYPE_ATTRIBUTES}.Nested_fam_or_assem then
												image_index := l_base_index + Internal_or_protected_offset
												description.prepend ("internal or protected ")
											else
												check
													should_not_be_here: False
												end
												image_index := l_base_index
											end
										else
											l_member ?= a_object
											if l_member /= Void then
												l_attributes := l_member.attributes
												analyze_offset (l_member)
												l_constructor ?= a_object
												if l_constructor /= Void then
													image_index := Constructor_group + icon_offset + icon_static_offset
													object_type := Codedom_method_type
													description := static_offset_description + offset_description + "constructor"
												else
													l_method ?= a_object
													if l_method /= Void then
														image_index := Method_group + icon_offset
														object_type := Codedom_method_type
														description := static_offset_description + offset_description + "method " + l_method.name
													else
														l_event ?= a_object
														if l_event /= Void then
															image_index := Event_group + icon_offset
															description := offset_description + "event " + l_event.name
															object_type := Codedom_event_type
														else
															l_property ?= a_object
															if l_property /= Void then
																object_type := Codedom_property_type
																if l_property.has_get and l_property.has_set then
																	image_index := Property_group + icon_offset + icon_static_offset
																	description := static_offset_description + offset_description + "read and write property " + l_property.name
																elseif l_property.has_get then
																	image_index := Read_only_property_group + icon_offset + icon_static_offset
																	description := static_offset_description + offset_description + "read only property " + l_property.name
																elseif l_property.has_set then
																	image_index := Write_only_property_group + icon_offset + icon_static_offset
																	description := static_offset_description + offset_description + "write only property " + l_property.name
																else
																	image_index := Property_group + icon_offset + icon_static_offset
																	description := static_offset_description + offset_description + "property " + l_property.name
																end
															else
																l_field ?= a_object
																if l_field /= Void then
																	object_type := Codedom_field_type
																	image_index := Field_group + icon_offset + icon_static_offset
																	description := static_offset_description + offset_description + "field " + l_field.name
																else
																	l_snippet_member ?= a_object
																	if l_snippet_member /= Void then
																		-- Type snippet
																		image_index := Type_snippet_group + icon_offset
																		description := static_offset_description + offset_description + "snippet member:%N" + l_snippet_member.text
																		object_type := Codedom_snippet_member_type
																	else
																		image_index := Error_icon
																		description := "Unknown CodeDom member type"
																		object_type := 0
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		ensure
			non_void_description: description /= Void
			valid_description: not description.is_empty
			valid_object_type: is_valid_codedom_type (object_type) or object_type = 0
		end

feature {NONE} -- Implementation

	analyze_offset (a_member: SYSTEM_DLL_CODE_TYPE_MEMBER) is
			-- Analyze offset in icon group and offset description of `a_member'.
			-- Set `icon_offset', `icon_static_offset', `offset_description' and `static_offset_description'
			-- accordingly.
		require
			non_void_member: a_member /= Void
		local
			l_attributes: SYSTEM_DLL_MEMBER_ATTRIBUTES
		do
			icon_static_offset := 0
			static_offset_description := ""
			offset_description := ""
			l_attributes := a_member.attributes & {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Access_mask
			if l_attributes = {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Private then
				icon_offset := Private_offset
				offset_description := "private "
			elseif l_attributes = {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Family_and_assembly then
				icon_offset := Internal_and_protected_offset
				offset_description := "internal and protected "
			elseif l_attributes = {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Family_or_assembly then
				icon_offset := Internal_or_protected_offset
				offset_description := "internal or protected "
			elseif l_attributes = {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Family then
				icon_offset := Protected_offset
				offset_description := "protected "
			elseif l_attributes = {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Assembly then
				icon_offset := Internal_offset
				offset_description := "internal "
			end
			if a_member.attributes & {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Static = {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Static then
				icon_static_offset := Static_offset
				static_offset_description := "static "
			else
				icon_static_offset := 0
				static_offset_description := ""
			end
		ensure
			non_void_description: offset_description /= Void
			valid_description: not offset_description.is_empty implies offset_description.item (offset_description.count) = ' '
			non_void_static_offset_description: static_offset_description /= Void
			valid_static_offset_description: not static_offset_description.is_empty implies static_offset_description.item (static_offset_description.count) = ' '
		end

feature {NONE} -- Private Access

	icon_offset: INTEGER
			-- Offset of icon in icon group of last analyzed member

	icon_static_offset: INTEGER
			-- Offset to static icon if last analyzed member was static
			-- 0 otherwise

	offset_description: STRING
			-- last analyzed offset description

	static_offset_description: STRING;
			-- last analyzed static offset description

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


end -- class TESTER_CODE_OBJECT_ANALYZER

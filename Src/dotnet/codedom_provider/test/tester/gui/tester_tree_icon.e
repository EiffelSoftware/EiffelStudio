indexing
	description: "Codedom tree icon"
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_TREE_ICON

inherit
	EV_PIXMAP

	TESTER_ICONS_INDICES
		export
			{NONE} all
		undefine
			default_create,
			copy,
			is_equal
		end

create
	make,
	make_compile_unit,
	make_namespace,
	make_type,
	make_expression,
	make_statement,
	make_argument,
	make_variable,
	make_primitive,
	make_error

feature {NONE} -- Initialization

	make (a_member: SYSTEM_DLL_CODE_TYPE_MEMBER) is
			-- Initialize icon from `a_member'.
		require
			non_void_member: a_member /= Void
		do
			default_create
			make_from_index (image_index (a_member))
		end

	make_compile_unit is
			-- Initialize icon for compile unit
		do
			default_create
			make_from_index (Compile_unit_icon)
		end
	
	make_namespace is
			-- Initialize icon for namespace
		do
			default_create
			make_from_index (Namespace_icon)
		end
	
	make_type is
			-- Initialize icon for type
		do
			default_create
			make_from_index (Class_group)
		end
	
	make_expression is
			-- Initialize icon for expression
		do
			default_create
			make_from_index (Expression_icon)
		end
	
	make_statement is
			-- Initialize icon for statement
		do
			default_create
			make_from_index (Statement_icon)
		end

	make_variable is
			-- Initialize icon for variable
		do
			default_create
			make_from_index (Variable_icon)
		end

	make_argument is
			-- Initialize icon for argument
		do
			default_create
			make_from_index (Argument_icon)
		end

	make_primitive is
			-- Initialize icon for primitive
		do
			default_create
			make_from_index (Primitive_icon)
		end

	make_error is
			-- Initialize icon for statement
		do
			default_create
			make_from_index (Error_icon)
		end

feature -- Access

	Icon_width: INTEGER is 16
			-- Icons width
	
	Icon_height: INTEGER is 16
			-- Icons height

feature {NONE} -- Implementation

	icon_offset (a_member: SYSTEM_DLL_CODE_TYPE_MEMBER): INTEGER is
			-- Offset of icon in icon group
		require
			non_void_member: a_member /= Void
		local
			l_attributes: SYSTEM_DLL_MEMBER_ATTRIBUTES
		do
			l_attributes := a_member.attributes & feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Access_mask
			if l_attributes = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Private then
				Result := Private_offset
			elseif l_attributes = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Family_and_assembly then
				Result := Internal_and_protected_offset
			elseif l_attributes = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Family_or_assembly then
				Result := Internal_or_protected_offset
			elseif l_attributes = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Family then
				Result := Protected_offset
			elseif l_attributes = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Assembly then
				Result := Internal_offset
			end
		end

	icon_static_offset (a_member: SYSTEM_DLL_CODE_TYPE_MEMBER): INTEGER is
			-- Offset to static icon if `a_member' is static,
			-- 0 otherwise
		do
			if a_member.attributes & feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Static = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Static then
				Result := Static_offset
			end
		end
		
	image_index (a_member: SYSTEM_DLL_CODE_TYPE_MEMBER): INTEGER is
			-- Index of icon correspoding to `a_member'
		require
			non_void_member: a_member /= Void
		local
			l_constructor: SYSTEM_DLL_CODE_CONSTRUCTOR
			l_method: SYSTEM_DLL_CODE_MEMBER_METHOD
			l_event: SYSTEM_DLL_CODE_MEMBER_EVENT
			l_field: SYSTEM_DLL_CODE_MEMBER_FIELD
			l_property: SYSTEM_DLL_CODE_MEMBER_PROPERTY
			l_base_index: INTEGER
			l_type: SYSTEM_DLL_CODE_TYPE_DECLARATION
			l_attributes: SYSTEM_DLL_MEMBER_ATTRIBUTES
			l_type_attributes: TYPE_ATTRIBUTES
		do
			l_type ?= a_member
			if l_type /= Void then
				if l_type.is_class then
					l_base_index := Class_group
				elseif l_type.is_enum then
					l_base_index := Enum_group
				elseif l_type.is_interface then
					l_base_index := Interface_group
				elseif l_type.is_struct then
					l_base_index := Struct_group
				end
				l_type_attributes := l_type.type_attributes
				if l_type_attributes = feature {TYPE_ATTRIBUTES}.Class_ or l_type_attributes = feature {TYPE_ATTRIBUTES}.Nested_assembly then
					Result := l_base_index + Internal_offset
				elseif l_type_attributes = feature {TYPE_ATTRIBUTES}.Public or l_type_attributes = feature {TYPE_ATTRIBUTES}.Nested_public then
					Result := l_base_index
				elseif l_type_attributes = feature {TYPE_ATTRIBUTES}.Nested_private then
					Result := l_base_index + Private_offset
				elseif l_type_attributes = feature {TYPE_ATTRIBUTES}.Nested_family then
					Result := l_base_index + Protected_offset
				elseif l_type_attributes = feature {TYPE_ATTRIBUTES}.Nested_fam_and_assem then
					Result := l_base_index + Internal_and_protected_offset
				elseif l_type_attributes = feature {TYPE_ATTRIBUTES}.Nested_fam_or_assem then
					Result := l_base_index + Internal_or_protected_offset
				else
					check
						should_not_be_here: False
					end
					Result := l_base_index
				end
			else
				l_attributes := a_member.attributes
				l_constructor ?= a_member
				if l_constructor /= Void then
					Result := Constructor_group + icon_offset (a_member) + icon_static_offset (a_member)
				else
					l_method ?= a_member
					if l_method /= Void then
						Result := Method_group + icon_offset (l_method)
					else
						l_event ?= a_member
						if l_event /= Void then
							Result := Event_group + icon_offset (a_member)
						else
							l_property ?= a_member
							if l_property /= Void then
								if l_property.has_get and l_property.has_set then
									Result := Property_group + icon_offset (l_property) + icon_static_offset (a_member)
								elseif l_property.has_get then
									Result := Read_only_property_group + icon_offset (l_property) + icon_static_offset (a_member)
								elseif l_property.has_set then
									Result := Write_only_property_group + icon_offset (l_property) + icon_static_offset (a_member)
								else
									Result := Property_group + icon_offset (l_property) + icon_static_offset (a_member)
								end
							else
								l_field ?= a_member
								if l_field /= Void then
									Result := Field_group + icon_offset (l_field) + icon_static_offset (a_member)
								else
									-- Type snippet
									Result := Type_snippet_group + icon_offset (a_member)
								end
							end
						end
					end
				end
			end
		end

	make_from_index (a_index: INTEGER) is
			-- Initialize icon from index in `icons_pixmap'.
		require
			valid_index: a_index >= 0 and a_index <= (icons_pixmap.width // Icon_width)
		do
			set_size (Icon_width, Icon_height)
			draw_sub_pixmap (0, 0, icons_pixmap, create {EV_RECTANGLE}.make (a_index * Icon_width, 0, Icon_width, Icon_height))
		end
		
feature {NONE} -- Private Access

	icons_pixmap: EV_PIXMAP is
			-- Pixmap with all icons
		local
			l_retried: BOOLEAN
		once
			if not l_retried then
				create Result
				Result.set_with_named_file ("icons\tester.png")
			else
				create Result.make_with_size (150 * 16, 16)
			end
		rescue
			l_retried := True
			retry
		end
		
end -- class TESTER_TREE_ICON

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider Tester
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
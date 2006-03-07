indexing
	description: "Codedom tree icon"
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_TREE_ICON

inherit
	EV_PIXMAP

	TESTER_CODE_OBJECT_ANALYZER
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
	make_error,
	make_custom_attribute,
	make_pragma

feature {NONE} -- Initialization

	make (a_member: SYSTEM_DLL_CODE_TYPE_MEMBER) is
			-- Initialize icon from `a_member'.
		require
			non_void_member: a_member /= Void
		do
			default_create
			analyze (a_member)
			make_from_index (image_index)
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

	make_custom_attribute is
			-- Initialize icon for custom attribute
		do
			default_create
			make_from_index (Custom_attribute_icon)
		end

	make_pragma is
			-- Initialize icon for custom attribute
		do
			default_create
			make_from_index (Pragma_icon)
		end

feature -- Access

	Icon_width: INTEGER is 16
			-- Icons width

	Icon_height: INTEGER is 16
			-- Icons height

feature {NONE} -- Implementation

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

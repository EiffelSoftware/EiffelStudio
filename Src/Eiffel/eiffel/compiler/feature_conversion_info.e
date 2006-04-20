indexing
	description: "Store information to be used when a conversion occurs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_CONVERSION_INFO

inherit
	CONVERSION_INFO
		redefine
			has_depend_unit, depend_unit
		end
	
create
	make_from,
	make_to
	
feature {NONE} -- Initialization

	make_from (a_source_type, a_target_type: TYPE_A; a_class: CLASS_C; a_feat: FEATURE_I) is
			-- Information about conversion from `a_source_type' to `a_target_type' using
			-- a `a_feat' from `a_class' routine of `a_target_type'.
		require
			a_source_type_not_void: a_source_type /= Void
			a_target_type_not_void: a_target_type /= Void
			a_class_not_void: a_class /= Void
			a_feat_not_void: a_feat /= Void
		do
			source_type := a_source_type
			target_type := a_target_type
			is_from_conversion := True
			conversion_feature := a_feat
			conversion_class_id := a_class.class_id
		ensure
			source_type_set: source_type = a_source_type
			target_type_set: target_type = a_target_type
			conversion_feature_set: conversion_feature = a_feat
			is_from_conversion_set: is_from_conversion
			conversion_class_id_set: conversion_class_id = a_class.class_id
		end

	make_to (a_source_type, a_target_type: TYPE_A; a_class: CLASS_C; a_feat: FEATURE_I) is
			-- Information about conversion from `a_source_type' to `a_target_type' using
			-- a `a_feat' from `a_class' routine of `a_source_type'.
		require
			a_source_type_not_void: a_source_type /= Void
			a_target_type_not_void: a_target_type /= Void
			a_class_not_void: a_class /= Void
			a_feat_not_void: a_feat /= Void
		do
			source_type := a_source_type
			target_type := a_target_type
			is_from_conversion := False
			conversion_feature := a_feat
			conversion_class_id := a_class.class_id
		ensure
			source_type_set: source_type = a_source_type
			target_type_set: target_type = a_target_type
			conversion_feature_set: conversion_feature = a_feat
			is_from_conversion_set: not is_from_conversion
			conversion_class_id_set: conversion_class_id = a_class.class_id
		end
		
feature -- Access

	source_type: TYPE_A
			-- Source type of conversion
			
	is_from_conversion: BOOLEAN
			-- True if conversion routine is defined on `target_type',
			-- False if defined on `source_type'

	conversion_feature: FEATURE_I
			-- Routine used for conversion
			
	conversion_class_id: INTEGER
			-- Class ID from where `conversion_feature' is coming from

feature -- Status report

	has_depend_unit: BOOLEAN is True
			-- Current conversion has an associated depend unit.

feature -- Properties

	depend_unit: DEPEND_UNIT is
			-- Associated depend unit used for incrementality
		do
			create Result.make (conversion_class_id, conversion_feature)
		end

feature -- Byte code generation

	byte_node (an_expr: EXPR_B): EXPR_B is
			-- Generate byte node needed to convert `an_expr' to the expected type
		do
			Result := byte_code_factory.convert_byte_node (an_expr, Current)
		end

	byte_code_factory: BYTE_CODE_FACTORY is
			-- Factory to create conversion byte node
		once
			create Result
		end

invariant
	source_type_not_void: source_type /= Void
	conversion_feature_not_void: conversion_feature /= Void
	conversion_class_id_non_negative: conversion_class_id > 0

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

end -- class FEATURE_CONVERSION_INFO

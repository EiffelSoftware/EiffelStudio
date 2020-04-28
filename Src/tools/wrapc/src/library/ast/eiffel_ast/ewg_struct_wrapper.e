note

	description:

		"Wraps C struct types"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_STRUCT_WRAPPER

inherit

	EWG_COMPOSITE_DATA_WRAPPER
		rename
			make as make_composite_data_wrapper
		end

create

	make

feature {NONE} -- Initialization

	make (a_mapped_eiffel_name: STRING; a_header_file_name: STRING;
			a_c_struct_type: EWG_C_AST_STRUCT_TYPE; a_members: like members)
		require
			a_mapped_eiffel_name_not_void: a_mapped_eiffel_name /= Void
			a_mapped_eiffel_name_not_empty: not a_mapped_eiffel_name.is_empty
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
			a_c_struct_type_not_void: a_c_struct_type /= Void
			a_members_not_void: a_members /= Void
		do
			make_composite_data_wrapper (a_mapped_eiffel_name, a_header_file_name, a_c_struct_type, a_members)
		ensure
			mapped_eiffel_name_set: mapped_eiffel_name = a_mapped_eiffel_name
			header_file_name_set: header_file_name = a_header_file_name
			c_struct_type_set: c_struct_type = a_c_struct_type
			c_composite_data_type_set: c_composite_data_type = a_c_struct_type
			members_set: members = a_members
		end

feature -- Access

	c_struct_type: EWG_C_AST_STRUCT_TYPE
			-- C struct type to wrapp
		do
			check attached {EWG_C_AST_STRUCT_TYPE} c_composite_data_type as l_struct_type then
				Result := l_struct_type
			end
		ensure
			c_struct_type_not_void: Result /= Void
			c_struct_type_is_c_type: Result = c_composite_data_type
		end

end

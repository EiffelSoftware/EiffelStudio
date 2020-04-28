note

	description:

		"Objects which wrap C callback types"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_CALLBACK_WRAPPER

inherit

	EWG_CALLABLE_WRAPPER
		rename
			make as make_callable_wrapper
		end

	EWG_ABSTRACT_TYPE_WRAPPER
		rename
			make as make_abstract_wrapper
		end

create
	make

feature {NONE} -- Initialization

	make (a_mapped_eiffel_name: STRING; a_header_file_name: STRING; a_c_pointer_type: EWG_C_AST_POINTER_TYPE;
			a_members: like members; a_callbacks_per_type: like callbacks_per_type)
		require
			a_mapped_eiffel_name_not_void: a_mapped_eiffel_name /= Void
			a_mapped_eiffel_name_not_empty: not a_mapped_eiffel_name.is_empty
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: not a_header_file_name.is_empty
			a_c_pointer_type_not_void: a_c_pointer_type /= Void
			a_c_pointer_type_is_callback: a_c_pointer_type.is_callback
			a_members_not_void: a_members /= Void
		do
			c_pointer_type := a_c_pointer_type
			callbacks_per_type := a_callbacks_per_type
			make_callable_wrapper (a_mapped_eiffel_name, a_header_file_name, a_members)
		ensure
			mapped_eiffel_name_set: mapped_eiffel_name = a_mapped_eiffel_name
			header_file_name_set: header_file_name = a_header_file_name
			c_pointer_type_set: c_pointer_type = a_c_pointer_type
			members_set: members = a_members
			callbacks_per_type_set: callbacks_per_type = a_callbacks_per_type
		end

feature

	c_pointer_type: EWG_C_AST_POINTER_TYPE
			-- C callback type to wrapp

	callbacks_per_type: INTEGER
			-- Numbers of callbacks per type		

	type: EWG_C_AST_TYPE
		do
			Result := c_pointer_type
		end

	get_stub: detachable EWG_FUNCTION_WRAPPER

	set_entry_struct: detachable EWG_FUNCTION_WRAPPER

	setter_object: detachable EWG_FUNCTION_WRAPPER

	release_object: detachable EWG_FUNCTION_WRAPPER

	set_get_stub (a_function_wrapper: EWG_FUNCTION_WRAPPER)
		require
			a_function_wrapper_not_void: a_function_wrapper /= Void
		do
			get_stub := a_function_wrapper
		ensure
			get_stub_set: get_stub = a_function_wrapper
		end

	set_set_entry_struct (a_function_wrapper: EWG_FUNCTION_WRAPPER)
		require
			a_function_wrapper_not_void: a_function_wrapper /= Void
		do
			set_entry_struct := a_function_wrapper
		ensure
			set_entry_struct_set: set_entry_struct = a_function_wrapper
		end

	set_setter_object (a_function_wrapper: EWG_FUNCTION_WRAPPER)
		require
			a_function_wrapper_not_void: a_function_wrapper /= Void
		do
			setter_object := a_function_wrapper
		ensure
			setter_object_set: setter_object = a_function_wrapper
		end

	set_release_object (a_function_wrapper: EWG_FUNCTION_WRAPPER)
		require
			a_function_wrapper_not_void: a_function_wrapper /= Void
		do
			release_object := a_function_wrapper
		ensure
			release_object_set: release_object = a_function_wrapper
		end


invariant

	c_pointer_type_not_void: c_pointer_type /= Void
	c_pointer_type_is_callback: c_pointer_type.is_callback

end

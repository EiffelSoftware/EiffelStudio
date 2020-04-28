note

	description:

		"Represents a wrapper clause that will generate callback wrappers"

	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_CONFIG_CALLBACK_WRAPPER_CLAUSE

inherit

	EWG_CONFIG_WRAPPER_CLAUSE
		redefine
			make
		end

	EWG_RENAMER
		export {NONE} all end

	EWG_SHARED_C_SYSTEM

create

	make


feature {NONE} -- Initialization

	make
		do
			Precursor
				-- By default set callbacks per type as 3.
		end

feature {ANY} -- Access

	callbacks_per_type: INTEGER
			-- Number of callbacks receivers per type.

	accepts_type (a_type: EWG_C_AST_TYPE): BOOLEAN
		do
			Result := a_type.skip_wrapper_irrelevant_types.is_callback
		end

	accepts_declaration (a_declaration: EWG_C_AST_DECLARATION): BOOLEAN
		do
			Result := False
		end

	set_callbacks_per_type (a_val: INTEGER)
		require
			valid_val: a_val > 0
		do
			callbacks_per_type := a_val
		ensure
			callbacks_per_type_set: callbacks_per_type = a_val
		end

feature {ANY} -- Basic Routines

	shallow_wrap_type (a_type: EWG_C_AST_TYPE;
							 a_include_header_file_name: STRING;
							 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		local
			member_list: DS_ARRAYED_LIST [EWG_MEMBER_WRAPPER]
			callback_wrapper: EWG_CALLBACK_WRAPPER
			l_callbacks_per_type: INTEGER
		do
			if attached {EWG_C_AST_POINTER_TYPE} a_type.skip_wrapper_irrelevant_types as pointer_type then
				create member_list.make_default
				if callbacks_per_type > 0 then
					l_callbacks_per_type := callbacks_per_type
				else
					l_callbacks_per_type := 3
				end
				create {EWG_ANSI_C_CALLBACK_WRAPPER} callback_wrapper.make (eiffel_identifier_for_type (pointer_type),
																								a_include_header_file_name,
																								pointer_type,
																								member_list, l_callbacks_per_type)
				a_eiffel_wrapper_set.add_wrapper (callback_wrapper)
			end
		end

	shallow_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
									  a_include_header_file_name: STRING;
									  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		do
				check
					dead_end: False
				end
		end

	deep_wrap_type (a_type: EWG_C_AST_TYPE;
						 a_include_header_file_name: STRING;
						 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
						 a_config_system: EWG_CONFIG_SYSTEM)
		local
			callback_wrapper: EWG_CALLBACK_WRAPPER
			function_type: EWG_C_AST_FUNCTION_TYPE
			cs: DS_BILINEAR_CURSOR [EWG_C_AST_DECLARATION]
			i: INTEGER
		do
			if attached {EWG_C_AST_POINTER_TYPE} a_type.skip_wrapper_irrelevant_types as pointer_type then
				-- TODO:
				callback_wrapper := a_eiffel_wrapper_set.callback_wrapper_from_callback (pointer_type)
				function_type := pointer_type.function_type
				if attached function_type.members as l_members then
					from
						cs := l_members.new_cursor
						cs.start
					until
						cs.off
					loop
						i := i + 1
						wrap_callback_parameter (callback_wrapper,
														 cs.item,
														 i,
														 a_include_header_file_name,
														 a_eiffel_wrapper_set,
														 a_config_system)
						cs.forth
					end
				end

				if c_system.types.void_type /= function_type.return_type.skip_consts_and_aliases then
					wrap_callback_return_type (callback_wrapper,
														a_include_header_file_name,
														a_eiffel_wrapper_set,
														a_config_system)
				end
				a_config_system.mark_type_completely_wrapped (a_type)
			end
		end

	deep_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
								  a_include_header_file_name: STRING;
								  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
								  a_config_system: EWG_CONFIG_SYSTEM)
		do
				check
					dead_end: False
				end
		end

feature {NONE}

	wrap_callback_parameter (a_callback_wrapper: EWG_CALLBACK_WRAPPER;
									 a_parameter: EWG_C_AST_DECLARATION;
									 a_index: INTEGER;
									 a_include_header_file_name: STRING;
									 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
									 a_config_system: EWG_CONFIG_SYSTEM)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
			a_parameter_not_void: a_parameter /= Void
			a_parameter_is_member_of_callback: attached a_callback_wrapper.c_pointer_type.function_type.members as l_members and then l_members.has (a_parameter)
			a_index_greater_equal_one: a_index >= 1
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
			a_config_system_not_void: a_config_system /= Void
		local
			mapped_eiffel_name: STRING
			member_wrapper: EWG_MEMBER_WRAPPER
			wrappable_type: EWG_C_AST_TYPE
		do
			if attached a_parameter.declarator as l_declarator then
				mapped_eiffel_name := eiffel_parameter_name_from_c_parameter_name (l_declarator)
			else
				create mapped_eiffel_name.make (("anonymous_").count + 3)
				mapped_eiffel_name.append_string ("anonymous_")
				mapped_eiffel_name.append_string (a_index.out)
			end
			wrappable_type := a_parameter.type.skip_wrapper_irrelevant_types
			a_config_system.force_shallow_wrap_type (a_parameter.type,
																  a_include_header_file_name,
																  a_eiffel_wrapper_set)

			create {EWG_NATIVE_MEMBER_WRAPPER} member_wrapper.make (mapped_eiffel_name,
																					  a_include_header_file_name,
																					  a_parameter)
			a_callback_wrapper.add_member (member_wrapper)
		end

	wrap_callback_return_type (a_callback_wrapper: EWG_CALLBACK_WRAPPER;
										a_include_header_file_name: STRING;
										a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET;
										a_config_system: EWG_CONFIG_SYSTEM)
			-- Add wrapper for the return type of callback `a_callback_wrapper.c_pointer_type' to
			-- `a_callback_wrapper'.
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
			callback_has_return_type: c_system.types.void_type /= a_callback_wrapper.c_pointer_type.function_type.return_type.skip_consts_and_aliases
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
			a_config_system_not_void: a_config_system /= Void
		local
			fake_declaration: EWG_C_AST_DECLARATION
			member_wrapper: EWG_MEMBER_WRAPPER
			return_type: EWG_C_AST_TYPE
			wrappable_type: EWG_C_AST_TYPE
		do
			return_type := a_callback_wrapper.c_pointer_type.function_type.return_type
			wrappable_type := return_type.skip_wrapper_irrelevant_types
			a_config_system.force_shallow_wrap_type (return_type,
																  a_include_header_file_name,
																  a_eiffel_wrapper_set)
			create fake_declaration.make (Void,
													return_type.skip_consts_and_aliases,
													a_callback_wrapper.c_pointer_type.function_type.header_file_name)
			create {EWG_NATIVE_MEMBER_WRAPPER} member_wrapper.make ("not_applicable", -- TODO:
																					  a_include_header_file_name,
																					  fake_declaration)
			a_callback_wrapper.set_return_type (member_wrapper)
		end

	default_eiffel_identifier_for_type (a_type: EWG_C_AST_TYPE): STRING
		do
			check attached {EWG_C_AST_POINTER_TYPE} a_type as pointer_type then
				if attached pointer_type.closest_alias_type as l_closest_alias_type and then attached l_closest_alias_type.name as l_name then
					Result := eiffel_feature_name_from_c_function_name (l_name)
				else
					Result := eiffel_feature_name_from_c_function_parameters (pointer_type.function_type)
				end
			end
		end

	default_eiffel_identifier_for_declaration (a_declaration: EWG_C_AST_DECLARATION): STRING
		do
				-- TODO check
			check
				dead_end: False
			end
			create Result.make_empty
		end

end




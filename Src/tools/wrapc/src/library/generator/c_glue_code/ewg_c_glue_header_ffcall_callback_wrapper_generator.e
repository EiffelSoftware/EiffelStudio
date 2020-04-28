note

	description:

		"Generates C glue header for callback wrappers"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_GLUE_HEADER_FFCALL_CALLBACK_WRAPPER_GENERATOR

inherit

	EWG_SHARED_C_SYSTEM
		export {NONE} all end

	EWG_RENAMER
		export {NONE} all end

	EWG_SHARED_TEMPLATE_EXPANDER
		export {NONE} all end

create

	make

feature

	make (a_output_stream: KI_TEXT_OUTPUT_STREAM)
		require
			a_output_stream_not_void: a_output_stream /= Void
		do
			output_stream := a_output_stream
		ensure
			output_stream_set: output_stream = a_output_stream
		end

feature

	generate (a_callback_wrapper: EWG_CALLBACK_WRAPPER)
			-- TODO: refactore not to use templates (to save memory)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			parameters: STRING
			parameters_with_comma: STRING
			typedef_name: STRING
		do
				check
					todo: False
				end
--				parameters := a_callback_wrapper.c_pointer_type.function_type.parameter_declarations
				if attached a_callback_wrapper.c_pointer_type.function_type.members as l_members  and then l_members.count > 0 then
					parameters_with_comma := (", ")
--					parameters_with_comma.prepend (", ")
				else
					parameters_with_comma := ""
				end
				typedef_name := a_callback_wrapper.mapped_eiffel_name
					check
						todo: False
					end
--				template_expander.expand_into_stream_from_array (output_stream,
--																				 callback_eiffel_feature_typedef_template,
--																				 <<typedef_name,
--																					parameters_with_comma,
--																					a_callback_wrapper.c_pointer_type.function_type.return_type.declaration_without_declarator
--																					>>)

				output_stream.put_new_line

				template_expander.expand_into_stream_from_array (output_stream,
																				 callback_stub_getter_prototype_template,
																				 <<typedef_name>>)
				output_stream.put_new_line
		end

feature {NONE}

	output_stream: KI_TEXT_OUTPUT_STREAM

feature {NONE}

	callback_eiffel_feature_typedef_template: STRING
			-- $1 ... typedef for eiffel feature callback
			-- $2 ... callback parameters (type and name)
			-- $3 ... callback return type
		once
			Result := "typedef $3 (*$1_eiffel_feature) (void* a_class$2);%N"
		end

	callback_stub_getter_prototype_template: STRING
								-- $1 ... callback eiffel name
					 once
								Result := "void* get_$1_stub ();%N"
					 end

invariant

	output_stream_not_void: output_stream /= Void

end

note

	description:

		"Generates Eiffel dispatcher class for C callbacks"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_EIFFEL_ABSTRACTION_ANSI_C_CALLBACK_WRAPPER_GENERATOR

inherit

	EWG_ABSTRACT_GENERATOR

	EWG_EIFFEL_ABSTRACTION_ANSI_C_CALLBACK_SIGNATURE_GENERATOR
		export {NONE} all end

	EWG_SHARED_TEMPLATE_EXPANDER
		export {NONE} all end

	EWG_RENAMER
		export {NONE} all end

create

	make

feature -- Generation

	generate (a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		local
			cs: DS_BILINEAR_CURSOR [EWG_CALLBACK_WRAPPER]
			ansi_c_callback_wrapper: EWG_ANSI_C_CALLBACK_WRAPPER
			file_name: STRING
			file: KL_TEXT_OUTPUT_FILE
		do
			from
				cs := a_eiffel_wrapper_set.new_callback_wrapper_cursor
				cs.start
			until
				cs.off
			loop
				ansi_c_callback_wrapper ?= cs.item
				if ansi_c_callback_wrapper /= Void then

					file_name := file_system.pathname (directory_structure.eiffel_directory_name,
																  (eiffel_class_name_from_c_callback_name (ansi_c_callback_wrapper.mapped_eiffel_name) + "_CALLBACK").as_lower + ".e")

					create file.make (file_name)
					file.recursive_open_write

					if not file.is_open_write then
						error_handler.report_cannot_write_error (file_name)
					else
						file.put_line (Generated_file_warning_eiffel_comment)
						file.put_new_line
						output_stream := file
						generate_callback_wrapper (ansi_c_callback_wrapper)
						file.close
					end
				end
				cs.forth
				error_handler.tick
			end
		end

feature {NONE} -- Implementation

	generate_callback_wrapper (a_callback_wrapper: EWG_ANSI_C_CALLBACK_WRAPPER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			class_name: STRING
			upper_name: STRING
		do
			class_name := eiffel_class_name_from_c_callback_name (a_callback_wrapper.mapped_eiffel_name) + "_CALLBACK"
			upper_name := eiffel_class_name_from_c_callback_name (a_callback_wrapper.mapped_eiffel_name)
			template_expander.expand_into_stream_from_array (output_stream,
																			 callback_class_template,
																			 <<upper_name,
																				on_callback_signature (a_callback_wrapper, "on_callback")>>)
		end

feature {NONE} -- Templates

		  callback_class_template: STRING
								-- $1 ... callback name in upper case
								-- $2 ... on_callback signature
					 once
								Result := "class $1_DISPATCHER%N" +
																		  "%N" +
																		  "%Tmake" +
																		  "%N" +
																		  "feature {ACCESS}%N" +
																		  "%N" +
																		  "%T$2%N" +
																		  "%T%Tdeferred%N" +
																		  "%T%Tend%N" +
																		  "%N" +
																		  "end%N"
					 end


end

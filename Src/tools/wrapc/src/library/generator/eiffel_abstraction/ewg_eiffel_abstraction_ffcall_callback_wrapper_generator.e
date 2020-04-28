note

	description:

		"Generates Eiffel dispatcher class for C callbacks"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_EIFFEL_ABSTRACTION_FFCALL_CALLBACK_WRAPPER_GENERATOR

inherit

	EWG_ABSTRACT_GENERATOR

	EWG_SHARED_TEMPLATE_EXPANDER
		export {NONE} all end

	EWG_RENAMER
		export {NONE} all end

	EWG_EIFFEL_ABSTRACTION_ANSI_C_CALLBACK_SIGNATURE_GENERATOR
		export {NONE} all end

create

	make

feature -- Generation

	generate (a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
		local
			cs: DS_BILINEAR_CURSOR [EWG_CALLBACK_WRAPPER]
			ffcall_callback_wrapper: EWG_FFCALL_CALLBACK_WRAPPER
			file_name: STRING
			file: KL_TEXT_OUTPUT_FILE
		do
			from
				cs := a_eiffel_wrapper_set.new_callback_wrapper_cursor
				cs.start
			until
				cs.off
			loop
				ffcall_callback_wrapper ?= cs.item
				if ffcall_callback_wrapper /= Void then

					file_name := file_system.pathname (directory_structure.eiffel_directory_name,
																  (eiffel_class_name_from_c_callback_name (ffcall_callback_wrapper.mapped_eiffel_name) + "_CALLBACK").as_lower + ".e")

					create file.make (file_name)
					file.recursive_open_write

					if not file.is_open_write then
						error_handler.report_cannot_write_error (file_name)
					else
						file.put_line (Generated_file_warning_eiffel_comment)
						file.put_new_line
						output_stream := file
						generate_callback_wrapper (ffcall_callback_wrapper)
						file.close
					end
				end
				cs.forth
				error_handler.tick
			end
		end

feature {NONE} -- Implementation

	generate_callback_wrapper (a_callback_wrapper: EWG_FFCALL_CALLBACK_WRAPPER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			base_name: STRING
			lower_name: STRING
		do
			base_name := eiffel_class_name_from_c_callback_name (a_callback_wrapper.mapped_eiffel_name)
			lower_name := a_callback_wrapper.mapped_eiffel_name.as_lower
			output_stream.put_string ("deferred class ")
			output_stream.put_string (base_name)
			output_stream.put_line ("_CALLBACK")
			output_stream.put_new_line
			output_stream.put_line ("inherit")
			output_stream.put_new_line
			output_stream.put_line ("%TEWG_IMPORTED_EXTERNAL_ROUTINES")
			output_stream.put_line ("%T%Texport {NONE} all end")
			output_stream.put_new_line
			output_stream.put_line ("%TEWG_IMPORTED_FFCALL_ROUTINES")
			output_stream.put_line ("%T%Texport {NONE} all end")
			output_stream.put_new_line
			output_stream.put_line ("%TEWG_CALLBACK_C_GLUE_CODE_FUNCTIONS_API")
			output_stream.put_line ("%T%Texport {NONE} all end")
			output_stream.put_new_line
			output_stream.put_line ("feature {NONE} -- Initialization")
			output_stream.put_new_line
			output_stream.put_line ("%Tmake ")
			output_stream.put_line ("%T%T%T-- Create new (already registered) callback object")
			output_stream.put_line ("%T%Tdo")
			output_stream.put_line ("%T%T%Tregister")
			output_stream.put_line ("%T%Tensure")
			output_stream.put_line ("%T%T%Tis_registered: is_registered")
			output_stream.put_line ("%T%Tend")
			output_stream.put_new_line
			output_stream.put_line ("feature {ANY}")
			output_stream.put_new_line
			output_stream.put_line ("%Titem: POINTER ")
			output_stream.put_line ("%T%T%T-- Pointer to register callback on the C side")
			output_stream.put_line ("%T%Trequire")
			output_stream.put_line ("%T%T%Tis_registered: is_registered")
			output_stream.put_line ("%T%Tdo")
			output_stream.put_line ("%T%T%TResult := dynamic_c_callback")
			output_stream.put_line ("%T%Tensure")
			output_stream.put_line ("%T%T%Titem_not_null: item /= Default_pointer")
			output_stream.put_line ("%T%Tend")
			output_stream.put_new_line
			output_stream.put_line ("%Tis_registered: BOOLEAN ")
			output_stream.put_line ("%T%T%T-- `Current' registered ?")
			output_stream.put_line ("%T%Tdo")
			output_stream.put_line ("%T%T%TResult := entry_struct /= Void")
			output_stream.put_line ("%T%Tend")
			output_stream.put_new_line
			output_stream.put_line ("%Tregister ")
			output_stream.put_line ("%T%T%T-- Register this callback.")
			output_stream.put_line ("%T%T%T-- Note that if the C side tried to call an")
			output_stream.put_line ("%T%T%T-- unregistered callback the behavior is undefined.")
			output_stream.put_line ("%T%T%T-- (It will most likely result in a crash)")
			output_stream.put_line ("%T%Trequire")
			output_stream.put_line ("%T%T%Tis_not_registered: not is_registered")
			output_stream.put_line ("%T%Tdo")
			output_stream.put_line ("%T%T%Tcreate entry_struct.make_new_unshared")
			output_stream.put_line ("%T%T%Tentry_struct.set_a_class (EXTERNAL_GARBAGE_COLLECTOR_.eif_adopt (Current))")
			output_stream.put_line ("%T%T%Tentry_struct.set_a_feature ($on_callback_frozen)")
			output_stream.put_string ("%T%T%Tdynamic_c_callback := FFCALL_.alloc_callback_external (get_")
			output_stream.put_string (lower_name)
			output_stream.put_line ("_stub_external, entry_struct.item)")
			output_stream.put_line ("%T%Tensure")
			output_stream.put_line ("%T%T%Tis_registered: is_registered")
			output_stream.put_line ("%T%Tend")
			output_stream.put_new_line
			output_stream.put_line ("%Tunregister ")
			output_stream.put_line ("%T%T%T-- Unregister this callback.")
			output_stream.put_line ("%T%T%T-- Note that as long as a callback is registered")
			output_stream.put_line ("%T%T%T-- it will not be collected by the garbage collector.")
			output_stream.put_line ("%T%Trequire")
			output_stream.put_line ("%T%T%Tis_registered: is_registered")
			output_stream.put_line ("%T%Tdo")
			output_stream.put_line ("%T%T%TFFCALL_.free_callback_external (dynamic_c_callback)")
			output_stream.put_line ("%T%T%Tdynamic_c_callback := Default_pointer")
			output_stream.put_line ("%T%T%TEXTERNAL_GARBAGE_COLLECTOR_.eif_wean (entry_struct.get_a_class)")
			output_stream.put_line ("%T%T%Tentry_struct := Void")
			output_stream.put_line ("%T%Tensure")
			output_stream.put_line ("%T%T%Tis_not_registered: not is_registered")
			output_stream.put_line ("%T%Tend")
			output_stream.put_new_line
			output_stream.put_line ("feature {NONE} -- Implementation")
			output_stream.put_new_line
			output_stream.put_string ("%T")
			output_stream.put_line (on_callback_signature (a_callback_wrapper, "on_callback"))
			output_stream.put_line ("%T%T%T-- Redefine this routine in descendants")
			output_stream.put_line ("%T%Tdeferred")
			output_stream.put_line ("%T%Tend")
			output_stream.put_new_line
			output_stream.put_string ("%Tfrozen ")
			output_stream.put_line (on_callback (a_callback_wrapper, "on_callback_frozen", "on_callback"))
			output_stream.put_line ("%Tentry_struct: EWG_FFCALL_CALLBACK_ENTRY_STRUCT")
			output_stream.put_line ("%T%T%T-- Holds information for C callback stub to call back to")
			output_stream.put_line ("%T%T%T-- `Current.on_frozen_callback'.")
			output_stream.put_new_line
			output_stream.put_line ("%Tdynamic_c_callback: POINTER")
			output_stream.put_line ("%T%T%T-- Address of dynamic C callback")
			output_stream.put_new_line
			output_stream.put_line ("end")

		end

end

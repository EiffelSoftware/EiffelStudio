note

	description:

		"Generates Eiffel dispatcher class for C callbacks"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_EIFFEL_ABSTRACTION_ANSI_C_CALLBACK_DISPATCHER_GENERATOR

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
			file_name: STRING
			file: KL_TEXT_OUTPUT_FILE
		do
			from
				cs := a_eiffel_wrapper_set.new_callback_wrapper_cursor
				cs.start
			until
				cs.off
			loop
				if cs.item /= Void then

					file_name := file_system.pathname (directory_structure.eiffel_directory_name, (eiffel_class_name_from_c_callback_name (cs.item.mapped_eiffel_name) + "_DISPATCHER").as_lower + ".e")

					create file.make (file_name)
					file.recursive_open_write

					if not file.is_open_write then
						error_handler.report_cannot_write_error (file_name)
					else
						file.put_line (Generated_file_callback_eiffel_comment)
						file.put_new_line
						output_stream := file
						generate_callback_wrapper (cs.item)
						file.close
					end
				end
				cs.forth
				error_handler.tick
			end
		end

feature {NONE} -- Implementation

	generate_callback_wrapper (a_callback_wrapper: EWG_CALLBACK_WRAPPER)
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			class_name: STRING
			upper_name: STRING
			ext_class_name: STRING
		do
			class_name := eiffel_class_name_from_c_callback_name (a_callback_wrapper.mapped_eiffel_name) + "_DISPATCHER"
			upper_name := eiffel_class_name_from_c_callback_name (a_callback_wrapper.mapped_eiffel_name)

			ext_class_name := c_header_file_name_to_eiffel_class_name (directory_structure.relative_callback_c_glue_header_file_name)
			ext_class_name.append_string ("_FUNCTIONS_API")

			if attached a_callback_wrapper.set_entry_struct as l_set_entry_struct and then
				attached a_callback_wrapper.get_stub as l_get_stub and then
				attached a_callback_wrapper.setter_object as l_setter and then
				attached a_callback_wrapper.release_object as l_release
			then
				template_expander.expand_into_stream_from_array (output_stream,
																	dispatcher_class_template,
																			<<upper_name,
																				make_definition (l_setter.mapped_eiffel_name, a_callback_wrapper.callbacks_per_type),
																				stub_definition (l_get_stub.mapped_eiffel_name, a_callback_wrapper.callbacks_per_type),
																				ext_class_name,
																				agent_definitions (a_callback_wrapper, a_callback_wrapper.callbacks_per_type),
																				callback_definition (a_callback_wrapper, a_callback_wrapper.callbacks_per_type),
																				dispose_definition (l_release.mapped_eiffel_name, l_setter.mapped_eiffel_name),
																				register_callback_definition (a_callback_wrapper, l_set_entry_struct.mapped_eiffel_name, a_callback_wrapper.callbacks_per_type),
																				release_callback_definition (a_callback_wrapper, a_callback_wrapper.callbacks_per_type),
																				status_report_callback_definition (a_callback_wrapper, a_callback_wrapper.callbacks_per_type)
																				>>	)
			end
		end


	stub_definition (a_string: STRING; a_count: INTEGER): STRING
		local
			l_name: STRING
			i: INTEGER
			dispatcher: STRING
		do
			dispatcher := "c_dispatcher_"
			create Result.make (100)
			create l_name.make_from_string (a_string)
			l_name.remove_tail (1)
			from
				i := 1
			until
				i > a_count
			loop
				Result.append ("%N")
				Result.append ("%T")
				Result.append (dispatcher)
				Result.append_integer (i)
				Result.append (": POINTER%N")
				Result.append ("%T%T%T-- The dispatcher `")
				Result.append (dispatcher)
				Result.append_integer (i)
				Result.append ("` is connected to a C function,%N")
				Result.append ("%T%T%T-- that can be given to the C library as a callback target%N")
				Result.append ("%T%T%T-- and on the other hand the Eiffel feature ")
				Result.append ("`on_callback_")
				Result.append_integer (i)
				Result.append ("`%N")
				Result.append ("%T%T%T-- When its C function gets called, the dispatcher%N")
				Result.append ("%T%T%T-- calls")
				Result.append ("`on_callback_")
				Result.append_integer (i)
				Result.append ("`on the Eiffel side.%N")
				Result.append ("%T%Tdo%N")
			    Result.append ("%T%T%TResult := ")
			    Result.append (l_name)
			    Result.append_integer (i)
			    Result.append ("%N")
				Result.append ("%T%Tend%N")
				i := i + 1
			end
		end

	callback_definition (a_callback_wrapper: EWG_CALLBACK_WRAPPER; a_count: INTEGER): STRING
		local
			i: INTEGER
			callback_name: STRING
		do
			callback_name := "on_callback_";
			create Result.make (100)
			from
				i := 1
			until
				i > a_count
			loop
				Result.append ("%T")
				Result.append (on_callback_signature (a_callback_wrapper, callback_name + i.out))
				Result.append ("%N")
				Result.append ("%T%T%T-- Callback target.%N")
				Result.append ("%T%Tdo%N")
				Result.append ("%T%T%T")
				Result.append (routine_call (a_callback_wrapper, i))
				Result.append ("%N")
				Result.append ("%T%Tend%N")
				Result.append ("%N")
				i := i + 1
			end
		end

	register_callback_definition (a_callback_wrapper: EWG_CALLBACK_WRAPPER; setter_stub: STRING; a_count: INTEGER): STRING
		local
			i: INTEGER
			register_name: STRING
			routine_name: STRING
			l_stub: STRING
		do
			register_name := "register_callback_";
			routine_name := "routine_"
			create l_stub.make_from_string (setter_stub)
			l_stub.remove_tail (1)
			create Result.make (100)
			from
				i := 1
			until
				i > a_count
			loop
				Result.append ("%T")
				Result.append (register_name)
				Result.append_integer (i)
				Result.append (" (a_routine: like routine_1)")
				Result.append ("%N")
				Result.append ("%T%T%T-- Register callback target `a_routine`.%N")
				Result.append ("%T%Trequire%N")
				Result.append ("%T%T%Tis_callback_")
				Result.append_integer (i)
				Result.append ("_unset: is_callback_")
				Result.append_integer (i)
				Result.append ("_available")
				Result.append ("%N")
				Result.append ("%T%Tdo%N")
				Result.append ("%T%T%T")
				Result.append (routine_name)
				Result.append_integer (i)
				Result.append (" := a_routine")
				Result.append ("%N")
				Result.append ("%T%T%T")
				Result.append (l_stub)
				Result.append_integer (i)
				Result.append (" ($on_callback_")
				Result.append_integer (i)
				Result.append (")")
				Result.append ("%N")
				Result.append ("%T%Tensure%N")
				Result.append ("%T%T%Tcallback_")
				Result.append_integer (i)
				Result.append ("_set: attached routine_")
				Result.append_integer (i)
				Result.append ("%N%T%Tend%N")
				Result.append ("%N")
				i := i + 1
			end
		end

	release_callback_definition (a_callback_wrapper: EWG_CALLBACK_WRAPPER; a_count: INTEGER): STRING
		local
			i: INTEGER
			register_name: STRING
			routine_name: STRING
		do
			register_name := "release_callback_";
			routine_name := "routine_"
			create Result.make (100)
			from
				i := 1
			until
				i > a_count
			loop
				Result.append ("%T")
				Result.append (register_name)
				Result.append_integer (i)
				Result.append ("%N")
				Result.append ("%T%T%T-- Release callback target.%N")
				Result.append ("%T%Tdo%N")
				Result.append ("%T%T%T")
				Result.append (routine_name)
				Result.append_integer (i)
				Result.append (" := Void")
				Result.append ("%N")
				Result.append ("%T%Tensure%N")
				Result.append ("%T%T%Tcallback_")
				Result.append_integer (i)
				Result.append ("_unset: routine_")
				Result.append_integer (i)
				Result.append (" = Void%N")
				Result.append ("%T%Tend%N")
				Result.append ("%N")
				i := i + 1
			end
		end

	status_report_callback_definition (a_callback_wrapper: EWG_CALLBACK_WRAPPER; a_count: INTEGER): STRING
		local
			i: INTEGER
			register_name: STRING
		do
			register_name := "is_callback_";
			create Result.make (100)
			from
				i := 1
			until
				i > a_count
			loop
				Result.append ("%T")
				Result.append (register_name)
				Result.append_integer (i)
				Result.append ("_available: BOOLEAN")
				Result.append ("%N")
				Result.append ("%T%T%T-- Is callback available?%N")
				Result.append ("%T%Tdo%N")
				Result.append ("%T%T%T")
				Result.append ("Result")
				Result.append (" := routine_")
				Result.append_integer (i)
				Result.append (" = Void %N")
				Result.append ("%T%Tend%N")
				Result.append ("%N")
				i := i + 1
			end
		end

	routine_call (a_callback_wrapper: EWG_CALLBACK_WRAPPER; i: INTEGER): STRING
		require
			a_callback_wrapper_not_void: a_callback_wrapper /= Void
		local
			cs: DS_BILINEAR_CURSOR [EWG_MEMBER_WRAPPER]
		do
			create Result.make (50)

			Result.append ("if attached routine_")
			Result.append_integer ( i )
			Result.append (" as l_routine then %N")
			if a_callback_wrapper.return_type /= Void then
				Result.append("%T%T%T%TResult := ")
				Result.append (" l_routine")
			else
				Result.append ("%T%T%T%Tl_routine")
			end
			Result.append (" (")
			if a_callback_wrapper.members.count > 0 then
				from
					cs := a_callback_wrapper.members.new_cursor
					cs.start
				until
					cs.off
				loop
					if attached {EWG_NATIVE_MEMBER_WRAPPER} cs.item as native_member_wrapper then
						Result.append_string ("a_")
						Result.append_string(native_member_wrapper.mapped_eiffel_name)

						if not cs.is_last then
							Result.append_string (", ")
						end
					end
					cs.forth
				end
			else
			  Result.append ("[]")
			end
			Result.append (")%N")
			Result.append ("%T%T%Tend")
		end

	agent_definitions (a_callback_wrapper: EWG_CALLBACK_WRAPPER; a_count: INTEGER): STRING
		local
			i: INTEGER
			l_routine: STRING
			definition: STRING
		do
			definition := on_callback_agent (a_callback_wrapper)
			l_routine := "routine_"
			create Result.make (100)
			from
				i := 1
			until
				i > a_count
			loop
				Result.append ("%T")
				Result.append (l_routine)
				Result.append_integer (i)
				Result.append (": detachable ")
				Result.append (definition)
				Result.append ("%N")
				Result.append ("%T%T%T--Eiffel routine to be call on callback.%N%N")
				i := i + 1
			end
		end

	make_definition (a_val: STRING; a_count: INTEGER): STRING
		local
			l_routine: STRING
		do
			l_routine := "routine_"
			create Result.make (100)
			Result.append ("%Tmake%N")
			Result.append ("%T%T%T%T-- Dispatcher initialization.%N")
			Result.append ("%T%Tdo%N")
			Result.append ("%T%T%T")
			Result.append (a_val)
			Result.append (" ($Current)%N")
			Result.append ("%T%Tend%N")
		end

	dispose_definition (a_release: STRING; a_setter: STRING): STRING
		do
			create Result.make (100)
			Result.append ("%T")
			Result.append ("dispose")
			Result.append ("%N")
			Result.append ("%T%T%T-- Wean `Current`.")
			Result.append ("%N")
			Result.append ("%T%Tdo%N")
			Result.append ("%T%T%T")
			Result.append (a_release)
			Result.append ("%N")
			Result.append ("%T%T%T")
			Result.append (a_setter)
			Result.append (" (default_pointer)")
			Result.append ("%N")
			Result.append ("%T%Tend%N")
			Result.append ("%N")
		end

feature {NONE} -- Templates

	Generated_file_callback_eiffel_comment: STRING =
		"{
note

	description: "[
		WrapC generates code to register a few numbers of Eiffel callback receivers per callback type, by default the number of Eiffel callbacks receivers per type is 3. 
		If you need to define a different number of callbacks per type  you can use the configuration file as follows:
		
		<rule>
 			<match>
				<identifier name=".*"/>
				<type name="callback"/>		
  			</match>
  			<wrapper type="default">
				<callbacks_per_type value="10"/>
			</wrapper>
		</rule>
		
		identifier: Constrains the name of elements: here any identifer.
		type: Constrains the construct type: here callback.
		callbacks_per_type: Number of callbacks.
		
		How to use this wrapper?
			1. Create an object instance of this class 
				create object.make
			2. Register a callback calling the feature register_callaback_n where n is between 1 and the number of callbacks per type by default 3.
			2.1 Before to register the callback check that's available using the feature is_callback_n_available.
				if object.is_callback_n_available then
					object.register_callack_n (agent my_eiffel_callback)
					...
			3. Call the dispatcher
				object.c_dispatcher_n
			4. If you need to release a callaback, call the feature release_callback_n
				object.release_callback_n
				
		To learn more check the web: https://github.com/eiffel-wrap-c/WrapC/blob/master/doc/Readme.md#callbacks
	]"

	generator: "Eiffel Wrapper Generator"
      }"


	dispatcher_class_template: STRING
			-- $1 ... callback name in upper case
			-- $2 ... "set_entry_*_struct" function name
			-- $3 ... "get_*_stub" function name
			-- $4 ... class name of external function wrapper for callback glue
			-- $5 ... routine definition PROCEDURE | FUNCTION
			-- $6 ... on_callback signature
			-- $7 ... disposable routine
			-- $8 ... Register template routines
			-- $9 ... Release callbacks
			-- $10 .. Status Report
		once
			Result := "class $1_DISPATCHER%N" +
				"%N"+
				"inherit%N" +
				"%N"+
				"%T$4%N" +
				"%T%Texport {NONE} all end"+
				"%N" +
				"%TDISPOSABLE%N"+
				"%N" +
				"create" +
				"%N" +
				"%Tmake" +
				"%N" +
				"%N" +
				"feature -- Initialization%N" +
				"%N" +
				"$2" +
				"%N" +
				"feature -- Access: Routine %N" +
				"%N" +
				"$5" +
				"feature -- Access: Dispatcher%N" +
				"%N" +
				"$3" +
				"%N" +
				"feature -- Access: Callback%N" +
				"%N" +
				"$6" +
				"%N" +
				"feature -- Access: Status Report%N" +
				"%N" +
				"$10" +
				"%N" +
				"feature -- Register: Callbacks%N" +
				"%N" +
				"$8" +
				"%N" +
				"feature -- Release: Callbacks%N" +
				"%N" +
				"$9" +
				"%N" +
				"feature {NONE} -- Implementation" +
				"%N" +
				"%N" +
				"$7"+
				"%N" +
				"end%N"
			end


end

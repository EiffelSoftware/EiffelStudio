
indexing
	description: "Generate Java Byte Code for the JVM"
	date: "$Date$"
	revision: "$Revision$"

class
	JVM_IL_CODE_GENERATOR

inherit
	IL_CODE_GENERATOR_I
		redefine
			print,
			start_parents_list,
			start_arguments_list,
			end_arguments_list,
			start_class_mappings,
			start_classes_descriptions,
			end_classes_descriptions
		end
	
	SHARED_JVM_CLASS_REPOSITORY
		undefine
			print
		end
			
	JVM_NAME_CONVERTER
		undefine
			print
		end
	JVM_CONSTANTS
		undefine
			print
		end
			
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialization of current object.
		do
			--			create debug_out.make_open_write ("debug_out.txt")
			debug ("JVM_GEN2")
				print ("Starting new generation ------------------------------%N")
			end
		end

feature -- Generation Structure

	start_assembly_generation (name, file_name, location: STRING) is
			-- Create Assembly with `name'.
		do
			debug ("JVM_GEN2")
				print ("ASM name: " + name + "%N")
			end
		end

	add_assembly_reference (name: STRING) is
			-- Add reference to assembly file `name' for type lookups.
		do
		end

	start_module_generation (name: STRING; debug_mode: BOOLEAN) is
			-- Create Module `name' within current assembly.
		do
			debug ("JVM_GEN2")
				print ("Generation of MODULE ")
				print (name)
										
				if debug_mode then
					print (" in debug mode")
				end
				print ("%N")
			end
		end

	define_entry_point (type_id: INTEGER; feature_id: INTEGER) is
			-- Define entry point for IL component from `feature_id' in
			-- class `type_id'.
			-- for each entry point add a new class that only has the
			-- static main function. In this function create a class of
			-- type `type_id' with the creation procedure `feature_id'
		local
			c: JVM_CLASS
			f: JVM_WRITTEN_FEATURE
			ep_class: JVM_CLASS
			ep_method: JVM_METHOD
		do
			c := repository.item (type_id)
			f ?= c.features.item (feature_id)
			debug ("JVM_GEN2")
				print ("def entry point: " + c.qualified_name + ", " + f.external_name + "%N")
			end
							
			-- Add entry class_
			calc_free_type_id
			repository.put (c.qualified_name_wo_l + "_" + f.external_name, last_free_type_id)
			ep_class := repository.item (last_free_type_id)
			ep_class.parents.force (repository.item_by_qualified_name ("Ljava/lang/Object;").type_id)
							
						-- Add entry method
			create ep_method.make (ep_class.constant_pool)
			ep_method.set_external_name ("main")
			ep_method.set_is_static (True)
			ep_method.set_parameters ("[Ljava/lang/String;")
			ep_method.set_return_type_name ("V")
			ep_method.set_feature_id (1)
			ep_method.close_signature
			ep_class.put_feature (ep_method)
							
						-- Add code for entry method
			ep_method.code.append_new_class (type_id)
			ep_method.code.append_dup
			ep_method.code.append_invoke_default_constructor (type_id)
			ep_method.code.append_invoke_from_feature_id (type_id, feature_id)
			ep_method.code.append_return (void_type)
							
						-- Since the new free type id is the highest one, the class
						-- will be generated automatically even if we are already
						-- in the `repository.generate_byte_code' loop.
		end

	end_assembly_generation is
			-- Finish creation of current assembly.
		do
			debug ("JVM_GEN2")
				print ("%N[end assembly generation]%N")
			end
			repository.generate_byte_code
		end

	end_module_generation is
			-- Finish creation of current module.
		do
			debug ("JVM_GEN2")
				print ("[end module generation]%N")
			end
		end

feature -- Class info

	start_class_mappings (class_count: INTEGER) is
		do
			Precursor (class_count)
			repository.set_capacity (class_count)
			highest_used_type_id := 0
		end
			
	generate_class_mappings (class_name: STRING; id: INTEGER; filename: STRING) is
			-- Create a correspondance table between `id' and `class_name'.
		do
			repository.put (rename_type (class_name), id)
			check
				filename_not_void: filename /= Void
			end
			repository.item (id).set_source_code_file_name (filename)
			debug ("JVM_GEN2")
				print ("class_ " + rename_type (class_name) + " has id " + id.out + " and is from file " + filename + "%N")
			end
			if
				id > highest_used_type_id
			then
				highest_used_type_id := id
			end
		end
	
	generate_array_class_mappings (class_name, element_type_name: STRING; id: INTEGER) is
			-- Create a correspondance table between `id' and `class_name'.
		do
			debug ("JVM_GEN2")
				print ("class_[ar] " + rename_type (class_name) + " has id " + id.out + "%N")
			end
			repository.put (rename_type (class_name), id)
			check
				repository.has_by_qualified_name (rename_type (element_type_name))
			end
			repository.item (id).set_array_type (repository.item_by_qualified_name (rename_type (element_type_name)).type_id)
			if
				id > highest_used_type_id
			then
				highest_used_type_id := id
			end
		end
	
	start_classes_descriptions is
			-- Following calls to current will only describe parents and features of current class.
		do
			Precursor
			debug ("JVM_GEN2")
				print ("start classes descr.......................%N")
			end
		end
	
	end_classes_descriptions is
			-- Generate runtime
		do
			Precursor
			debug ("JVM_GEN2")
				print ("end classes descr.......................%N")
			end
			
			-- create Runtime class_
			calc_free_type_id
			repository.put ("ISERuntime", last_free_type_id)
			ISERuntime := repository.item (last_free_type_id)
			ISERuntime.parents.force (repository.item_by_qualified_name ("Ljava/lang/Object;").type_id)			
						
						-- add StringObject
			create static_string_object.make (ISERuntime.constant_pool)
			static_string_object.set_external_name ("StringObject")
			static_string_object.set_type_id (ISERuntime.type_id)
			static_string_object.set_is_static (True)
			static_string_object.set_is_field (True)
			static_string_object.set_return_type_name ("Ljava/lang/String;")
			static_string_object.set_feature_id (1)
			static_string_object.close_signature
			ISERuntime.put_feature (static_string_object)
			
						-- add InAssertion
			create static_in_assertion.make (ISERuntime.constant_pool)
			static_in_assertion.set_external_name ("InAssertion")
			static_in_assertion.set_type_id (ISERuntime.type_id)
			static_in_assertion.set_is_static (True)
			static_in_assertion.set_is_field (True)
			static_in_assertion.set_return_type_name ("Z")
			static_in_assertion.set_feature_id (2)
			static_in_assertion.close_signature
			ISERuntime.put_feature (static_in_assertion)
		end

	generate_class_header (is_interface, is_deferred, is_expanded, is_external: BOOLEAN; type_id: INTEGER) is
			-- Generate class name and its specifier.
		do
			current_type_id := type_id
						
			debug ("JVM_GEN2")
				print ("[gen class header] ")
				if
					is_interface
				then
					print ("interface_ ")
				end
				if
					is_deferred
				then
					print ("deferred_ ")
				end
				print (current_class.qualified_name)
				print ("%N")
			end
							
			if
				is_interface and not current_class.qualified_name.is_equal ("Ljava/lang/Object;")
			then
				current_class.set_interface
			end
			if
				is_deferred
			then
				current_class.set_deferred
			end
			if
				is_expanded
			then
				current_class.set_expanded
			end
			if
				is_external
			then
				current_class.set_external
			end
							
		end

	end_class is
			-- Finish description of current class structure.
		do
		end

	start_parents_list is
			-- Starting inheritance part description
		do
			Precursor
		end

	add_to_parents_list (type_id: INTEGER) is
			-- Add class `name' into list of parents of current type.
		do
			current_class.parents.force (type_id)
		end

	end_parents_list is
			-- Finishing inheritance part description
		do
		end
				
feature -- Features info

	start_features_list (type_id: INTEGER) is
			-- Starting enumeration of features written in current class.
		do
			current_type_id := type_id
						--	 current_class := repository.item (current_type_id)
			check
				current_class /= Void
			end
			debug ("JVM_GEN2")
				print ("start feat list for class ")
				print (current_class.qualified_name)
				print ("------------------------%N")
			end
		end

	start_feature_description (arg_count: INTEGER) is
			-- Start description of a feature of current class.
		do
						--	 print ("%N[st f desc]")
			current_feature := Void
			current_written_feature := Void
			current_method := Void
		end

	create_feature_description is
			-- End description of a feature of current class.
		do
			if
				current_written_feature /= Void and then not current_written_feature.is_signature_closed
			then
				current_written_feature.close_signature
			end
			--	 print ("[cr feat desc]")
		end

	check_renaming is
			-- Check renaming for current feature and class.
		do
			-- TODO: resolve renaming
		end

	check_renaming_and_redefinition is
			-- Check covariance for current feature and class.
		do
			-- TODO: resolve renaming and covarant redefinition
		end

	end_features_list is
			-- Finishing enumeration of features written in current class.
		do
						--	 print ("%N[end feat list]")
		end

	current_is_redefined: BOOLEAN
			-- Value stored bewteen calls of `generate_feature_nature' and `generate_feature_identification'.
			-- Should be redesigned so this attribute can be removed
	current_is_deferred: BOOLEAN
			-- Value stored bewteen calls of `generate_feature_nature' and `generate_feature_identification'.
			-- Should be redesigned so this attribute can be removed
	current_is_frozen: BOOLEAN
			-- Value stored bewteen calls of `generate_feature_nature' and `generate_feature_identification'.
			-- Should be redesigned so this attribute can be removed
	current_is_attribute: BOOLEAN
			-- Value stored bewteen calls of `generate_feature_nature' and `generate_feature_identification'.
			-- Should be redesigned so this attribute can be removed
			
	generate_feature_nature (is_redefined, is_deferred, is_frozen, is_attribute: BOOLEAN) is
			-- Generate nature of current feature.
		do
							
			current_is_redefined := is_redefined
			current_is_deferred := is_deferred
			current_is_frozen := is_frozen
			current_is_attribute := is_attribute
							
			debug ("JVM_GEN2")
				print ("%T%T [gen feat nature]")
				if is_frozen then
					print ("frozen ")
				else
					print ("       ")
				end
				if is_redefined then
					print ("redef ")
				else
					print ("      ")
				end
				if is_attribute then
					print ("field ")
				else
					print ("      ")
				end
				if is_deferred then
					print ("*")
				else
					print (" ")
				end
				print ("%N")
			end
		end

	generate_feature_identification (name: STRING; feature_id: INTEGER; routine_ids: ARRAY [INTEGER]; in_current_class: BOOLEAN; written_type_id: INTEGER) is
			-- Generate feature name.
		local
			wf: JVM_WRITTEN_FEATURE
			rf: JVM_REFLECTED_FEATURE
			il_name: STRING
			rout_id: INTEGER
		do
			rout_id := routine_ids.item (routine_ids.lower)
			if
				(not in_current_class or current_is_redefined)
			then
				-- feature has precursor. The precursor may be external
				-- and thus have an alias (external) name
				-- we only care about the external name, thus we look it up
				il_name := current_class.try_external_name_of_precursor_by_routine_id (rout_id)
			end
			if
				il_name = Void
			then
				il_name := name
			end
												
			if
				in_current_class
			then
				if
					current_is_attribute
				then
					create wf.make (current_class.constant_pool)
					wf.set_is_field (True)
				else
					create {JVM_METHOD} wf.make (current_class.constant_pool)
				end
				current_written_feature := wf
				wf.set_external_name (il_name)
				current_feature := wf
			else
				create rf.make
				rf.set_written_type_id (written_type_id)
				current_feature := rf
			end
			current_feature.set_feature_id (feature_id)
			current_feature.set_routine_id (rout_id)
							
							
			debug ("JVM_GEN2")
				print (current_class.qualified_name_wo_l + "::")
				print ("feature[1] " + il_name + "%T%T%TFID:"+ feature_id.out + "%T%TRID:" + rout_id.out + "%T%T")
				if
					not in_current_class
				then
					print ("not_in_curr ")
				end
				if
					current_is_redefined
				then
					print ("redef. ")
				end
				print ("%N")
			end
			current_feature.set_type_id (current_type_id)
			current_class.put_feature (current_feature)
		end
			
	generate_external_identification (name, il_name: STRING; ext_kind, feature_id, rout_id: INTEGER; in_current_class: BOOLEAN; written_type_id: INTEGER; signature: ARRAY [STRING]; return_type: STRING) is
			-- Generate feature identification.
		local
			wf: JVM_WRITTEN_FEATURE
			rf: JVM_REFLECTED_FEATURE
		do
			if
				in_current_class
			then
				create wf.make (current_class.constant_pool)
				current_written_feature := wf
				wf.set_external_name (il_name)
							
				inspect
					ext_kind
										
				when normal_type then
					-- Do nothing
										
				when creator_type then
					wf.set_is_constructor (True)
					wf.set_external_name ("<init>")
										
				when field_type then
					wf.set_is_field (True)
													
				when set_field_type then
					wf.set_is_field_setter (True)
										
				when set_static_field_type then
					wf.set_is_field_setter (True)
					wf.set_is_static (True)
										
				when static_type then
					wf.set_is_static (True)
										
				when static_field_type then
					wf.set_is_field (True)
					wf.set_is_static (True)
										
				when get_property_type then
					check False end -- Not possible
										
				when set_property_type then
					check False end -- Not possible
										
				else
					check False end -- unkown constant
				end
										
				if
					signature /= Void
				then
					wf.set_parameters_from_string_array (signature)
				end
				if
					return_type /= Void
				then
					wf.set_return_type_from_string (return_type)
				end
				current_feature := wf
			else
				create rf.make
				rf.set_written_type_id (written_type_id)
				current_feature := rf
			end	
							
			current_feature.set_feature_id (feature_id)
			current_feature.set_routine_id (rout_id)
							
			debug ("JVM_GEN2")
				print (current_class.qualified_name_wo_l + "::")
				print ("ext.feature[2] " + il_name + "%T%T%TFID:" + feature_id.out + "%T%TRID:" + rout_id.out + "%T%T")
				if
					not in_current_class
				then
					print ("inherited")
				end
				print ("%N")
			end
			current_feature.set_type_id (current_type_id)
			current_class.put_feature (current_feature)

			create_feature_description
		end

	generate_deferred_external_identification (name: STRING; feature_id, rout_id, written_type_id: INTEGER) is
			-- Generate feature name.
		local
			wf: JVM_WRITTEN_FEATURE
			rf: JVM_REFLECTED_FEATURE
			fn: STRING
			deh: PLAIN_TEXT_FILE
			external_name: STRING
			debug_state: INTEGER
		do
			-- since the compiler does not tell me the alias name of the
			-- deferred externals yet, i read them from a file produced
			-- by the emittor. this is a dirty hack (tm)
			fn := clone (current_class.qualified_name_wo_l)
			fn.replace_substring_all ("/", ".")
			fn.append_string (".deh")
			fn.prepend_string ("gen/")
			create deh.make (fn)
			if
				deh.access_exists
			then
				deh.open_read
				debug ("JVM_GEN2")
					print ("looking for " + name + "%N")
				end
				from
					deh.read_line
				until
					deh.last_string.is_equal (name) or deh.end_of_file
				loop
					deh.read_line -- skip alias
				end
				if
					not deh.end_of_file
				then
					-- we now are at the line of the alias corrisponding to `name'
					deh.read_line
					external_name := clone (deh.last_string)
					create wf.make (current_class.constant_pool)
					current_written_feature := wf
					wf.set_external_name (external_name)
					current_feature := wf
				else
					-- did not find alias. this means that the deferred
					-- external has a non deferred Precursor somwhere
					create rf.make
					rf.set_written_type_id (written_type_id)
								-- TODO: I need this information !!!
					current_feature := rf
					external_name := name
					debug_state := 1
				end
			else
				-- there is no file -> external has non deferred
				-- Precursor somewhere
				create rf.make
				rf.set_written_type_id (written_type_id)
				current_feature := rf
				external_name := name
				debug_state := 2
			end
							
			debug ("JVM_GEN2")
				print (current_class.qualified_name_wo_l + "::")
				print ("ext.def.feature[3] " + external_name + "%T%T%TFID:"+ feature_id.out + "%T%TRID:" + rout_id.out + "%T%T")
				print (" " + debug_state.out + "%N")
			end
			current_feature.set_feature_id (feature_id)
			current_feature.set_routine_id (rout_id)
			current_feature.set_type_id (current_type_id)
			current_class.put_feature (current_feature)
		end

	current_parameters: LINKED_LIST [PAIR [INTEGER, STRING]]
			-- temporary storage for parameter list
			-- each pair holds a type_id and the parameter name
			
	generate_feature_return_type (type_id: INTEGER) is
			-- Generate return type `type_id' of current feature.
		do
			if
				current_written_feature /= Void
			then
				check
					consistent: current_written_feature = current_feature
				end
				current_written_feature.set_return_type_by_id (type_id)
			end
			debug ("JVM_GEN2")
				print (": ")
				print (repository.item (type_id).qualified_name)
			end
		end

	start_arguments_list (count: INTEGER) is
			-- Start declaration of arguments list of `count' size of current feature.
		do
			debug ("JVM_GEN2")
				print (" (")
			end
			Precursor (count)
			create current_parameters.make
		end

	generate_feature_argument (name: STRING; type_id: INTEGER) is
			-- Generate argument `name' of type `type_a'.
		local
			p: PAIR [INTEGER, STRING]
		do
			create p
			p.set_first (type_id)
			p.set_second (name)
			current_parameters.force (p)
			debug ("JVM_GEN2")
				print ("; ")
				print (name)
				print (": ")
				print (repository.item (type_id).qualified_name)
			end
		end

	end_arguments_list is
			-- End declaration of arguments list of current feature.
		do
			debug ("JVM_GEN2")
				print (")")
			end
			if
				current_written_feature /= Void
			then
				check
					consistent: current_written_feature = current_feature
				end
				current_written_feature.set_parameters_from_type_id_list (current_parameters)
			end
		end

feature -- IL Generation
	
	
	
	start_il_generation (type_id: INTEGER) is
		do
			current_type_id := type_id
							
			debug ("JVM_GEN")
				print ("[start il gen]%N")
			end
		end

	generate_feature_il (feature_id: INTEGER) is
			-- Start il generation for feature `feature_id' of class `class_id'.
		do
			debug ("JVM_GEN")
				print ("%NIL code for class ")
				print (repository.item (current_type_id).qualified_name)
				print (", ")
				print (repository.item (current_type_id).features.item (feature_id).written_feature.external_name)
				print ("%N")
			end
			current_feature := current_class.features.item (feature_id)
			current_written_feature ?= current_feature
			current_method ?= current_feature
			counter.reset
							
			check
				current_method /= Void
			end
		end

	generate_creation_feature_il (feature_id: INTEGER) is
			-- Start il generation for creation feature `feature_id' of class `class_id'.
		do
		end

	generate_external_call (base_name: STRING; name: STRING; ext_kind: INTEGER; parameters_type: ARRAY [STRING]; return_type: STRING; is_virtual: BOOLEAN; type_id: INTEGER; feature_id: INTEGER) is
			-- Generate call to `name' with signature `parameters_type'.
		do
			debug ("JVM_GEN")
				print ("%T")
				print ("%T")
			end
			inspect
				ext_kind
			when normal_type then
				debug ("JVM_GEN")
					print ("callvirt [1*] ")
					print (base_name)
					print ("::")
					print (name + "%N")
				end
				current_method.code.append_invoke_from_feature_id (type_id, feature_id)
			when field_type then
				debug ("JVM_GEN")
					print ("ldfld[1*] ")
					print (base_name)
					print ("::")
					print (name + "%N")
				end
				current_method.code.append_push_field_by_feature_id (type_id, feature_id)
			when set_field_type then
				debug ("JVM_GEN")
					print ("set field [ ]")
					print (base_name)
					print ("::")
					print (name + "%N")
				end
				current_method.code.append_pop_field_by_feature_id (type_id, feature_id)
			when static_field_type then
				debug ("JVM_GEN")
					print ("ldsfld [*]")
					print (base_name)
					print ("::")
					print (name + "%N")
				end
				current_method.code.append_push_field_by_feature_id (type_id, feature_id)
			when set_static_field_type then
				debug ("JVM_GEN")
					print ("stsfld [ ]")
					print (base_name)
					print ("::")
					print (name + "%N")
				end
				--repository.item (type_id).features.item (feature_id)
				current_method.code.append_pop_field_by_feature_id (type_id, feature_id)
			when static_type then
				debug ("JVM_GEN")
					print ("call [ ]")
					print (base_name)
					print ("::")
					print (name + "%N")
				end
				current_method.code.append_invoke_from_feature_id (type_id, feature_id)
			when get_property_type then
				check False end
			when set_property_type then
				check False end
			when creator_type then
				debug ("JVM_GEN")
					print ("call constr [1*]")
					print (base_name)
					print ("::")
					print (name + "%N")
				end
				--	    current_method.code.append_new_class (type_id)
				current_method.code.append_invoke_from_feature_id (type_id, feature_id)
			else
				debug ("JVM_GEN")
					print ("Error ")
					print (base_name)
					print ("::")
					print (name + "%N")
				end
			end
		end
			
feature -- Local variable info generation

	put_result_info (type_id: INTEGER) is
			-- Specifies `type_id' of type of result.
		do
			debug ("JVM_GEN")
				print ("put_result_info: " + type_id.out + "%N")
			end
			-- this info is already set by current_method, so just 
			-- initialize the value
			current_method.code.append_push_default_value (eiffel_type_id_to_jvm_type_id (type_id))
			current_method.code.append_pop_into_local (current_method.return_index, eiffel_type_id_to_jvm_type_id (type_id))
		end
			
	put_local_info (type_id: INTEGER; name: STRING) is
			-- Specifies `type_id' of type local.
		do
			debug ("JVM_GEN")
				print ("put_local_info: " + type_id.out + "(" + name + ", " + eiffel_type_id_to_jvm_type_id (type_id).out + ")%Na")
			end
			current_method.add_eiffel_local_info (type_id, name)
			current_method.code.append_push_default_value (eiffel_type_id_to_jvm_type_id (type_id))
			current_method.code.append_pop_into_local (current_method.eiffel_locals_index.item (current_method.eiffel_locals_index.count), eiffel_type_id_to_jvm_type_id (type_id))
		end

feature -- Object creation

	create_like_current_object is
			-- Create object of same type as current object.
		do
			debug ("JVM_GEN")
				print ("%Tnewobj [2*] like Current")
				print (repository.item (current_type_id).qualified_name + "%N")
			end
			current_method.code.append_new_class (current_type_id)
						--	 current_method.code.append_dup
						--	 current_method.code.append_invoke_default_constructor (current_type_id)
		end

	create_object (type_id: INTEGER) is
			-- Create object of `type_id'.
		do
			debug ("JVM_GEN")
				print ("%Tnewobj [3*]")
				print (repository.item (type_id).qualified_name + "%N")
			end
			current_method.code.append_new_class (type_id)
						--	 current_method.code.append_dup
						--	 current_method.code.append_invoke_default_constructor (type_id)
		end

	create_attribute_object (type_id, feature_id: INTEGER) is
			-- Create object of `type_id'.
		local
			c: JVM_CLASS
			wf: JVM_WRITTEN_FEATURE
			att_type_id: INTEGER
		do
			debug ("JVM_GEN")
				print ("%Tcreate attribute obj [*] type_id:" + type_id.out +
						 " feature_id: " + feature_id.out + "%N")
			end
			c := repository.item (type_id)
			wf := c.features.item (feature_id).written_feature
			check
				wf_is_field: wf.is_field
				wf_has_non_void_return_type: wf.has_non_void_return_type
			end
			att_type_id := wf.return_class.type_id
			c := repository.item (att_type_id)
			if
				c.is_array_type
			then
				generate_array_creation (c.element_type_id)
			else
				current_method.code.append_new_class (att_type_id)
			end
		end

	mark_creation_routines (feature_ids: ARRAY [INTEGER]) is
			-- Mark routines of `feature_ids' in Current class as creation
			-- routine of Current class.
		do
		end

feature -- IL stack managment

	duplicate_top is
			-- Duplicate top element of IL stack.
		do
			debug ("JVM_GEN")
				print ("%Tdup [*]%N")
			end
			current_method.code.append_dup
		end

	pop is
			-- Remove top element of IL stack.
		do
			debug ("JVM_GEN")
				print ("%Tpop [*]%N")
			end
			current_method.code.append_pop
		end

feature -- Variables access

	generate_current is
			-- Generate access to `Current'.
			-- push "this" onto stack
		do
			debug ("JVM_GEN")
				print ("%Tgenerate current [*]%N")
			end
			current_method.code.append_push_from_local (0, current_class.jvm_type_id)
		end

	generate_result is
			-- Generate access to `Result'.
		do
			debug ("JVM_GEN")
				print ("%T generate result [*] %N")
			end
			current_method.code.append_push_from_local (current_method.return_index, current_method.return_jvm_type_id)
		end

	generate_attribute (type_id, feature_id: INTEGER) is
			-- Generate access to attribute of `feature_id' in `type_id'.
		do
							
			debug ("JVM_GEN")
				print ("%N%Tldfld [*2] ")
				print (repository.item (type_id).qualified_name)
				print ("::")
				print (repository.item (type_id).features.item (feature_id).written_feature.external_name + "%N")
			end
							
			current_method.code.append_push_field_by_feature_id (type_id, feature_id)
		end

	generate_feature_access (type_id, feature_id: INTEGER; is_virtual: BOOLEAN) is
			-- Generate access to feature of `feature_id' in `type_id'.
		do
			debug ("JVM_GEN")
				print ("%Tcallvirt [*2] ")
				print (repository.item (type_id).qualified_name_wo_l)
				print ("::")
				print (repository.item (type_id).features.item (feature_id).written_feature.external_name + "%N")
			end
							
			current_method.code.append_invoke_from_feature_id (type_id, feature_id)
		end

	generate_argument (n: INTEGER) is
			-- Generate access to `n'-th variable arguments of current feature.
		do
			debug ("JVM_GEN")
				print ("%Tpush from local [*] number:" + n.out + " type:" + current_method.parameter_jvm_type_ids.item (n).out + "slot:"
						 + current_method.parameter_jvm_type_ids.item (n).out + "%N")
			end
			current_method.code.append_push_from_local (current_method.parameters_index.item (n) , current_method.parameter_jvm_type_ids.item (n))
		end

	generate_local (n: INTEGER) is
			-- Generate access to `n'-th local variable of current feature.
		do
			check
				n_not_zero: n > 0
			end
			debug ("JVM_GEN")
				print ("%Tpush from register to stack [*] :" + (n).out + "slot: " + current_method.eiffel_locals_index.item (n).out +
						 " type: " + current_method.eiffel_locals_type_id.item (n).out + "%N")
			end
			current_method.code.append_push_from_local (current_method.eiffel_locals_index.item (n), eiffel_type_id_to_jvm_type_id (current_method.eiffel_locals_type_id.item (n)))
		end

	generate_metamorphose (type_id: INTEGER) is
			-- Generate `metamorphose', ie boxing a basic type of `type_id' into its
			-- corresponding reference type.
		do
			debug ("JVM_GEN")
				print ("%Tbox [ ]")
				print (repository.item (type_id).qualified_name + "%N")
			end
		end

feature -- Addresses

	generate_local_address (n: INTEGER) is
			-- Generate address of `n'-th local variable.
		do
			debug ("JVM_GEN")
				print ("%Tgen local addr [ ]%N")
			end
			check
				TODO: False
			end
		end

	generate_argument_address (n: INTEGER) is
			-- Generate address of `n'-th argument variable.
		do
			debug ("JVM_GEN")
				print ("%Tgen arg addr [ ]%N")
			end
			check
				TODO: False
			end
		end

	generate_current_address is
			-- Generate address of `Current'.
		do
			debug ("JVM_GEN")
				print ("%Tgen curr addr [ ]%N")
			end
			check
				TODO: False
			end
		end

	generate_result_address is
			-- Generate address of `Result'.
		do
			debug ("JVM_GEN")
				print ("%Tgen result addr [ ]%N")
			end
			check
				TODO: False
			end
		end

	generate_attribute_address (type_id, feature_id: INTEGER) is
			-- Generate address of attribute of `feature_id' in class `type_id'.
		do
			debug ("JVMGEN")
				print ("%Tgen attr addr [ ]%N")
			end
			check
				TODO: False
			end
		end

	generate_routine_address (type_id, feature_id: INTEGER) is
			-- Generate address of routine of `feature_id' in class `type_id'.
		do
			debug ("JVMGEN")
				print ("%Tgen routine addr [ ]%N")
			end
			check
				TODO: False
			end
		end

	generate_load_from_address (type_id: INTEGER) is
			-- Load value of `type_i' type from address pushed on stack.
		do
		end

feature -- Assignments

	generate_is_instance_of (type_id: INTEGER) is
			-- Generate `Isinst' byte code instruction.
		do
			debug ("JVM_GEN")
				print ("%Tis instance of [*]:" + type_id.out + "%N")
			end
			current_method.code.append_is_instance_of_by_type_id (type_id)
		end

	generate_check_cast (source_type_id, target_type_id: INTEGER) is
			-- Generate `checkcast' byte code instruction.
		do
			debug ("JVM_GEN")
				print ("%Tcheckcast [*]:" + target_type_id.out + "%N")
			end
			current_method.code.append_check_cast_by_type_id (target_type_id)
		end

	generate_attribute_assignment (feature_id: INTEGER) is
			-- Generate assignment to attribute of `feature_id' in current class.
		do
			debug ("JVM_GEN")
				print ("%Tattr ass [*]")
				print (repository.item (current_type_id).qualified_name)
				print ("::")
				print (repository.item (current_type_id).features.item (feature_id).written_feature.external_name + "%N")
			end
			-- Perform assignment
			current_method.code.append_pop_field_by_feature_id (current_type_id, feature_id)
		end

	generate_local_assignment (n: INTEGER) is
			-- Generate assignment to `n'-th local variable of current feature.
		do
			check
				n_not_zero: n > 0
			end
			debug ("JVM_GEN")
				print ("%Tpush from stack into reg [*] local:" + (n).out + "slot:" +
						 current_method.eiffel_locals_index.item (n).out + "%N")
			end
			current_method.code.append_pop_into_local (current_method.eiffel_locals_index.item (n),
																	 eiffel_type_id_to_jvm_type_id (current_method.eiffel_locals_type_id.item (n)) )
		end

	generate_result_assignment is
			-- Generate assignment to Result variable of current feature.
		do
			debug ("JVM_GEN")
				print ("%T generate result assignment [*]%N")
			end
							
			-- put top element of stack into local variable slot for
			-- result (current_feature.result_index)
			current_method.code.append_pop_into_local (current_method.return_index, current_method.return_jvm_type_id)
		end

feature -- Return statements

	generate_return is
			-- Generate simple end of routine
		do
			debug ("JVM_GEN")
				print ("%Tret [*]%N")
			end
			current_method.code.append_return (current_method.return_jvm_type_id)
		end

	generate_return_value is
			-- Generate end of routine which returns `Result'.
		do
			generate_result
			generate_return
		end

feature -- Once management

	generate_once_done_info (name: STRING) is
			-- Generate declaration of static `done' variable corresponding
			-- to once feature `name'.
		do
			debug ("JVM_ONCE")
				print ("%Tgen once done info, name:" + name + "[*]%N")
			end
			create once_done.make (current_method.constant_pool)
			once_done.set_external_name (name + "_once_done")
			once_done.set_type_id (current_method.type_id)
			once_done.set_is_static (True)
			once_done.set_is_field (True)
			once_done.set_return_type_name ("Z")
			once_done.set_feature_id (current_method.class_.features.count + 1)
			once_done.close_signature
			current_method.class_.put_feature (once_done)
		end

	generate_once_result_info (name: STRING; type_id: INTEGER) is
			-- Generate declaration of static `result' variable corresponding
			-- to once function `name' that has a return type `type_id'.
		do
			debug ("JVM_ONCE")
				print ("%Tgen once result info, name:" + name + "type_id: " + type_id.out + "[*]%N")
			end
			create once_result.make (current_method.constant_pool)
			once_result.set_external_name (name + "_once_result")
			once_result.set_type_id (current_method.type_id)
			once_result.set_is_static (True)
			once_result.set_is_field (True)
			once_result.set_return_type_name (repository.item (type_id).qualified_name_wo_l)
			once_result.set_feature_id (current_method.class_.features.count + 1)
			once_result.close_signature
			current_method.class_.put_feature (once_result)		
		end
	
	generate_once_test is
			-- Generate test on `done' of once feature `name'.
		do
			debug ("JVM_ONCE")
				print ("%Tgen once test [*]%N")
			end
			current_method.code.append_push_field (once_done)
		end

	generate_once_result is
			-- Generate access to static `result' variable to load last
			-- computed value of current processed once function
		do
			debug ("JVM_ONCE")
				print ("%Tgen once result [*]%N")
			end
			current_method.code.append_push_field (once_result)
		end

	generate_once_store_result is
			-- Generate setting of static `result' variable corresponding
			-- to current processed once function.
		do
			debug ("JVM_ONCE")
				print ("%Tgen once store result [*]%N")
			end
			current_method.code.append_pop_field (once_result)
			current_method.code.append_push_manifest_int (1)
			current_method.code.append_pop_field (once_done)
		end

feature -- Array manipulation

	generate_array_access (kind: INTEGER) is
			-- Generate call to `item' of ARRAY.
		do
			debug ("JVM_GEN")
				print ("%N%Tldelem.")
				inspect
					kind
				when il_i1 then
					print ("i1")
				when il_i2 then
					print ("i2")
				when il_i4 then
					print ("i4")
				when il_i8 then
					print ("i8")
				when il_r4 then
					print ("r4")
				when il_r8 then
					print ("r8")
				when il_ref then
					print ("ref")
				end
			end
			current_method.code.append_push_from_array (kind)
		end

	generate_array_write (kind: INTEGER) is
			-- Generate call to `put' of ARRAY.
		do
			debug ("JVM_GEN")
				print ("%N%Tstelem.")
				inspect
					kind
				when il_i1 then
					print ("i1")
				when il_i2 then
					print ("i2")
				when il_i4 then
					print ("i4")
				when il_i8 then
					print ("i8")
				when il_r4 then
					print ("r4")
				when il_r8 then
					print ("r8")
				when il_ref then
					print ("ref")
				end
			end
			current_method.code.append_pop_into_array (kind)
		end

	generate_array_creation (type_id: INTEGER) is
		do
			debug ("JVM_GEN")
				print ("%N%Tnewarr [*]")
				print (repository.item (type_id).qualified_name + ", " + type_id.out)
			end
			current_method.code.append_new_array_by_type_id (type_id)
		end

	generate_array_count is
		do
			debug ("JVM_GEN")
				print ("%N%Tarr count [*]")
			end
			current_method.code.append_push_array_count
		end

	generate_array_upper is
		do
			debug ("JVM_GEN")
				print ("%N%Tarr upper [*]")
			end
			-- upper is always (count - 1), since lower is always 0
			current_method.code.append_push_array_count
			current_method.code.append_push_manifest_int (1)
			current_method.code.append_sub
		end

	generate_array_lower is
		do
			debug ("JVM_GEN")
				print ("%N%Tarr lower [*]")
			end
			-- lower is always 0
			current_method.code.append_pop -- consume arreay reference
			current_method.code.append_push_manifest_int (0)  -- push 0
		end

feature -- Exception handling

	generate_start_exception_block is
			-- Mark a certain routine has having a rescue clause.
		do
		end

	generate_start_rescue is
			-- Mark beginning of rescue clause in routine.
		do
		end

	generate_end_exception_block is
			-- Mark end of rescue clause and end of routine.
		do
		end

feature -- Assertions

	generate_in_assertion_test (end_of_assert: INTEGER) is
		do
			debug ("JVM_DBC")
				print ("%Tgen. in ass. test: " + end_of_assert.out + "[*]%N")
			end
			current_method.code.append_push_field (static_in_assertion)
			current_method.code.append_branch_on_true_by_label_id (end_of_assert)
		end

	generate_set_assertion_status is
		do
			debug ("JVM_DBC")
				print ("%Tgen. set ass. status [*]%N")
			end
			current_method.code.append_push_manifest_int (1)
			current_method.code.append_pop_field (static_in_assertion)
		end

	generate_restore_assertion_status is
		do
			debug ("JVM_DBC")
				print ("%Tgen. restore ass. status [*]%N")
			end
			current_method.code.append_push_manifest_int (0)
			current_method.code.append_pop_field (static_in_assertion)
		end

	generate_assertion_check (assert_type: INTEGER; tag: STRING) is
		local
			l: INTEGER
		do
			debug ("JVM_DBC")
				print ("%Tgen. ass. check test: " + assert_type.out + ", " + tag.out + "[*]%N")
			end
			l := create_label
			current_method.code.append_branch_on_true_by_label_id (l)
			current_method.code.append_new_class_by_name ("java/lang/Exception")
			current_method.code.append_dup
			current_method.code.append_push_manifest_string (tag)
			current_method.code.append_invoke_special ("<init>", "(Ljava/lang/String;)V", "java/lang/Exception")
			current_method.code.stack.remove -- obj
			current_method.code.append_throw_exception
			mark_label (l)
		end

	generate_precondition_violation is
		do
			debug ("JVM_DBC")
				print ("%Tgen. precond viol [*]%N")
			end
			current_method.code.append_new_class_by_name ("java/lang/Exception")
			current_method.code.append_dup
			current_method.code.append_push_field (static_string_object)
			current_method.code.append_invoke_special ("<init>", "(Ljava/lang/String;)V", "java/lang/Exception")
			current_method.code.stack.remove -- obj
			current_method.code.append_throw_exception
		end

	generate_precondition_check (tag: STRING; labelID: INTEGER) is
		do
			debug ("JVM_DBC")
				print ("%Tgen. precond check:" + tag + ", " + labelID.out + " [*]%N")
			end
			current_method.code.append_push_manifest_string (tag)
			current_method.code.append_pop_field (static_string_object)
			current_method.code.append_branch_on_false_by_label_id (labelID)
		end

	generate_invariant_checking (type_id: INTEGER) is
		local
			f: JVM_WRITTEN_FEATURE
		do
			debug ("JVM_DBC")
				print ("%Tgen. invariant checking: " + type_id.out + "[ ]%N")
			end
			f := repository.item (type_id).invariant_
			if
				f /= Void
			then
				current_method.code.append_invoke (repository.item (type_id).invariant_)
			end
		end

	mark_invariant (feature_id: INTEGER) is
		do
			debug ("JVM_DBC")
				print ("%Tmark invariant: " + feature_id.out + "[*]%N")
			end
			current_class.set_invariant (current_class.features.item (feature_id).written_feature)
		end

feature -- Constants generation

	put_void is
			-- Put `Void' on IL stack.
		do
			debug ("JVM_GEN")
				print ("%Tldnull [*]%N")
			end
			current_method.code.append_push_null
		end

	put_manifest_string (s: STRING) is
			-- Put `s' on IL stack.
		do
			debug ("JVM_GEN")
				print ("%Tldstr [*]%"%N")
				print (s)
				print ("%"")
			end
			current_method.code.append_push_manifest_string (s)
		end

	put_integer32_constant (i: INTEGER) is
			-- Put `i' on IL stack.
		do
			debug ("JVM_GEN")
				print ("%Tput i32 on stack [*]%N")
				print (i)
			end
			current_method.code.append_push_manifest_int (i)
		end

	put_double_constant (d: DOUBLE) is
			-- Put `d' on IL stack.
		do
			debug ("JVM_GEN")
				print ("%Tldc.r8 [*]%N")
				print (d)
			end
			current_method.code.append_push_manifest_double (d)
		end

	put_character_constant (c: CHARACTER) is
			-- Put `c' on IL stack.
		do
			debug ("JVM_GEN")
				print ("%Tpush char [*]: " + c.out + "%N")
				print (c.code)
			end
			current_method.code.append_push_manifest_int (c.code)
		end

	put_boolean_constant (b: BOOLEAN) is
			-- Put `b' on IL stack.
		do
			if b then
				debug ("JVM_GEN")
					print ("%Tpush bool (True) [*]%N")
				end
				current_method.code.append_push_manifest_int (1)
			else
				debug ("JVM_GEN")
					print ("%Tpush bool (False) [*]%N")
				end
				current_method.code.append_push_manifest_int (0)
			end
		end

feature -- Labels and branching

	branch_on_true (label: INTEGER) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is True.
		do
			debug ("JVM_GEN")
				print ("%Tbrtrue [*]" + label.out + "%N")
			end
			current_method.code.append_branch_on_true_by_label_id (label)
		end

	branch_on_false (label: INTEGER) is
			-- Generate a branch instruction to `label' if top of
			-- IL stack is False.
		do
			debug ("JVM_GEN")
				print ("%Tbrfalse [*]" + label.out + "%N")
			end
			current_method.code.append_branch_on_false_by_label_id (label)
		end

	branch_to (label: INTEGER) is
			-- Generate a branch instruction to `label'.
		do
			debug ("JVM_GEN")
				print ("%Tbr [*]" + label.out + "%N")
			end
			current_method.code.append_branch_by_label_id (label)
		end

	mark_label (label: INTEGER) is
			-- Mark a portion of code with `label'.
		do
			debug ("JVM_GEN")
				print ("mark label: " + label.out + "%N")
			end
			check
				valid_label: current_method.code.labels.valid_index (label)
				label_not_void: current_method.code.labels.item (label) /= Void
			end
			current_method.code.labels.item (label).close (current_method.code.position)
		end

	create_label: INTEGER is
			-- Create a new label.
			-- TODO: This feature violates CQS
		local
			l: JVM_LABEL
		do
			Result := counter.next
			create l.make (Result)
			current_method.code.labels.force (l, current_method.code.labels.count + 1)
		end

feature -- Binary operator generation

	generate_lt is
			-- Generate `<' operator.
		do
			debug ("JVM_GEN")
				print ("%Tlt [*]%N")
			end
			current_method.code.append_lt
		end

	generate_le is
			-- Generate `<=' operator.
		do
			debug ("JVM_GEN")
				print ("%Tle [*]%N")
			end
			-- TODO: Make more efficient
			current_method.code.append_gt
			current_method.code.append_not		
		end
								
	generate_gt is
			-- Generate `>' operator.
		do
			debug ("JVM_GEN")
				print ("%Tgt [*]%N")
			end
			current_method.code.append_gt
		end
								
	generate_ge is
			-- Generate `>=' operator.
		do
			debug ("JVM_GEN")
				print ("%Tge [*]%N")
			end
			current_method.code.append_ge
		end

	generate_star is
			-- Generate `*' operator.
		do
			debug ("JVM_GEN")
				print ("%Tmul%N")
			end
			current_method.code.append_mul
		end

	generate_slash is
			-- Generate `/' operator.
		do
			debug ("JVM_GEN")
				print ("%Tdiv%N")
			end
			current_method.code.append_precise_div
		end

	generate_power is
			-- Generate `^' operator.
		do
			debug ("JVM_GEN")
				print ("%Tpower [ ]%N")
			end
			check
				TODO: False
			end
		end

	generate_plus is
			-- Generate `+' operator.
		do
			debug ("JVM_GEN")
				print ("%Tadd [*]%N")
			end
			current_method.code.append_add
		end

	generate_mod is
			-- Generate `\\' operator.
		do
			debug ("JVM_GEN")
				print ("%Trem [ ]%N")
			end
			check
				TODO: False
			end
		end

	generate_minus is
			-- Generate `-' operator.
		do
			debug ("JVM_GEN")
				print ("%Tsub%N")
			end
			current_method.code.append_sub
		end

	generate_div is
			-- Generate `//' operator.
		do
			debug ("JVM_GEN")
				print ("%Tdiv [*]%N")
			end
			current_method.code.append_div
		end

	generate_xor is
			-- Generate `xor' operator.
		do
			debug ("JVM_GEN [ ]")
				print ("%Txor%N")
			end
			check
				TODO:False
			end
		end

	generate_or is
			-- Generate `or' and `or else' operator.
		do
			debug ("JVM_GEN")
				print ("%Tor%N")
			end
			check
				TODO: False
			end
		end

	generate_and is
			-- Generate `and' and `and then' operator.
		do
			debug ("JVM_aGEN")
				print ("%Tand%N")
			end
			current_method.code.append_and
		end

	generate_implies is
			-- Generate `implies operator.
		do
			debug ("JVM_GEN")
				print ("%Timplies%N")
			end
			check
				TODO: False
			end
		end

	generate_eq is
			-- Generate `=' operator.
		do
			debug ("JVM_GEN")
				print ("%Teq [*]%N")
			end
			current_method.code.append_eq
		end

	generate_ne is
			-- Generate `/=' operator.
		do
			debug ("JVM_GEN")
				print ("%Tne [*]%N")
			end
			current_method.code.append_ne
		end

	generate_shl is
			-- Generate `|<<' operator (shift left)
		do
			check
				not_implemented_yet: False
			end
		end

	generate_shr is
			-- Generate `|>>' operator (shift right)
		do
			check
				not_implemented_yet: False
			end
		end

feature -- Unary operator generation

	generate_uplus is
			-- Generate '+' operator.
		do
			-- Nothing to do.
		end

	generate_uminus is
			-- Generate '-' operator.
		do
			debug ("JVM_GEN")
				print ("%Tneg [*]%N")	
			end
			current_method.code.append_neg
		end

	generate_not is
			-- Generate 'not' operator.
		do
			debug ("JVM_GEN")
				print ("%Tnot [*]%N")
			end
			current_method.code.append_not
		end

feature -- Line Info for debugging

	put_line_info (n: INTEGER) is
			-- Generate `file_name' and `n' to enable to find corresponding
			-- Eiffel class file in IL code.
		do
			debug ("JVM_GEN")
				print ("#line ")
				print (n)
				print ("%N")
			end
			current_method.put_line_info (n)
		end

feature -- Compilation error handling

	last_error: STRING is
			-- Last exception which occurred during IL generation
		do
			Result := ""
		end

feature {NONE} -- Output

	print (some: ANY) is
			-- Write terse external representation of `some' on `output_file'.
		do
			debug ("JVM_GEN")
				if some /= Void then
					io.put_string (some.out)
				end
			end
		end

feature {NONE} -- Internal data
			
	current_type_id: INTEGER
			-- Type id of class being generated.
			
	current_class: JVM_CLASS is
		do
			Result := repository.item (current_type_id)
		end
			
	current_feature: JVM_FEATURE
			
	current_method: JVM_METHOD
			-- method that is currently added code to
	
	current_written_feature: JVM_WRITTEN_FEATURE

	counter: COUNTER is
			-- Counter for labels
		once
			create Result
		end
			
	calc_free_type_id is
			-- get a type id that is unused
			-- you can only use this feature once all classes that come
			-- from the compiler front end have been mapped !!!
			-- the Result will be stored in `last_free_type_id'
		do
			highest_used_type_id := highest_used_type_id + 1
			last_free_type_id := highest_used_type_id
		end
			
	last_free_type_id: INTEGER
			-- the last free type id, see `calc_free_type_id'
			
	highest_used_type_id: INTEGER
			-- the highest type id used in the system
				
	ISERuntime: JVM_CLASS
			-- Runtime class that holds global assertion helpers
	
	static_string_object: JVM_WRITTEN_FEATURE
			-- holds the tag of the last failed assertion
	
	static_in_assertion: JVM_WRITTEN_FEATURE
			-- `True' only when we are currently in an assertion check
			-- Avoids recursive assertion evaluation, this is good 
			-- because it is common (not even bad design) to have
			-- recursive assertion dependencies. In such cases we would 
			-- loop independently, which is of course not what we want.
	
	once_done: JVM_WRITTEN_FEATURE
			-- caches the once_done feature for the current once function
	
	once_result: JVM_WRITTEN_FEATURE
			-- caches the once_result feature for the current once function

feature {NONE} -- HACK FIXME NOT IMPLEMENTED

	generate_unmetamorphose (type_id: INTEGER) is
			-- Generate `unmetamorphose', ie unboxing a reference to a basic type of `type_id'.
			-- Load content of address resulting from unbox operation.
		do
		end
	
end -- class JVM_IL_CODE_GENERATOR
							
							







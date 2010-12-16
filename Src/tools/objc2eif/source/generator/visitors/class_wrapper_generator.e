note
	description: "A visitor used to generate wrappers for Objective-C classes."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_WRAPPER_GENERATOR

inherit
	GENERATOR_VISITOR
		redefine
			visit_class_decl,
			visit_category_decl,
			visit_method_decl,
			visit_property_decl
		end

create
	make

feature {NONE} -- Initialization

	make (a_wrappers_generator: WRAPPERS_GENERATOR)
			-- Initialize `Current' with `a_wrappers_generator'.
		do
			create classes.make (0)
			current_wrapping_features_group := ""
			wrappers_generator := a_wrappers_generator
			create flattened_classes.make (0)
			create flattened_protocols.make (0)
			create resolved_methods_conflicts.make (0)
		end

feature -- Access

	classes: HASH_TABLE [EIFFEL_CLASS_DECL, STRING]
			-- A table of eiffel classes that wrap their Objective-C counterpart, indexed by class name.

feature -- Operations

	visit_class_decl (c: OBJC_CLASS_DECL)
			-- Visit a class declaration.
		local
			class_name: STRING
			inheritance_declarations: HASH_TABLE [ARRAY [TUPLE [option_name: STRING; options: ARRAY[STRING]]], STRING]
			continue_generation: BOOLEAN
			creation_procedures_groups: ARRAY [TUPLE [export_statuses: ARRAY [STRING]; names: ARRAY [STRING]]]
			protocols: HASH_TABLE [OBJC_PROTOCOL_DECL, STRING]
			wrapper_objc_class_name_feature: EIFFEL_FEATURE_DECL
			body: STRING
		do
			current_objc_class := c
			class_name := c.name
			current_wrapping_features_group := ""
			create current_eiffel_class.make (objc_class_name_to_eiffel_style (class_name), c.framework)
			inheritance_declarations := current_eiffel_class.inheritance_declarations
			continue_generation := True
			if class_name.is_equal ("NSObject") then
				inheritance_declarations.put (<<>>, configuration.ns_common_file.name.split ('/').last.split ('.').first.as_upper)
			elseif attached c.parent_class as parent_class then
					inheritance_declarations.put (<<["redefine", <<"wrapper_objc_class_name">>]>>, objc_class_name_to_eiffel_style (parent_class.name))
			end
			protocols := c.protocols
			from
				protocols.start
			until
				protocols.after
			loop
				inheritance_declarations.put (<<>>, objc_class_name_to_eiffel_style (protocols.item_for_iteration.name) + protocol_suffix)
				protocols.forth
			end
			resolve_features_conflicts
			creation_procedures_groups := current_eiffel_class.creation_procedures_groups
			creation_procedures_groups.force (
				[
					<<configuration.ns_any_file.name.split ('/').last.split ('.').first.as_upper>>,
					<<"make_with_pointer", "make_with_pointer_and_retain">>
				],
				creation_procedures_groups.upper + 1
			)
			add_creation_procedures
				-- We only support NSObject as root class for the moment. Ignore the other root classes.
			continue_generation := not (
										attached c.parent_class as parent_class and then
								   		attached parent_class.name as parent_class_name and then
								   		(parent_class_name.is_equal ("NSProxy") or parent_class_name.is_equal ("NSPort")) or
								   		class_name.is_equal ("NSProxy") or
								   		class_name.is_equal ("NSPort")
								   )
			if continue_generation then
				Precursor (c)
					-- Add the wrapper_objc_class_name feature to the class
				body := "[
							-- The class name used for classes of the generated wrapper classes.
						do
							Result := "$WRAPPER_CLASS_NAME"
						end
					]"
				body.replace_substring_all ("$WRAPPER_CLASS_NAME", class_name)
				create wrapper_objc_class_name_feature.make ("wrapper_objc_class_name", <<>>, body)
				wrapper_objc_class_name_feature.return_type := "STRING"
				current_eiffel_class.features_groups.put ([<<"NONE">>, <<wrapper_objc_class_name_feature>>], "Implementation")
					-- Add this class to the classes hash map.
				classes.put (current_eiffel_class, current_eiffel_class.name)
			end
		end

	visit_category_decl (c: OBJC_CATEGORY_DECL)
			-- Visit a category declaration.
		do
			current_objc_category := c
			current_wrapping_features_group := c.name
			Precursor (c)
			current_objc_category := Void
		end

	visit_method_decl (m: OBJC_METHOD_DECL)
			-- Visit a method declaration.
		local
			features: ARRAY [EIFFEL_FEATURE_DECL]
			features_groups: HASH_TABLE [TUPLE [export_statuses: ARRAY [STRING]; features: ARRAY [EIFFEL_FEATURE_DECL]], STRING]
			features_group: TUPLE [export_statuses: ARRAY [STRING]; features: ARRAY [EIFFEL_FEATURE_DECL]]
			features_group_name: STRING
			creation_procedure: detachable EIFFEL_FEATURE_DECL
			wrapper_feature: detachable EIFFEL_FEATURE_DECL
			wrapper_external_feature: detachable EIFFEL_FEATURE_DECL
			unsupported: BOOLEAN
		do
			check current_eiffel_class_not_void: current_eiffel_class /= Void end
			check current_objc_class_not_void: current_objc_class /= Void end
				-- Ignore "..." arguments.
			if m.arguments.for_all (agent (a: OBJC_ARGUMENT_DECL): BOOLEAN do Result := not a.is_dotdotdot end) then
				if
						-- Ignore methods defined in categories outside the framework this class has been defined in.
					not (
						attached current_objc_category as objc_category and then
						not objc_category.framework.is_equal (current_eiffel_class.framework)
					) and
						-- Ignore class methods
					not m.is_class_method and
						-- Ignore the method if it was defined in a parent class already.
					not (attached current_objc_class.parent_class as parent_class and then parent_class.instances_respond_to_selector (m.selector_name))
				then
					features_groups := current_eiffel_class.features_groups
					if not m.is_class_method and m.selector_name.starts_with ("init") then
							-- Generate creation procedure
						if attached features_groups.item ("Initialization") as private_features_group then
							features := private_features_group.features
						else
							features_group := [<<"NONE">>, <<>>];
							features_groups.put (features_group, "Initialization")
							features := features_group.features
						end
						creation_procedure := generate_creation_procedure (m)
						unsupported := unsupported or not is_method_supported (m)
						features.force (creation_procedure, features.upper + 1)
					else
							-- Generate wrapper feature
						if current_wrapping_features_group.is_empty then
							check attached current_objc_class as objc_class then
								features_group_name := current_objc_class.name
							end
						else
							features_group_name := current_wrapping_features_group
						end
						if attached features_groups.item (features_group_name) as wrapper_features_group then
							features := wrapper_features_group.features
						else
							features_group := [<<>>, <<>>]
							features_groups.put (features_group, features_group_name)
							features := features_group.features
						end
						wrapper_feature := generate_wrapper_feature (m)
						unsupported := unsupported or not is_method_supported (m)
						features.force (wrapper_feature, features.upper + 1)
					end
						-- Generate external
					if current_wrapping_features_group.is_empty then
						check attached current_objc_class as objc_class then
							features_group_name := current_objc_class.name + " " + externals_name
						end
					else
						features_group_name := current_wrapping_features_group + " " + externals_name
					end
					if attached features_groups.item (features_group_name) as externals_features_group then
						features := externals_features_group.features
					else
						features_group := [<<"NONE">>, <<>>]
						features_groups.put (features_group, features_group_name)
						features := features_group.features
					end
					wrapper_external_feature := generate_external (m)
					unsupported := unsupported or not is_method_supported (m)
					features.force (wrapper_external_feature, features.upper + 1)
						-- Comment out the features if they're unsupported
					if attached creation_procedure as attached_creation_procedure then
						attached_creation_procedure.is_commented := unsupported
					end
					if attached wrapper_feature as attached_wrapper_feature then
						attached_wrapper_feature.is_commented := unsupported
					end
					if attached wrapper_external_feature as attached_wrapper_external_feature then
						attached_wrapper_external_feature.is_commented := unsupported
					end
				end
			end
		end

	visit_property_decl (p: OBJC_PROPERTY_DECL)
			-- <Precursor>
		local
			features_groups: HASH_TABLE [TUPLE [export_statuses: ARRAY [STRING]; features: ARRAY [EIFFEL_FEATURE_DECL]], STRING]
			features: ARRAY [EIFFEL_FEATURE_DECL]
			features_group: TUPLE [export_statuses: ARRAY [STRING]; features: ARRAY [EIFFEL_FEATURE_DECL]]
			type: OBJC_TYPE_DECL
			unsupported: BOOLEAN
			generated_feature: EIFFEL_FEATURE_DECL
		do
			check current_eiffel_class_not_void: current_eiffel_class /= Void end
			check current_objc_class_not_void: current_objc_class /= Void end
			type := p.type
			if
				not (attached {OBJC_BASIC_TYPE_DECL} type as basic_type and then basic_type.is_void) and
				not (attached {OBJC_STRUCT_TYPE_DECL} type as struct_type)
			then
				if attached {OBJC_BASIC_TYPE_DECL} type then
					unsupported := objc_type_to_eiffel_type (type).is_equal (unsupported_type)
				elseif attached {OBJC_POINTER_TYPE_DECL} type as pointer_type then
					if not pointer_type.is_pointer_to_selector then
						if
							not pointer_type.is_pointer_to_c_string and
							(pointer_type.is_pointer_to_instance_object and not pointer_type.name.starts_with ("id") implies
							wrappers_generator.eiffel_class_exists (pointer_type.name.split (' ').first))
						then
							unsupported := (objc_type_to_eiffel_type (pointer_type)).is_equal (unsupported_type)
						else
							unsupported := True
						end
					end
				else
					unsupported := True
				end
			end
			features_groups := current_eiffel_class.features_groups
			if attached features_groups.item ("Properties") as properties_group then
				features := properties_group.features
			else
				features_group := [<<>>, <<>>];
				features_groups.put (features_group, "Properties")
				features := features_group.features
			end
			generated_feature := generate_property_getter (p)
			generated_feature.is_commented := unsupported
			features.force (generated_feature, features.upper + 1)
			if not p.readonly then
				generated_feature := generate_property_setter (p)
				generated_feature.is_commented := unsupported
				features.force (generated_feature, features.upper + 1)
			end
			if attached features_groups.item ("Properties " + externals_name) as properties_externals_group then
				features := properties_externals_group.features
			else
				features_group := [<<"NONE">>, <<>>];
				features_groups.put (features_group, "Properties " + externals_name)
				features := features_group.features
			end
			generated_feature := generate_property_objc_getter (p)
			generated_feature.is_commented := unsupported
			features.force (generated_feature, features.upper + 1)
			if not p.readonly then
				generated_feature := generate_property_objc_setter (p)
				generated_feature.is_commented := unsupported
				features.force (generated_feature, features.upper + 1)
			end
		end


feature {NONE} -- Implementation

	flatten_class (c: OBJC_CLASS_DECL)
			-- Flatten `c' and store it in `flattened_classes'.
		local
			methods: HASH_TABLE [OBJC_METHOD_DECL, STRING]
			parent_class_name: STRING
			category: OBJC_CATEGORY_DECL
		do
			create methods.make (0)
				-- Add methods of `c'.
			methods.merge (c.methods)
				-- For all categories
			across c.categories as cursor loop
				category := cursor.item
					-- Add category methods (only from those defined in categories of the same framework)
				if category.framework.is_equal (c.framework) then
					methods.merge (category.methods)
				end
			end
			if attached c.parent_class as parent_class then
				parent_class_name := parent_class.name
					-- If needed, flatten parent class
				if not flattened_classes.has (parent_class_name) then
					flatten_class (parent_class)
				end
				check attached flattened_classes.item (parent_class_name) as parent_class_methods then
						-- Add methods of parent class
					methods.merge (parent_class_methods)
				end
			end
			flattened_classes.put (methods, c.name)
		end

	flatten_protocol (p: OBJC_PROTOCOL_DECL)
			-- Flatten `p' and store it in `flattened_protocols'.
		local
			methods: HASH_TABLE [OBJC_METHOD_DECL, STRING]
			protocol: OBJC_PROTOCOL_DECL
			protocol_name: STRING
		do
			if not flattened_protocols.has (p.name) then
				create methods.make (0)
					-- Add methods of `p'.
				methods.merge (p.methods)
					-- For all parent protocols
				across p.parent_protocols as cursor loop
					protocol := cursor.item
					protocol_name := protocol.name
						-- If needed, flatten protocol
					if not flattened_protocols.has (protocol_name) then
						flatten_protocol (protocol)
					end
						-- Add methods of protocol
					check attached flattened_protocols.item (protocol_name) as protocol_methods then
						methods.merge (protocol_methods)
					end
				end
				flattened_protocols.put (methods, p.name)
			end
		end

	generate_wrapper_feature (m: OBJC_METHOD_DECL): EIFFEL_FEATURE_DECL
			-- Generate an eiffel wrapper feature for `m'.
		require
			current_objc_class_not_void: current_objc_class /= Void
			current_eiffel_class_not_void: current_eiffel_class /= Void
		local
			body: STRING
			code: STRING
			eiffel_type: STRING
			feature_name: STRING
			eiffel_arguments: ARRAY [TUPLE [name: STRING; type: STRING]]
			objc_arguments: ARRAYED_LIST [OBJC_ARGUMENT_DECL]
			objc_argument: OBJC_ARGUMENT_DECL
			args: STRING
			argument_name_in_eiffel_style: STRING
			selector_name: STRING
			method_identifier: STRING
			retain_policies: HASH_TABLE [BOOLEAN, STRING]
			locals: STRING
			attachment_tests: STRING
		do
			selector_name := m.selector_name
			if m.is_class_method then
				method_identifier := "+" + selector_name
			else
				method_identifier := "-" + selector_name
			end
			body := "[
						-- Auto generated Objective-C wrapper.
					$CODE
				]"
			feature_name := eiffel_name_for_objc_method (m)
			create Result.make (feature_name, <<>>, body)
			create code.make_empty
			check attached m.return_type as type then
				if not (attached {OBJC_BASIC_TYPE_DECL} type as basic_type and then basic_type.is_void) then
					if attached {OBJC_BASIC_TYPE_DECL} type then
						code := "[
								local$LOCALS
								do$ATTACHMENT_TESTS
									Result := $EXTERNAL_FEATURE_NAME (item$ARGS)
								end
							]"
						eiffel_type := objc_type_to_eiffel_type (type)
					elseif attached {OBJC_POINTER_TYPE_DECL} type as pointer_type then
						if pointer_type.is_pointer_to_selector then
							eiffel_type := objc_type_to_eiffel_type (pointer_type)
							check eiffel_type.is_equal (configuration.objc_selector_file.name.split ('/').last.split ('.').first.as_upper) end
								code := "[
										local
											result_pointer: POINTER$LOCALS
										do$ATTACHMENT_TESTS
											result_pointer := $EXTERNAL_FEATURE_NAME (item$ARGS)
											if result_pointer /= default_pointer then
												create {$SELECTOR_TYPE} Result.make_with_pointer (result_pointer)
											end
											
										end
									]"
								code.replace_substring_all ("$SELECTOR_TYPE", eiffel_type)
								eiffel_type.prepend ("detachable ")
						else
							eiffel_type := "detachable "
							code := "[
									local
										result_pointer: POINTER$LOCALS
									do$ATTACHMENT_TESTS
										result_pointer := $EXTERNAL_FEATURE_NAME (item$ARGS)
										if result_pointer /= default_pointer then
											if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
												check attached {like $FEATURE_NAME} existing_eiffel_object as valid_result then
													Result := valid_result
												end
											else
												check attached {like $FEATURE_NAME} new_eiffel_object (result_pointer, $RETAIN) as valid_result_pointer then
													Result := valid_result_pointer
												end
											end
										end
									end
								]"
							retain_policies := configuration.retain_policies
							if retain_policies.has (method_identifier) then
								if retain_policies.item (method_identifier) then
									code.replace_substring_all ("$RETAIN", "True")
								else
									code.replace_substring_all ("$RETAIN", "False")
								end
							else
								if
									selector_name.starts_with ("new") or
									selector_name.starts_with ("alloc") or
									selector_name.substring_index ("copy", 1) > 0  or
									selector_name.substring_index ("Copy", 1) > 0
								then
									code.replace_substring_all ("$RETAIN", "False")
								else
									code.replace_substring_all ("$RETAIN", "True")
								end
							end
							if
								not pointer_type.is_pointer_to_c_string and
								(pointer_type.is_pointer_to_instance_object and not pointer_type.name.starts_with ("id") implies
								wrappers_generator.eiffel_class_exists (pointer_type.name.split (' ').first))
							then
								eiffel_type.append (objc_type_to_eiffel_type (pointer_type))
								if eiffel_type.is_equal ("detachable " + unsupported_type) then
									eiffel_type := unsupported_type
								end
							else
								eiffel_type.append (unsupported_type)
							end
						end
					elseif attached {OBJC_STRUCT_TYPE_DECL} type as struct_type then
						code := "[
								local$LOCALS
								do$ATTACHMENT_TESTS
									create Result.make
									$EXTERNAL_FEATURE_NAME (item, Result.item$ARGS)
								end
							]"
						eiffel_type := objc_class_name_to_eiffel_style (struct_type.name)
					else
						code := "[
								local$LOCALS
								do$ATTACHMENT_TESTS
									Result := $EXTERNAL_FEATURE_NAME (item$ARGS)
								end
							]"
						eiffel_type := unsupported_type
					end
					Result.return_type := eiffel_type
					code.replace_substring_all ("$FEATURE_NAME", feature_name)
				else
					code := "[
							local$LOCALS
							do$ATTACHMENT_TESTS
								$EXTERNAL_FEATURE_NAME (item$ARGS)
							end
						]"
				end
			end
			code.replace_substring_all ("$EXTERNAL_FEATURE_NAME", external_prefix + feature_name)
			eiffel_arguments := Result.arguments_list
			objc_arguments := m.arguments
			create args.make_empty
			create locals.make_empty
			create attachment_tests.make_empty
			from
				objc_arguments.start
			until
				objc_arguments.after
			loop
				objc_argument := objc_arguments.item
				if attached objc_argument.type as type then
					args.append (", ")
					check attached objc_argument.argument_name as argument_name then
						argument_name_in_eiffel_style := objc_identifier_to_eiffel_style (argument_name)
						if not (argument_name_in_eiffel_style.starts_with ("a_") or argument_name_in_eiffel_style.starts_with ("an_")) then
							argument_name_in_eiffel_style.prepend ("a_")
						end
						if attached {OBJC_BASIC_TYPE_DECL} type then
							eiffel_type := objc_type_to_eiffel_type (type)
							args.append (argument_name_in_eiffel_style)
						elseif attached {OBJC_STRUCT_TYPE_DECL} type as struct_type then
							eiffel_type := objc_class_name_to_eiffel_style (struct_type.name)
							args.append (argument_name_in_eiffel_style + ".item")
						elseif attached {OBJC_POINTER_TYPE_DECL} type as pointer_type then
							if
								not pointer_type.is_pointer_to_c_string and
								(pointer_type.is_pointer_to_instance_object and not pointer_type.name.starts_with ("id") implies
								wrappers_generator.eiffel_class_exists (pointer_type.name.split (' ').first))
							then
								eiffel_type := objc_type_to_eiffel_type (pointer_type)
								if eiffel_type.is_equal (unsupported_type) then
									eiffel_type := unsupported_type
								else
									eiffel_type.prepend ("detachable ")
								end
								locals.append ("%N%T" + argument_name_in_eiffel_style + "__item: POINTER")
								attachment_tests.append ("%N%Tif attached " + argument_name_in_eiffel_style + " as " + argument_name_in_eiffel_style + "_attached then%N")
								attachment_tests.append ("%T%T" + argument_name_in_eiffel_style + "__item := " + argument_name_in_eiffel_style + "_attached.item%N")
								attachment_tests.append ("%Tend")
								args.append (argument_name_in_eiffel_style + "__item")
							else
								eiffel_type := unsupported_type
							end
						else
							eiffel_type := unsupported_type
						end
						eiffel_arguments.force ([argument_name_in_eiffel_style, eiffel_type], eiffel_arguments.upper + 1)
					end
				else
					check valid_arguments_count: objc_arguments.count = 1 end
				end
				objc_arguments.forth
			end
			code.replace_substring_all ("$ARGS", args)
			code.replace_substring_all ("$LOCALS", locals)
			code.replace_substring_all ("$ATTACHMENT_TESTS", attachment_tests)
			body.replace_substring_all ("$CODE", code)
	end

	generate_external (m: OBJC_METHOD_DECL): EIFFEL_FEATURE_DECL
			-- Generate an eiffel external feature for `m'.
		require
			current_objc_class_not_void: current_objc_class /= Void
			current_eiffel_class_not_void: current_eiffel_class /= Void
		local
			eiffel_arguments: ARRAY [TUPLE [name: STRING; type: STRING]]
			objc_arguments: ARRAYED_LIST [OBJC_ARGUMENT_DECL]
			objc_argument: OBJC_ARGUMENT_DECL
			eiffel_type: STRING
			body: STRING
			framework: STRING
			code: STRING
			argument_name_in_eiffel_style: STRING
		do
			body := "[
						-- Auto generated Objective-C wrapper.
					external
						"C inline use <$FRAMEWORK/$FRAMEWORK.h>"
					alias
						"$SBL
							$CODE
						 $SBR"
					end
				]"
			if attached current_objc_category as objc_category then
				framework := objc_category.framework
			else
				framework := current_eiffel_class.framework
			end
			body.replace_substring_all ("$FRAMEWORK", framework)
			body.replace_substring_all ("$SBL", "[")
			body.replace_substring_all ("$SBR", "]")
			create Result.make (external_prefix + eiffel_name_for_objc_method (m), <<["an_item", "POINTER"]>>, body)
			create code.make_empty
			eiffel_arguments := Result.arguments_list
			check attached m.return_type as type then
				if attached {OBJC_STRUCT_TYPE_DECL} type as struct_type then
					code.append ("*(" + struct_type.name + " *)$result_pointer = ")
					eiffel_arguments.force (["result_pointer", "POINTER"], eiffel_arguments.upper + 1)
				elseif not (attached {OBJC_BASIC_TYPE_DECL} type as basic_type and then basic_type.is_void) then
					code.append ("return ")
					if attached {OBJC_BASIC_TYPE_DECL} type then
						eiffel_type := objc_type_to_eiffel_type (type)
					elseif attached {OBJC_POINTER_TYPE_DECL} type then
						code.append ("(EIF_POINTER)")
						eiffel_type := "POINTER"
					else
						eiffel_type := unsupported_type
					end
					Result.return_type := eiffel_type
				end
			end
			code.append ("[(" + current_objc_class.name + " *)$an_item")
			objc_arguments := m.arguments
			from
				objc_arguments.start
			until
				objc_arguments.after
			loop
				objc_argument := objc_arguments.item
				code.append (" " + objc_argument.label)
				if attached objc_argument.type as type then
					code.append (":")
					check attached objc_argument.argument_name as argument_name then
						argument_name_in_eiffel_style := objc_identifier_to_eiffel_style (argument_name)
						if not (argument_name_in_eiffel_style.starts_with ("a_") or argument_name_in_eiffel_style.starts_with ("an_")) then
							argument_name_in_eiffel_style.prepend ("a_")
						elseif argument_name_in_eiffel_style.is_equal ("an_item") then
							argument_name_in_eiffel_style.append ("_arg")
						end
						if attached {OBJC_BASIC_TYPE_DECL} type then
							eiffel_type := objc_type_to_eiffel_type (type)
							code.append ("$" + argument_name_in_eiffel_style)
						elseif attached {OBJC_STRUCT_TYPE_DECL} type then
							eiffel_type := "POINTER"
							code.append ("*((" + type.name + " *)$" + argument_name_in_eiffel_style + ")")
						elseif attached {OBJC_POINTER_TYPE_DECL} type as pointer_type then
							if
								pointer_type.is_pointer_to_c_string or
								pointer_type.is_pointer_to_class_object or
								pointer_type.is_pointer_to_instance_object or
								pointer_type.is_pointer_to_selector
							then
								eiffel_type := "POINTER"
								code.append ("$" + argument_name_in_eiffel_style)
							else
								eiffel_type := unsupported_type
							end
						else
							eiffel_type := unsupported_type
						end
						eiffel_arguments.force ([argument_name_in_eiffel_style, eiffel_type], eiffel_arguments.upper + 1)
					end
				else
					check valid_arguments_count: objc_arguments.count = 1 end
				end
				objc_arguments.forth
			end
			code.append ("];")
			body.replace_substring_all ("$CODE", code)
		end

	generate_creation_procedure (m: OBJC_METHOD_DECL): EIFFEL_FEATURE_DECL
			-- Generate an creation procedure for `m'.
		local
			creation_procedure_name: STRING
			body: STRING
			arguments: ARRAYED_LIST [OBJC_ARGUMENT_DECL]
			arguments_string: STRING
			eiffel_arguments: ARRAY [TUPLE [name: STRING; type: STRING]]
			argument_name: STRING
			current_argument: OBJC_ARGUMENT_DECL
			eiffel_type: STRING
			locals: STRING
			attachment_tests: STRING
		do
			creation_procedure_name := eiffel_name_for_objc_method (m)
			creation_procedure_name.remove_head (4)
			creation_procedure_name.prepend ("make")
			body := "[
						-- Initialize `Current'.
					local$LOCALS
					do$ATTACHMENT_TESTS
						make_with_pointer ($INIT_NAME(allocate_object$ARGS))
						if item = default_pointer then
							-- TODO: handle initialization error.
						end
					end
				]"
			body.replace_substring_all ("$INIT_NAME", external_prefix + eiffel_name_for_objc_method (m))
			create Result.make (creation_procedure_name, <<>>, body)
			create locals.make_empty
			create attachment_tests.make_empty
			eiffel_arguments := Result.arguments_list
			from
				arguments := m.arguments
				create arguments_string.make_empty
				arguments.start
			until
				arguments.after
			loop
				current_argument := arguments.item
				if
					attached current_argument.argument_name as attached_argument_name and then
					attached current_argument.type as type
				then
					argument_name := objc_identifier_to_eiffel_style (attached_argument_name)
					if not (argument_name.starts_with ("a_") or argument_name.starts_with ("an_")) then
						argument_name.prepend ("a_")
					end
					if attached {OBJC_BASIC_TYPE_DECL} type then
						eiffel_type := objc_type_to_eiffel_type (type)
						arguments_string.append (", " + argument_name)
					elseif attached {OBJC_STRUCT_TYPE_DECL} type as struct_type then
						eiffel_type := objc_class_name_to_eiffel_style (struct_type.name)
						arguments_string.append (", " + argument_name + ".item")
					elseif attached {OBJC_POINTER_TYPE_DECL} type as pointer_type then
						if
							not pointer_type.is_pointer_to_c_string and
							(pointer_type.is_pointer_to_instance_object and not pointer_type.name.starts_with ("id") implies
							wrappers_generator.eiffel_class_exists (pointer_type.name.split (' ').first))
						then
							eiffel_type := objc_type_to_eiffel_type (pointer_type)
							if eiffel_type.is_equal (unsupported_type) then
								eiffel_type := unsupported_type
							else
								eiffel_type.prepend ("detachable ")
							end
							locals.append ("%N%T" + argument_name + "__item: POINTER")
							attachment_tests.append ("%N%Tif attached " + argument_name + " as " + argument_name + "_attached then%N")
							attachment_tests.append ("%T%T" + argument_name + "__item := " + argument_name + "_attached.item%N")
							attachment_tests.append ("%Tend")
							arguments_string.append (", " + argument_name + "__item")
						else
							eiffel_type := unsupported_type
						end
					else
						eiffel_type := unsupported_type
					end
					eiffel_arguments.force ([argument_name, eiffel_type], eiffel_arguments.upper + 1)
				end
				arguments.forth
			end
			body.replace_substring_all ("$ARGS", arguments_string)
			body.replace_substring_all ("$LOCALS", locals)
			body.replace_substring_all ("$ATTACHMENT_TESTS", attachment_tests)
		end

	generate_property_getter (p: OBJC_PROPERTY_DECL): EIFFEL_FEATURE_DECL
			-- Generate a getter for `p'.
		local
			body: STRING
			code: STRING
			type: OBJC_TYPE_DECL
			feature_name: STRING
			eiffel_type: STRING
			setter: STRING
		do
			body := "[
						-- Auto generated Objective-C wrapper.
					$CODE
				]"
			feature_name := objc_identifier_to_eiffel_style (p.getter)
			create Result.make (feature_name, <<>>, body)
			setter := objc_identifier_to_eiffel_style (p.setter)
			setter.remove_tail (1)
			if not p.readonly then
				Result.setter := setter
			end
			create code.make_empty
			type := p.type
			if not (attached {OBJC_BASIC_TYPE_DECL} type as basic_type and then basic_type.is_void) then
				if attached {OBJC_BASIC_TYPE_DECL} type then
					code := "[
							do
								Result := $EXTERNAL_FEATURE_NAME (item)
							end
						]"
					eiffel_type := objc_type_to_eiffel_type (type)
				elseif attached {OBJC_POINTER_TYPE_DECL} type as pointer_type then
					if pointer_type.is_pointer_to_selector then
						eiffel_type := objc_type_to_eiffel_type (pointer_type)
						check eiffel_type.is_equal (configuration.objc_selector_file.name.split ('/').last.split ('.').first.as_upper) end
							code := "[
									local
										result_pointer: POINTER
									do
										result_pointer := $EXTERNAL_FEATURE_NAME (item)
										if result_pointer /= default_pointer then
											create {$SELECTOR_TYPE} Result.make_with_pointer (result_pointer)
										end

									end
								]"
							code.replace_substring_all ("$SELECTOR_TYPE", eiffel_type)
							eiffel_type.prepend ("detachable ")
					else
						eiffel_type := "detachable "
						code := "[
								local
									result_pointer: POINTER
								do
									result_pointer := $EXTERNAL_FEATURE_NAME (item)
									if result_pointer /= default_pointer then
										if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
											check attached {like $FEATURE_NAME} existing_eiffel_object as valid_result then
												Result := valid_result
											end
										else
											check attached {like $FEATURE_NAME} new_eiffel_object (result_pointer, True) as valid_result_pointer then
												Result := valid_result_pointer
											end
										end
									end
								end
							]"
						if
							not pointer_type.is_pointer_to_c_string and
							(pointer_type.is_pointer_to_instance_object and not pointer_type.name.starts_with ("id") implies
							wrappers_generator.eiffel_class_exists (pointer_type.name.split (' ').first))
						then
							eiffel_type.append (objc_type_to_eiffel_type (pointer_type))
							if eiffel_type.is_equal ("detachable " + unsupported_type) then
								eiffel_type := unsupported_type
							end
						else
							eiffel_type.append (unsupported_type)
						end
					end
				elseif attached {OBJC_STRUCT_TYPE_DECL} type as struct_type then
					code := "[
							do
								create Result.make
								$EXTERNAL_FEATURE_NAME (item, Result.item)
							end
						]"
					eiffel_type := objc_class_name_to_eiffel_style (struct_type.name)
				else
					code := "[
							do
								Result := $EXTERNAL_FEATURE_NAME (item)
							end
						]"
					eiffel_type := unsupported_type
				end
				Result.return_type := eiffel_type
				code.replace_substring_all ("$FEATURE_NAME", feature_name)
			else
				code := "[
						do
							$EXTERNAL_FEATURE_NAME (item)
						end
					]"
			end
			code.replace_substring_all ("$EXTERNAL_FEATURE_NAME", external_prefix + feature_name)
			body.replace_substring_all ("$CODE", code)
		end

	generate_property_setter (p: OBJC_PROPERTY_DECL): EIFFEL_FEATURE_DECL
			-- Generate a setter for `p'.
		local
			body: STRING
			suffix: STRING
			type: OBJC_TYPE_DECL
			feature_name: STRING
			eiffel_type: STRING
			arguments_list: ARRAY [TUPLE [name: STRING; type: STRING]]
			locals: STRING
			attachment_tests: STRING
		do
			body := "[
						-- Auto generated Objective-C wrapper.
					local$LOCALS
					do$ATTACHMENT_TEST
						$EXTERNAL_FEATURE_NAME (item, an_arg$SUFFIX)
					end
				]"
			feature_name := objc_identifier_to_eiffel_style (p.setter)
			feature_name.remove_tail (1)
			body.replace_substring_all ("$EXTERNAL_FEATURE_NAME", external_prefix + feature_name)
			create Result.make (feature_name, <<>>, body)
			create locals.make_empty
			create attachment_tests.make_empty
			type := p.type
			suffix := ""
			if attached {OBJC_BASIC_TYPE_DECL} type then
				eiffel_type := objc_type_to_eiffel_type (type)
			elseif attached {OBJC_STRUCT_TYPE_DECL} type as struct_type then
				eiffel_type := objc_class_name_to_eiffel_style (struct_type.name)
				suffix.append (".item")
			elseif attached {OBJC_POINTER_TYPE_DECL} type as pointer_type then
				if
					not pointer_type.is_pointer_to_c_string and
					(pointer_type.is_pointer_to_instance_object and not pointer_type.name.starts_with ("id") implies
					wrappers_generator.eiffel_class_exists (pointer_type.name.split (' ').first))
				then
					eiffel_type := objc_type_to_eiffel_type (pointer_type)
					if eiffel_type.is_equal (unsupported_type) then
						eiffel_type := unsupported_type
					else
						eiffel_type.prepend ("detachable ")
					end
					locals.append ("%N%Tan_arg__item: POINTER")
					attachment_tests.append ("%N%Tif attached an_arg as an_arg_attached then%N")
					attachment_tests.append ("%T%Tan_arg__item := an_arg_attached.item%N")
					attachment_tests.append ("%Tend")
					suffix.append ("__item")
				else
					eiffel_type := unsupported_type
				end
			else
				eiffel_type := unsupported_type
			end
			arguments_list := Result.arguments_list
			arguments_list.force (["an_arg", eiffel_type], arguments_list.upper + 1)
			body.replace_substring_all ("$SUFFIX", suffix)
			body.replace_substring_all ("$LOCALS", locals)
			body.replace_substring_all ("$ATTACHMENT_TEST", attachment_tests)
		end

	generate_property_objc_getter (p: OBJC_PROPERTY_DECL): EIFFEL_FEATURE_DECL
			-- Generate a getter external for `p'.
		require
			current_objc_class_not_void: current_objc_class /= Void
			current_eiffel_class_not_void: current_eiffel_class /= Void
		local
			body: STRING
			code: STRING
			type: OBJC_TYPE_DECL
			framework: STRING
			eiffel_type: STRING
			arguments_list: ARRAY [TUPLE [name: STRING; type: STRING]]
		do
			body := "[
						-- Auto generated Objective-C wrapper.
					external
						"C inline use <$FRAMEWORK/$FRAMEWORK.h>"
					alias
						"$SBL
							$CODE
						 $SBR"
					end
				]"
			if attached current_objc_category as objc_category then
				framework := objc_category.framework
			else
				framework := current_eiffel_class.framework
			end
			body.replace_substring_all ("$FRAMEWORK", framework)
			body.replace_substring_all ("$SBL", "[")
			body.replace_substring_all ("$SBR", "]")
			create Result.make (external_prefix + objc_identifier_to_eiffel_style (p.getter), <<["an_item", "POINTER"]>>, body)
			create code.make_empty
			type := p.type
			arguments_list := Result.arguments_list
			if attached {OBJC_STRUCT_TYPE_DECL} type as struct_type then
				code.append ("*(" + struct_type.name + " *)$result_pointer = ")
				arguments_list.force (["result_pointer", "POINTER"], arguments_list.upper + 1)
			elseif not (attached {OBJC_BASIC_TYPE_DECL} type as basic_type and then basic_type.is_void) then
				code.append ("return ")
				if attached {OBJC_BASIC_TYPE_DECL} type then
					eiffel_type := objc_type_to_eiffel_type (type)
				elseif attached {OBJC_POINTER_TYPE_DECL} type then
					code.append ("(EIF_POINTER)")
					eiffel_type := "POINTER"
				else
					eiffel_type := unsupported_type
				end
				Result.return_type := eiffel_type
			end
			code.append ("[(" + current_objc_class.name + " *)$an_item " + p.getter + "];")
			body.replace_substring_all ("$CODE", code)
		end

	generate_property_objc_setter (p: OBJC_PROPERTY_DECL): EIFFEL_FEATURE_DECL
			-- Generate a setter external for `p'.
		require
			current_objc_class_not_void: current_objc_class /= Void
			current_eiffel_class_not_void: current_eiffel_class /= Void
		local
			framework: STRING
			body: STRING
			setter: STRING
			type: OBJC_TYPE_DECL
			arguments_list: ARRAY [TUPLE [name: STRING; type: STRING]]
			eiffel_type: STRING
		do
			body := "[
						-- Auto generated Objective-C wrapper.
					external
						"C inline use <$FRAMEWORK/$FRAMEWORK.h>"
					alias
						"$SBL
							[($CLASS_NAME *)$an_item $SETTER_NAME$ARG]
						 $SBR"
					end
				]"
			if attached current_objc_category as objc_category then
				framework := objc_category.framework
			else
				framework := current_eiffel_class.framework
			end
			body.replace_substring_all ("$FRAMEWORK", framework)
			body.replace_substring_all ("$SBL", "[")
			body.replace_substring_all ("$SBR", "]")
			body.replace_substring_all ("$CLASS_NAME", current_objc_class.name)
			setter := objc_identifier_to_eiffel_style (p.setter)
			setter.remove_tail (1)
			body.replace_substring_all ("$SETTER_NAME", p.setter)
			create Result.make (external_prefix + setter, <<["an_item", "POINTER"]>>, body)
			type := p.type
			if attached {OBJC_BASIC_TYPE_DECL} type then
				eiffel_type := objc_type_to_eiffel_type (type)
				body.replace_substring_all ("$ARG", "$an_arg")
			elseif attached {OBJC_STRUCT_TYPE_DECL} type then
				eiffel_type := "POINTER"
				body.replace_substring_all ("$ARG", "*((" + type.name + " *)$an_arg)")
			elseif attached {OBJC_POINTER_TYPE_DECL} type as pointer_type then
				if
					pointer_type.is_pointer_to_c_string or
					pointer_type.is_pointer_to_class_object or
					pointer_type.is_pointer_to_instance_object or
					pointer_type.is_pointer_to_selector
				then
					eiffel_type := "POINTER"
					body.replace_substring_all ("$ARG", "$an_arg")
				else
					eiffel_type := unsupported_type
				end
			else
				eiffel_type := unsupported_type
			end
			arguments_list := Result.arguments_list
			arguments_list.force (["an_arg", eiffel_type], arguments_list.upper + 1)
		end

	resolve_features_conflicts
			-- Resolve feature conflicts when inheriting from multiple protocols.
		require
			current_objc_class_not_void: current_objc_class /= Void
			current_eiffel_class_not_void: current_eiffel_class /= Void
		local
			inheritance_declarations: HASH_TABLE [ARRAY [TUPLE [option_name: STRING; options: ARRAY [STRING]]], STRING]
			current_protocol, other_protocol: OBJC_PROTOCOL_DECL
			class_methods: HASH_TABLE [OBJC_METHOD_DECL, STRING] -- Not to be confused with Objective-C "class methods"
			current_protocol_methods, other_protocol_methods: HASH_TABLE [OBJC_METHOD_DECL, STRING]
			current_protocol_method, other_protocol_method: OBJC_METHOD_DECL
			current_protocol_method_name: STRING
			undefine_option: TUPLE [option_name: STRING; options: ARRAY [STRING]]
			found: BOOLEAN
			undefined_method_name: STRING
		do
			create resolved_methods_conflicts.make (0)
			create undefine_option
			inheritance_declarations := current_eiffel_class.inheritance_declarations
			flatten_class (current_objc_class)
			check attached flattened_classes.item (current_objc_class.name) as attached_class_methods then
				class_methods := attached_class_methods
			end
				-- For all protocols
			across current_objc_class.protocols as current_protocol_cursor loop
				current_protocol := current_protocol_cursor.item
				flatten_protocol (current_protocol)
				check attached flattened_protocols.item (current_protocol.name) as attached_current_protocol_methods then
					current_protocol_methods := attached_current_protocol_methods
				end
					-- For all current protocol methods
				across current_protocol_methods as current_protocol_methods_cursor loop
					current_protocol_method := current_protocol_methods_cursor.item
					if not current_protocol_method.is_class_method and then is_method_supported (current_protocol_method) then
						current_protocol_method_name := current_protocol_method.selector_name
							-- Find a conflict for `current_protocol_method_name'.
							-- For all class methods
						across class_methods as class_methods_cursor loop
							if
								not class_methods_cursor.item.is_class_method and
								is_method_supported (class_methods_cursor.item) and
								class_methods_cursor.item.selector_name.is_equal (current_protocol_method_name) and
								not current_protocol_method_name.starts_with ("init") and
								not current_protocol_method_name.is_equal ("release") and
								not current_protocol_method_name.is_equal ("autorelease") and
								not current_protocol_method_name.is_equal ("retain")
							then
									-- Found a conflict with the class.
									-- Undefine this method in the current_protocol
								check attached inheritance_declarations.item (objc_class_name_to_eiffel_style (current_protocol.name) + protocol_suffix) as inheritance_declaration then
										-- Check whether an `undefine' option already exists
									found := False
									across inheritance_declaration as options_cursor loop
										if options_cursor.item.option_name.is_equal ("undefine") then
											undefine_option := options_cursor.item
											found := True
										end
									end
									if not found then
										undefine_option := ["undefine", <<>>]
										inheritance_declaration.force (undefine_option, inheritance_declaration.upper + 1)
									end
									undefined_method_name := eiffel_name_for_objc_method (current_protocol_method)
									undefine_option.options.force (undefined_method_name, undefine_option.options.count + 1)
									undefine_option.options.force (external_prefix + undefined_method_name, undefine_option.options.count + 1)
								end
								resolved_methods_conflicts.put (current_protocol_method, current_protocol_method_name)
							end
						end
							-- For all other protocols
						across current_objc_class.protocols as other_protocol_cursor loop
							other_protocol := other_protocol_cursor.item
							if current_protocol /= other_protocol then
								flatten_protocol (other_protocol)
								check attached flattened_protocols.item (other_protocol.name) as attached_other_protocol_methods then
									other_protocol_methods := attached_other_protocol_methods
								end
									-- For all other protocol's methods
								across other_protocol_methods as other_protocol_methods_cursor loop
									other_protocol_method := other_protocol_methods_cursor.item
									if
										not other_protocol_method.is_class_method and
										is_method_supported (other_protocol_method) and
										not resolved_methods_conflicts.has (other_protocol_method.selector_name) and then
										other_protocol_method.selector_name.is_equal (current_protocol_method_name) and
										not current_protocol_method_name.starts_with ("init") and
										not current_protocol_method_name.is_equal ("release") and
										not current_protocol_method_name.is_equal ("autorelease") and
										not current_protocol_method_name.is_equal ("retain")
									then
											-- Found a conflict between parent protocols
											-- Undefine this method in the current protocol and mark it as "conflict resolved"
											-- by adding it to the resolved_methods_conflicts hash_table
										check attached inheritance_declarations.item (objc_class_name_to_eiffel_style (current_protocol.name) + protocol_suffix) as inheritance_declaration then
												-- Check whether an `undefine' option already exists
											found := False
											across inheritance_declaration as options_cursor loop
												if options_cursor.item.option_name.is_equal ("undefine") then
													undefine_option := options_cursor.item
													found := True
												end
											end
											if not found then
												undefine_option := ["undefine", <<>>]
												inheritance_declaration.force (undefine_option, inheritance_declaration.upper + 1)
											end
											undefined_method_name := eiffel_name_for_objc_method (current_protocol_method)
											undefine_option.options.force (undefined_method_name, undefine_option.options.count + 1)
											undefine_option.options.force (external_prefix + undefined_method_name, undefine_option.options.count + 1)
										end
										resolved_methods_conflicts.put (current_protocol_method, current_protocol_method_name)
									end
								end
							end
						end
					end
				end
			end
		end

	add_creation_procedures
			-- Add the creation procedures to the class.
		require
			current_objc_class_not_void: current_objc_class /= Void
			current_eiffel_class_not_void: current_eiffel_class /= Void
		local
			creation_procedure_name: STRING
			creation_procedures_group_names: ARRAY [STRING]
			class_methods: HASH_TABLE [OBJC_METHOD_DECL, STRING]
			class_method: OBJC_METHOD_DECL
			class_method_name: STRING
		do
			check attached flattened_classes.item (current_objc_class.name) as current_objc_class_methods then
				class_methods := current_objc_class_methods
			end
			across class_methods as cursor loop
				class_method := cursor.item
				class_method_name := class_method.selector_name
				if not class_method.is_class_method and class_method_name.starts_with ("init") and then is_method_supported (class_method) then
					if not current_eiffel_class.creation_procedures_groups.valid_index (2) then
						current_eiffel_class.creation_procedures_groups.force ([<<>>, <<>>], 2)
					end
					creation_procedures_group_names := current_eiffel_class.creation_procedures_groups.item (2).names
					creation_procedure_name := eiffel_name_for_objc_method (class_method)
					creation_procedure_name.remove_head (4)
					creation_procedure_name.prepend ("make")
					creation_procedures_group_names.force (creation_procedure_name, creation_procedures_group_names.upper + 1)
				end
			end
		end

	is_method_supported (m: OBJC_METHOD_DECL): BOOLEAN
			-- Is the protocol method represented by Current supported?
		local
			current_argument: OBJC_ARGUMENT_DECL
			eiffel_type: STRING
			arguments: ARRAYED_LIST [OBJC_ARGUMENT_DECL]
		do
			Result := True
			check attached m.return_type as type then
				if
					not (attached {OBJC_BASIC_TYPE_DECL} type as basic_type and then basic_type.is_void) and
					not (attached {OBJC_STRUCT_TYPE_DECL} type as struct_type)
				then
					if attached {OBJC_BASIC_TYPE_DECL} type then
						if objc_type_to_eiffel_type (type).is_equal (unsupported_type) then
							Result := False
						end
					elseif attached {OBJC_POINTER_TYPE_DECL} type as pointer_type then
						if not pointer_type.is_pointer_to_selector then
							eiffel_type := "detachable "
							if
								not pointer_type.is_pointer_to_c_string and
								(pointer_type.is_pointer_to_instance_object and not pointer_type.name.starts_with ("id") implies
								wrappers_generator.eiffel_class_exists (pointer_type.name.split (' ').first))
							then
								eiffel_type.append (objc_type_to_eiffel_type (pointer_type))
								if eiffel_type.is_equal ("detachable " + unsupported_type) then
									Result := False
								end
							else
								Result := False
							end
						end
					else
						Result := False
					end
				end
			end
			from
				arguments := m.arguments
				arguments.start
			until
				arguments.after
			loop
				current_argument := arguments.item
				if
					attached current_argument.argument_name as attached_argument_name and then
					attached current_argument.type as type and then
					not (attached {OBJC_STRUCT_TYPE_DECL} type as struct_type)
				then
					if attached {OBJC_BASIC_TYPE_DECL} type then
						if objc_type_to_eiffel_type (type).is_equal (unsupported_type) then
							Result := False
						end
					elseif attached {OBJC_POINTER_TYPE_DECL} type as pointer_type then
						if
							not pointer_type.is_pointer_to_c_string and
							(pointer_type.is_pointer_to_instance_object and not pointer_type.name.starts_with ("id") implies
							wrappers_generator.eiffel_class_exists (pointer_type.name.split (' ').first))
						then
							if objc_type_to_eiffel_type (pointer_type).is_equal (unsupported_type) then
								Result := False
							end
						else
							Result := False
						end
					else
						Result := False
					end
				end
				arguments.forth
			end
		end

	wrappers_generator: WRAPPERS_GENERATOR
			-- The wrapper generator.

	current_objc_category: detachable OBJC_CATEGORY_DECL
			-- The Objective-C category currently being visited.

	current_objc_class: detachable OBJC_CLASS_DECL note option: stable attribute end
			-- The Objective-C class currently being visited.

	current_eiffel_class: detachable EIFFEL_CLASS_DECL note option: stable attribute end
			-- The eiffel class currently being generated.

	current_wrapping_features_group: STRING
			-- The current wrapping features group name.

	flattened_classes: HASH_TABLE [HASH_TABLE [OBJC_METHOD_DECL, STRING], STRING]
		-- A class name indexed table of tables of Objective-C methods indexed their selectors names.

	flattened_protocols: HASH_TABLE [HASH_TABLE [OBJC_METHOD_DECL, STRING], STRING]
		-- A protocol name indexed table of tables of Objective-C methods indexed their selectors names.

	resolved_methods_conflicts: HASH_TABLE [OBJC_METHOD_DECL, STRING]
		-- A table of Objective-C methods indexed by their names. This is an auxiliary table used to keep
		-- track of those methods for which the conflict has been resolved.

end

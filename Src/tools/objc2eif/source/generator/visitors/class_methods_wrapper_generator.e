note
	description: "A visitor used to generate wrappers for Objective-C classes."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_METHODS_WRAPPER_GENERATOR

inherit
	GENERATOR_VISITOR
		redefine
			visit_class_decl,
			visit_category_decl,
			visit_method_decl
		end

create
	make

feature {NONE} -- Initialization

	make (a_wrappers_generator: WRAPPERS_GENERATOR)
			-- Initialize `Current'.
		do
			create classes.make (0)
			current_wrapping_features_group := ""
			wrappers_generator := a_wrappers_generator
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
			wrapper_objc_class_name_feature, is_subclass_instance_feature: EIFFEL_FEATURE_DECL
			body: STRING
		do
			current_objc_class := c
			class_name := c.name
			current_wrapping_features_group := ""
			create current_eiffel_class.make (objc_class_name_to_eiffel_style (class_name) + utils_suffix, c.framework)
			inheritance_declarations := current_eiffel_class.inheritance_declarations
			continue_generation := True
			if class_name.is_equal ("NSObject") then
				inheritance_declarations.put (<<["redefine", <<"is_subclass_instance">>]>>, configuration.ns_named_class.name.split ('/').last.split ('.').first.as_upper)
			elseif attached c.parent_class as parent_class then
					inheritance_declarations.put (<<["redefine", <<"wrapper_objc_class_name", "is_subclass_instance">>]>>, objc_class_name_to_eiffel_style (parent_class.name) + utils_suffix)
			end
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
					-- Add wrapper_object_class_name feature
				body := "[
							-- The class name used for classes of the generated wrapper classes.
						do
							Result := "$WRAPPER_CLASS_NAME"
						end
					]"
				body.replace_substring_all ("$WRAPPER_CLASS_NAME", class_name)
				create wrapper_objc_class_name_feature.make ("wrapper_objc_class_name", <<>>, body)
				wrapper_objc_class_name_feature.return_type := "STRING"
					-- Add is_subclass_instance feature
				body := "[
							-- <Precursor>
						do
							Result := False
						end
					]"
				create is_subclass_instance_feature.make ("is_subclass_instance", <<>>, body)
				is_subclass_instance_feature.return_type := "BOOLEAN"
				current_eiffel_class.features_groups.put ([<<"NONE">>, <<wrapper_objc_class_name_feature, is_subclass_instance_feature>>], "Implementation")
					-- Add the class
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
		do
			check current_eiffel_class_not_void: current_eiffel_class /= Void end
			check current_objc_class_not_void: current_objc_class /= Void end
				-- Ignore "..." arguments.
			if m.arguments.for_all (agent (a: OBJC_ARGUMENT_DECL): BOOLEAN do Result := not a.is_dotdotdot end) then
				if
						-- Ignore instance methods
					m.is_class_method and
						-- Ignore the method if it was defined in a parent class already.
					not (attached current_objc_class.parent_class as parent_class and then parent_class.responds_to_selector (m.selector_name)) and
						-- Ignore allocation methods
					not m.selector_name.starts_with ("alloc")
				then
					features_groups := current_eiffel_class.features_groups
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
					features.force (generate_wrapper_feature (m), features.upper + 1)
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
					features.force (generate_external (m), features.upper + 1)
				end
			end
		end

feature {NONE} -- Implementation

	generate_wrapper_feature (m: OBJC_METHOD_DECL): EIFFEL_FEATURE_DECL
			-- Generate an eiffel wrapper feature for `m'.
		require
			current_objc_class_not_void: current_objc_class /= Void
			current_eiffel_class_not_void: current_eiffel_class /= Void
		local
			unsupported: BOOLEAN
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
								local
									l_objc_class: OBJC_CLASS$LOCALS
								do$ATTACHMENT_TESTS
									create l_objc_class.make_with_name (get_class_name)
									check l_objc_class_registered: l_objc_class.registered end
									Result := $EXTERNAL_FEATURE_NAME (l_objc_class.item$ARGS)
								end
							]"
						eiffel_type := objc_type_to_eiffel_type (type)
						if eiffel_type.is_equal (unsupported_type) then
							unsupported := True
						end
					elseif attached {OBJC_POINTER_TYPE_DECL} type as pointer_type then
						if pointer_type.is_pointer_to_selector then
							eiffel_type := objc_type_to_eiffel_type (pointer_type)
							check eiffel_type.is_equal (configuration.objc_selector_file.name.split ('/').last.split ('.').first.as_upper) end
								code := "[
										local
											result_pointer: POINTER
											l_objc_class: OBJC_CLASS$LOCALS
										do$ATTACHMENT_TESTS
											create l_objc_class.make_with_name (get_class_name)
											check l_objc_class_registered: l_objc_class.registered end
											result_pointer := $EXTERNAL_FEATURE_NAME (l_objc_class.item$ARGS)
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
										l_objc_class: OBJC_CLASS$LOCALS
									do$ATTACHMENT_TESTS
										create l_objc_class.make_with_name (get_class_name)
										check l_objc_class_registered: l_objc_class.registered end
										result_pointer := $EXTERNAL_FEATURE_NAME (l_objc_class.item$ARGS)
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
									unsupported := True
								end
							else
								eiffel_type.append (unsupported_type)
								unsupported := True
							end
						end
					elseif attached {OBJC_STRUCT_TYPE_DECL} type as struct_type then
						code := "[
								local
									l_objc_class: OBJC_CLASS$LOCALS
								do$ATTACHMENT_TESTS
									create l_objc_class.make_with_name (get_class_name)
									check l_objc_class_registered: l_objc_class.registered end
									create Result.make
									$EXTERNAL_FEATURE_NAME (l_objc_class.item, Result.item$ARGS)
								end
							]"
						eiffel_type := objc_class_name_to_eiffel_style (struct_type.name)
					else
						code := "[
								local
									l_objc_class: OBJC_CLASS$LOCALS
								do$ATTACHMENT_TESTS
									create l_objc_class.make_with_name (get_class_name)
									check l_objc_class_registered: l_objc_class.registered end
									Result := $EXTERNAL_FEATURE_NAME (l_objc_class.item$ARGS)
								end
							]"
						eiffel_type := unsupported_type
						unsupported := True
					end
					Result.return_type := eiffel_type
					code.replace_substring_all ("$FEATURE_NAME", feature_name)
				else
					code := "[
							local
								l_objc_class: OBJC_CLASS$LOCALS
							do$ATTACHMENT_TESTS
								create l_objc_class.make_with_name (get_class_name)
								check l_objc_class_registered: l_objc_class.registered end
								$EXTERNAL_FEATURE_NAME (l_objc_class.item$ARGS)
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
							if eiffel_type.is_equal (unsupported_type) then
								unsupported := True
							end
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
									unsupported := True
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
								unsupported := True
							end
						else
							eiffel_type := unsupported_type
							unsupported := True
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
			Result.is_commented := unsupported
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
			unsupported: BOOLEAN
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
			create Result.make (external_prefix + eiffel_name_for_objc_method (m), <<["a_class_object", "POINTER"]>>, body)
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
						if eiffel_type.is_equal (unsupported_type) then
							unsupported := True
						end
					elseif attached {OBJC_POINTER_TYPE_DECL} type then
						code.append ("(EIF_POINTER)")
						eiffel_type := "POINTER"
					else
						eiffel_type := unsupported_type
						unsupported := True
					end
					Result.return_type := eiffel_type
				end
			end
			code.append ("[(Class)$a_class_object")
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
						if not argument_name_in_eiffel_style.starts_with ("a_") then
							argument_name_in_eiffel_style.prepend ("a_")
						end
						if attached {OBJC_BASIC_TYPE_DECL} type then
							eiffel_type := objc_type_to_eiffel_type (type)
							if eiffel_type.is_equal (unsupported_type) then
								unsupported := True
							end
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
								unsupported := True
							end
						else
							eiffel_type := unsupported_type
							unsupported := True
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
			Result.is_commented := unsupported
		end

	wrappers_generator: WRAPPERS_GENERATOR

	current_objc_category: detachable OBJC_CATEGORY_DECL
			-- The Objective-C category currently being visited.

	current_objc_class: detachable OBJC_CLASS_DECL note option: stable attribute end
			-- The Objective-C class currently being visited.

	current_eiffel_class: detachable EIFFEL_CLASS_DECL note option: stable attribute end
			-- The eiffel class currently being generated.

	current_wrapping_features_group: STRING
			-- The current wrapping features group name.

	utils_suffix: STRING = "_UTILS"
			-- The suffix for the class name.

end

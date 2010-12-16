note
	description: "Summary description for {PROTOCOLS_GENERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROTOCOLS_GENERATOR

inherit
	GENERATOR_VISITOR
		redefine
			visit_protocol_decl,
			visit_protocol_method_decl
		end

create
	make

feature {NONE} -- Initialization

	make (a_wrappers_generator: WRAPPERS_GENERATOR)
			-- Initialize `Current' with `a_wrappers_generator'.
		do
			create classes.make (0)
			wrappers_generator := a_wrappers_generator
		end

feature -- Access

	classes: HASH_TABLE [EIFFEL_CLASS_DECL, STRING]
			-- A table of eiffel classes that wrap their Objective-C counterpart, indexed by class name.

feature -- Operations

	visit_protocol_decl (p: OBJC_PROTOCOL_DECL)
			-- Visit a protocol declaration.
		local
			inheritance_declarations: HASH_TABLE [ARRAY [TUPLE [option_name: STRING; options: ARRAY[STRING]]], STRING]
			parent_protocols: HASH_TABLE[OBJC_PROTOCOL_DECL, STRING]
		do
			if not p.is_forward_reference then
				current_objc_protocol := p
				check not p.framework.is_empty end
				create current_eiffel_class.make (objc_class_name_to_eiffel_style (p.name) + protocol_suffix, p.framework)
				current_eiffel_class.is_deferred := True
				inheritance_declarations := current_eiffel_class.inheritance_declarations
				parent_protocols := p.parent_protocols
				if p.name.is_equal ("NSObject") or parent_protocols.is_empty then
					inheritance_declarations.put (<<>>, configuration.ns_common_file.name.split ('/').last.split ('.').first.as_upper)
				else
					from
						parent_protocols.start
					until
						parent_protocols.after
					loop
						inheritance_declarations.put (<<>>, objc_class_name_to_eiffel_style (parent_protocols.item_for_iteration.name) + protocol_suffix)
						parent_protocols.forth
					end
				end
				Precursor (p)
				classes.put (current_eiffel_class, current_eiffel_class.name)
			end
		end

	visit_protocol_method_decl (m: OBJC_PROTOCOL_METHOD_DECL)
			-- Visit a method declaration.
		local
			features_groups: HASH_TABLE [TUPLE [export_statuses: ARRAY [STRING]; features: ARRAY [EIFFEL_FEATURE_DECL]], STRING]
			features_group: TUPLE [export_statuses: ARRAY [STRING]; features: ARRAY [EIFFEL_FEATURE_DECL]]
			features: ARRAY [EIFFEL_FEATURE_DECL]
			generated_feature: EIFFEL_FEATURE_DECL
			selector_name: STRING
		do
			check attached current_eiffel_class end
			selector_name := m.selector_name
			features_groups := current_eiffel_class.features_groups
			if
					-- Ignore "..." arguments.
				m.arguments.for_all (agent (a: OBJC_ARGUMENT_DECL): BOOLEAN do Result := not a.is_dotdotdot end) and
					-- For the moment, ignore class methods
				not m.is_class_method and
					-- We don't support methods that start with "init" because of the way we map them
					-- in the classes.
				not selector_name.starts_with ("init")
			then
				if m.is_required then
						-- Generate required method
					if
						not (
							selector_name.is_equal ("retain") or
							selector_name.is_equal ("release") or
							selector_name.is_equal ("autorelease")
						)
					then
						if attached features_groups.item ("Required Methods") as attached_features_groups then
							features_group := attached_features_groups
						else
							features_group := [<<>>,<<>>]
							features_groups.put (features_group, "Required Methods")
						end
						features := features_group.features
						features.force (generate_wrapper_feature (m), features.upper + 1)
					end
						-- Generate required method external
					if attached features_groups.item ("Required Methods Externals") as attached_features_groups then
						features_group := attached_features_groups
					else
						features_group := [<<"NONE">>,<<>>]
						features_groups.put (features_group, "Required Methods Externals")
					end
					features := features_group.features
					features.force (generate_external (m), features.upper + 1)
				else
						-- Generate optional method
					if attached features_groups.item ("Optional Methods") as attached_features_groups then
						features_group := attached_features_groups
					else
						features_group := [<<>>,<<>>]
						features_groups.put (features_group, "Optional Methods")
					end
					features := features_group.features
					generated_feature := generate_optional_method (m)
					features.force (generated_feature, features.upper + 1)
						-- Generate `has_optional_method'
					if attached features_groups.item ("Status Report") as attached_features_groups then
						features_group := attached_features_groups
					else
						features_group := [<<>>,<<>>]
						features_groups.put (features_group, "Status Report")
					end
					features := features_group.features
					features.force (generate_has_optional_method_feature (m, generated_feature.is_commented), features.upper + 1)
						-- Generate `objc_has_optional_method'
					if attached features_groups.item ("Status Report Externals") as attached_features_groups then
						features_group := attached_features_groups
					else
						features_group := [<<>>,<<>>]
						features_groups.put (features_group, "Status Report Externals")
					end
					features := features_group.features
					features.force (generate_objc_has_optional_method_feature (m, generated_feature.is_commented), features.upper + 1)
						-- Generate optional method external
					if attached features_groups.item ("Optional Methods Externals") as attached_features_groups then
						features_group := attached_features_groups
					else
						features_group := [<<"NONE">>,<<>>]
						features_groups.put (features_group, "Optional Methods Externals")
					end
					features := features_group.features
					features.force (generate_external (m), features.upper + 1)

				end
			end
		end

feature {NONE} -- Implementation

	generate_optional_method (m: OBJC_PROTOCOL_METHOD_DECL): EIFFEL_FEATURE_DECL
			-- Generate the eiffel feature corresponding to `m'.
		local
			precondition: STRING
		do
			Result := generate_wrapper_feature (m)
			check attached Result.body as attached_body then
				precondition := "%Nrequire%N"
				precondition.append ("%Thas_" + eiffel_name_for_objc_method (m) + ": has_" + eiffel_name_for_objc_method (m))
				attached_body.insert_string (precondition, attached_body.index_of ('%N', 1))
			end
		end

	generate_has_optional_method_feature (m: OBJC_PROTOCOL_METHOD_DECL; is_commented: BOOLEAN): EIFFEL_FEATURE_DECL
			-- Generate the eiffel feature corresponding to `m'.
		local
			body: STRING
		do
			body := "[
					-- Auto generated Objective-C wrapper.
				do
					Result := $EXTERNAL_PREFIXhas_$METHOD_NAME (item)
				end
			]"
			Create Result.make ("has_" + eiffel_name_for_objc_method (m), <<>>, body)
			body.replace_substring_all ("$EXTERNAL_PREFIX", external_prefix)
			body.replace_substring_all ("$METHOD_NAME", eiffel_name_for_objc_method (m))
			Result.is_commented := is_commented
			Result.return_type := "BOOLEAN"
		end

	generate_objc_has_optional_method_feature (m: OBJC_PROTOCOL_METHOD_DECL; is_commented: BOOLEAN): EIFFEL_FEATURE_DECL
			-- Generate the eiffel feature corresponding to `m'.
		local
			body: STRING
		do
			body := "[
					-- Auto generated Objective-C wrapper.
				external
					"C inline use <$FRAMEWORK/$FRAMEWORK.h>"
				alias
					"$SBL
						return [(id)$an_item respondsToSelector:@selector($SELECTOR_NAME)];
					 $SBR"
				end
			]"
			body.replace_substring_all ("$SBL", "[")
			body.replace_substring_all ("$SBR", "]")
			check attached current_objc_protocol end
			body.replace_substring_all ("$FRAMEWORK", current_objc_protocol.framework)
			body.replace_substring_all ("$SELECTOR_NAME", m.selector_name)
			Create Result.make (external_prefix + "has_" + eiffel_name_for_objc_method (m), <<["an_item", "POINTER"]>>, body)
			Result.is_commented := is_commented
			Result.return_type := "BOOLEAN"
		end

	generate_wrapper_feature (m: OBJC_METHOD_DECL): EIFFEL_FEATURE_DECL
			-- Generate an eiffel wrapper feature for `m'.
		require
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
								local$LOCALS
								do$ATTACHMENT_TESTS
									Result := $EXTERNAL_FEATURE_NAME (item$ARGS)
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
									unsupported := True
								end
							else
								eiffel_type.append (unsupported_type)
								unsupported := True
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
						unsupported := True
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
			current_objc_protocol_not_void: current_objc_protocol /= Void
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
			framework := current_eiffel_class.framework
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
			code.append ("[(id <" + current_objc_protocol.name + ">)$an_item")
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
			-- The wrapper generator.

	current_eiffel_class: detachable EIFFEL_CLASS_DECL note option: stable attribute end
			-- The eiffel class currently being generated.

	current_objc_protocol: detachable OBJC_PROTOCOL_DECL note option: stable attribute end
			-- The Objective-C protocol currently being examined.

end

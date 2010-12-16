note
	description: "Summary description for {EIFFEL_DEBUG_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DEBUG_VISITOR

inherit
	EIFFEL_ENTITY_DECL_VISITOR

create
	make

feature {NONE} -- Initialization

	make
		do
			last_result := ""
		end

feature -- Access

	last_result: STRING

feature -- Operations

	visit_class_decl (c: EIFFEL_CLASS_DECL)
			-- Visit a class declaration.
		local
			inheritance_decls: HASH_TABLE [ARRAY [TUPLE [option_name: STRING; options: ARRAY[STRING]]], STRING]
			inheritance_decl_options: ARRAY [TUPLE [option_name: STRING; options: ARRAY[STRING]]]
			inheritance_options_group: TUPLE [option_name: STRING; options: ARRAY[STRING]]
			inheritance_options: ARRAY[STRING]
			creation_procedures_groups: ARRAY [TUPLE [export_statuses: ARRAY [STRING]; group: ARRAY [STRING]]]
			creation_procedures_group: TUPLE [export_statuses: ARRAY [STRING]; names: ARRAY [STRING]]
			creation_procedures: ARRAY [STRING]
			creation_procedures_export_statuses: ARRAY [STRING]
			features_groups: HASH_TABLE [TUPLE [export_statuses: ARRAY [STRING]; features: ARRAY [EIFFEL_FEATURE_DECL]], STRING]
			features_group: TUPLE [export_statuses: ARRAY [STRING]; features: ARRAY [EIFFEL_FEATURE_DECL]]
			features_group_export_statuses: ARRAY [STRING]
			features: ARRAY [EIFFEL_FEATURE_DECL]
		do
				-- Output header
			last_result := "[
				note
					description: "Auto-generated Objective-C wrapper class"
					date: "$Date$"
					revision: "$Revision$"
				]"
			last_result.append ("%N%N")
				-- Output class name
			if c.is_deferred then
				last_result.append ("deferred ")
			end
			last_result.append ("class%N")
			last_result.append ("%T" + c.name + "%N%N")
				-- Output inheritance declarations
			inheritance_decls := c.inheritance_declarations
			if not c.inheritance_declarations.is_empty then
				last_result.append ("inherit%N")
				across inheritance_decls as l_declaration loop
					inheritance_decl_options := l_declaration.item
					last_result.append ("%T" + l_declaration.key + "%N")
					if not inheritance_decl_options.is_empty then
						across inheritance_decl_options as inheritance_decl_options_cursor loop
							inheritance_options_group := inheritance_decl_options_cursor.item
							last_result.append ("%T%T" + inheritance_options_group.option_name + "%N")
							inheritance_options := inheritance_options_group.options
							if not inheritance_options.is_empty then
								across inheritance_options as inheritance_options_cursor loop
									last_result.append ("%T%T%T" + inheritance_options_cursor.item + ",%N")
								end
								last_result.remove_tail (2)
								last_result.append ("%N")
							end
						end
						last_result.append ("%T%Tend%N%N")
					end
				end
				last_result.append ("%N")
			end
				-- Output creation procedures
			creation_procedures_groups := c.creation_procedures_groups
			across creation_procedures_groups as creation_procedures_groups_cursor loop
				creation_procedures_group := creation_procedures_groups_cursor.item
				creation_procedures := creation_procedures_group.names
				if not creation_procedures_group.is_empty then
					last_result.append ("create")
					creation_procedures_export_statuses := creation_procedures_group.export_statuses
					if not creation_procedures_export_statuses.is_empty then
						last_result.append (" {")
						across creation_procedures_export_statuses as creation_procedures_export_statuses_cursor loop
							last_result.append (creation_procedures_export_statuses_cursor.item + ", ")
						end
						last_result.remove_tail (2)
						last_result.append ("}")
					end
					last_result.append ("%N")
					across creation_procedures as creation_procedures_cursor loop
						last_result.append ("%T" + creation_procedures_cursor.item + ",%N")
					end
					last_result.remove_tail (2)
					last_result.append ("%N%N")
				end
			end
				-- Output features
			features_groups := c.features_groups
			from
				features_groups.start
			until
				features_groups.after
			loop
				features_group := features_groups.item_for_iteration
				last_result.append ("feature")
				features_group_export_statuses := features_group.export_statuses
				if not features_group_export_statuses.is_empty then
					last_result.append (" {")
					across features_group_export_statuses as features_group_export_statuses_cursor loop
						last_result.append (features_group_export_statuses_cursor.item + ", ")
					end
					last_result.remove_tail (2)
					last_result.append ("}")
				end
				last_result.append (" -- " + features_groups.key_for_iteration + "%N%N")
				features := features_group.features
				across features as features_cursor loop
					visit_feature_decl (features_cursor.item)
				end
				features_groups.forth
			end
				-- Close class declaration
			last_result.append ("end")
		end

	visit_feature_decl (r: EIFFEL_FEATURE_DECL)
			-- Visit a feature declaration.
		local
			arguments_list: ARRAY [TUPLE [name: STRING; type: STRING]]
			splitted_body: LIST [STRING]
			argument: TUPLE [name: STRING; type: STRING]
			comment: STRING
		do
			create comment.make_empty
			if r.is_commented then
				comment := "--"
			end
				-- Output routine name
			last_result.append (comment + "%T" + r.name)
			arguments_list := r.arguments_list
			if not arguments_list.is_empty then
					-- Output arguments
				last_result.append (" (")
				across arguments_list as arguments_list_cursor loop
					argument := arguments_list_cursor.item
					last_result.append (argument.name + ": " + argument.type + "; ")
				end
				last_result.remove_tail (2)
				last_result.append (")")
			end
			if attached r.return_type as attached_return_type then
					-- Output return type
				last_result.append (": " + attached_return_type)
			end
			if attached r.setter as attached_setter then
				last_result.append (" assign " + attached_setter)
			end
				-- Output body
			last_result.append ("%N")
			if attached r.body as attached_body then
				splitted_body := attached_body.split ('%N')
				from
					splitted_body.start
				until
					splitted_body.after
				loop
					last_result.append (comment + "%T%T" + splitted_body.item + "%N")
					splitted_body.forth
				end
				last_result.append ("%N")
			end
		end

end

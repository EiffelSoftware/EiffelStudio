indexing
	description: "Common heir for generating IL (MSIL, JVM) metadata for a particular type"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IL_META_DATA_GENERATOR

inherit
	SHARED_WORKBENCH

	SHARED_IL_CODE_GENERATOR

	COMPILER_EXPORTER

	SHARED_BYTE_CONTEXT

feature -- Generation

	generate_class_mappings (class_type: CLASS_TYPE) is
			-- Generate class description
		require
			class_type_not_void: class_type /= Void
		local
			name, element_name: STRING
			sp: SPECIAL_CLASS_TYPE
		do
			sp ?= class_type
			if sp /= Void then
				name := sp.il_type_name
				element_name := sp.il_element_type_name
				il_generator.generate_array_class_mappings (name, element_name,
																		  class_type.static_type_id)
			else
				name := class_type.type.il_type_name
				il_generator.generate_class_mappings (name, class_type.static_type_id,
																  class_type.associated_class.lace_class.base_name)
			end

		end

	generate_class_custom_attribute (class_type: CLASS_TYPE) is
			-- Generate class custom attribute of `class_type' if any.
		require
			class_type_not_void: class_type /= Void
		deferred
		end

	generate_il_class_description (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate class description of `class_type'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		deferred
		end

	generate_il_features_description (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate features description of `class_type'.
		require
			class_c_not_void: class_c /= Void
			class_type_not_void: class_type /= Void
		do
			current_class_type := class_type
			is_class_external := class_c.is_external

						-- Generate features
			generate_features (class_c)
		end

feature {NONE} -- Ancestors

	generate_ancestors (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate ancestors map of `class_c'.
		require
			class_c_not_void: class_c /= Void
		local
			parents: FIXED_LIST [CL_TYPE_A]
			parent_type: CL_TYPE_I
		do
			parents := class_c.parents
			if not parents.is_empty then
				from
					context.set_class_type (class_type)
					il_generator.start_parents_list
					parents.start
				until
					parents.after
				loop
					parent_type ?= context.real_type (parents.item.type_i)
					il_generator.add_to_parents_list (parent_type.associated_class_type.static_type_id)
					parents.forth
				end
				il_generator.end_parents_list
			end
		end

feature {NONE} -- Feature generation

	generate_features (class_c: CLASS_C) is
			-- Generate features written in `class_c'.
		require
			class_c_not_void: class_c /= Void
		local
			feat_tbl: FEATURE_TABLE
			feat: FEATURE_I
			in_current_class: BOOLEAN
			written_static_type_id: INTEGER
		do
			from
				feat_tbl := class_c.feature_table
				feat_tbl.start
				il_generator.start_features_list (current_type_id)
			until
				feat_tbl.after
			loop
				feat := feat_tbl.item_for_iteration
				in_current_class := feat.written_in = class_c.class_id
				written_static_type_id := written_type_id (class_c, feat)
				generate_feature (feat, in_current_class, written_static_type_id)
				feat_tbl.forth
			end
			if class_c.has_invariant then
				feat := class_c.invariant_feature
				in_current_class := feat.written_in = class_c.class_id
				written_static_type_id := written_type_id (class_c, feat)
				generate_feature (feat, in_current_class, written_static_type_id)
			end

--			generate_creation_routines (class_c)
				
			il_generator.end_features_list
		end

	generate_feature (feat: FEATURE_I; in_current_class: BOOLEAN; type_id: INTEGER) is
			-- Generate `feat' description.
		require
			feat_not_void: feat /= Void
			positive_type_id: type_id > 0
		deferred
		end

	generate_creation_routines (class_c: CLASS_C) is
			-- Generate description for creation routines of `class_c' if any.
		require
			class_c_not_void: class_c /= Void
		local
			a: ARRAY [INTEGER]
			creators: EXTEND_TABLE [EXPORT_I, STRING]
			feat_tbl: FEATURE_TABLE
			i: INTEGER
		do
			if not class_c.is_external then
				creators := class_c.creators	
				if creators /= Void and then not creators.is_empty then
					from
						create a.make (0, class_c.creators.count - 1)
						creators.start
						feat_tbl := class_c.feature_table
					until
						creators.after
					loop
						a.put (feat_tbl.item (creators.key_for_iteration).feature_id, i)
						creators.forth
						i := i + 1
					end
					il_generator.mark_creation_routines (a)
				end
			end
		end

	generate_arguments (feat: FEATURE_I) is
			-- Generate arguments' description of `feat'.
		require
			feat_not_void: feat /= Void
		local
			feat_arg: FEAT_ARG
			type_i: TYPE_I
			gen_type_i: GEN_TYPE_I
			i: INTEGER
		do
			if feat.has_arguments then
				feat_arg := feat.arguments
				from
					il_generator.start_arguments_list (feat_arg.count)
					feat_arg.start
					i := 1
				until
					feat_arg.after
				loop
					type_i := feat_arg.item.actual_type.type_i
					check
						type_i_not_void: type_i /= Void
					end
					if not type_i.has_formal then
						if not type_i.is_none then
							il_generator.generate_feature_argument (feat_arg.item_name (i), type_i)
						else
							check
								False
							end
						end
					else
						gen_type_i ?= current_class_type.type
						type_i := type_i.instantiation_in (gen_type_i)
						il_generator.generate_feature_argument (feat_arg.item_name (i), type_i)
					end
					feat_arg.forth
					i := i + 1
				end

				il_generator.end_arguments_list
			end
		end

	generate_return_type (feat: FEATURE_I) is
			-- Generate return type of `feat' if any.
		require
			feat_not_void: feat /= Void
		local
			type_i: TYPE_I
			gen_type_i: GEN_TYPE_I
		do
			if
				feat.is_function or
				feat.is_attribute or feat.is_constant
			then
					-- Current feature is a function
				type_i := feat.type.actual_type.type_i
				check
					type_i_not_void: type_i /= Void
				end
				if not type_i.has_formal then
					if not type_i.is_none then
						il_generator.generate_feature_return_type (type_i)
					else
						check
							False
						end
					end
				else
					gen_type_i ?= current_class_type.type
					type_i := type_i.instantiation_in (gen_type_i)
					il_generator.generate_feature_return_type (type_i)
				end
			end
		end

feature {NONE} -- Implementation

	written_type_id (class_c: CLASS_C; feat: FEATURE_I): INTEGER is
			-- Return static_type_id of class that defined `feat'.
		require
			class_c_not_void: class_c /= Void
			feat_not_void: feat /= Void
		local
			written_in: INTEGER
			cl_type_a: CL_TYPE_A
			written_class: CLASS_C
		do
			written_in := feat.written_in
				-- If `feat' is defined in current class, that's easy and we
				-- return `current_type_id'. Otherwise we have to find the
				-- correct CLASS_TYPE object where `feat' is written.
			if class_c.class_id = written_in then
				Result := current_type_id
			else
				written_class := System.class_of_id (written_in) 
					-- We go through the hierarchy only when `written_class'
					-- is generic, otherwise for the most general case where
					-- `written_class' is not generic it will take a long
					-- time to go through the inheritance hierarchy.
				if written_class.types.count > 1 then
					cl_type_a := current_class_type.type.type_a
					Result := cl_type_a.find_class_type (written_class)
						.type_i.associated_class_type.static_type_id
				else
					Result := written_class.types.first.static_type_id
				end
			end
		end

	current_class_type: CLASS_TYPE
			-- Current class type being analyzed.

	current_type_id: INTEGER is
			-- Static type_id of class being analyzed.
		require
			current_class_type_set: current_class_type /= Void
		do
			Result := current_class_type.static_type_id
		end

	is_class_external: BOOLEAN
			-- Is current class an external one?

	void_name: STRING is "void"
			-- Name of `Void' attribute of class ANY.

end -- class IL_META_DATA_GENERATOR


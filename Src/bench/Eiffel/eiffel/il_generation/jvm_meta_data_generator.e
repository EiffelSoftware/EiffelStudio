indexing
	description: "Generates JVM metadata for a particular type"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JVM_META_DATA_GENERATOR

inherit
	IL_META_DATA_GENERATOR
	
create
	make

feature -- Initialization

	make is
		do
		end

feature -- Generation

	generate_il_class_description (class_c: CLASS_C; class_type: CLASS_TYPE) is
			-- Generate class description of `class_type'.
		do
			current_class_type := class_type
			is_class_external := class_c.is_external

						-- Generate class nature description
			il_generator.generate_class_header (class_c.is_fully_deferred,
															class_c.is_deferred, class_c.is_expanded, is_class_external, class_type.static_type_id)

			generate_ancestors (class_c, class_type)
		end

feature {NONE} -- Not applicable

	generate_class_custom_attribute (class_type: CLASS_TYPE) is
			-- Generate class custom attribute of `class_type' if any.
			--| Not applicable in Java generation.
		do
		end

feature {NONE} -- Feature generation

	generate_feature (feat: FEATURE_I; in_current_class: BOOLEAN; type_id:INTEGER) is
			-- Generate `feat' description.
		local
			is_deferred: BOOLEAN
			is_redefined: BOOLEAN
			is_frozen: BOOLEAN
			need_generation: BOOLEAN
			ext: EXTERNAL_I
			def: DEF_PROC_I
			attr: ATTRIBUTE_I
			il_ext: IL_EXTENSION_I
			inv_feat: INVARIANT_FEAT_I
		do
			need_generation := True

			attr ?= feat
			if attr /= Void then
				need_generation := not attr.feature_name.is_equal (void_name)
			end

			if need_generation then
				if feat.has_arguments then
					il_generator.start_feature_description (feat.arguments.count)
				else
					il_generator.start_feature_description (0)
				end
				is_deferred := feat.is_deferred
				is_redefined := not feat.is_origin
				is_frozen := feat.is_frozen

				if not is_class_external then
					if in_current_class then
						il_generator.generate_feature_nature (is_redefined, is_deferred, is_frozen, feat.is_attribute)
						il_generator.generate_feature_identification (feat.feature_name,
							feat.feature_id, feat.rout_id_set, in_current_class, type_id)
						generate_arguments (feat)
						generate_return_type (feat)

						inv_feat ?= feat
						if inv_feat /= Void then
							il_generator.mark_invariant (feat.feature_id)
						end
						il_generator.create_feature_description
						il_generator.check_renaming_and_redefinition
					else
						def ?= feat
						if def /= Void and then System.class_of_id (feat.written_in).is_external then
							il_generator.generate_deferred_external_identification (feat.feature_name,
								feat.feature_id, feat.rout_id_set.first, type_id)
						else
							il_generator.generate_feature_identification (feat.feature_name,
								feat.feature_id, feat.rout_id_set, in_current_class, type_id)
						end
						il_generator.check_renaming
					end
				else
					if in_current_class then
						ext ?= feat
						if ext /= Void then
							il_ext ?= ext.extension
							check
								has_alias: il_ext /= Void
							end
							il_generator.generate_external_identification (feat.feature_name,
								ext.alias_name, il_ext.type, feat.feature_id,
								feat.rout_id_set.first, in_current_class, type_id,
								il_ext.argument_types, il_ext.return_type)
						else
							def ?= feat
							if def /= Void then
							   il_generator.generate_deferred_external_identification (
												feat.feature_name,feat.feature_id, 
												feat.rout_id_set.first, type_id)
							
							   generate_arguments (feat)
							   generate_return_type (feat)
							   
							   il_generator.create_feature_description
							else
								-- Special case of manually added function in class of basic types.
								-- Does not need special generation
							end
						end
					else
						def ?= feat
						if def /= Void then
						   il_generator.generate_deferred_external_identification (feat.feature_name,
													   feat.feature_id, 
													   feat.rout_id_set.first,
													   type_id)
							
						   generate_arguments (feat)
						   generate_return_type (feat)
						   il_generator.create_feature_description
						else
							ext ?= feat
							check
								ext_not_void: ext /= Void
							end
							il_ext ?= ext.extension
							check
								has_alias: il_ext /= Void
							end
							il_generator.generate_external_identification (feat.feature_name,
								ext.alias_name, il_ext.type, feat.feature_id,
								feat.rout_id_set.first, in_current_class, type_id,
								il_ext.argument_types, il_ext.return_type)
						end
					end
				end
			end
		end


end -- class JVM_META_DATA_GENERATOR


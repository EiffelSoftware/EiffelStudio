indexing
	description: "Description of a feature"
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_DESCRIPTOR

inherit
	IEIFFEL_FEATURE_DESCRIPTOR_IMPL_STUB
		redefine
			name,
			written_class,
			evaluated_class,
			description,
			signature,
			all_callers,
			all_callers_count,
			local_callers,
			local_callers_count,
			descendant_callers,
			descendant_callers_count,
			implementers,
			implementer_count,
			ancestor_versions,
			ancestor_version_count,
			descendant_versions,
			descendant_version_count,
			exported_to,
			is_once,
			is_external,
			is_deferred,
			is_frozen,
			is_infix,
			is_prefix,
			is_attribute,
			is_procedure,
			is_function,
			is_unique,
			is_constant,
			is_obsolete,
			has_precondition,
			has_postcondition,
			feature_location
		end

	SHARED_EIFFEL_PROJECT
		export {NONE}
			all
		end

create
	make_with_class_i_and_feature_i

feature {NONE} -- Initialization

	make_with_class_i_and_feature_i (a_class: CLASS_I; a_feature: FEATURE_I) is
			-- Initialize structure with `a_feature' evaluated in `a_class'.
		require
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
		do
			create_item
			compiler_feature := a_feature
			compiler_class := a_class
		end

feature -- Access

	name: STRING is
			-- Feature name.
		do
			Result := compiler_feature.feature_name
		ensure then
			result_exists: Result /= void
		end

	written_class: STRING is
			-- Name of the class where the feature is written in.
		do
			Result := compiler_feature.e_feature.associated_class.lace_class.name
		ensure then
			result_exists: Result /= void			
		end

	evaluated_class: STRING is
			-- Name of the class where the feature was evaluated in.
		do
			Result := compiler_class.name
		ensure then
			result_exists: Result /= void			
		end

	description: STRING is
			-- Feature description.
			--| FIXME For the moment, only returns the external name.
		do
			Result := compiler_feature.external_name
		ensure then
			result_exists: Result /= void			
		end

	signature: STRING is
			-- Feature signature.
		do
			Result := compiler_feature.api_feature (compiler_class.compiled_class.class_id).feature_signature
		ensure then
			result_exists: Result /= void			
		end

	all_callers: ECOM_VARIANT is
			-- List of all feature callers, including callers of ancestor and descendant versions.
		local
			res: ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
		do
			res := all_callers_internal
			create ecom_res.make_from_array (res, 1, <<1>>, <<res.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
		ensure then
			result_exists: Result /= Void
		end

	all_callers_count: INTEGER is
			-- Number of all callers.
		do
			Result := all_callers_internal.count
		end
		
	local_callers: ECOM_VARIANT is
			-- List of feature callers.
		local
			res: ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
		do
			res := local_callers_internal
			create ecom_res.make_from_array (res, 1, <<1>>, <<res.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
		ensure then
			result_exists: Result /= Void
		end
		
	local_callers_count: INTEGER is
			-- Number of local callers.
		do
			Result := local_callers_internal.count
		end
		
	descendant_callers: ECOM_VARIANT is
			-- List of feature callers, including callers of descendant versions.
		local
			res: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
		do
			res := descendant_callers_internal
			create ecom_res.make_from_array (res, 1, <<1>>, <<res.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
		ensure then
			result_exists: Result /= Void
		end

	descendant_callers_count: INTEGER is
			-- Number of descendant callers.
		do
			Result := descendant_callers_internal.count
		end
		
	implementers: ECOM_VARIANT is
			-- List of implementers.
		local
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]
			rout_id_set: ROUT_ID_SET
			rout_id: INTEGER
			current_feature: E_FEATURE
			current_class, written_cl, c: CLASS_C
			precursors: LIST [CLASS_C]
			rc, i, nb: INTEGER
			res: ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			desc: FEATURE_DESCRIPTOR
			feat: FEATURE_I
		do
			current_class := compiler_class.compiled_class
			current_feature := compiler_feature.api_feature (current_class.class_id)
			written_cl := current_feature.written_class
			precursors := current_feature.precursors
			create classes.make
			record_descendants (classes, current_class)
			if not classes.has (current_class) then
				classes.extend (current_class)
			end
			if precursors /= Void then
				classes.append (precursors)
			end
			rout_id_set := current_feature.rout_id_set
			rc := rout_id_set.count
			create res.make (1, classes.count * rc)
			from
				i := 1
				nb := 1
			until
				i > rc
			loop
				rout_id := rout_id_set.item (i)
				from
					classes.start
				until
					classes.after
				loop
					c := classes.item
					feat := c.feature_table.origin_table.item (rout_id)
					if feat /= Void then
						create {FEATURE_DESCRIPTOR} desc.make_with_class_i_and_feature_i (c.lace_class, feat)
						res.put (desc, nb)
						nb := nb + 1
					end
					classes.forth
				end
				i := i + 1
			end
			res.resize (1, nb)
			create ecom_res.make_from_array (res, 1, <<1>>, <<res.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
		ensure then
			result_exists: Result /= void			
		end

	implementer_count: INTEGER is
			-- Number of feature implementers.
		do
			Result := implementers.unknown_interface_array.count
		end

	ancestor_versions: ECOM_VARIANT is
			-- List of ancestor versions.
		local
			res: ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
		do
			res := ancestor_versions_internal
			create ecom_res.make_from_array (res, 1, <<1>>, <<res.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
		ensure then
			result_exists: Result /= void	
		end

	ancestor_version_count: INTEGER is
			-- Number of ancestor versions.
		do
			Result := ancestor_versions_internal.count
		end
		
	descendant_versions: ECOM_VARIANT is
			-- List of descendant versions.
		local
			res: ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
		do
			res := descendant_versions_internal
			create ecom_res.make_from_array (res, 1, <<1>>, <<res.count>>)
			create Result.make
			Result.set_unknown_array (ecom_res)
		end

	descendant_version_count: INTEGER is
			-- Number of descendant versions.
		do
			Result := descendant_versions_internal.count
		end
		
	exported_to: ECOM_ARRAY [STRING] is
			-- List of classes, to which feature is exported.
		local
			res: ARRAY [STRING]
			classes: ARRAY [CLASS_C]
			i, nb_classes: INTEGER
		do
			classes := Eiffel_system.Workbench.system.classes.sorted_classes
			create res.make (1, Eiffel_system.Workbench.system.classes.count)
			from
				i := 1
				nb_classes := 1
			until
				i > res.count
			loop
				if compiler_feature.is_exported_for (classes.item (i)) then
					res.put (classes.item (i).name, nb_classes)
					nb_classes := nb_classes + 1
				end
				i := i + 1
			end
			res.resize (1, nb_classes - 1)
			create Result.make_from_array (res, 1, <<1>>, <<res.count>>)
		ensure then
			result_exists: Result /= Void
		end

	is_once: BOOLEAN is
			-- Is once feature?
		do
			Result := compiler_feature.is_once
		end

	is_external: BOOLEAN is
			-- Is external feature?
		do
			Result := compiler_feature.is_external
		end

	is_deferred: BOOLEAN is
			-- Is deferred feature?
		do
			Result := compiler_feature.is_deferred
		end

	is_constant: BOOLEAN is
			-- Is constant?
		do
			Result := compiler_feature.is_constant
		end

	is_frozen: BOOLEAN is
			-- is frozen feature?
		do
			Result := compiler_feature.is_frozen
		end

	is_infix: BOOLEAN is
			-- Is infix?
		do
			Result := compiler_feature.is_infix
		end

	is_prefix: BOOLEAN is
			-- Is prefix?
		do
			Result := compiler_feature.is_prefix
		end

	is_attribute: BOOLEAN is
			-- Is attribute?
		do
			Result := compiler_feature.is_attribute
		end

	is_procedure: BOOLEAN is
			-- Is procedure?
		do
			Result := compiler_feature.is_procedure and not compiler_feature.is_function
		end

	is_function: BOOLEAN is
			-- Is function?
		do
			Result := compiler_feature.is_function
		end

	is_unique: BOOLEAN is
			-- Is unique?
		do
			Result := compiler_feature.is_unique
		end

	is_obsolete: BOOLEAN is
			-- Is obsolete feature?
		do
			Result := compiler_feature.is_obsolete
		end

	has_precondition: BOOLEAN is
			-- Does feature have precondition?
		do
			Result := compiler_feature.has_precondition
		end

	has_postcondition: BOOLEAN is
			-- Does feature have postcondition?
		do
			Result := compiler_feature.has_postcondition
		end

feature -- Basic Operations

	feature_location (file_path: CELL [STRING]; line_number: INTEGER_REF) is
			-- Feature location, full path to file and line number
			-- `file_path' [in, out].  
			-- `line_number' [in, out].
		local
			start_position: INTEGER
			txt: STRING
		do
			if file_path /= Void and line_number /= Void then
				file_path.replace (compiler_feature.e_feature.written_class.file_name)
				start_position := compiler_feature.e_feature.ast.start_position
				txt := compiler_feature.written_class.lace_class.text.substring (1, start_position)
				line_number.set_item (txt.occurrences ('%N') + 1)
			end
		end

feature {FEATURE_DESCRIPTOR} -- Implementation
		
	local_callers_internal: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] is
			-- Callers of `compiler_feature'.
		local
			client, current_class: CLASS_C
			clients: LINKED_LIST [CLASS_C]
			list: SORTED_LIST [STRING]
			feat: FEATURE_I
			feat_desc: FEATURE_DESCRIPTOR
			i: INTEGER
		do
			create Result.make (Initial_array_size)
			current_class := compiler_class.compiled_class
			clients := current_class.clients
			from
				clients.start
				Result.start
			until
				clients.after
			loop
				client := clients.item
				list := compiler_feature.api_feature (current_class.class_id).callers (client)
				if list /= Void then
					from
						list.start
					until
						list.after
					loop
						feat := client.feature_table.item (list.item)
						check
							feature_found: feat /= Void
						end
						create feat_desc.make_with_class_i_and_feature_i (client.lace_class, feat)
						Result.extend (feat_desc)
						i := i + 1
						list.forth
					end
				end
				clients.forth
			end
		ensure
			result_exists: Result /= Void
		end

feature {NONE} -- Implementation

	compiler_feature: FEATURE_I
			-- Associated compiler structure.
			
	compiler_class: CLASS_I
			-- Compiler structure ot the class `compiler_feature' was evaluated in.

	record_descendants (classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]; e_class: CLASS_C) is
			-- Record the descendants of `class_c' to `classes'.
		require
			valid_classes: classes /= Void
			valid_e_class: e_class /= Void
		local
			descendants: LINKED_LIST [CLASS_C]
			desc_c: CLASS_C
		do
			descendants := e_class.descendants
			classes.extend (e_class)
			from
				descendants.start
			until
				descendants.after
			loop
				desc_c := descendants.item
				if not classes.has (desc_c) then
					record_descendants (classes, desc_c)
				end
				descendants.forth
			end
		end

	record_parents (classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]; e_class: CLASS_C) is
			-- Record parents of `class_c' to `classes'.	
		local
			parents: FIXED_LIST [CL_TYPE_A]
			e_parent: CLASS_C
		do
			parents := e_class.parents
			classes.extend (e_class)
			from
				parents.start
			until
				parents.after
			loop
				e_parent := parents.item.associated_class
				if not classes.has (e_parent) then
					record_parents (classes, e_parent)
				end
				parents.forth
			end
		end

	descendant_callers_internal: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] is
			-- Callers of `compiler_feature' and of its descendant versions.
		local
			desc_vers: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			feat_desc: FEATURE_DESCRIPTOR
		do
			desc_vers := descendant_versions_internal
			Result := local_callers_internal
			from
				desc_vers.start
			until
				desc_vers.after
			loop
				feat_desc ?= desc_vers.item
				Result.finish
				Result.merge_right (feat_desc.local_callers_internal)
				desc_vers.forth
			end
		ensure
			result_exists: Result /= Void
		end
		
	all_callers_internal: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] is
			-- Callers of `compiler_feature' and of its descendant and ancestor versions.
		local
			vers: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE]
			feat_desc: FEATURE_DESCRIPTOR
		do
			vers := ancestor_versions_internal
			vers.finish
			vers.merge_right (descendant_versions_internal)
			Result := local_callers_internal
			from
				vers.start
			until
				vers.after
			loop
				feat_desc ?= vers.item
				Result.finish
				Result.merge_right (feat_desc.local_callers_internal)
				vers.forth
			end
		ensure
			result_exists: Result /= Void
		end
				
	ancestor_versions_internal: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] is
			-- Ancestor versions of `compiler_feature'.
		local
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]
			rout_id_set: ROUT_ID_SET
			rout_id, i: INTEGER
			current_feature: E_FEATURE
			other_feature: FEATURE_I
			c, current_class: CLASS_C
			desc: IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE
		do
			current_class := compiler_class.compiled_class
			current_feature := compiler_feature.api_feature (current_class.class_id)
			create classes.make
			record_parents (classes, current_class)
			classes.prune_all (current_class)

			rout_id_set := current_feature.rout_id_set
			create Result.make (0)
			from
				i := 1
			until
				i > rout_id_set.count
			loop
				rout_id := rout_id_set.item (i)
				from
					classes.start
				until
					classes.after
				loop
					c := classes.item
					other_feature := c.feature_table.origin_table.item (rout_id)
					if other_feature /= Void then
						create {FEATURE_DESCRIPTOR} desc.make_with_class_i_and_feature_i (c.lace_class, other_feature)
						Result.extend (desc)
					end
					classes.forth
				end
				i := i + 1
			end
		ensure
			result_exists: Result /= Void
		end

	descendant_versions_internal: ARRAYED_LIST [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] is
			-- Descendant versions of `compiler_feature'.
		local
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_C]
			rout_id_set: ROUT_ID_SET
			rout_id, i: INTEGER
			other_feature: FEATURE_I
			e_class, current_class: CLASS_C
			current_feature: E_FEATURE
			desc: IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE
		do
			current_class := compiler_class.compiled_class
			current_feature := compiler_feature.api_feature (current_class.class_id)
			create classes.make
			record_descendants (classes, current_class)
			classes.prune_all (current_class)

			rout_id_set := current_feature.rout_id_set
			create Result.make (0)
			from
				i := 1
			until
				i > rout_id_set.count
			loop
				rout_id := rout_id_set.item (i)
				from
					classes.start
				until
					classes.after
				loop
					e_class := classes.item
					other_feature := e_class.feature_table.origin_table.item (rout_id)
					if other_feature /= Void then
						create {FEATURE_DESCRIPTOR} desc.make_with_class_i_and_feature_i (e_class.lace_class, other_feature)
						Result.extend (desc)
					end
					classes.forth
				end
				i := i + 1
			end
		ensure
			result_exists: Result /= Void
		end
		
	Initial_array_size: INTEGER is 0
			
end -- class FEATURE_DESCRIPTOR

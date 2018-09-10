note
	description: "Manages lists of translated and untranslated features and types."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_TRANSLATION_POOL

inherit

	E2B_SHARED_CONTEXT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize empty pool.
		do
			create untranslated_elements.make (100)
			create translated_elements.make (100)
			create ids.make (100)
		end

feature -- Access

	untranslated_elements: attached ARRAYED_LIST [attached E2B_TRANSLATION_UNIT]
			-- List of untranslated units.

	translated_elements: attached ARRAYED_LIST [attached E2B_TRANSLATION_UNIT]
			-- List of translated units.

	next_untranslated_element: E2B_TRANSLATION_UNIT
			-- Next untranslated element.
		require
			has_untranslated_elements: has_untranslated_elements
		do
			Result := untranslated_elements.first
		ensure
			result_attached: attached Result
		end

feature -- Status report

	has_untranslated_elements: BOOLEAN
			-- Do some untranslated elements exist?
		do
			Result := not untranslated_elements.is_empty
		end

feature -- Element change

	mark_translated (a_unit: E2B_TRANSLATION_UNIT)
			-- Mark `a_unit' as translated.
		local
			l_found: BOOLEAN
		do
			from
				untranslated_elements.start
			until
				untranslated_elements.after or l_found
			loop
				if untranslated_elements.item.id ~ a_unit.id then
					l_found := True
					translated_elements.extend (untranslated_elements.item)
					untranslated_elements.remove
				else
					untranslated_elements.forth
				end
			end
			check l_found end
		end

	reset
			-- Reset translation pool.
		do
			untranslated_elements.wipe_out
			translated_elements.wipe_out
			ids.wipe_out
		end

feature -- Adding independent units

	add_type (a_type: CL_TYPE_A)
			-- Add type `a_type'.
		require
			not_like_type: not a_type.is_like
			no_formals: not a_type.has_formal_generic
		do
			if not a_type.is_basic and not helper.is_class_any (a_type.base_class) and not helper.is_agent_type (a_type) then
				add_translation_unit (create {E2B_TU_TYPE}.make (a_type))
				add_translation_unit (create {E2B_TU_INVARIANT}.make (a_type))
			end
		end

	add_parent_type (a_type: CL_TYPE_A)
			-- Add type `a_type' that is only mentioned as a parent of a used type.
		require
			no_formals: not a_type.has_formal_generic
		do
			if not a_type.is_basic and not helper.is_class_any (a_type.base_class) then
				add_translation_unit (create {E2B_TU_TYPE}.make (a_type))
			end
		end

	add_feature (a_feature: FEATURE_I; a_context_type: CL_TYPE_A)
			-- Add signature and implementation of feature `a_feature' of `a_context_type'.
		require
			no_formals: not a_context_type.has_formal_generic
		do
			-- The enclosing type has to be tranlated before the feature,
			-- becuase some ownership defaults depend on analysing the invariant
			add_type (a_context_type)
			internal_add_feature (a_feature, a_context_type, False)
		end

	add_referenced_feature (a_feature: FEATURE_I; a_context_type: CL_TYPE_A)
			-- Add feature `a_feature' in of `a_context_type' as referenced feature.
		require
			no_formals: not a_context_type.has_formal_generic
		do
			internal_add_feature (a_feature, a_context_type, True)
		end

	add_write_frame_function (a_feature: FEATURE_I; a_context_type: CL_TYPE_A)
			-- Add write frame function of feature `a_feature' of `a_context_type'.
		require
			no_formals: not a_context_type.has_formal_generic
		do
			add_translation_unit (create {E2B_TU_WRITE_FRAME}.make (a_feature, a_context_type))
		end

	add_read_frame_function (a_feature: FEATURE_I; a_context_type: CL_TYPE_A)
			-- Add read frame function of feature `a_feature' of `a_context_type'.
		require
			no_formals: not a_context_type.has_formal_generic
		do
			add_translation_unit (create {E2B_TU_READ_FRAME}.make (a_feature, a_context_type))
		end

	add_function_precondition_predicate (a_feature: FEATURE_I; a_context_type: CL_TYPE_A)
			-- Add precondition predicate of feature `a_feature' of `a_context_type'.
		require
			no_formals: not a_context_type.has_formal_generic
		local
			l_pre_predicate: E2B_TU_FUNCTION_PRE_PREDICATE
		do
			create l_pre_predicate.make (a_feature, a_context_type)
			add_translation_unit (l_pre_predicate)
		end

	add_filtered_invariant_function (a_type: CL_TYPE_A; a_included, a_excluded: LIST [STRING]; a_ancestor: CLASS_C)
			-- Add invariant function of type `a_type'.
		require
			no_formals: not a_type.has_formal_generic
		do
			add_translation_unit (create {E2B_TU_INVARIANT}.make_filtered (a_type, a_included, a_excluded, a_ancestor))
		end

	add_postcondition_predicate (a_feature: FEATURE_I; a_context_type: CL_TYPE_A)
			-- Add postcondition predicate of feature `a_feature' of `a_context_type'.
		require
			no_formals: not a_context_type.has_formal_generic
		local
			l_post_predicate: E2B_TU_ROUTINE_POST_PREDICATE
		do
			create l_post_predicate.make (a_feature, a_context_type)
			add_translation_unit (l_post_predicate)
		end

	add_class_check (a_class_type: CL_TYPE_A)
			-- Add validity check for `a_class_type'.
		require
			no_formals: not a_class_type.has_formal_generic
		local
			l_class: E2B_TU_CLASS
		do
			if not helper.is_skipped_class (a_class_type.base_class) then
				create l_class.make (a_class_type)
				add_type (a_class_type)
				add_translation_unit (l_class)
			end
		end

feature {NONE} -- Implementation

	ids: HASH_TABLE [BOOLEAN, STRING]
			-- Hash map to store translation unit ids.

	add_translation_unit (a_unit: E2B_TRANSLATION_UNIT)
			-- Add translation unit `a_unit'.
		require
			a_unit_attached: attached a_unit
		do
			if not ids.has (a_unit.id) then
				untranslated_elements.extend (a_unit)
				ids.put (True, a_unit.id.twin)
			end
		ensure
			ids.has (a_unit.id)
		end

	internal_add_feature (a_feature: FEATURE_I; a_context_type: CL_TYPE_A; a_is_referenced: BOOLEAN)
			-- Add signature and implementation of feature `a_feature' of `a_context_type'.
			-- If `a_referenced' is true, then only the signature will be created.
		do
			if a_feature.is_attribute or helper.is_built_in_attribute (a_feature) then
				add_attribute (a_feature, a_context_type)
			elseif a_feature.is_routine then
				if helper.is_feature_logical (a_feature) then
					add_logical (a_feature, a_context_type)
				else
					if helper.is_creator_of_class (a_feature, a_context_type.base_class) then
							-- This is a creation routine
						add_creator (a_feature, a_context_type, a_is_referenced)
					end
					if not helper.is_creator (a_feature) then
							-- Unless the feature is marked as creator, it can be used as a normal routine;
							-- Note that a non-creation procedure can be marked as creator
							-- (e.g. if it's supposed to be used as a creation procedure in descendants),
							-- in this case it will not be verified at all in the current context type.
						add_routine (a_feature, a_context_type, a_is_referenced)
					end
				end
			elseif a_feature.is_constant then
					-- Ignore constants / nothing to verify
			else
				check internal_error: False end
			end
		end

	add_routine (a_feature: FEATURE_I; a_context_type: CL_TYPE_A; a_is_referenced: BOOLEAN)
			-- Add signature,
			--     variant functions,
			--     functional representation (if returns a value)
			--     and implementation (unless just `a_is_referenced') of `a_feature' of `a_context_type'.
		local
			l_signature: E2B_TU_ROUTINE_SIGNATURE
			l_variants: E2B_TU_VARIANTS
			l_functional_representation: E2B_TU_ROUTINE_FUNCTIONAL
			l_implementation: E2B_TU_ROUTINE_IMPLEMENTATION
		do
				-- Add signature
			create l_signature.make (a_feature, a_context_type)
			add_translation_unit (l_signature)

				-- Add functional representation
			if helper.has_functional_representation (a_feature) then
				create l_functional_representation.make (a_feature, a_context_type)
				add_translation_unit (l_functional_representation)
			end

			if not a_is_referenced and not a_feature.is_deferred and not helper.is_skipped (a_feature) then
					-- Add variant functions
					-- (has to be processed before the implementation)
				if options.is_ownership_enabled then
					create l_variants.make (a_feature, a_context_type)
					add_translation_unit (l_variants)
				end

					-- Add implementation				
				create l_implementation.make (a_feature, a_context_type)
				add_translation_unit (l_implementation)
			end
		end

	add_attribute (a_feature: FEATURE_I; a_context_type: CL_TYPE_A)
			-- Add attribute `a_feature' of `a_context_type'.
		local
			l_attribute: E2B_TU_ATTRIBUTE
		do
			create l_attribute.make (a_feature, a_context_type)
			add_translation_unit (l_attribute)
		end

	add_creator (a_feature: FEATURE_I; a_context_type: CL_TYPE_A; a_is_referenced: BOOLEAN)
			-- Add signature and implementation of creator `a_feature' of `a_context_type'.
		local
			l_creator: E2B_TU_CREATOR_SIGNATURE
			l_creator_impl: E2B_TU_CREATOR_IMPLEMENTATION
		do
			create l_creator.make (a_feature, a_context_type)
			add_translation_unit (l_creator)
			if a_is_referenced or helper.is_skipped (a_feature) or (helper.is_explicit (a_feature, "contracts") and not helper.is_creator (a_feature)) then
				-- Skip if: only referenced, should be skipped or
				-- contracts are explicit (unless creator), becuase in that case the non-creator version has a stronger spec and the same implementation
			else
				create l_creator_impl.make (a_feature, a_context_type)
				add_translation_unit (l_creator_impl)
			end
		end

	add_logical (a_feature: FEATURE_I; a_context_type: CL_TYPE_A)
			-- Add logical feature `a_feature' of `a_context_type'.
		local
			l_logical: E2B_TU_LOGICAL_SIGNATURE
		do
			create l_logical.make (a_feature, a_context_type)
			add_translation_unit (l_logical)
		end

end

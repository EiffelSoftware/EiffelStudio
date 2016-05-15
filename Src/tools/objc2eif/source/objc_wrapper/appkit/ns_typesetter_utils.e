note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TYPESETTER_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSTypesetter

--	printing_adjustment_in_layout_manager__for_nominally_spaced_glyph_range__packed_glyphs__count_ (a_layout_mgr: detachable NS_LAYOUT_MANAGER; a_nominally_spaced_glyphs_range: NS_RANGE; a_packed_glyphs: UNSUPPORTED_TYPE; a_packed_glyphs_count: NATURAL_64): NS_SIZE
--			-- Auto generated Objective-C wrapper.
--		local
--			l_objc_class: OBJC_CLASS
--			a_layout_mgr__item: POINTER
--		do
--			if attached a_layout_mgr as a_layout_mgr_attached then
--				a_layout_mgr__item := a_layout_mgr_attached.item
--			end
--			create l_objc_class.make_with_name (get_class_name)
--			check l_objc_class_registered: l_objc_class.registered end
--			create Result.make
--			objc_printing_adjustment_in_layout_manager__for_nominally_spaced_glyph_range__packed_glyphs__count_ (l_objc_class.item, Result.item, a_layout_mgr__item, a_nominally_spaced_glyphs_range.item, , a_packed_glyphs_count)
--		end

	shared_system_typesetter: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_shared_system_typesetter (l_objc_class.item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shared_system_typesetter} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shared_system_typesetter} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	shared_system_typesetter_for_behavior_ (a_the_behavior: INTEGER_64): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			result_pointer := objc_shared_system_typesetter_for_behavior_ (l_objc_class.item, a_the_behavior)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like shared_system_typesetter_for_behavior_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like shared_system_typesetter_for_behavior_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	default_typesetter_behavior: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
		do
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_default_typesetter_behavior (l_objc_class.item)
		end

feature {NONE} -- NSTypesetter Externals

	objc_printing_adjustment_in_layout_manager__for_nominally_spaced_glyph_range__packed_glyphs__count_ (a_class_object: POINTER; result_pointer: POINTER; a_layout_mgr: POINTER; a_nominally_spaced_glyphs_range: POINTER; a_packed_glyphs: POINTER; a_packed_glyphs_count: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(Class)$a_class_object printingAdjustmentInLayoutManager:$a_layout_mgr forNominallySpacedGlyphRange:*((NSRange *)$a_nominally_spaced_glyphs_range) packedGlyphs:$a_packed_glyphs count:$a_packed_glyphs_count];
			 ]"
		end

	objc_shared_system_typesetter (a_class_object: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object sharedSystemTypesetter];
			 ]"
		end

	objc_shared_system_typesetter_for_behavior_ (a_class_object: POINTER; a_the_behavior: INTEGER_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(Class)$a_class_object sharedSystemTypesetterForBehavior:$a_the_behavior];
			 ]"
		end

	objc_default_typesetter_behavior (a_class_object: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(Class)$a_class_object defaultTypesetterBehavior];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSTypesetter"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end

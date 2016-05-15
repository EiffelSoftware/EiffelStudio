note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_MANAGER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSFontManager

	is_multiple: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_multiple (item)
		end

	selected_font: detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_selected_font (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like selected_font} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like selected_font} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_selected_font__is_multiple_ (a_font_obj: detachable NS_FONT; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			objc_set_selected_font__is_multiple_ (item, a_font_obj__item, a_flag)
		end

	set_font_menu_ (a_new_menu: detachable NS_MENU)
			-- Auto generated Objective-C wrapper.
		local
			a_new_menu__item: POINTER
		do
			if attached a_new_menu as a_new_menu_attached then
				a_new_menu__item := a_new_menu_attached.item
			end
			objc_set_font_menu_ (item, a_new_menu__item)
		end

	font_menu_ (a_create: BOOLEAN): detachable NS_MENU
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_font_menu_ (item, a_create)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_menu_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_menu_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_panel_ (a_create: BOOLEAN): detachable NS_FONT_PANEL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_font_panel_ (item, a_create)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_panel_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_panel_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_with_family__traits__weight__size_ (a_family: detachable NS_STRING; a_traits: NATURAL_64; a_weight: INTEGER_64; a_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_family__item: POINTER
		do
			if attached a_family as a_family_attached then
				a_family__item := a_family_attached.item
			end
			result_pointer := objc_font_with_family__traits__weight__size_ (item, a_family__item, a_traits, a_weight, a_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_with_family__traits__weight__size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_with_family__traits__weight__size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	traits_of_font_ (a_font_obj: detachable NS_FONT): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			Result := objc_traits_of_font_ (item, a_font_obj__item)
		end

	weight_of_font_ (a_font_obj: detachable NS_FONT): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			Result := objc_weight_of_font_ (item, a_font_obj__item)
		end

	available_fonts: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_available_fonts (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like available_fonts} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like available_fonts} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	available_font_families: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_available_font_families (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like available_font_families} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like available_font_families} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	available_members_of_font_family_ (a_fam: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_fam__item: POINTER
		do
			if attached a_fam as a_fam_attached then
				a_fam__item := a_fam_attached.item
			end
			result_pointer := objc_available_members_of_font_family_ (item, a_fam__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like available_members_of_font_family_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like available_members_of_font_family_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	convert_font_ (a_font_obj: detachable NS_FONT): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			result_pointer := objc_convert_font_ (item, a_font_obj__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like convert_font_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like convert_font_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	convert_font__to_size_ (a_font_obj: detachable NS_FONT; a_size: REAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			result_pointer := objc_convert_font__to_size_ (item, a_font_obj__item, a_size)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like convert_font__to_size_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like convert_font__to_size_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	convert_font__to_face_ (a_font_obj: detachable NS_FONT; a_typeface: detachable NS_STRING): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_font_obj__item: POINTER
			a_typeface__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			if attached a_typeface as a_typeface_attached then
				a_typeface__item := a_typeface_attached.item
			end
			result_pointer := objc_convert_font__to_face_ (item, a_font_obj__item, a_typeface__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like convert_font__to_face_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like convert_font__to_face_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	convert_font__to_family_ (a_font_obj: detachable NS_FONT; a_family: detachable NS_STRING): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_font_obj__item: POINTER
			a_family__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			if attached a_family as a_family_attached then
				a_family__item := a_family_attached.item
			end
			result_pointer := objc_convert_font__to_family_ (item, a_font_obj__item, a_family__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like convert_font__to_family_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like convert_font__to_family_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	convert_font__to_have_trait_ (a_font_obj: detachable NS_FONT; a_trait: NATURAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			result_pointer := objc_convert_font__to_have_trait_ (item, a_font_obj__item, a_trait)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like convert_font__to_have_trait_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like convert_font__to_have_trait_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	convert_font__to_not_have_trait_ (a_font_obj: detachable NS_FONT; a_trait: NATURAL_64): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			result_pointer := objc_convert_font__to_not_have_trait_ (item, a_font_obj__item, a_trait)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like convert_font__to_not_have_trait_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like convert_font__to_not_have_trait_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	convert_weight__of_font_ (a_up_flag: BOOLEAN; a_font_obj: detachable NS_FONT): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_font_obj__item: POINTER
		do
			if attached a_font_obj as a_font_obj_attached then
				a_font_obj__item := a_font_obj_attached.item
			end
			result_pointer := objc_convert_weight__of_font_ (item, a_up_flag, a_font_obj__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like convert_weight__of_font_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like convert_weight__of_font_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	is_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_enabled (item)
		end

	set_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_enabled_ (item, a_flag)
		end

	action: detachable OBJC_SELECTOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_action (item)
			if result_pointer /= default_pointer then
				create {OBJC_SELECTOR} Result.make_with_pointer (result_pointer)
			end
			
		end

	set_action_ (a_selector: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			objc_set_action_ (item, a_selector__item)
		end

	send_action: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_send_action (item)
		end

	set_delegate_ (an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			an_object__item: POINTER
		do
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_set_delegate_ (item, an_object__item)
		end

	delegate: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	localized_name_for_family__face_ (a_family: detachable NS_STRING; a_face_key: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_family__item: POINTER
			a_face_key__item: POINTER
		do
			if attached a_family as a_family_attached then
				a_family__item := a_family_attached.item
			end
			if attached a_face_key as a_face_key_attached then
				a_face_key__item := a_face_key_attached.item
			end
			result_pointer := objc_localized_name_for_family__face_ (item, a_family__item, a_face_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like localized_name_for_family__face_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like localized_name_for_family__face_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_selected_attributes__is_multiple_ (a_attributes: detachable NS_DICTIONARY; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_attributes__item: POINTER
		do
			if attached a_attributes as a_attributes_attached then
				a_attributes__item := a_attributes_attached.item
			end
			objc_set_selected_attributes__is_multiple_ (item, a_attributes__item, a_flag)
		end

	convert_attributes_ (a_attributes: detachable NS_DICTIONARY): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_attributes__item: POINTER
		do
			if attached a_attributes as a_attributes_attached then
				a_attributes__item := a_attributes_attached.item
			end
			result_pointer := objc_convert_attributes_ (item, a_attributes__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like convert_attributes_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like convert_attributes_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	available_font_names_matching_font_descriptor_ (a_descriptor: detachable NS_FONT_DESCRIPTOR): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_descriptor__item: POINTER
		do
			if attached a_descriptor as a_descriptor_attached then
				a_descriptor__item := a_descriptor_attached.item
			end
			result_pointer := objc_available_font_names_matching_font_descriptor_ (item, a_descriptor__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like available_font_names_matching_font_descriptor_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like available_font_names_matching_font_descriptor_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	collection_names: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_collection_names (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like collection_names} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like collection_names} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	font_descriptors_in_collection_ (a_collection_names: detachable NS_STRING): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_collection_names__item: POINTER
		do
			if attached a_collection_names as a_collection_names_attached then
				a_collection_names__item := a_collection_names_attached.item
			end
			result_pointer := objc_font_descriptors_in_collection_ (item, a_collection_names__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like font_descriptors_in_collection_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like font_descriptors_in_collection_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_collection__options_ (a_collection_name: detachable NS_STRING; a_collection_options: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_collection_name__item: POINTER
		do
			if attached a_collection_name as a_collection_name_attached then
				a_collection_name__item := a_collection_name_attached.item
			end
			Result := objc_add_collection__options_ (item, a_collection_name__item, a_collection_options)
		end

	remove_collection_ (a_collection_name: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_collection_name__item: POINTER
		do
			if attached a_collection_name as a_collection_name_attached then
				a_collection_name__item := a_collection_name_attached.item
			end
			Result := objc_remove_collection_ (item, a_collection_name__item)
		end

	add_font_descriptors__to_collection_ (a_descriptors: detachable NS_ARRAY; a_collection_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_descriptors__item: POINTER
			a_collection_name__item: POINTER
		do
			if attached a_descriptors as a_descriptors_attached then
				a_descriptors__item := a_descriptors_attached.item
			end
			if attached a_collection_name as a_collection_name_attached then
				a_collection_name__item := a_collection_name_attached.item
			end
			objc_add_font_descriptors__to_collection_ (item, a_descriptors__item, a_collection_name__item)
		end

	remove_font_descriptor__from_collection_ (a_descriptor: detachable NS_FONT_DESCRIPTOR; a_collection: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_descriptor__item: POINTER
			a_collection__item: POINTER
		do
			if attached a_descriptor as a_descriptor_attached then
				a_descriptor__item := a_descriptor_attached.item
			end
			if attached a_collection as a_collection_attached then
				a_collection__item := a_collection_attached.item
			end
			objc_remove_font_descriptor__from_collection_ (item, a_descriptor__item, a_collection__item)
		end

	current_font_action: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_current_font_action (item)
		end

	convert_font_traits_ (a_traits: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_convert_font_traits_ (item, a_traits)
		end

	set_target_ (a_target: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_target__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			objc_set_target_ (item, a_target__item)
		end

	target: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_target (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like target} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like target} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSFontManager Externals

	objc_is_multiple (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFontManager *)$an_item isMultiple];
			 ]"
		end

	objc_selected_font (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item selectedFont];
			 ]"
		end

	objc_set_selected_font__is_multiple_ (an_item: POINTER; a_font_obj: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item setSelectedFont:$a_font_obj isMultiple:$a_flag];
			 ]"
		end

	objc_set_font_menu_ (an_item: POINTER; a_new_menu: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item setFontMenu:$a_new_menu];
			 ]"
		end

	objc_font_menu_ (an_item: POINTER; a_create: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item fontMenu:$a_create];
			 ]"
		end

	objc_font_panel_ (an_item: POINTER; a_create: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item fontPanel:$a_create];
			 ]"
		end

	objc_font_with_family__traits__weight__size_ (an_item: POINTER; a_family: POINTER; a_traits: NATURAL_64; a_weight: INTEGER_64; a_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item fontWithFamily:$a_family traits:$a_traits weight:$a_weight size:$a_size];
			 ]"
		end

	objc_traits_of_font_ (an_item: POINTER; a_font_obj: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFontManager *)$an_item traitsOfFont:$a_font_obj];
			 ]"
		end

	objc_weight_of_font_ (an_item: POINTER; a_font_obj: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFontManager *)$an_item weightOfFont:$a_font_obj];
			 ]"
		end

	objc_available_fonts (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item availableFonts];
			 ]"
		end

	objc_available_font_families (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item availableFontFamilies];
			 ]"
		end

	objc_available_members_of_font_family_ (an_item: POINTER; a_fam: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item availableMembersOfFontFamily:$a_fam];
			 ]"
		end

	objc_convert_font_ (an_item: POINTER; a_font_obj: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item convertFont:$a_font_obj];
			 ]"
		end

	objc_convert_font__to_size_ (an_item: POINTER; a_font_obj: POINTER; a_size: REAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item convertFont:$a_font_obj toSize:$a_size];
			 ]"
		end

	objc_convert_font__to_face_ (an_item: POINTER; a_font_obj: POINTER; a_typeface: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item convertFont:$a_font_obj toFace:$a_typeface];
			 ]"
		end

	objc_convert_font__to_family_ (an_item: POINTER; a_font_obj: POINTER; a_family: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item convertFont:$a_font_obj toFamily:$a_family];
			 ]"
		end

	objc_convert_font__to_have_trait_ (an_item: POINTER; a_font_obj: POINTER; a_trait: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item convertFont:$a_font_obj toHaveTrait:$a_trait];
			 ]"
		end

	objc_convert_font__to_not_have_trait_ (an_item: POINTER; a_font_obj: POINTER; a_trait: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item convertFont:$a_font_obj toNotHaveTrait:$a_trait];
			 ]"
		end

	objc_convert_weight__of_font_ (an_item: POINTER; a_up_flag: BOOLEAN; a_font_obj: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item convertWeight:$a_up_flag ofFont:$a_font_obj];
			 ]"
		end

	objc_is_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFontManager *)$an_item isEnabled];
			 ]"
		end

	objc_set_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item setEnabled:$a_flag];
			 ]"
		end

	objc_action (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item action];
			 ]"
		end

	objc_set_action_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item setAction:$a_selector];
			 ]"
		end

	objc_send_action (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFontManager *)$an_item sendAction];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item setDelegate:$an_object];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item delegate];
			 ]"
		end

	objc_localized_name_for_family__face_ (an_item: POINTER; a_family: POINTER; a_face_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item localizedNameForFamily:$a_family face:$a_face_key];
			 ]"
		end

	objc_set_selected_attributes__is_multiple_ (an_item: POINTER; a_attributes: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item setSelectedAttributes:$a_attributes isMultiple:$a_flag];
			 ]"
		end

	objc_convert_attributes_ (an_item: POINTER; a_attributes: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item convertAttributes:$a_attributes];
			 ]"
		end

	objc_available_font_names_matching_font_descriptor_ (an_item: POINTER; a_descriptor: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item availableFontNamesMatchingFontDescriptor:$a_descriptor];
			 ]"
		end

	objc_collection_names (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item collectionNames];
			 ]"
		end

	objc_font_descriptors_in_collection_ (an_item: POINTER; a_collection_names: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item fontDescriptorsInCollection:$a_collection_names];
			 ]"
		end

	objc_add_collection__options_ (an_item: POINTER; a_collection_name: POINTER; a_collection_options: INTEGER_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFontManager *)$an_item addCollection:$a_collection_name options:$a_collection_options];
			 ]"
		end

	objc_remove_collection_ (an_item: POINTER; a_collection_name: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFontManager *)$an_item removeCollection:$a_collection_name];
			 ]"
		end

	objc_add_font_descriptors__to_collection_ (an_item: POINTER; a_descriptors: POINTER; a_collection_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item addFontDescriptors:$a_descriptors toCollection:$a_collection_name];
			 ]"
		end

	objc_remove_font_descriptor__from_collection_ (an_item: POINTER; a_descriptor: POINTER; a_collection: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item removeFontDescriptor:$a_descriptor fromCollection:$a_collection];
			 ]"
		end

	objc_current_font_action (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFontManager *)$an_item currentFontAction];
			 ]"
		end

	objc_convert_font_traits_ (an_item: POINTER; a_traits: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFontManager *)$an_item convertFontTraits:$a_traits];
			 ]"
		end

	objc_set_target_ (an_item: POINTER; a_target: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item setTarget:$a_target];
			 ]"
		end

	objc_target (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item target];
			 ]"
		end

feature -- NSFontManagerMenuActionMethods

	font_named__has_traits_ (a_f_name: detachable NS_STRING; a_some_traits: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_f_name__item: POINTER
		do
			if attached a_f_name as a_f_name_attached then
				a_f_name__item := a_f_name_attached.item
			end
			Result := objc_font_named__has_traits_ (item, a_f_name__item, a_some_traits)
		end

	available_font_names_with_traits_ (a_some_traits: NATURAL_64): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_available_font_names_with_traits_ (item, a_some_traits)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like available_font_names_with_traits_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like available_font_names_with_traits_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_font_trait_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_add_font_trait_ (item, a_sender__item)
		end

	remove_font_trait_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_remove_font_trait_ (item, a_sender__item)
		end

	modify_font_via_panel_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_modify_font_via_panel_ (item, a_sender__item)
		end

	modify_font_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_modify_font_ (item, a_sender__item)
		end

	order_front_font_panel_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_order_front_font_panel_ (item, a_sender__item)
		end

	order_front_styles_panel_ (a_sender: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_sender__item: POINTER
		do
			if attached a_sender as a_sender_attached then
				a_sender__item := a_sender_attached.item
			end
			objc_order_front_styles_panel_ (item, a_sender__item)
		end

feature {NONE} -- NSFontManagerMenuActionMethods Externals

	objc_font_named__has_traits_ (an_item: POINTER; a_f_name: POINTER; a_some_traits: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSFontManager *)$an_item fontNamed:$a_f_name hasTraits:$a_some_traits];
			 ]"
		end

	objc_available_font_names_with_traits_ (an_item: POINTER; a_some_traits: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSFontManager *)$an_item availableFontNamesWithTraits:$a_some_traits];
			 ]"
		end

	objc_add_font_trait_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item addFontTrait:$a_sender];
			 ]"
		end

	objc_remove_font_trait_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item removeFontTrait:$a_sender];
			 ]"
		end

	objc_modify_font_via_panel_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item modifyFontViaPanel:$a_sender];
			 ]"
		end

	objc_modify_font_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item modifyFont:$a_sender];
			 ]"
		end

	objc_order_front_font_panel_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item orderFrontFontPanel:$a_sender];
			 ]"
		end

	objc_order_front_styles_panel_ (an_item: POINTER; a_sender: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSFontManager *)$an_item orderFrontStylesPanel:$a_sender];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSFontManager"
		end

end

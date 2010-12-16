note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_LAYOUT_MANAGER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_GLYPH_STORAGE_PROTOCOL
		undefine
			set_int_attribute__value__for_glyph_at_index_,
			objc_set_int_attribute__value__for_glyph_at_index_,
			attributed_string,
			objc_attributed_string,
			layout_options,
			objc_layout_options
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSLayoutManager

	text_storage: detachable NS_TEXT_STORAGE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_storage (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_storage} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_storage} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_text_storage_ (a_text_storage: detachable NS_TEXT_STORAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_text_storage__item: POINTER
		do
			if attached a_text_storage as a_text_storage_attached then
				a_text_storage__item := a_text_storage_attached.item
			end
			objc_set_text_storage_ (item, a_text_storage__item)
		end

	attributed_string: detachable NS_ATTRIBUTED_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attributed_string (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attributed_string} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attributed_string} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	replace_text_storage_ (a_new_text_storage: detachable NS_TEXT_STORAGE)
			-- Auto generated Objective-C wrapper.
		local
			a_new_text_storage__item: POINTER
		do
			if attached a_new_text_storage as a_new_text_storage_attached then
				a_new_text_storage__item := a_new_text_storage_attached.item
			end
			objc_replace_text_storage_ (item, a_new_text_storage__item)
		end

	glyph_generator: detachable NS_GLYPH_GENERATOR
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_glyph_generator (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like glyph_generator} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like glyph_generator} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_glyph_generator_ (a_glyph_generator: detachable NS_GLYPH_GENERATOR)
			-- Auto generated Objective-C wrapper.
		local
			a_glyph_generator__item: POINTER
		do
			if attached a_glyph_generator as a_glyph_generator_attached then
				a_glyph_generator__item := a_glyph_generator_attached.item
			end
			objc_set_glyph_generator_ (item, a_glyph_generator__item)
		end

	typesetter: detachable NS_TYPESETTER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_typesetter (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like typesetter} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like typesetter} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_typesetter_ (a_typesetter: detachable NS_TYPESETTER)
			-- Auto generated Objective-C wrapper.
		local
			a_typesetter__item: POINTER
		do
			if attached a_typesetter as a_typesetter_attached then
				a_typesetter__item := a_typesetter_attached.item
			end
			objc_set_typesetter_ (item, a_typesetter__item)
		end

	delegate: detachable NS_LAYOUT_MANAGER_DELEGATE_PROTOCOL
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

	set_delegate_ (a_delegate: detachable NS_LAYOUT_MANAGER_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	text_containers: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_containers (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_containers} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_containers} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	add_text_container_ (a_container: detachable NS_TEXT_CONTAINER)
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			objc_add_text_container_ (item, a_container__item)
		end

	insert_text_container__at_index_ (a_container: detachable NS_TEXT_CONTAINER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			objc_insert_text_container__at_index_ (item, a_container__item, a_index)
		end

	remove_text_container_at_index_ (a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_text_container_at_index_ (item, a_index)
		end

	text_container_changed_geometry_ (a_container: detachable NS_TEXT_CONTAINER)
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			objc_text_container_changed_geometry_ (item, a_container__item)
		end

	text_container_changed_text_view_ (a_container: detachable NS_TEXT_CONTAINER)
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			objc_text_container_changed_text_view_ (item, a_container__item)
		end

	set_background_layout_enabled_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_background_layout_enabled_ (item, a_flag)
		end

	background_layout_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_background_layout_enabled (item)
		end

	set_uses_screen_fonts_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_screen_fonts_ (item, a_flag)
		end

	uses_screen_fonts: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_screen_fonts (item)
		end

	set_shows_invisible_characters_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_invisible_characters_ (item, a_flag)
		end

	shows_invisible_characters: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_invisible_characters (item)
		end

	set_shows_control_characters_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_shows_control_characters_ (item, a_flag)
		end

	shows_control_characters: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_shows_control_characters (item)
		end

	set_hyphenation_factor_ (a_factor: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_hyphenation_factor_ (item, a_factor)
		end

	hyphenation_factor: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_hyphenation_factor (item)
		end

	set_default_attachment_scaling_ (a_scaling: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_default_attachment_scaling_ (item, a_scaling)
		end

	default_attachment_scaling: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_default_attachment_scaling (item)
		end

	set_typesetter_behavior_ (a_the_behavior: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_typesetter_behavior_ (item, a_the_behavior)
		end

	typesetter_behavior: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_typesetter_behavior (item)
		end

	layout_options: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_layout_options (item)
		end

	set_allows_non_contiguous_layout_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_allows_non_contiguous_layout_ (item, a_flag)
		end

	allows_non_contiguous_layout: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_allows_non_contiguous_layout (item)
		end

	has_non_contiguous_layout: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_has_non_contiguous_layout (item)
		end

--	invalidate_glyphs_for_character_range__change_in_length__actual_character_range_ (a_char_range: NS_RANGE; a_delta: INTEGER_64; a_actual_char_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_actual_char_range__item: POINTER
--		do
--			if attached a_actual_char_range as a_actual_char_range_attached then
--				a_actual_char_range__item := a_actual_char_range_attached.item
--			end
--			objc_invalidate_glyphs_for_character_range__change_in_length__actual_character_range_ (item, a_char_range.item, a_delta, a_actual_char_range__item)
--		end

--	invalidate_layout_for_character_range__actual_character_range_ (a_char_range: NS_RANGE; a_actual_char_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_actual_char_range__item: POINTER
--		do
--			if attached a_actual_char_range as a_actual_char_range_attached then
--				a_actual_char_range__item := a_actual_char_range_attached.item
--			end
--			objc_invalidate_layout_for_character_range__actual_character_range_ (item, a_char_range.item, a_actual_char_range__item)
--		end

--	invalidate_layout_for_character_range__is_soft__actual_character_range_ (a_char_range: NS_RANGE; a_flag: BOOLEAN; a_actual_char_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_actual_char_range__item: POINTER
--		do
--			if attached a_actual_char_range as a_actual_char_range_attached then
--				a_actual_char_range__item := a_actual_char_range_attached.item
--			end
--			objc_invalidate_layout_for_character_range__is_soft__actual_character_range_ (item, a_char_range.item, a_flag, a_actual_char_range__item)
--		end

	invalidate_display_for_character_range_ (a_char_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_invalidate_display_for_character_range_ (item, a_char_range.item)
		end

	invalidate_display_for_glyph_range_ (a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_invalidate_display_for_glyph_range_ (item, a_glyph_range.item)
		end

	text_storage__edited__range__change_in_length__invalidated_range_ (a_str: detachable NS_TEXT_STORAGE; a_edited_mask: NATURAL_64; a_new_char_range: NS_RANGE; a_delta: INTEGER_64; a_invalidated_char_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_str__item: POINTER
		do
			if attached a_str as a_str_attached then
				a_str__item := a_str_attached.item
			end
			objc_text_storage__edited__range__change_in_length__invalidated_range_ (item, a_str__item, a_edited_mask, a_new_char_range.item, a_delta, a_invalidated_char_range.item)
		end

	ensure_glyphs_for_character_range_ (a_char_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_ensure_glyphs_for_character_range_ (item, a_char_range.item)
		end

	ensure_glyphs_for_glyph_range_ (a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_ensure_glyphs_for_glyph_range_ (item, a_glyph_range.item)
		end

	ensure_layout_for_character_range_ (a_char_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_ensure_layout_for_character_range_ (item, a_char_range.item)
		end

	ensure_layout_for_glyph_range_ (a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_ensure_layout_for_glyph_range_ (item, a_glyph_range.item)
		end

	ensure_layout_for_text_container_ (a_container: detachable NS_TEXT_CONTAINER)
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			objc_ensure_layout_for_text_container_ (item, a_container__item)
		end

	ensure_layout_for_bounding_rect__in_text_container_ (a_bounds: NS_RECT; a_container: detachable NS_TEXT_CONTAINER)
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			objc_ensure_layout_for_bounding_rect__in_text_container_ (item, a_bounds.item, a_container__item)
		end

--	insert_glyphs__length__for_starting_glyph_at_index__character_index_ (a_glyphs: UNSUPPORTED_TYPE; a_length: NATURAL_64; a_glyph_index: NATURAL_64; a_char_index: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_glyphs__item: POINTER
--		do
--			if attached a_glyphs as a_glyphs_attached then
--				a_glyphs__item := a_glyphs_attached.item
--			end
--			objc_insert_glyphs__length__for_starting_glyph_at_index__character_index_ (item, a_glyphs__item, a_length, a_glyph_index, a_char_index)
--		end

	insert_glyph__at_glyph_index__character_index_ (a_glyph: NATURAL_32; a_glyph_index: NATURAL_64; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_insert_glyph__at_glyph_index__character_index_ (item, a_glyph, a_glyph_index, a_char_index)
		end

	replace_glyph_at_index__with_glyph_ (a_glyph_index: NATURAL_64; a_new_glyph: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_replace_glyph_at_index__with_glyph_ (item, a_glyph_index, a_new_glyph)
		end

	delete_glyphs_in_range_ (a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_delete_glyphs_in_range_ (item, a_glyph_range.item)
		end

	set_character_index__for_glyph_at_index_ (a_char_index: NATURAL_64; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_character_index__for_glyph_at_index_ (item, a_char_index, a_glyph_index)
		end

	set_int_attribute__value__for_glyph_at_index_ (a_attribute_tag: INTEGER_64; a_val: INTEGER_64; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_int_attribute__value__for_glyph_at_index_ (item, a_attribute_tag, a_val, a_glyph_index)
		end

	invalidate_glyphs_on_layout_invalidation_for_glyph_range_ (a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_invalidate_glyphs_on_layout_invalidation_for_glyph_range_ (item, a_glyph_range.item)
		end

	number_of_glyphs: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_number_of_glyphs (item)
		end

--	glyph_at_index__is_valid_index_ (a_glyph_index: NATURAL_64; a_is_valid_index: UNSUPPORTED_TYPE): NATURAL_32
--			-- Auto generated Objective-C wrapper.
--		local
--			a_is_valid_index__item: POINTER
--		do
--			if attached a_is_valid_index as a_is_valid_index_attached then
--				a_is_valid_index__item := a_is_valid_index_attached.item
--			end
--			Result := objc_glyph_at_index__is_valid_index_ (item, a_glyph_index, a_is_valid_index__item)
--		end

	glyph_at_index_ (a_glyph_index: NATURAL_64): NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_glyph_at_index_ (item, a_glyph_index)
		end

	is_valid_glyph_index_ (a_glyph_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_valid_glyph_index_ (item, a_glyph_index)
		end

	character_index_for_glyph_at_index_ (a_glyph_index: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_character_index_for_glyph_at_index_ (item, a_glyph_index)
		end

	glyph_index_for_character_at_index_ (a_char_index: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_glyph_index_for_character_at_index_ (item, a_char_index)
		end

	int_attribute__for_glyph_at_index_ (a_attribute_tag: INTEGER_64; a_glyph_index: NATURAL_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_int_attribute__for_glyph_at_index_ (item, a_attribute_tag, a_glyph_index)
		end

--	get_glyphs_in_range__glyphs__character_indexes__glyph_inscriptions__elastic_bits_ (a_glyph_range: NS_RANGE; a_glyph_buffer: UNSUPPORTED_TYPE; a_char_index_buffer: UNSUPPORTED_TYPE; a_inscribe_buffer: UNSUPPORTED_TYPE; a_elastic_buffer: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_glyph_buffer__item: POINTER
--			a_char_index_buffer__item: POINTER
--			a_inscribe_buffer__item: POINTER
--			a_elastic_buffer__item: POINTER
--		do
--			if attached a_glyph_buffer as a_glyph_buffer_attached then
--				a_glyph_buffer__item := a_glyph_buffer_attached.item
--			end
--			if attached a_char_index_buffer as a_char_index_buffer_attached then
--				a_char_index_buffer__item := a_char_index_buffer_attached.item
--			end
--			if attached a_inscribe_buffer as a_inscribe_buffer_attached then
--				a_inscribe_buffer__item := a_inscribe_buffer_attached.item
--			end
--			if attached a_elastic_buffer as a_elastic_buffer_attached then
--				a_elastic_buffer__item := a_elastic_buffer_attached.item
--			end
--			Result := objc_get_glyphs_in_range__glyphs__character_indexes__glyph_inscriptions__elastic_bits_ (item, a_glyph_range.item, a_glyph_buffer__item, a_char_index_buffer__item, a_inscribe_buffer__item, a_elastic_buffer__item)
--		end

--	get_glyphs_in_range__glyphs__character_indexes__glyph_inscriptions__elastic_bits__bidi_levels_ (a_glyph_range: NS_RANGE; a_glyph_buffer: UNSUPPORTED_TYPE; a_char_index_buffer: UNSUPPORTED_TYPE; a_inscribe_buffer: UNSUPPORTED_TYPE; a_elastic_buffer: UNSUPPORTED_TYPE; a_bidi_level_buffer: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_glyph_buffer__item: POINTER
--			a_char_index_buffer__item: POINTER
--			a_inscribe_buffer__item: POINTER
--			a_elastic_buffer__item: POINTER
--		do
--			if attached a_glyph_buffer as a_glyph_buffer_attached then
--				a_glyph_buffer__item := a_glyph_buffer_attached.item
--			end
--			if attached a_char_index_buffer as a_char_index_buffer_attached then
--				a_char_index_buffer__item := a_char_index_buffer_attached.item
--			end
--			if attached a_inscribe_buffer as a_inscribe_buffer_attached then
--				a_inscribe_buffer__item := a_inscribe_buffer_attached.item
--			end
--			if attached a_elastic_buffer as a_elastic_buffer_attached then
--				a_elastic_buffer__item := a_elastic_buffer_attached.item
--			end
--			Result := objc_get_glyphs_in_range__glyphs__character_indexes__glyph_inscriptions__elastic_bits__bidi_levels_ (item, a_glyph_range.item, a_glyph_buffer__item, a_char_index_buffer__item, a_inscribe_buffer__item, a_elastic_buffer__item, )
--		end

--	get_glyphs__range_ (a_glyph_array: UNSUPPORTED_TYPE; a_glyph_range: NS_RANGE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_glyph_array__item: POINTER
--		do
--			if attached a_glyph_array as a_glyph_array_attached then
--				a_glyph_array__item := a_glyph_array_attached.item
--			end
--			Result := objc_get_glyphs__range_ (item, a_glyph_array__item, a_glyph_range.item)
--		end

	set_text_container__for_glyph_range_ (a_container: detachable NS_TEXT_CONTAINER; a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			objc_set_text_container__for_glyph_range_ (item, a_container__item, a_glyph_range.item)
		end

	set_line_fragment_rect__for_glyph_range__used_rect_ (a_fragment_rect: NS_RECT; a_glyph_range: NS_RANGE; a_used_rect: NS_RECT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_line_fragment_rect__for_glyph_range__used_rect_ (item, a_fragment_rect.item, a_glyph_range.item, a_used_rect.item)
		end

	set_extra_line_fragment_rect__used_rect__text_container_ (a_fragment_rect: NS_RECT; a_used_rect: NS_RECT; a_container: detachable NS_TEXT_CONTAINER)
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			objc_set_extra_line_fragment_rect__used_rect__text_container_ (item, a_fragment_rect.item, a_used_rect.item, a_container__item)
		end

	set_location__for_start_of_glyph_range_ (a_location: NS_POINT; a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_location__for_start_of_glyph_range_ (item, a_location.item, a_glyph_range.item)
		end

--	set_locations__starting_glyph_indexes__count__for_glyph_range_ (a_locations: UNSUPPORTED_TYPE; a_glyph_indexes: UNSUPPORTED_TYPE; a_count: NATURAL_64; a_glyph_range: NS_RANGE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_locations__item: POINTER
--			a_glyph_indexes__item: POINTER
--		do
--			if attached a_locations as a_locations_attached then
--				a_locations__item := a_locations_attached.item
--			end
--			if attached a_glyph_indexes as a_glyph_indexes_attached then
--				a_glyph_indexes__item := a_glyph_indexes_attached.item
--			end
--			objc_set_locations__starting_glyph_indexes__count__for_glyph_range_ (item, a_locations__item, a_glyph_indexes__item, a_count, a_glyph_range.item)
--		end

	set_not_shown_attribute__for_glyph_at_index_ (a_flag: BOOLEAN; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_not_shown_attribute__for_glyph_at_index_ (item, a_flag, a_glyph_index)
		end

	set_draws_outside_line_fragment__for_glyph_at_index_ (a_flag: BOOLEAN; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_draws_outside_line_fragment__for_glyph_at_index_ (item, a_flag, a_glyph_index)
		end

	set_attachment_size__for_glyph_range_ (a_attachment_size: NS_SIZE; a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_attachment_size__for_glyph_range_ (item, a_attachment_size.item, a_glyph_range.item)
		end

--	get_first_unlaid_character_index__glyph_index_ (a_char_index: UNSUPPORTED_TYPE; a_glyph_index: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_char_index__item: POINTER
--			a_glyph_index__item: POINTER
--		do
--			if attached a_char_index as a_char_index_attached then
--				a_char_index__item := a_char_index_attached.item
--			end
--			if attached a_glyph_index as a_glyph_index_attached then
--				a_glyph_index__item := a_glyph_index_attached.item
--			end
--			objc_get_first_unlaid_character_index__glyph_index_ (item, a_char_index__item, a_glyph_index__item)
--		end

	first_unlaid_character_index: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_first_unlaid_character_index (item)
		end

	first_unlaid_glyph_index: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_first_unlaid_glyph_index (item)
		end

--	text_container_for_glyph_at_index__effective_range_ (a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE): detachable NS_TEXT_CONTAINER
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_effective_glyph_range__item: POINTER
--		do
--			if attached a_effective_glyph_range as a_effective_glyph_range_attached then
--				a_effective_glyph_range__item := a_effective_glyph_range_attached.item
--			end
--			result_pointer := objc_text_container_for_glyph_at_index__effective_range_ (item, a_glyph_index, a_effective_glyph_range__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like text_container_for_glyph_at_index__effective_range_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like text_container_for_glyph_at_index__effective_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	used_rect_for_text_container_ (a_container: detachable NS_TEXT_CONTAINER): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			create Result.make
			objc_used_rect_for_text_container_ (item, Result.item, a_container__item)
		end

	line_fragment_rect_for_glyph_at_index__effective_range_ (a_glyph_index: NATURAL_64; a_effective_glyph_range: POINTER): NS_RECT
			-- Auto generated Objective-C wrapper.
		do
			create Result.make
			objc_line_fragment_rect_for_glyph_at_index__effective_range_ (item, Result.item, a_glyph_index, a_effective_glyph_range)
		end

--	line_fragment_used_rect_for_glyph_at_index__effective_range_ (a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE): NS_RECT
--			-- Auto generated Objective-C wrapper.
--		local
--			a_effective_glyph_range__item: POINTER
--		do
--			if attached a_effective_glyph_range as a_effective_glyph_range_attached then
--				a_effective_glyph_range__item := a_effective_glyph_range_attached.item
--			end
--			create Result.make
--			objc_line_fragment_used_rect_for_glyph_at_index__effective_range_ (item, Result.item, a_glyph_index, a_effective_glyph_range__item)
--		end

--	line_fragment_rect_for_glyph_at_index__effective_range__without_additional_layout_ (a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE; a_flag: BOOLEAN): NS_RECT
--			-- Auto generated Objective-C wrapper.
--		local
--			a_effective_glyph_range__item: POINTER
--		do
--			if attached a_effective_glyph_range as a_effective_glyph_range_attached then
--				a_effective_glyph_range__item := a_effective_glyph_range_attached.item
--			end
--			create Result.make
--			objc_line_fragment_rect_for_glyph_at_index__effective_range__without_additional_layout_ (item, Result.item, a_glyph_index, a_effective_glyph_range__item, a_flag)
--		end

--	line_fragment_used_rect_for_glyph_at_index__effective_range__without_additional_layout_ (a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE; a_flag: BOOLEAN): NS_RECT
--			-- Auto generated Objective-C wrapper.
--		local
--			a_effective_glyph_range__item: POINTER
--		do
--			if attached a_effective_glyph_range as a_effective_glyph_range_attached then
--				a_effective_glyph_range__item := a_effective_glyph_range_attached.item
--			end
--			create Result.make
--			objc_line_fragment_used_rect_for_glyph_at_index__effective_range__without_additional_layout_ (item, Result.item, a_glyph_index, a_effective_glyph_range__item, a_flag)
--		end

--	text_container_for_glyph_at_index__effective_range__without_additional_layout_ (a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE; a_flag: BOOLEAN): detachable NS_TEXT_CONTAINER
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_effective_glyph_range__item: POINTER
--		do
--			if attached a_effective_glyph_range as a_effective_glyph_range_attached then
--				a_effective_glyph_range__item := a_effective_glyph_range_attached.item
--			end
--			result_pointer := objc_text_container_for_glyph_at_index__effective_range__without_additional_layout_ (item, a_glyph_index, a_effective_glyph_range__item, a_flag)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like text_container_for_glyph_at_index__effective_range__without_additional_layout_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like text_container_for_glyph_at_index__effective_range__without_additional_layout_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	extra_line_fragment_rect: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_extra_line_fragment_rect (item, Result.item)
		end

	extra_line_fragment_used_rect: NS_RECT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_extra_line_fragment_used_rect (item, Result.item)
		end

	extra_line_fragment_text_container: detachable NS_TEXT_CONTAINER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_extra_line_fragment_text_container (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like extra_line_fragment_text_container} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like extra_line_fragment_text_container} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	location_for_glyph_at_index_ (a_glyph_index: NATURAL_64): NS_POINT
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_location_for_glyph_at_index_ (item, Result.item, a_glyph_index)
		end

	not_shown_attribute_for_glyph_at_index_ (a_glyph_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_not_shown_attribute_for_glyph_at_index_ (item, a_glyph_index)
		end

	draws_outside_line_fragment_for_glyph_at_index_ (a_glyph_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_draws_outside_line_fragment_for_glyph_at_index_ (item, a_glyph_index)
		end

	attachment_size_for_glyph_at_index_ (a_glyph_index: NATURAL_64): NS_SIZE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_attachment_size_for_glyph_at_index_ (item, Result.item, a_glyph_index)
		end

	set_layout_rect__for_text_block__glyph_range_ (a_rect: NS_RECT; a_block: detachable NS_TEXT_BLOCK; a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_block__item: POINTER
		do
			if attached a_block as a_block_attached then
				a_block__item := a_block_attached.item
			end
			objc_set_layout_rect__for_text_block__glyph_range_ (item, a_rect.item, a_block__item, a_glyph_range.item)
		end

	set_bounds_rect__for_text_block__glyph_range_ (a_rect: NS_RECT; a_block: detachable NS_TEXT_BLOCK; a_glyph_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_block__item: POINTER
		do
			if attached a_block as a_block_attached then
				a_block__item := a_block_attached.item
			end
			objc_set_bounds_rect__for_text_block__glyph_range_ (item, a_rect.item, a_block__item, a_glyph_range.item)
		end

	layout_rect_for_text_block__glyph_range_ (a_block: detachable NS_TEXT_BLOCK; a_glyph_range: NS_RANGE): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_block__item: POINTER
		do
			if attached a_block as a_block_attached then
				a_block__item := a_block_attached.item
			end
			create Result.make
			objc_layout_rect_for_text_block__glyph_range_ (item, Result.item, a_block__item, a_glyph_range.item)
		end

	bounds_rect_for_text_block__glyph_range_ (a_block: detachable NS_TEXT_BLOCK; a_glyph_range: NS_RANGE): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_block__item: POINTER
		do
			if attached a_block as a_block_attached then
				a_block__item := a_block_attached.item
			end
			create Result.make
			objc_bounds_rect_for_text_block__glyph_range_ (item, Result.item, a_block__item, a_glyph_range.item)
		end

--	layout_rect_for_text_block__at_index__effective_range_ (a_block: detachable NS_TEXT_BLOCK; a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE): NS_RECT
--			-- Auto generated Objective-C wrapper.
--		local
--			a_block__item: POINTER
--			a_effective_glyph_range__item: POINTER
--		do
--			if attached a_block as a_block_attached then
--				a_block__item := a_block_attached.item
--			end
--			if attached a_effective_glyph_range as a_effective_glyph_range_attached then
--				a_effective_glyph_range__item := a_effective_glyph_range_attached.item
--			end
--			create Result.make
--			objc_layout_rect_for_text_block__at_index__effective_range_ (item, Result.item, a_block__item, a_glyph_index, a_effective_glyph_range__item)
--		end

--	bounds_rect_for_text_block__at_index__effective_range_ (a_block: detachable NS_TEXT_BLOCK; a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE): NS_RECT
--			-- Auto generated Objective-C wrapper.
--		local
--			a_block__item: POINTER
--			a_effective_glyph_range__item: POINTER
--		do
--			if attached a_block as a_block_attached then
--				a_block__item := a_block_attached.item
--			end
--			if attached a_effective_glyph_range as a_effective_glyph_range_attached then
--				a_effective_glyph_range__item := a_effective_glyph_range_attached.item
--			end
--			create Result.make
--			objc_bounds_rect_for_text_block__at_index__effective_range_ (item, Result.item, a_block__item, a_glyph_index, a_effective_glyph_range__item)
--		end

--	glyph_range_for_character_range__actual_character_range_ (a_char_range: NS_RANGE; a_actual_char_range: UNSUPPORTED_TYPE): NS_RANGE
--			-- Auto generated Objective-C wrapper.
--		local
--			a_actual_char_range__item: POINTER
--		do
--			if attached a_actual_char_range as a_actual_char_range_attached then
--				a_actual_char_range__item := a_actual_char_range_attached.item
--			end
--			create Result.make
--			objc_glyph_range_for_character_range__actual_character_range_ (item, Result.item, a_char_range.item, a_actual_char_range__item)
--		end

--	character_range_for_glyph_range__actual_glyph_range_ (a_glyph_range: NS_RANGE; a_actual_glyph_range: UNSUPPORTED_TYPE): NS_RANGE
--			-- Auto generated Objective-C wrapper.
--		local
--			a_actual_glyph_range__item: POINTER
--		do
--			if attached a_actual_glyph_range as a_actual_glyph_range_attached then
--				a_actual_glyph_range__item := a_actual_glyph_range_attached.item
--			end
--			create Result.make
--			objc_character_range_for_glyph_range__actual_glyph_range_ (item, Result.item, a_glyph_range.item, a_actual_glyph_range__item)
--		end

	glyph_range_for_text_container_ (a_container: detachable NS_TEXT_CONTAINER): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			create Result.make
			objc_glyph_range_for_text_container_ (item, Result.item, a_container__item)
		end

	range_of_nominally_spaced_glyphs_containing_index_ (a_glyph_index: NATURAL_64): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
		do
			create Result.make
			objc_range_of_nominally_spaced_glyphs_containing_index_ (item, Result.item, a_glyph_index)
		end

--	rect_array_for_character_range__within_selected_character_range__in_text_container__rect_count_ (a_char_range: NS_RANGE; a_sel_char_range: NS_RANGE; a_container: detachable NS_TEXT_CONTAINER; a_rect_count: UNSUPPORTED_TYPE): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_container__item: POINTER
--			a_rect_count__item: POINTER
--		do
--			if attached a_container as a_container_attached then
--				a_container__item := a_container_attached.item
--			end
--			if attached a_rect_count as a_rect_count_attached then
--				a_rect_count__item := a_rect_count_attached.item
--			end
--			result_pointer := objc_rect_array_for_character_range__within_selected_character_range__in_text_container__rect_count_ (item, a_char_range.item, a_sel_char_range.item, a_container__item, a_rect_count__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like rect_array_for_character_range__within_selected_character_range__in_text_container__rect_count_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like rect_array_for_character_range__within_selected_character_range__in_text_container__rect_count_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	rect_array_for_glyph_range__within_selected_glyph_range__in_text_container__rect_count_ (a_glyph_range: NS_RANGE; a_sel_glyph_range: NS_RANGE; a_container: detachable NS_TEXT_CONTAINER; a_rect_count: UNSUPPORTED_TYPE): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_container__item: POINTER
--			a_rect_count__item: POINTER
--		do
--			if attached a_container as a_container_attached then
--				a_container__item := a_container_attached.item
--			end
--			if attached a_rect_count as a_rect_count_attached then
--				a_rect_count__item := a_rect_count_attached.item
--			end
--			result_pointer := objc_rect_array_for_glyph_range__within_selected_glyph_range__in_text_container__rect_count_ (item, a_glyph_range.item, a_sel_glyph_range.item, a_container__item, a_rect_count__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like rect_array_for_glyph_range__within_selected_glyph_range__in_text_container__rect_count_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like rect_array_for_glyph_range__within_selected_glyph_range__in_text_container__rect_count_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	bounding_rect_for_glyph_range__in_text_container_ (a_glyph_range: NS_RANGE; a_container: detachable NS_TEXT_CONTAINER): NS_RECT
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			create Result.make
			objc_bounding_rect_for_glyph_range__in_text_container_ (item, Result.item, a_glyph_range.item, a_container__item)
		end

	glyph_range_for_bounding_rect__in_text_container_ (a_bounds: NS_RECT; a_container: detachable NS_TEXT_CONTAINER): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			create Result.make
			objc_glyph_range_for_bounding_rect__in_text_container_ (item, Result.item, a_bounds.item, a_container__item)
		end

	glyph_range_for_bounding_rect_without_additional_layout__in_text_container_ (a_bounds: NS_RECT; a_container: detachable NS_TEXT_CONTAINER): NS_RANGE
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			create Result.make
			objc_glyph_range_for_bounding_rect_without_additional_layout__in_text_container_ (item, Result.item, a_bounds.item, a_container__item)
		end

--	glyph_index_for_point__in_text_container__fraction_of_distance_through_glyph_ (a_point: NS_POINT; a_container: detachable NS_TEXT_CONTAINER; a_partial_fraction: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_container__item: POINTER
--			a_partial_fraction__item: POINTER
--		do
--			if attached a_container as a_container_attached then
--				a_container__item := a_container_attached.item
--			end
--			if attached a_partial_fraction as a_partial_fraction_attached then
--				a_partial_fraction__item := a_partial_fraction_attached.item
--			end
--			Result := objc_glyph_index_for_point__in_text_container__fraction_of_distance_through_glyph_ (item, a_point.item, a_container__item, a_partial_fraction__item)
--		end

	glyph_index_for_point__in_text_container_ (a_point: NS_POINT; a_container: detachable NS_TEXT_CONTAINER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			Result := objc_glyph_index_for_point__in_text_container_ (item, a_point.item, a_container__item)
		end

	fraction_of_distance_through_glyph_for_point__in_text_container_ (a_point: NS_POINT; a_container: detachable NS_TEXT_CONTAINER): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_container__item: POINTER
		do
			if attached a_container as a_container_attached then
				a_container__item := a_container_attached.item
			end
			Result := objc_fraction_of_distance_through_glyph_for_point__in_text_container_ (item, a_point.item, a_container__item)
		end

--	character_index_for_point__in_text_container__fraction_of_distance_between_insertion_points_ (a_point: NS_POINT; a_container: detachable NS_TEXT_CONTAINER; a_partial_fraction: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_container__item: POINTER
--			a_partial_fraction__item: POINTER
--		do
--			if attached a_container as a_container_attached then
--				a_container__item := a_container_attached.item
--			end
--			if attached a_partial_fraction as a_partial_fraction_attached then
--				a_partial_fraction__item := a_partial_fraction_attached.item
--			end
--			Result := objc_character_index_for_point__in_text_container__fraction_of_distance_between_insertion_points_ (item, a_point.item, a_container__item, a_partial_fraction__item)
--		end

--	get_line_fragment_insertion_points_for_character_at_index__alternate_positions__in_display_order__positions__character_indexes_ (a_char_index: NATURAL_64; a_flag: BOOLEAN; a_d_flag: BOOLEAN; a_positions: UNSUPPORTED_TYPE; a_char_indexes: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		local
--			a_positions__item: POINTER
--			a_char_indexes__item: POINTER
--		do
--			if attached a_positions as a_positions_attached then
--				a_positions__item := a_positions_attached.item
--			end
--			if attached a_char_indexes as a_char_indexes_attached then
--				a_char_indexes__item := a_char_indexes_attached.item
--			end
--			Result := objc_get_line_fragment_insertion_points_for_character_at_index__alternate_positions__in_display_order__positions__character_indexes_ (item, a_char_index, a_flag, a_d_flag, a_positions__item, a_char_indexes__item)
--		end

--	temporary_attributes_at_character_index__effective_range_ (a_char_index: NATURAL_64; a_effective_char_range: UNSUPPORTED_TYPE): detachable NS_DICTIONARY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_effective_char_range__item: POINTER
--		do
--			if attached a_effective_char_range as a_effective_char_range_attached then
--				a_effective_char_range__item := a_effective_char_range_attached.item
--			end
--			result_pointer := objc_temporary_attributes_at_character_index__effective_range_ (item, a_char_index, a_effective_char_range__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like temporary_attributes_at_character_index__effective_range_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like temporary_attributes_at_character_index__effective_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	set_temporary_attributes__for_character_range_ (a_attrs: detachable NS_DICTIONARY; a_char_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_attrs__item: POINTER
		do
			if attached a_attrs as a_attrs_attached then
				a_attrs__item := a_attrs_attached.item
			end
			objc_set_temporary_attributes__for_character_range_ (item, a_attrs__item, a_char_range.item)
		end

	add_temporary_attributes__for_character_range_ (a_attrs: detachable NS_DICTIONARY; a_char_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_attrs__item: POINTER
		do
			if attached a_attrs as a_attrs_attached then
				a_attrs__item := a_attrs_attached.item
			end
			objc_add_temporary_attributes__for_character_range_ (item, a_attrs__item, a_char_range.item)
		end

	remove_temporary_attribute__for_character_range_ (a_attr_name: detachable NS_STRING; a_char_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_attr_name__item: POINTER
		do
			if attached a_attr_name as a_attr_name_attached then
				a_attr_name__item := a_attr_name_attached.item
			end
			objc_remove_temporary_attribute__for_character_range_ (item, a_attr_name__item, a_char_range.item)
		end

--	temporary_attribute__at_character_index__effective_range_ (a_attr_name: detachable NS_STRING; a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_attr_name__item: POINTER
--			a_range__item: POINTER
--		do
--			if attached a_attr_name as a_attr_name_attached then
--				a_attr_name__item := a_attr_name_attached.item
--			end
--			if attached a_range as a_range_attached then
--				a_range__item := a_range_attached.item
--			end
--			result_pointer := objc_temporary_attribute__at_character_index__effective_range_ (item, a_attr_name__item, a_location, a_range__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like temporary_attribute__at_character_index__effective_range_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like temporary_attribute__at_character_index__effective_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	temporary_attribute__at_character_index__longest_effective_range__in_range_ (a_attr_name: detachable NS_STRING; a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE; a_range_limit: NS_RANGE): detachable NS_OBJECT
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_attr_name__item: POINTER
--			a_range__item: POINTER
--		do
--			if attached a_attr_name as a_attr_name_attached then
--				a_attr_name__item := a_attr_name_attached.item
--			end
--			if attached a_range as a_range_attached then
--				a_range__item := a_range_attached.item
--			end
--			result_pointer := objc_temporary_attribute__at_character_index__longest_effective_range__in_range_ (item, a_attr_name__item, a_location, a_range__item, a_range_limit.item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like temporary_attribute__at_character_index__longest_effective_range__in_range_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like temporary_attribute__at_character_index__longest_effective_range__in_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

--	temporary_attributes_at_character_index__longest_effective_range__in_range_ (a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE; a_range_limit: NS_RANGE): detachable NS_DICTIONARY
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_range__item: POINTER
--		do
--			if attached a_range as a_range_attached then
--				a_range__item := a_range_attached.item
--			end
--			result_pointer := objc_temporary_attributes_at_character_index__longest_effective_range__in_range_ (item, a_location, a_range__item, a_range_limit.item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like temporary_attributes_at_character_index__longest_effective_range__in_range_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like temporary_attributes_at_character_index__longest_effective_range__in_range_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	add_temporary_attribute__value__for_character_range_ (a_attr_name: detachable NS_STRING; a_value: detachable NS_OBJECT; a_char_range: NS_RANGE)
			-- Auto generated Objective-C wrapper.
		local
			a_attr_name__item: POINTER
			a_value__item: POINTER
		do
			if attached a_attr_name as a_attr_name_attached then
				a_attr_name__item := a_attr_name_attached.item
			end
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			objc_add_temporary_attribute__value__for_character_range_ (item, a_attr_name__item, a_value__item, a_char_range.item)
		end

	substitute_font_for_font_ (a_original_font: detachable NS_FONT): detachable NS_FONT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_original_font__item: POINTER
		do
			if attached a_original_font as a_original_font_attached then
				a_original_font__item := a_original_font_attached.item
			end
			result_pointer := objc_substitute_font_for_font_ (item, a_original_font__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like substitute_font_for_font_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like substitute_font_for_font_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	default_line_height_for_font_ (a_the_font: detachable NS_FONT): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_the_font__item: POINTER
		do
			if attached a_the_font as a_the_font_attached then
				a_the_font__item := a_the_font_attached.item
			end
			Result := objc_default_line_height_for_font_ (item, a_the_font__item)
		end

	default_baseline_offset_for_font_ (a_the_font: detachable NS_FONT): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_the_font__item: POINTER
		do
			if attached a_the_font as a_the_font_attached then
				a_the_font__item := a_the_font_attached.item
			end
			Result := objc_default_baseline_offset_for_font_ (item, a_the_font__item)
		end

	uses_font_leading: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_uses_font_leading (item)
		end

	set_uses_font_leading_ (a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_uses_font_leading_ (item, a_flag)
		end

feature {NONE} -- NSLayoutManager Externals

	objc_text_storage (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLayoutManager *)$an_item textStorage];
			 ]"
		end

	objc_set_text_storage_ (an_item: POINTER; a_text_storage: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setTextStorage:$a_text_storage];
			 ]"
		end

	objc_attributed_string (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLayoutManager *)$an_item attributedString];
			 ]"
		end

	objc_replace_text_storage_ (an_item: POINTER; a_new_text_storage: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item replaceTextStorage:$a_new_text_storage];
			 ]"
		end

	objc_glyph_generator (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLayoutManager *)$an_item glyphGenerator];
			 ]"
		end

	objc_set_glyph_generator_ (an_item: POINTER; a_glyph_generator: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setGlyphGenerator:$a_glyph_generator];
			 ]"
		end

	objc_typesetter (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLayoutManager *)$an_item typesetter];
			 ]"
		end

	objc_set_typesetter_ (an_item: POINTER; a_typesetter: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setTypesetter:$a_typesetter];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLayoutManager *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_text_containers (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLayoutManager *)$an_item textContainers];
			 ]"
		end

	objc_add_text_container_ (an_item: POINTER; a_container: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item addTextContainer:$a_container];
			 ]"
		end

	objc_insert_text_container__at_index_ (an_item: POINTER; a_container: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item insertTextContainer:$a_container atIndex:$a_index];
			 ]"
		end

	objc_remove_text_container_at_index_ (an_item: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item removeTextContainerAtIndex:$a_index];
			 ]"
		end

	objc_text_container_changed_geometry_ (an_item: POINTER; a_container: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item textContainerChangedGeometry:$a_container];
			 ]"
		end

	objc_text_container_changed_text_view_ (an_item: POINTER; a_container: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item textContainerChangedTextView:$a_container];
			 ]"
		end

	objc_set_background_layout_enabled_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setBackgroundLayoutEnabled:$a_flag];
			 ]"
		end

	objc_background_layout_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item backgroundLayoutEnabled];
			 ]"
		end

	objc_set_uses_screen_fonts_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setUsesScreenFonts:$a_flag];
			 ]"
		end

	objc_uses_screen_fonts (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item usesScreenFonts];
			 ]"
		end

	objc_set_shows_invisible_characters_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setShowsInvisibleCharacters:$a_flag];
			 ]"
		end

	objc_shows_invisible_characters (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item showsInvisibleCharacters];
			 ]"
		end

	objc_set_shows_control_characters_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setShowsControlCharacters:$a_flag];
			 ]"
		end

	objc_shows_control_characters (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item showsControlCharacters];
			 ]"
		end

	objc_set_hyphenation_factor_ (an_item: POINTER; a_factor: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setHyphenationFactor:$a_factor];
			 ]"
		end

	objc_hyphenation_factor (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item hyphenationFactor];
			 ]"
		end

	objc_set_default_attachment_scaling_ (an_item: POINTER; a_scaling: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setDefaultAttachmentScaling:$a_scaling];
			 ]"
		end

	objc_default_attachment_scaling (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item defaultAttachmentScaling];
			 ]"
		end

	objc_set_typesetter_behavior_ (an_item: POINTER; a_the_behavior: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setTypesetterBehavior:$a_the_behavior];
			 ]"
		end

	objc_typesetter_behavior (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item typesetterBehavior];
			 ]"
		end

	objc_layout_options (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item layoutOptions];
			 ]"
		end

	objc_set_allows_non_contiguous_layout_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setAllowsNonContiguousLayout:$a_flag];
			 ]"
		end

	objc_allows_non_contiguous_layout (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item allowsNonContiguousLayout];
			 ]"
		end

	objc_has_non_contiguous_layout (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item hasNonContiguousLayout];
			 ]"
		end

--	objc_invalidate_glyphs_for_character_range__change_in_length__actual_character_range_ (an_item: POINTER; a_char_range: POINTER; a_delta: INTEGER_64; a_actual_char_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSLayoutManager *)$an_item invalidateGlyphsForCharacterRange:*((NSRange *)$a_char_range) changeInLength:$a_delta actualCharacterRange:];
--			 ]"
--		end

--	objc_invalidate_layout_for_character_range__actual_character_range_ (an_item: POINTER; a_char_range: POINTER; a_actual_char_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSLayoutManager *)$an_item invalidateLayoutForCharacterRange:*((NSRange *)$a_char_range) actualCharacterRange:];
--			 ]"
--		end

--	objc_invalidate_layout_for_character_range__is_soft__actual_character_range_ (an_item: POINTER; a_char_range: POINTER; a_flag: BOOLEAN; a_actual_char_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSLayoutManager *)$an_item invalidateLayoutForCharacterRange:*((NSRange *)$a_char_range) isSoft:$a_flag actualCharacterRange:];
--			 ]"
--		end

	objc_invalidate_display_for_character_range_ (an_item: POINTER; a_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item invalidateDisplayForCharacterRange:*((NSRange *)$a_char_range)];
			 ]"
		end

	objc_invalidate_display_for_glyph_range_ (an_item: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item invalidateDisplayForGlyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

	objc_text_storage__edited__range__change_in_length__invalidated_range_ (an_item: POINTER; a_str: POINTER; a_edited_mask: NATURAL_64; a_new_char_range: POINTER; a_delta: INTEGER_64; a_invalidated_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item textStorage:$a_str edited:$a_edited_mask range:*((NSRange *)$a_new_char_range) changeInLength:$a_delta invalidatedRange:*((NSRange *)$a_invalidated_char_range)];
			 ]"
		end

	objc_ensure_glyphs_for_character_range_ (an_item: POINTER; a_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item ensureGlyphsForCharacterRange:*((NSRange *)$a_char_range)];
			 ]"
		end

	objc_ensure_glyphs_for_glyph_range_ (an_item: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item ensureGlyphsForGlyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

	objc_ensure_layout_for_character_range_ (an_item: POINTER; a_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item ensureLayoutForCharacterRange:*((NSRange *)$a_char_range)];
			 ]"
		end

	objc_ensure_layout_for_glyph_range_ (an_item: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item ensureLayoutForGlyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

	objc_ensure_layout_for_text_container_ (an_item: POINTER; a_container: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item ensureLayoutForTextContainer:$a_container];
			 ]"
		end

	objc_ensure_layout_for_bounding_rect__in_text_container_ (an_item: POINTER; a_bounds: POINTER; a_container: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item ensureLayoutForBoundingRect:*((NSRect *)$a_bounds) inTextContainer:$a_container];
			 ]"
		end

--	objc_insert_glyphs__length__for_starting_glyph_at_index__character_index_ (an_item: POINTER; a_glyphs: UNSUPPORTED_TYPE; a_length: NATURAL_64; a_glyph_index: NATURAL_64; a_char_index: NATURAL_64)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSLayoutManager *)$an_item insertGlyphs: length:$a_length forStartingGlyphAtIndex:$a_glyph_index characterIndex:$a_char_index];
--			 ]"
--		end

	objc_insert_glyph__at_glyph_index__character_index_ (an_item: POINTER; a_glyph: NATURAL_32; a_glyph_index: NATURAL_64; a_char_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item insertGlyph:$a_glyph atGlyphIndex:$a_glyph_index characterIndex:$a_char_index];
			 ]"
		end

	objc_replace_glyph_at_index__with_glyph_ (an_item: POINTER; a_glyph_index: NATURAL_64; a_new_glyph: NATURAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item replaceGlyphAtIndex:$a_glyph_index withGlyph:$a_new_glyph];
			 ]"
		end

	objc_delete_glyphs_in_range_ (an_item: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item deleteGlyphsInRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

	objc_set_character_index__for_glyph_at_index_ (an_item: POINTER; a_char_index: NATURAL_64; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setCharacterIndex:$a_char_index forGlyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_set_int_attribute__value__for_glyph_at_index_ (an_item: POINTER; a_attribute_tag: INTEGER_64; a_val: INTEGER_64; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setIntAttribute:$a_attribute_tag value:$a_val forGlyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_invalidate_glyphs_on_layout_invalidation_for_glyph_range_ (an_item: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item invalidateGlyphsOnLayoutInvalidationForGlyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

	objc_number_of_glyphs (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item numberOfGlyphs];
			 ]"
		end

--	objc_glyph_at_index__is_valid_index_ (an_item: POINTER; a_glyph_index: NATURAL_64; a_is_valid_index: UNSUPPORTED_TYPE): NATURAL_32
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSLayoutManager *)$an_item glyphAtIndex:$a_glyph_index isValidIndex:];
--			 ]"
--		end

	objc_glyph_at_index_ (an_item: POINTER; a_glyph_index: NATURAL_64): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item glyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_is_valid_glyph_index_ (an_item: POINTER; a_glyph_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item isValidGlyphIndex:$a_glyph_index];
			 ]"
		end

	objc_character_index_for_glyph_at_index_ (an_item: POINTER; a_glyph_index: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item characterIndexForGlyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_glyph_index_for_character_at_index_ (an_item: POINTER; a_char_index: NATURAL_64): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item glyphIndexForCharacterAtIndex:$a_char_index];
			 ]"
		end

	objc_int_attribute__for_glyph_at_index_ (an_item: POINTER; a_attribute_tag: INTEGER_64; a_glyph_index: NATURAL_64): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item intAttribute:$a_attribute_tag forGlyphAtIndex:$a_glyph_index];
			 ]"
		end

--	objc_get_glyphs_in_range__glyphs__character_indexes__glyph_inscriptions__elastic_bits_ (an_item: POINTER; a_glyph_range: POINTER; a_glyph_buffer: UNSUPPORTED_TYPE; a_char_index_buffer: UNSUPPORTED_TYPE; a_inscribe_buffer: UNSUPPORTED_TYPE; a_elastic_buffer: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSLayoutManager *)$an_item getGlyphsInRange:*((NSRange *)$a_glyph_range) glyphs: characterIndexes: glyphInscriptions: elasticBits:];
--			 ]"
--		end

--	objc_get_glyphs_in_range__glyphs__character_indexes__glyph_inscriptions__elastic_bits__bidi_levels_ (an_item: POINTER; a_glyph_range: POINTER; a_glyph_buffer: UNSUPPORTED_TYPE; a_char_index_buffer: UNSUPPORTED_TYPE; a_inscribe_buffer: UNSUPPORTED_TYPE; a_elastic_buffer: UNSUPPORTED_TYPE; a_bidi_level_buffer: POINTER): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSLayoutManager *)$an_item getGlyphsInRange:*((NSRange *)$a_glyph_range) glyphs: characterIndexes: glyphInscriptions: elasticBits: bidiLevels:$a_bidi_level_buffer];
--			 ]"
--		end

--	objc_get_glyphs__range_ (an_item: POINTER; a_glyph_array: UNSUPPORTED_TYPE; a_glyph_range: POINTER): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSLayoutManager *)$an_item getGlyphs: range:*((NSRange *)$a_glyph_range)];
--			 ]"
--		end

	objc_set_text_container__for_glyph_range_ (an_item: POINTER; a_container: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setTextContainer:$a_container forGlyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

	objc_set_line_fragment_rect__for_glyph_range__used_rect_ (an_item: POINTER; a_fragment_rect: POINTER; a_glyph_range: POINTER; a_used_rect: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setLineFragmentRect:*((NSRect *)$a_fragment_rect) forGlyphRange:*((NSRange *)$a_glyph_range) usedRect:*((NSRect *)$a_used_rect)];
			 ]"
		end

	objc_set_extra_line_fragment_rect__used_rect__text_container_ (an_item: POINTER; a_fragment_rect: POINTER; a_used_rect: POINTER; a_container: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setExtraLineFragmentRect:*((NSRect *)$a_fragment_rect) usedRect:*((NSRect *)$a_used_rect) textContainer:$a_container];
			 ]"
		end

	objc_set_location__for_start_of_glyph_range_ (an_item: POINTER; a_location: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setLocation:*((NSPoint *)$a_location) forStartOfGlyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

--	objc_set_locations__starting_glyph_indexes__count__for_glyph_range_ (an_item: POINTER; a_locations: UNSUPPORTED_TYPE; a_glyph_indexes: UNSUPPORTED_TYPE; a_count: NATURAL_64; a_glyph_range: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSLayoutManager *)$an_item setLocations: startingGlyphIndexes: count:$a_count forGlyphRange:*((NSRange *)$a_glyph_range)];
--			 ]"
--		end

	objc_set_not_shown_attribute__for_glyph_at_index_ (an_item: POINTER; a_flag: BOOLEAN; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setNotShownAttribute:$a_flag forGlyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_set_draws_outside_line_fragment__for_glyph_at_index_ (an_item: POINTER; a_flag: BOOLEAN; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setDrawsOutsideLineFragment:$a_flag forGlyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_set_attachment_size__for_glyph_range_ (an_item: POINTER; a_attachment_size: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setAttachmentSize:*((NSSize *)$a_attachment_size) forGlyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

--	objc_get_first_unlaid_character_index__glyph_index_ (an_item: POINTER; a_char_index: UNSUPPORTED_TYPE; a_glyph_index: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSLayoutManager *)$an_item getFirstUnlaidCharacterIndex: glyphIndex:];
--			 ]"
--		end

	objc_first_unlaid_character_index (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item firstUnlaidCharacterIndex];
			 ]"
		end

	objc_first_unlaid_glyph_index (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item firstUnlaidGlyphIndex];
			 ]"
		end

--	objc_text_container_for_glyph_at_index__effective_range_ (an_item: POINTER; a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSLayoutManager *)$an_item textContainerForGlyphAtIndex:$a_glyph_index effectiveRange:];
--			 ]"
--		end

	objc_used_rect_for_text_container_ (an_item: POINTER; result_pointer: POINTER; a_container: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSLayoutManager *)$an_item usedRectForTextContainer:$a_container];
			 ]"
		end

	objc_line_fragment_rect_for_glyph_at_index__effective_range_ (an_item: POINTER; result_pointer: POINTER; a_glyph_index: NATURAL_64; a_effective_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSLayoutManager *)$an_item lineFragmentRectForGlyphAtIndex:$a_glyph_index effectiveRange:$a_effective_glyph_range];
			 ]"
		end

--	objc_line_fragment_used_rect_for_glyph_at_index__effective_range_ (an_item: POINTER; result_pointer: POINTER; a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				*(NSRect *)$result_pointer = [(NSLayoutManager *)$an_item lineFragmentUsedRectForGlyphAtIndex:$a_glyph_index effectiveRange:];
--			 ]"
--		end

--	objc_line_fragment_rect_for_glyph_at_index__effective_range__without_additional_layout_ (an_item: POINTER; result_pointer: POINTER; a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE; a_flag: BOOLEAN)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				*(NSRect *)$result_pointer = [(NSLayoutManager *)$an_item lineFragmentRectForGlyphAtIndex:$a_glyph_index effectiveRange: withoutAdditionalLayout:$a_flag];
--			 ]"
--		end

--	objc_line_fragment_used_rect_for_glyph_at_index__effective_range__without_additional_layout_ (an_item: POINTER; result_pointer: POINTER; a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE; a_flag: BOOLEAN)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				*(NSRect *)$result_pointer = [(NSLayoutManager *)$an_item lineFragmentUsedRectForGlyphAtIndex:$a_glyph_index effectiveRange: withoutAdditionalLayout:$a_flag];
--			 ]"
--		end

--	objc_text_container_for_glyph_at_index__effective_range__without_additional_layout_ (an_item: POINTER; a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE; a_flag: BOOLEAN): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSLayoutManager *)$an_item textContainerForGlyphAtIndex:$a_glyph_index effectiveRange: withoutAdditionalLayout:$a_flag];
--			 ]"
--		end

	objc_extra_line_fragment_rect (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSLayoutManager *)$an_item extraLineFragmentRect];
			 ]"
		end

	objc_extra_line_fragment_used_rect (an_item: POINTER; result_pointer: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSLayoutManager *)$an_item extraLineFragmentUsedRect];
			 ]"
		end

	objc_extra_line_fragment_text_container (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLayoutManager *)$an_item extraLineFragmentTextContainer];
			 ]"
		end

	objc_location_for_glyph_at_index_ (an_item: POINTER; result_pointer: POINTER; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSPoint *)$result_pointer = [(NSLayoutManager *)$an_item locationForGlyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_not_shown_attribute_for_glyph_at_index_ (an_item: POINTER; a_glyph_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item notShownAttributeForGlyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_draws_outside_line_fragment_for_glyph_at_index_ (an_item: POINTER; a_glyph_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item drawsOutsideLineFragmentForGlyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_attachment_size_for_glyph_at_index_ (an_item: POINTER; result_pointer: POINTER; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSSize *)$result_pointer = [(NSLayoutManager *)$an_item attachmentSizeForGlyphAtIndex:$a_glyph_index];
			 ]"
		end

	objc_set_layout_rect__for_text_block__glyph_range_ (an_item: POINTER; a_rect: POINTER; a_block: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setLayoutRect:*((NSRect *)$a_rect) forTextBlock:$a_block glyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

	objc_set_bounds_rect__for_text_block__glyph_range_ (an_item: POINTER; a_rect: POINTER; a_block: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setBoundsRect:*((NSRect *)$a_rect) forTextBlock:$a_block glyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

	objc_layout_rect_for_text_block__glyph_range_ (an_item: POINTER; result_pointer: POINTER; a_block: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSLayoutManager *)$an_item layoutRectForTextBlock:$a_block glyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

	objc_bounds_rect_for_text_block__glyph_range_ (an_item: POINTER; result_pointer: POINTER; a_block: POINTER; a_glyph_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSLayoutManager *)$an_item boundsRectForTextBlock:$a_block glyphRange:*((NSRange *)$a_glyph_range)];
			 ]"
		end

--	objc_layout_rect_for_text_block__at_index__effective_range_ (an_item: POINTER; result_pointer: POINTER; a_block: POINTER; a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				*(NSRect *)$result_pointer = [(NSLayoutManager *)$an_item layoutRectForTextBlock:$a_block atIndex:$a_glyph_index effectiveRange:];
--			 ]"
--		end

--	objc_bounds_rect_for_text_block__at_index__effective_range_ (an_item: POINTER; result_pointer: POINTER; a_block: POINTER; a_glyph_index: NATURAL_64; a_effective_glyph_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				*(NSRect *)$result_pointer = [(NSLayoutManager *)$an_item boundsRectForTextBlock:$a_block atIndex:$a_glyph_index effectiveRange:];
--			 ]"
--		end

--	objc_glyph_range_for_character_range__actual_character_range_ (an_item: POINTER; result_pointer: POINTER; a_char_range: POINTER; a_actual_char_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				*(NSRange *)$result_pointer = [(NSLayoutManager *)$an_item glyphRangeForCharacterRange:*((NSRange *)$a_char_range) actualCharacterRange:];
--			 ]"
--		end

--	objc_character_range_for_glyph_range__actual_glyph_range_ (an_item: POINTER; result_pointer: POINTER; a_glyph_range: POINTER; a_actual_glyph_range: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				*(NSRange *)$result_pointer = [(NSLayoutManager *)$an_item characterRangeForGlyphRange:*((NSRange *)$a_glyph_range) actualGlyphRange:];
--			 ]"
--		end

	objc_glyph_range_for_text_container_ (an_item: POINTER; result_pointer: POINTER; a_container: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSLayoutManager *)$an_item glyphRangeForTextContainer:$a_container];
			 ]"
		end

	objc_range_of_nominally_spaced_glyphs_containing_index_ (an_item: POINTER; result_pointer: POINTER; a_glyph_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSLayoutManager *)$an_item rangeOfNominallySpacedGlyphsContainingIndex:$a_glyph_index];
			 ]"
		end

--	objc_rect_array_for_character_range__within_selected_character_range__in_text_container__rect_count_ (an_item: POINTER; a_char_range: POINTER; a_sel_char_range: POINTER; a_container: POINTER; a_rect_count: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSLayoutManager *)$an_item rectArrayForCharacterRange:*((NSRange *)$a_char_range) withinSelectedCharacterRange:*((NSRange *)$a_sel_char_range) inTextContainer:$a_container rectCount:];
--			 ]"
--		end

--	objc_rect_array_for_glyph_range__within_selected_glyph_range__in_text_container__rect_count_ (an_item: POINTER; a_glyph_range: POINTER; a_sel_glyph_range: POINTER; a_container: POINTER; a_rect_count: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSLayoutManager *)$an_item rectArrayForGlyphRange:*((NSRange *)$a_glyph_range) withinSelectedGlyphRange:*((NSRange *)$a_sel_glyph_range) inTextContainer:$a_container rectCount:];
--			 ]"
--		end

	objc_bounding_rect_for_glyph_range__in_text_container_ (an_item: POINTER; result_pointer: POINTER; a_glyph_range: POINTER; a_container: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRect *)$result_pointer = [(NSLayoutManager *)$an_item boundingRectForGlyphRange:*((NSRange *)$a_glyph_range) inTextContainer:$a_container];
			 ]"
		end

	objc_glyph_range_for_bounding_rect__in_text_container_ (an_item: POINTER; result_pointer: POINTER; a_bounds: POINTER; a_container: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSLayoutManager *)$an_item glyphRangeForBoundingRect:*((NSRect *)$a_bounds) inTextContainer:$a_container];
			 ]"
		end

	objc_glyph_range_for_bounding_rect_without_additional_layout__in_text_container_ (an_item: POINTER; result_pointer: POINTER; a_bounds: POINTER; a_container: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				*(NSRange *)$result_pointer = [(NSLayoutManager *)$an_item glyphRangeForBoundingRectWithoutAdditionalLayout:*((NSRect *)$a_bounds) inTextContainer:$a_container];
			 ]"
		end

--	objc_glyph_index_for_point__in_text_container__fraction_of_distance_through_glyph_ (an_item: POINTER; a_point: POINTER; a_container: POINTER; a_partial_fraction: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSLayoutManager *)$an_item glyphIndexForPoint:*((NSPoint *)$a_point) inTextContainer:$a_container fractionOfDistanceThroughGlyph:];
--			 ]"
--		end

	objc_glyph_index_for_point__in_text_container_ (an_item: POINTER; a_point: POINTER; a_container: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item glyphIndexForPoint:*((NSPoint *)$a_point) inTextContainer:$a_container];
			 ]"
		end

	objc_fraction_of_distance_through_glyph_for_point__in_text_container_ (an_item: POINTER; a_point: POINTER; a_container: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item fractionOfDistanceThroughGlyphForPoint:*((NSPoint *)$a_point) inTextContainer:$a_container];
			 ]"
		end

--	objc_character_index_for_point__in_text_container__fraction_of_distance_between_insertion_points_ (an_item: POINTER; a_point: POINTER; a_container: POINTER; a_partial_fraction: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSLayoutManager *)$an_item characterIndexForPoint:*((NSPoint *)$a_point) inTextContainer:$a_container fractionOfDistanceBetweenInsertionPoints:];
--			 ]"
--		end

--	objc_get_line_fragment_insertion_points_for_character_at_index__alternate_positions__in_display_order__positions__character_indexes_ (an_item: POINTER; a_char_index: NATURAL_64; a_flag: BOOLEAN; a_d_flag: BOOLEAN; a_positions: UNSUPPORTED_TYPE; a_char_indexes: UNSUPPORTED_TYPE): NATURAL_64
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return [(NSLayoutManager *)$an_item getLineFragmentInsertionPointsForCharacterAtIndex:$a_char_index alternatePositions:$a_flag inDisplayOrder:$a_d_flag positions: characterIndexes:];
--			 ]"
--		end

--	objc_temporary_attributes_at_character_index__effective_range_ (an_item: POINTER; a_char_index: NATURAL_64; a_effective_char_range: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSLayoutManager *)$an_item temporaryAttributesAtCharacterIndex:$a_char_index effectiveRange:];
--			 ]"
--		end

	objc_set_temporary_attributes__for_character_range_ (an_item: POINTER; a_attrs: POINTER; a_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setTemporaryAttributes:$a_attrs forCharacterRange:*((NSRange *)$a_char_range)];
			 ]"
		end

	objc_add_temporary_attributes__for_character_range_ (an_item: POINTER; a_attrs: POINTER; a_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item addTemporaryAttributes:$a_attrs forCharacterRange:*((NSRange *)$a_char_range)];
			 ]"
		end

	objc_remove_temporary_attribute__for_character_range_ (an_item: POINTER; a_attr_name: POINTER; a_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item removeTemporaryAttribute:$a_attr_name forCharacterRange:*((NSRange *)$a_char_range)];
			 ]"
		end

--	objc_temporary_attribute__at_character_index__effective_range_ (an_item: POINTER; a_attr_name: POINTER; a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSLayoutManager *)$an_item temporaryAttribute:$a_attr_name atCharacterIndex:$a_location effectiveRange:];
--			 ]"
--		end

--	objc_temporary_attribute__at_character_index__longest_effective_range__in_range_ (an_item: POINTER; a_attr_name: POINTER; a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE; a_range_limit: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSLayoutManager *)$an_item temporaryAttribute:$a_attr_name atCharacterIndex:$a_location longestEffectiveRange: inRange:*((NSRange *)$a_range_limit)];
--			 ]"
--		end

--	objc_temporary_attributes_at_character_index__longest_effective_range__in_range_ (an_item: POINTER; a_location: NATURAL_64; a_range: UNSUPPORTED_TYPE; a_range_limit: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSLayoutManager *)$an_item temporaryAttributesAtCharacterIndex:$a_location longestEffectiveRange: inRange:*((NSRange *)$a_range_limit)];
--			 ]"
--		end

	objc_add_temporary_attribute__value__for_character_range_ (an_item: POINTER; a_attr_name: POINTER; a_value: POINTER; a_char_range: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item addTemporaryAttribute:$a_attr_name value:$a_value forCharacterRange:*((NSRange *)$a_char_range)];
			 ]"
		end

	objc_substitute_font_for_font_ (an_item: POINTER; a_original_font: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLayoutManager *)$an_item substituteFontForFont:$a_original_font];
			 ]"
		end

	objc_default_line_height_for_font_ (an_item: POINTER; a_the_font: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item defaultLineHeightForFont:$a_the_font];
			 ]"
		end

	objc_default_baseline_offset_for_font_ (an_item: POINTER; a_the_font: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item defaultBaselineOffsetForFont:$a_the_font];
			 ]"
		end

	objc_uses_font_leading (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item usesFontLeading];
			 ]"
		end

	objc_set_uses_font_leading_ (an_item: POINTER; a_flag: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item setUsesFontLeading:$a_flag];
			 ]"
		end

feature -- NSTextViewSupport

	ruler_markers_for_text_view__paragraph_style__ruler_ (a_view: detachable NS_TEXT_VIEW; a_style: detachable NS_PARAGRAPH_STYLE; a_ruler: detachable NS_RULER_VIEW): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_view__item: POINTER
			a_style__item: POINTER
			a_ruler__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_style as a_style_attached then
				a_style__item := a_style_attached.item
			end
			if attached a_ruler as a_ruler_attached then
				a_ruler__item := a_ruler_attached.item
			end
			result_pointer := objc_ruler_markers_for_text_view__paragraph_style__ruler_ (item, a_view__item, a_style__item, a_ruler__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ruler_markers_for_text_view__paragraph_style__ruler_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ruler_markers_for_text_view__paragraph_style__ruler_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	ruler_accessory_view_for_text_view__paragraph_style__ruler__enabled_ (a_view: detachable NS_TEXT_VIEW; a_style: detachable NS_PARAGRAPH_STYLE; a_ruler: detachable NS_RULER_VIEW; a_is_enabled: BOOLEAN): detachable NS_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_view__item: POINTER
			a_style__item: POINTER
			a_ruler__item: POINTER
		do
			if attached a_view as a_view_attached then
				a_view__item := a_view_attached.item
			end
			if attached a_style as a_style_attached then
				a_style__item := a_style_attached.item
			end
			if attached a_ruler as a_ruler_attached then
				a_ruler__item := a_ruler_attached.item
			end
			result_pointer := objc_ruler_accessory_view_for_text_view__paragraph_style__ruler__enabled_ (item, a_view__item, a_style__item, a_ruler__item, a_is_enabled)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like ruler_accessory_view_for_text_view__paragraph_style__ruler__enabled_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like ruler_accessory_view_for_text_view__paragraph_style__ruler__enabled_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	layout_manager_owns_first_responder_in_window_ (a_window: detachable NS_WINDOW): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_window__item: POINTER
		do
			if attached a_window as a_window_attached then
				a_window__item := a_window_attached.item
			end
			Result := objc_layout_manager_owns_first_responder_in_window_ (item, a_window__item)
		end

	first_text_view: detachable NS_TEXT_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_first_text_view (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like first_text_view} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like first_text_view} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	text_view_for_beginning_of_selection: detachable NS_TEXT_VIEW
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_text_view_for_beginning_of_selection (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like text_view_for_beginning_of_selection} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like text_view_for_beginning_of_selection} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	draw_background_for_glyph_range__at_point_ (a_glyphs_to_show: NS_RANGE; a_origin: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_background_for_glyph_range__at_point_ (item, a_glyphs_to_show.item, a_origin.item)
		end

	draw_glyphs_for_glyph_range__at_point_ (a_glyphs_to_show: NS_RANGE; a_origin: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_glyphs_for_glyph_range__at_point_ (item, a_glyphs_to_show.item, a_origin.item)
		end

--	show_packed_glyphs__length__glyph_range__at_point__font__color__printing_adjustment_ (a_glyphs: UNSUPPORTED_TYPE; a_glyph_len: NATURAL_64; a_glyph_range: NS_RANGE; a_point: NS_POINT; a_font: detachable NS_FONT; a_color: detachable NS_COLOR; a_printing_adjustment: NS_SIZE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_font__item: POINTER
--			a_color__item: POINTER
--		do
--			if attached a_font as a_font_attached then
--				a_font__item := a_font_attached.item
--			end
--			if attached a_color as a_color_attached then
--				a_color__item := a_color_attached.item
--			end
--			objc_show_packed_glyphs__length__glyph_range__at_point__font__color__printing_adjustment_ (item, , a_glyph_len, a_glyph_range.item, a_point.item, a_font__item, a_color__item, a_printing_adjustment.item)
--		end

	show_attachment_cell__in_rect__character_index_ (a_cell: detachable NS_CELL; a_rect: NS_RECT; a_attachment_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_cell__item: POINTER
		do
			if attached a_cell as a_cell_attached then
				a_cell__item := a_cell_attached.item
			end
			objc_show_attachment_cell__in_rect__character_index_ (item, a_cell__item, a_rect.item, a_attachment_index)
		end

--	fill_background_rect_array__count__for_character_range__color_ (a_rect_array: UNSUPPORTED_TYPE; a_rect_count: NATURAL_64; a_char_range: NS_RANGE; a_color: detachable NS_COLOR)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_rect_array__item: POINTER
--			a_color__item: POINTER
--		do
--			if attached a_rect_array as a_rect_array_attached then
--				a_rect_array__item := a_rect_array_attached.item
--			end
--			if attached a_color as a_color_attached then
--				a_color__item := a_color_attached.item
--			end
--			objc_fill_background_rect_array__count__for_character_range__color_ (item, a_rect_array__item, a_rect_count, a_char_range.item, a_color__item)
--		end

	draw_underline_for_glyph_range__underline_type__baseline_offset__line_fragment_rect__line_fragment_glyph_range__container_origin_ (a_glyph_range: NS_RANGE; a_underline_val: INTEGER_64; a_baseline_offset: REAL_64; a_line_rect: NS_RECT; a_line_glyph_range: NS_RANGE; a_container_origin: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_underline_for_glyph_range__underline_type__baseline_offset__line_fragment_rect__line_fragment_glyph_range__container_origin_ (item, a_glyph_range.item, a_underline_val, a_baseline_offset, a_line_rect.item, a_line_glyph_range.item, a_container_origin.item)
		end

	underline_glyph_range__underline_type__line_fragment_rect__line_fragment_glyph_range__container_origin_ (a_glyph_range: NS_RANGE; a_underline_val: INTEGER_64; a_line_rect: NS_RECT; a_line_glyph_range: NS_RANGE; a_container_origin: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_underline_glyph_range__underline_type__line_fragment_rect__line_fragment_glyph_range__container_origin_ (item, a_glyph_range.item, a_underline_val, a_line_rect.item, a_line_glyph_range.item, a_container_origin.item)
		end

	draw_strikethrough_for_glyph_range__strikethrough_type__baseline_offset__line_fragment_rect__line_fragment_glyph_range__container_origin_ (a_glyph_range: NS_RANGE; a_strikethrough_val: INTEGER_64; a_baseline_offset: REAL_64; a_line_rect: NS_RECT; a_line_glyph_range: NS_RANGE; a_container_origin: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_draw_strikethrough_for_glyph_range__strikethrough_type__baseline_offset__line_fragment_rect__line_fragment_glyph_range__container_origin_ (item, a_glyph_range.item, a_strikethrough_val, a_baseline_offset, a_line_rect.item, a_line_glyph_range.item, a_container_origin.item)
		end

	strikethrough_glyph_range__strikethrough_type__line_fragment_rect__line_fragment_glyph_range__container_origin_ (a_glyph_range: NS_RANGE; a_strikethrough_val: INTEGER_64; a_line_rect: NS_RECT; a_line_glyph_range: NS_RANGE; a_container_origin: NS_POINT)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_strikethrough_glyph_range__strikethrough_type__line_fragment_rect__line_fragment_glyph_range__container_origin_ (item, a_glyph_range.item, a_strikethrough_val, a_line_rect.item, a_line_glyph_range.item, a_container_origin.item)
		end

feature {NONE} -- NSTextViewSupport Externals

	objc_ruler_markers_for_text_view__paragraph_style__ruler_ (an_item: POINTER; a_view: POINTER; a_style: POINTER; a_ruler: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLayoutManager *)$an_item rulerMarkersForTextView:$a_view paragraphStyle:$a_style ruler:$a_ruler];
			 ]"
		end

	objc_ruler_accessory_view_for_text_view__paragraph_style__ruler__enabled_ (an_item: POINTER; a_view: POINTER; a_style: POINTER; a_ruler: POINTER; a_is_enabled: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLayoutManager *)$an_item rulerAccessoryViewForTextView:$a_view paragraphStyle:$a_style ruler:$a_ruler enabled:$a_is_enabled];
			 ]"
		end

	objc_layout_manager_owns_first_responder_in_window_ (an_item: POINTER; a_window: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSLayoutManager *)$an_item layoutManagerOwnsFirstResponderInWindow:$a_window];
			 ]"
		end

	objc_first_text_view (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLayoutManager *)$an_item firstTextView];
			 ]"
		end

	objc_text_view_for_beginning_of_selection (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSLayoutManager *)$an_item textViewForBeginningOfSelection];
			 ]"
		end

	objc_draw_background_for_glyph_range__at_point_ (an_item: POINTER; a_glyphs_to_show: POINTER; a_origin: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item drawBackgroundForGlyphRange:*((NSRange *)$a_glyphs_to_show) atPoint:*((NSPoint *)$a_origin)];
			 ]"
		end

	objc_draw_glyphs_for_glyph_range__at_point_ (an_item: POINTER; a_glyphs_to_show: POINTER; a_origin: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item drawGlyphsForGlyphRange:*((NSRange *)$a_glyphs_to_show) atPoint:*((NSPoint *)$a_origin)];
			 ]"
		end

--	objc_show_packed_glyphs__length__glyph_range__at_point__font__color__printing_adjustment_ (an_item: POINTER; a_glyphs: POINTER; a_glyph_len: NATURAL_64; a_glyph_range: POINTER; a_point: POINTER; a_font: POINTER; a_color: POINTER; a_printing_adjustment: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSLayoutManager *)$an_item showPackedGlyphs:$a_glyphs length:$a_glyph_len glyphRange:*((NSRange *)$a_glyph_range) atPoint:*((NSPoint *)$a_point) font:$a_font color:$a_color printingAdjustment:*((NSSize *)$a_printing_adjustment)];
--			 ]"
--		end

	objc_show_attachment_cell__in_rect__character_index_ (an_item: POINTER; a_cell: POINTER; a_rect: POINTER; a_attachment_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item showAttachmentCell:$a_cell inRect:*((NSRect *)$a_rect) characterIndex:$a_attachment_index];
			 ]"
		end

--	objc_fill_background_rect_array__count__for_character_range__color_ (an_item: POINTER; a_rect_array: UNSUPPORTED_TYPE; a_rect_count: NATURAL_64; a_char_range: POINTER; a_color: POINTER)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <AppKit/AppKit.h>"
--		alias
--			"[
--				[(NSLayoutManager *)$an_item fillBackgroundRectArray: count:$a_rect_count forCharacterRange:*((NSRange *)$a_char_range) color:$a_color];
--			 ]"
--		end

	objc_draw_underline_for_glyph_range__underline_type__baseline_offset__line_fragment_rect__line_fragment_glyph_range__container_origin_ (an_item: POINTER; a_glyph_range: POINTER; a_underline_val: INTEGER_64; a_baseline_offset: REAL_64; a_line_rect: POINTER; a_line_glyph_range: POINTER; a_container_origin: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item drawUnderlineForGlyphRange:*((NSRange *)$a_glyph_range) underlineType:$a_underline_val baselineOffset:$a_baseline_offset lineFragmentRect:*((NSRect *)$a_line_rect) lineFragmentGlyphRange:*((NSRange *)$a_line_glyph_range) containerOrigin:*((NSPoint *)$a_container_origin)];
			 ]"
		end

	objc_underline_glyph_range__underline_type__line_fragment_rect__line_fragment_glyph_range__container_origin_ (an_item: POINTER; a_glyph_range: POINTER; a_underline_val: INTEGER_64; a_line_rect: POINTER; a_line_glyph_range: POINTER; a_container_origin: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item underlineGlyphRange:*((NSRange *)$a_glyph_range) underlineType:$a_underline_val lineFragmentRect:*((NSRect *)$a_line_rect) lineFragmentGlyphRange:*((NSRange *)$a_line_glyph_range) containerOrigin:*((NSPoint *)$a_container_origin)];
			 ]"
		end

	objc_draw_strikethrough_for_glyph_range__strikethrough_type__baseline_offset__line_fragment_rect__line_fragment_glyph_range__container_origin_ (an_item: POINTER; a_glyph_range: POINTER; a_strikethrough_val: INTEGER_64; a_baseline_offset: REAL_64; a_line_rect: POINTER; a_line_glyph_range: POINTER; a_container_origin: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item drawStrikethroughForGlyphRange:*((NSRange *)$a_glyph_range) strikethroughType:$a_strikethrough_val baselineOffset:$a_baseline_offset lineFragmentRect:*((NSRect *)$a_line_rect) lineFragmentGlyphRange:*((NSRange *)$a_line_glyph_range) containerOrigin:*((NSPoint *)$a_container_origin)];
			 ]"
		end

	objc_strikethrough_glyph_range__strikethrough_type__line_fragment_rect__line_fragment_glyph_range__container_origin_ (an_item: POINTER; a_glyph_range: POINTER; a_strikethrough_val: INTEGER_64; a_line_rect: POINTER; a_line_glyph_range: POINTER; a_container_origin: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSLayoutManager *)$an_item strikethroughGlyphRange:*((NSRange *)$a_glyph_range) strikethroughType:$a_strikethrough_val lineFragmentRect:*((NSRect *)$a_line_rect) lineFragmentGlyphRange:*((NSRange *)$a_line_glyph_range) containerOrigin:*((NSPoint *)$a_container_origin)];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSLayoutManager"
		end

end

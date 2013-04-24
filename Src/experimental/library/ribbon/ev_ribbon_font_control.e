note
	description: "[
					To simplify the integration and configuration of font support in applications that require word 
					processing and text editing capabilities, the Windows Ribbon framework provides a specialized 
					Font Control that exposes a wide range of font properties such as typeface name, style, point 
					size, and effects.
					
					http://msdn.microsoft.com/en-us/library/dd940498(v=VS.85).aspx
																													]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_FONT_CONTROL

inherit
	EV_RIBBON_BUTTON
		redefine
			execute,
			update_property
		end

feature -- Command

	update_properties
			-- Update all font properties
		do
			font_control_properties
		end

feature -- Query

	background_color: detachable EV_COLOR
			-- Background color

	background_color_type: NATURAL_32
			-- Background color type

	bold: NATURAL_32
			-- Bold

	changed_properties: detachable EV_PROPERTY_STORE
			-- List of changed properties

	delta_size: NATURAL_32
			-- Delta size

	family: detachable STRING_32
			-- Family

	foreground_color: detachable EV_COLOR
			-- Foreground color

	foreground_color_type: INTEGER
			-- Foreground color type

	italic: INTEGER
			-- Italic

	size: REAL_64
			-- Size

	strikethrough: INTEGER
			-- Strikethrough

	underline: INTEGER
			-- Underline

	vertical_positioning: INTEGER
			-- Vertical positioning

feature {NONE} -- Implementation

	font_control_properties
			-- Query font control properties
		local
			l_command_id: NATURAL_32
			l_enum: EV_UI_INVALIDATIONS_ENUM
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
			l_property_store: EV_PROPERTY_STORE
		do
			if command_list.count > 0 then
				l_command_id := command_list.item (command_list.lower)
				check command_id_valid: l_command_id /= 0 end

				if attached ribbon as l_ribbon then
					create l_key.make_font_properties
					create l_enum
					create l_value.make_empty
					l_ribbon.get_command_property (l_command_id, l_key, l_value)

					create l_property_store.share_with_pointer (l_value.iunknown_value)
					update_with_property_store (l_property_store)
				end
			end
		end

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER_32; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		local
			l_key: EV_PROPERTY_KEY
--			l_property_set: EV_SIMPLE_PROPERTY_SET
		do
			Result := Precursor (a_command_id, a_execution_verb, a_property_key, a_property_value, a_command_execution_properties)
			if command_list.has (a_command_id) then
				create l_key.share_from_pointer (a_property_key)
				if l_key.is_font_properties then
					if a_execution_verb = {EV_EXECUTION_VERB}.execute then

						if a_command_execution_properties /= default_pointer then
--							create l_property_set.share_with_pointer (a_command_execution_properties)
--							l_property_value := l_property_set.value (l_sub_key)
						end
					end
				else
					Result := Precursor {EV_RIBBON_BUTTON}(a_command_id, a_execution_verb, a_property_key, a_property_value, a_command_execution_properties)
				end
			end

		end

	update_property (a_command_id: NATURAL_32; a_property_key, a_property_current_value, a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		do
			Result := Precursor (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
		end

	update_with_property_store (a_property_store: EV_PROPERTY_STORE)
			-- Update font control property with `a_property_store'
		local
			l_count, l_max: NATURAL_32
			l_property_value: EV_PROPERTY_VARIANT
			l_wel_color: WEL_COLOR_REF
			l_key: EV_PROPERTY_KEY
		do
			from
					l_max := a_property_store.count
				until
					l_count >= l_max
				loop
					l_key := a_property_store.key_at (l_count)
					if l_key.is_font_properties_size then
						l_property_value := a_property_store.value (l_key)
						if l_property_value.var_type /= {EV_PROPERTY_VARIANT_TYPE}.vt_empty then
							size := l_property_value.decimal_value
						end
					elseif l_key.is_font_properties_family then
						l_property_value := a_property_store.value (l_key)
						if l_property_value.var_type /= {EV_PROPERTY_VARIANT_TYPE}.vt_empty then
							family := l_property_value.string_value
						end
					elseif l_key.is_font_properties_backgroundcolor then
						l_property_value := a_property_store.value (l_key)
						if l_property_value.var_type /= {EV_PROPERTY_VARIANT_TYPE}.vt_empty then
							create l_wel_color.make_by_color (l_property_value.uint32_value.as_integer_32)
							create background_color.make_with_8_bit_rgb (l_wel_color.red, l_wel_color.green, l_wel_color.blue)
						end
					elseif l_key.is_font_properties_backgroundcolor_type then
						l_property_value := a_property_store.value (l_key)
						if l_property_value.var_type /= {EV_PROPERTY_VARIANT_TYPE}.vt_empty then
							background_color_type := l_property_value.uint32_value
						end
					elseif l_key.is_font_properties_bold then
						l_property_value := a_property_store.value (l_key)
						if l_property_value.var_type /= {EV_PROPERTY_VARIANT_TYPE}.vt_empty then
							bold := l_property_value.uint32_value
						end
					elseif l_key.is_font_properties_changed_properties then
						l_property_value := a_property_store.value (l_key)
						if l_property_value.var_type /= {EV_PROPERTY_VARIANT_TYPE}.vt_empty then
							-- Not implementated
						end
					elseif l_key.is_font_properties_delta_size then
						l_property_value := a_property_store.value (l_key)
						if l_property_value.var_type /= {EV_PROPERTY_VARIANT_TYPE}.vt_empty then
							delta_size := l_property_value.uint32_value
						end
					end

					l_count := l_count + 1
				end
		end
note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

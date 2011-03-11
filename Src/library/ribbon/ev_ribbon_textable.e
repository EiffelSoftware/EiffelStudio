note
	description: "Summary description for {EV_RIBBON_TEXTABLE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_TEXTABLE

feature -- Query

	ribbon: detachable EV_RIBBON
			-- Parent ribbon
		deferred
		end

	label_title: detachable STRING_32
			-- Text will be used by `update_property'

feature -- Command

	set_text (a_text: STRING_32)
			-- Set `label_title' with `a_text'
		local
			l_key: EV_PROPERTY_KEY
			l_command_id: NATURAL_32
			l_enum: EV_UI_INVALIDATIONS_ENUM
		do
			if command_list.count > 0 then
				l_command_id := command_list.item (command_list.lower)
				check command_id_valid: l_command_id /= 0 end

				if attached ribbon as l_ribbon then
					create l_key.make_label
					create l_enum
					l_ribbon.invalidate (l_command_id, l_enum.ui_invalidations_property, l_key)
					label_title := a_text
				end
			end
		end

feature {NONE} --Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current
		deferred
		end

	update_property_for_text (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			--
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
		do
			create l_key.share_from_pointer (a_property_key)
			if l_key.is_label then
				if attached label_title as l_text then
					create l_value.share_from_pointer (a_property_new_value)
					l_value.set_string_value (l_text)

					-- Don't clear `label_title' after set, since Microsoft Ribbon framework maybe query it twice
					-- If `a_property_new_value' not set, then it means empty string
					-- label_title := void
					Result := {EV_RIBBON_HRESULT}.s_ok
				end
			end
		end

end

note
	description: "[
					Ribbon items with abilities to set and query large/small images
					]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_IMAGEABLE

feature -- Query

	ribbon: detachable EV_RIBBON
			-- Parent ribbon
		deferred
		end

feature -- Command

	set_small_image (a_image: EV_PIXEL_BUFFER)
			-- Set small image
		require
			not_void: a_image /= Void
		local
			l_key: EV_PROPERTY_KEY
			l_command_id: NATURAL_32
			l_enum: EV_UI_INVALIDATIONS_ENUM
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_small_image
				create l_enum
				l_ribbon.invalidate (l_command_id, l_enum.ui_invalidations_property, l_key)
				small_image_to_set := a_image
			end
		end

	set_large_image (a_image: EV_PIXEL_BUFFER)
			-- Set large image
		require
			not_void: a_image /= Void
		local
			l_key: EV_PROPERTY_KEY
			l_command_id: NATURAL_32
			l_enum: EV_UI_INVALIDATIONS_ENUM
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_large_image
				create l_enum
				l_ribbon.invalidate (l_command_id, l_enum.ui_invalidations_property, l_key)
				large_image_to_set := a_image
			end
		end

feature {NONE} --Implementation

	update_property_for_image (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- Update small/large images in `update_property'
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
		do
			create l_key.share_from_pointer (a_property_key)
			if l_key.is_small_image then
				if attached small_image_to_set as l_image then
					create l_value.share_from_pointer (a_property_new_value)
					l_value.set_image (l_image)
					small_image_to_set := Void
				end
			elseif l_key.is_large_image then
				if attached large_image_to_set as l_image then
					create l_value.share_from_pointer (a_property_new_value)
					l_value.set_image (l_image)
					large_image_to_set := Void
				end
			end
		end

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current
		deferred
		end

	small_image_to_set: detachable EV_PIXEL_BUFFER
			-- Image will be used by `update_proptery'

	large_image_to_set: detachable EV_PIXEL_BUFFER
			-- Image will be used by `update_proptery'

;note
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

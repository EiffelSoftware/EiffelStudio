note
	description: "Summary description for {EV_NS_RESPONDER}."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_NS_RESPONDER

inherit
	EV_COCOA_KEY_CONVERSION
		rename
			key_down as vision_key_down_constant,
			key_up as vision_key_up_constant
		end

feature -- Event handling

	key_down (a_event: NS_EVENT)
			-- Translate a Cocoa key-event to an EiffelVision key event
		local
			cocoa_code: NATURAL_16
		do
			io.put_string_32 ({STRING_32} "Key down: " + a_event.characters.as_string_32 + " (" + a_event.key_code.out + ")%N")
			if attached key_press_actions_internal as actions then
				if a_event.characters_ignoring_modifiers.count = 1 then
					cocoa_code := a_event.characters_ignoring_modifiers.character_at_index (0)
					actions.call ([create {EV_KEY}.make_with_code (key_code_from_cocoa (cocoa_code))])
				end
			end

			if attached key_press_string_actions_internal as actions then
				if a_event.modifier_flags & {NS_EVENT}.function_key_mask = 0 then
					-- Do not call for arrow keys, etc.
					actions.call ([a_event.characters.as_string_32])
				end
			end

			--Precursor {EV_NS_WINDOW} (a_event)
		end

	key_up (a_event: NS_EVENT)
			-- Translate a Cocoa key-event to an EiffelVision key event
		local
			cocoa_code: NATURAL_16
		do
			io.put_string_32 ({STRING_32} "Key up: " + a_event.characters.as_string_32 + " (" + a_event.key_code.out + ")%N")
			if attached key_release_actions_internal as actions then
				if a_event.characters_ignoring_modifiers.count = 1 then
					cocoa_code := a_event.characters_ignoring_modifiers.character_at_index (0)
					actions.call ([create {EV_KEY}.make_with_code (key_code_from_cocoa (cocoa_code))])
				end
			end
			--Precursor {EV_NS_WINDOW} (a_event)
		end

	flags_changed
			-- Cocoa doesn't generate keyDown/Up messages for modifier keys. We have to override the flagsChanged: message
		do

		end

feature {NONE} -- Actions

	key_press_actions_internal: detachable EV_KEY_ACTION_SEQUENCE
		deferred
		end

	key_release_actions_internal: detachable EV_KEY_ACTION_SEQUENCE
		deferred
		end

	key_press_string_actions_internal: detachable EV_KEY_STRING_ACTION_SEQUENCE
		deferred
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

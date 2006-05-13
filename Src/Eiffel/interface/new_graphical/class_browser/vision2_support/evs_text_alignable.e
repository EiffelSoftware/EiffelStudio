indexing
	description: "Object that represents an alignment setting"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_TEXT_ALIGNABLE

inherit
	EVS_SETTING_CHANGE_ACTIONS

feature -- Align setting

	align_text_center is
			-- Display `text' centered.
		do
			lock_update
			boolean_flags := boolean_flags.set_bit (False, 1)
			boolean_flags := boolean_flags.set_bit (True, 2)
			boolean_flags := boolean_flags.set_bit (False, 3)
			unlock_update
			try_call_setting_change_actions
		ensure
			alignment_set: is_center_aligned
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			lock_update
			boolean_flags := boolean_flags.set_bit (False, 1)
			boolean_flags := boolean_flags.set_bit (False, 2)
			boolean_flags := boolean_flags.set_bit (True, 3)
			unlock_update
			try_call_setting_change_actions
		ensure
			alignment_set: is_right_aligned
		end

	align_text_left is
			-- Display `text' left aligned.
		do
			lock_update
			boolean_flags := boolean_flags.set_bit (True, 1)
			boolean_flags := boolean_flags.set_bit (False, 2)
			boolean_flags := boolean_flags.set_bit (False, 3)
			unlock_update
			try_call_setting_change_actions
		ensure
			alignment_set: is_left_aligned
		end

	align_text_vertically_center is
			-- Display `text' centered vertically.
		do
			lock_update
			boolean_flags := boolean_flags.set_bit (False, 4)
			boolean_flags := boolean_flags.set_bit (True, 5)
			boolean_flags := boolean_flags.set_bit (False, 6)
			unlock_update
			try_call_setting_change_actions
		ensure
			alignment_set: is_vertically_center_aligned
		end

	align_text_top is
			-- Display `text' top aligned.
		do
			lock_update
			boolean_flags := boolean_flags.set_bit (True, 4)
			boolean_flags := boolean_flags.set_bit (False, 5)
			boolean_flags := boolean_flags.set_bit (False, 6)
			unlock_update
			try_call_setting_change_actions
		ensure
			alignment_set: is_top_aligned
		end

	align_text_bottom is
			-- Display `text' bottom aligned.
		do
			lock_update
			boolean_flags := boolean_flags.set_bit (False, 4)
			boolean_flags := boolean_flags.set_bit (False, 5)
			boolean_flags := boolean_flags.set_bit (True, 6)
			unlock_update
			try_call_setting_change_actions
		ensure
			alignment_set: is_bottom_aligned
		end

feature -- Status report

	is_left_aligned: BOOLEAN is
			-- Is `text' of `Current' left aligned?
			-- Ignored during re-draw if `layout_procedure' /= Void.
		do
			Result := boolean_flags.bit_test (1) = True
		end

	is_center_aligned: BOOLEAN is
			-- Is `text' of `Current' center aligned?
			-- Ignored during re-draw if `layout_procedure' /= Void.
		do
			Result := boolean_flags.bit_test (2) = True
		end

	is_right_aligned: BOOLEAN is
			-- Is `text' of `Current' right aligned?
			-- Ignored during re-draw if `layout_procedure' /= Void.
		do
			Result := boolean_flags.bit_test (3) = True
		end

	is_top_aligned: BOOLEAN is
			-- Is `text' of `Current' top aligned?
			-- Ignored during re-draw if `layout_procedure' /= Void.
		do
			Result := boolean_flags.bit_test (4) = True
		end

	is_vertically_center_aligned: BOOLEAN is
			-- Is `text' of `Current' vertically center aligned?
			-- Ignored during re-draw if `layout_procedure' /= Void.
		do
			Result := boolean_flags.bit_test (5) = True
		end

	is_bottom_aligned: BOOLEAN is
			-- Is `text' of `Current' bottom aligned?
			-- Ignored during re-draw if `layout_procedure' /= Void.
		do
			Result := boolean_flags.bit_test (6) = True
		end

feature{NONE} -- Implementation

	boolean_flags: INTEGER_8;
			-- Current boolean flags for internal use only.
			-- Bit 1 set to 1 if left aligned
			-- Bit 2 set to 1 if center aligned
			-- Bit 3 set to 1 if right aligned
			-- Bit 4 set to 1 if top aligned
			-- Bit 5 set to 1 if vertically center aligned
			-- Bit 6 set to 1 if bottom aligned
			-- Bit 7 set to 1 if `is_full_select_enabled'.

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
        license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
        licensing_options:	"http://www.eiffel.com/licensing"
        copying: "[
                        This file is part of Eiffel Software's Eiffel Development Environment.
                        
                        Eiffel Software's Eiffel Development Environment is free
                        software; you can redistribute it and/or modify it under
                        the terms of the GNU General Public License as published
                        by the Free Software Foundation, version 2 of the License
                        (available at the URL listed under "license" above).
                        
                        Eiffel Software's Eiffel Development Environment is
                        distributed in the hope that it will be useful,	but
                        WITHOUT ANY WARRANTY; without even the implied warranty
                        of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
                        See the	GNU General Public License for more details.
                        
                        You should have received a copy of the GNU General Public
                        License along with Eiffel Software's Eiffel Development
                        Environment; if not, write to the Free Software Foundation,
                        Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
                ]"
        source: "[
                         Eiffel Software
                         356 Storke Road, Goleta, CA 93117 USA
                         Telephone 805-685-1006, Fax 805-685-6869
                         Website http://www.eiffel.com
                         Customer support http://support.eiffel.com
                ]"


end

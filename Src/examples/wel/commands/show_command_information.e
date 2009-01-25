note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	SHOW_COMMAND_INFORMATION

inherit
	WEL_COMMAND

feature

	execute (argument: ANY)
			-- Add information about Wm_move message in the
			-- list box.
		local
			s: STRING
		do
			if {mi: WEL_COMMAND_MESSAGE} message_information and then {lb: WEL_SINGLE_SELECTION_LIST_BOX} argument then
				if mi.from_menu or (mi.from_control and then mi.control /= lb) then
					s := "WM_COMMAND: id="
					s.append (mi.id.out)

					s.append (" From control=")
					s.append (mi.from_control.out)

					lb.add_string (s)
					lb.select_item (lb.count - 1)
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SHOW_COMMAND_INFORMATION


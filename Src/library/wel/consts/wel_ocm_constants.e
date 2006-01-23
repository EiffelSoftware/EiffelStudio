indexing
	description	: "Reflected Window Message IDs. Defined in OleCtl.h"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_OCM_CONSTANTS

inherit
	WEL_WM_CONSTANTS

	WEL_WM_CTLCOLOR_CONSTANTS	

feature -- Access

	Ocm__base: INTEGER is 
			-- Declared in Windows as OCM__BASE.
		once
			Result := (Wm_user + 7168)
		end
		
	Ocm_command: INTEGER is 
			-- Declared in Windows as OCM_COMMAND.
		once
			Result := (Ocm__base + Wm_command)
		end

	Ocm_ctlcolorbtn: INTEGER is 
			-- Declared in Windows as OCM_CTLCOLORBTN.
		once
			Result := (Ocm__base + Wm_ctlcolorbtn)
		end

	Ocm_ctlcoloredit: INTEGER is 
			-- Declared in Windows as OCM_CTLCOLOREDIT.
		once
			Result := (Ocm__base + Wm_ctlcoloredit)
		end

	Ocm_ctlcolordlg: INTEGER is 
			-- Declared in Windows as OCM_CTLCOLORDLG.
		once
			Result := (Ocm__base + Wm_ctlcolordlg)
		end

	Ocm_ctlcolorlistbox: INTEGER is 
			-- Declared in Windows as OCM_CTLCOLORLISTBOX.
		once
			Result := (Ocm__base + Wm_ctlcolorlistbox)
		end

	Ocm_ctlcolormsgbox: INTEGER is 
			-- Declared in Windows as OCM_CTLCOLORMSGBOX.
		once
			Result := (OCM__BASE + Wm_ctlcolormsgbox)
		end

	Ocm_ctlcolorscrollbar: INTEGER is 
			-- Declared in Windows as OCM_CTLCOLORSCROLLBAR.
		once
			Result := (OCM__BASE + Wm_ctlcolorscrollbar)
		end

	Ocm_ctlcolorstatic: INTEGER is 
			-- Declared in Windows as OCM_CTLCOLORSTATIC.
		once
			Result := (OCM__BASE + Wm_ctlcolorstatic)
		end

	Ocm_ctlcolor: INTEGER is 
			-- Declared in Windows as OCM_CTLCOLOR.
		once
			Result := (Ocm__base + Wm_ctlcolor)
		end

	Ocm_drawitem: INTEGER is 
			-- Declared in Windows as OCM_DRAWITEM.
		once
			Result := (Ocm__base + Wm_drawitem)
		end

	Ocm_measureitem: INTEGER is 
			-- Declared in Windows as OCM_MEASUREITEM.
		once
			Result := (Ocm__base + Wm_measureitem)
		end

	Ocm_deleteitem: INTEGER is 
			-- Declared in Windows as OCM_DELETEITEM.
		once
			Result := (Ocm__base + Wm_deleteitem)
		end

	Ocm_vkeytoitem: INTEGER is 
			-- Declared in Windows as OCM_VKEYTOITEM.
		once
			Result := (Ocm__base + Wm_vkeytoitem)
		end

	Ocm_chartoitem: INTEGER is 
			-- Declared in Windows as OCM_CHARTOITEM.
		once
			Result := (Ocm__base + Wm_chartoitem)
		end

	Ocm_compareitem: INTEGER is 
			-- Declared in Windows as OCM_COMPAREITEM.
		once
			Result := (Ocm__base + Wm_compareitem)
		end

	Ocm_hscroll: INTEGER is 
			-- Declared in Windows as OCM_HSCROLL.
		once
			Result := (Ocm__base + Wm_hscroll)
		end

	Ocm_vscroll: INTEGER is 
			-- Declared in Windows as OCM_VSCROLL.
		once
			Result := (Ocm__base + Wm_vscroll)
		end

	Ocm_parentnotify: INTEGER is 
			-- Declared in Windows as OCM_PARENTNOTIFY.
		once
			Result := (Ocm__base + Wm_parentnotify)
		end

	Ocm_notify: INTEGER is 
			-- Declared in Windows as OCM_NOTIFY.
		once
			Result := (Ocm__base + Wm_notify)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_OCM_CONSTANTS


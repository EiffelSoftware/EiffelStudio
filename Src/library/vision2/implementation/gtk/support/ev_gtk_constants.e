indexing

	description: "EV_GTK_CONSTANTS - copied from C include files"
	version: "0.1 - 3/6/98 (gtk+-99.4)"
	author: "Richie Bielak"

class
	EV_GTK_CONSTANTS

feature

	-- GtkWindowType
	GTK_WINDOW_TOPLEVEL: INTEGER is 0
	GTK_WINDOW_DIALOG: INTEGER is 1
	GTK_WINDOW_POPUP: INTEGER is 2

	-- GtkPolicyType
	GTK_POLICY_ALWAYS: INTEGER is 0
	GTK_POLICY_AUTOMATIC: INTEGER is 1

	-- GtkProgressBarStyle
	GTK_PROGRESS_CONTINUOUS: INTEGER is 0
	GTK_PROGRESS_DISCRETE: INTEGER is 1

	-- GtkProgressBarOrientation
	-- We only use these 2 because of windows platform.
	GTK_PROGRESS_LEFT_TO_RIGHT: INTEGER is 0
	GTK_PROGRESS_BOTTOM_TO_TOP: INTEGER is 2

	-- Widget flags
	GTK_VISIBLE: INTEGER is  8
	GTK_MAPPED: INTEGER  is  16
	GTK_UNMAPPED: INTEGER is 32
	GTK_REALIZED: INTEGER is 64
	GTK_SENSITIVE: INTEGER is 126
	GTK_PARENT_SENSITIVE: INTEGER is 256
	GTK_NO_WINDOW: INTEGER is 512
	GTK_HAS_FOCUS: INTEGER is 1024
	GTK_CAN_FOCUS: INTEGER is 2048
	GTK_HAS_DEFAULT: INTEGER is 4096
	GTK_CAN_DEFAULT: INTEGER is 8192
	GTK_PROPAGATE_STATE: INTEGER is 16_384
	GTK_ANCHORED: INTEGER is 32_768
	GTK_BASIC: INTEGER is 65_536
	GTK_USER_STYLE: INTEGER is 131_072
	GTK_GRAB_ALL: INTEGER is 262_144
	GTK_REDRAW_PENDING: INTEGER is 524_288
	GTK_RESIZE_PENDING: INTEGER is 1_048_576
	GTK_RESIZE_NEEDED: INTEGER is 2_097_152
	GTK_HAS_SHAPE_MASK: INTEGER is 4_194_304

	-- Options for tables
	GTK_EXPAND: INTEGER is 1
	GTK_SHRINK: INTEGER is 2
	GTK_FILL: INTEGER is 4

	-- Orientation for toolbars etc
	GTK_ORIENTATION_HORIZONTAL: INTEGER is 0
	GTK_ORIENTATION_VERTICAL: INTEGER is 1

	-- Toolbars style
	GTK_TOOLBAR_ICONS: INTEGER is 0
	GTK_TOOLBAR_TEXT: INTEGER is 1
	GTK_TOOLBAR_BOTH: INTEGER is 2

	-- Constants for Justification
	GTK_JUSTIFY_LEFT: INTEGER is 0
	GTK_JUSTIFY_RIGHT: INTEGER is 1
	GTK_JUSTIFY_CENTER: INTEGER is 2
	GTK_JUSTIFY_FILL: INTEGER is 3

	--------------------------------
	-- Selection mode for a list. --
	--
	-- GTK_SELECTION_SINGLE - The selection is either NULL or contains a GList pointer for a single selected item. 
	-- GTK_SELECTION_BROWSE - The selection is NULL if the list contains no widgets or insensitive ones only, otherwise it
	--	contains a GList pointer for one GList structure, and therefore exactly one list item. 
	-- GTK_SELECTION_MULTIPLE - The selection is NULL if no list items are selected or a GList pointer for the first selected item.
	--	That in turn points to a GList structure for the second selected item and so on. 
	-- GTK_SELECTION_EXTENDED - The selection is always NULL. 

	GTK_SELECTION_SINGLE: INTEGER is 0
	GTK_SELECTION_BROWSE: INTEGER is 1
	GTK_SELECTION_MULTIPLE: INTEGER is 2
	GTK_SELECTION_EXTENDED: INTEGER is 3

end

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.7  2001/06/07 23:08:05  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.8.3  2000/10/06 20:11:47  oconnor
--| cosmetics
--|
--| Revision 1.5.8.2  2000/09/06 23:18:42  king
--| Reviewed
--|
--| Revision 1.5.8.1  2000/05/03 19:08:43  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/02/14 11:40:29  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.10.3  2000/02/04 04:56:29  oconnor
--| released
--|
--| Revision 1.5.10.2  2000/01/27 19:29:34  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.10.1  1999/11/24 17:29:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.6.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

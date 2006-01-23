indexing 
	status: "See notice at end of class."; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
deferred class
	GRABABLE_WINDOWS

inherit
	G_ANY

	W_MAN_GEN
 
feature -- Status report

	insensitive_list: LINKED_LIST [WIDGET_IMP]
			-- Collection of widgets set insensitive
			-- by exclusive grab

	is_cascade_grab: BOOLEAN is
			-- Is the shell popped up with cascade grab (allowing the other
			-- shells popped up with grab to receive events) ?
		do
			Result := grab_style = Modal
		end

	is_exclusive_grab: BOOLEAN is
			-- Is the shell popped up with exclusive grab ?
		do
			Result := grab_style = Modal
		end

	is_no_grab: BOOLEAN is
			-- Is the shell popped up with no grab ?
		do
			Result := grab_style = Modeless
		end

	parent: COMPOSITE_IMP is
		deferred
		end

feature -- Status setting

	set_cascade_grab is
			-- Specifies that the shell would be popped up with cascade grab
			-- (allowing the other shells poped up with grab to receive events).
		do
			grab_style := Modal
		ensure 
			is_cascade_grab: is_cascade_grab
		end

	set_exclusive_grab is
			-- Specifies that the shell would be popped up with exclusive grab.
		do
			grab_style := Modal
		ensure 
			is_exclusive_grab: is_exclusive_grab
		end

	set_no_grab is
			-- Specifies that the shell would be popped up with no grab.
		do
			grab_style := Modeless
		ensure 
			is_no_grab: is_no_grab
		end

feature {NONE} --Implementation

	grab_style: INTEGER
			-- style of grab

	Modal: INTEGER is 1
			-- Indicates modal grab style.

	Modeless: INTEGER is 2
			-- Indicates modeless grab style.

	set_windows_insensitive is
			-- Set windows insensitive that are sensitive
		require
			insensitive_list_void: insensitive_list = Void
		local
			area: SPECIAL [WIDGET]
			i : INTEGER
			w : WIDGET
			ww: WIDGET_IMP
			to_set: BOOLEAN
			dw: DIALOG_IMP
		do
			area := widget_manager.area
			from
				i := 0
				create insensitive_list.make
			until
				i >= widget_manager.count
			loop
				w := area.item(i)
				ww ?= w.implementation
				to_set := w.depth = 0
				if not to_set then
					dw ?= ww
					to_set := dw /= Void and dw /= Current
				end
				if to_set and then ww.exists and then ww.enabled then
					ww.disable
					insensitive_list.extend (ww)
				end
				i := i + 1
			end
			if parent /= Void and then parent.exists and then parent.enabled then
				parent.disable
				insensitive_list.extend (parent)
			end
		ensure
			insensitive_list_exists: insensitive_list /= Void
		end

	set_windows_sensitive is
			-- Set windows previously set insensitive back to sensitive
		require
			insensitive_list_exists: insensitive_list /= Void
		do
			from
				insensitive_list.start
			until
				insensitive_list.after
			loop
				if insensitive_list.item.exists then
					insensitive_list.item.enable
				end
				insensitive_list.forth
			end
			insensitive_list := Void
		ensure
			insensitive_list_void: insensitive_list = Void
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




end -- class GRABABLE_WINDOWS


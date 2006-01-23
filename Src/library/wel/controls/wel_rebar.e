indexing
	description: "Control window that contains one or more bands%
		%that can be moved by the user."
	legal: "See notice at end of class."
	note: "To use this control you need to create a%
		% WEL_INIT_COMMON_CONTROLS with the flags Icc_cool_Classes%
		% and Icc_bar_classes in your application class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_REBAR

inherit
	WEL_CONTROL
		undefine
			process_message,
			on_getdlgcode,
			on_wm_notify,
			on_wm_erase_background
		redefine
			process_notification_info,
			set_parent
		end

	WEL_COMPOSITE_WINDOW
		undefine
			destroy,
			on_wm_nc_destroy,
			set_default_window_procedure,
			call_default_window_procedure,
			minimal_width,
			minimal_height,
			move_and_resize,
			move
		redefine
			on_wm_paint,
			set_parent
		end

	WEL_CCS_CONSTANTS
		export
			{NONE} all
		end

	WEL_RBS_CONSTANTS
		export
			{NONE} all
		end

	WEL_RBN_CONSTANTS
		export
			{NONE} all
		end

	WEL_RB_CONSTANTS
		export
			{NONE} all
		end

	WEL_RBIM_CONSTANTS
		export
			{NONE} all
		end

	WEL_RBBIM_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; an_id: INTEGER) is
			-- Create a rebar with `a_parent' as parent and
			-- `an_id' as id.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			internal_window_make (a_parent, Void, default_style,
				0, 0, 0, 0, an_id, default_pointer)
			id := an_id
		ensure
			exists: exists
			parent_set: parent = a_parent
			id_set: id = an_id
		end

feature -- Status report

	band_count: INTEGER is
			-- Number of bands in the rebar control.
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item, Rb_getbandcount, to_wparam (0), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

	row_count: INTEGER is
			-- Number of rows of bands in the rebar control.
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item, Rb_getrowcount, to_wparam (0), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

	row_height (index: INTEGER): INTEGER is
			-- Retrieve the height of the zero-based `index' band.
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item, Rb_getrowheight, to_wparam (index), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

	get_bar_info: WEL_REBARINFO is
			-- Retrieve all the informations about the current rebar
			-- control
		require
			exists: exists
		do
			create Result.make
			Result.set_mask (Rbim_imagelist)
			cwin_send_message (item, Rb_getbarinfo, to_wparam (0), Result.item)
		end

	get_band_info (index: INTEGER): WEL_REBARBANDINFO is
			-- Retrieve all the informations about the zero-based
			-- `index' band of the rebar.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < band_count
		local
			buffer: STRING
		do
			create Result.make
			Result.set_mask (Rbbim_style + Rbbim_colors + Rbbim_text
				+ Rbbim_image + Rbbim_child + Rbbim_childsize
				+ Rbbim_size + Rbbim_background + Rbbim_id)
			create buffer.make (buffer_size)
			buffer.fill_blank
			Result.set_text (buffer)
			cwin_send_message (item, Rb_getbandinfo, to_wparam (index), Result.item)
		end

feature -- Status setting

	set_bar_info (info: WEL_REBARINFO) is
			-- Make `info' the new informations about the rebar.
		require
			exists: exists
			info_not_void: info /= Void
			info_exists: info.exists
		do
			cwin_send_message (item, Rb_setbarinfo, to_wparam (0), info.item)
		end

	set_band_info (info: WEL_REBARBANDINFO; index: INTEGER) is
			-- Make `info' the new informations about the zero-based
			-- `index' band of the rebar.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < band_count
			info_not_void: info /= Void
			info_exists: info.exists
		do
			cwin_send_message (item, Rb_setbandinfo, to_wparam (index), info.item)
		end

feature -- Element change

   	set_parent (a_parent: WEL_WINDOW) is
   			-- Change the parent of the current window.
			-- We need to use both windows methods to reparent
			-- the rebar otherwise it doesn't work.
   		do
			if a_parent /= Void then
				parent := a_parent
				cwin_set_parent (item, a_parent.item)
				cwin_send_message (item, Rb_setparent, a_parent.item, to_lparam (0))
			else
				parent := Void
				cwin_set_parent (item, default_pointer)
				cwin_send_message (item, Rb_setparent, to_wparam (0), to_lparam (0))
			end
		end

	prepend_band (band: WEL_REBARBANDINFO) is
			-- Insert `band' in the rebar.
		require
			exists: exists
			valid_band: band /= Void and then band.exists
		do
			cwin_send_message (item, Rb_insertband, to_wparam (0), band.item)
		end

	append_band (band: WEL_REBARBANDINFO) is
			-- Insert `band' in the rebar.
		require
			exists: exists
			valid_band: band /= Void and then band.exists
		do
			cwin_send_message (item, Rb_insertband, to_wparam (-1), band.item)
		end

	insert_band (band: WEL_REBARBANDINFO; index: INTEGER) is
			-- Insert `band' in the rebar.
		require
			exists: exists
			band_not_void: band /= Void
			band_exists: band.exists
			index_large_enough: index >= 0
			index_small_enough: index < band_count
		do
			cwin_send_message (item, Rb_insertband, to_wparam (index), band.item)
		end

	delete_band (index: INTEGER) is
			-- Delete the zero-based `index' band from the rebar.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < band_count
		do
			cwin_send_message (item, Rb_deleteband, to_wparam (index), to_lparam (0))
		end

feature -- Notifications

	on_rbn_heightchanged is
			-- The height of the rebar have changed.
		require
			exists: exists
		do
		end

feature -- Basic operations

	reposition is
			-- Reposition the window according to the parent.
			-- This function needs to be called in the
			-- `on_size' routine of the parent.
		require
			exists: exists
		do
			cwin_send_message (item, Wm_size, to_wparam (0), to_lparam (0))
		end

feature {WEL_COMPOSITE_WINDOW} -- Implementation

	process_notification_info (notification_info: WEL_NMHDR) is
			-- Process a `notification_code' sent by Windows
			-- through the Wm_notify message
		local
			code: INTEGER
		do
			code := notification_info.code
			if code = Rbn_heightchange then
				on_rbn_heightchanged
			end
		end

feature {NONE} -- Implementation

	buffer_size: INTEGER is 30
			-- Windows text retrieval buffer size

	class_name: STRING is
			-- Window class name to create
		once
			create Result.make (0)
			Result.from_c (cwin_rebar_class)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_clipsiblings
				+ Ws_clipchildren + Rbs_varheight + Ccs_nodivider
				+ Rbs_bandborders + Rbs_tooltips
		end

  	on_wm_paint (wparam: POINTER) is
   			-- Wm_paint message.
   		do
   			-- Need to do nothing
 		end

feature {NONE} -- Externals

	cwin_rebar_class: POINTER is
		external
			"C [macro %"cctrl.h%"] : EIF_POINTER"
		alias
			"REBARCLASSNAME"
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




end -- class WEL_REBAR


note
	description: "[
			The OLEINPLACEFRAMEINFO structure contains information 
			about the accelerators supported by a container during 
			an in-place session. The structure is used in the 
			IOleInPlaceSite::GetWindowContext method and the 
			OleTranslateAccelerator function.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_OIFI_RECORD

inherit
	ECOM_STRUCTURE
		redefine
			make
		end

create
	make,
	make_from_pointer

feature {NONE}  -- Initialization

	make
			-- Make.
		do
			Precursor {ECOM_STRUCTURE}
		end

	make_from_pointer (a_pointer: POINTER)
			-- Make from pointer.
		do
			make_by_pointer (a_pointer)
		end

feature -- Access

	cb: INTEGER
			-- No description available.
		do
			Result := ccom_tag_oifi_cb (item)
		end

	f_mdiapp: INTEGER
			-- No description available.
		do
			Result := ccom_tag_oifi_f_mdiapp (item)
		end

	hwnd_frame: POINTER
			-- No description available.
		do
			Result := ccom_tag_oifi_hwnd_frame (item)
		end

	h_accel: POINTER
			-- No description available.
		do
			Result := ccom_tag_oifi_h_accel (item)
		end

	c_accel_entries: INTEGER
			-- No description available.
		do
			Result := ccom_tag_oifi_c_accel_entries (item)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of structure
		do
			Result := c_size_of_tag_oifi
		end

feature -- Basic Operations

	set_cb (a_cb: INTEGER)
			-- Set `cb' with `a_cb'.
		do
			ccom_tag_oifi_set_cb (item, a_cb)
		end

	set_f_mdiapp (a_f_mdiapp: INTEGER)
			-- Set `f_mdiapp' with `a_f_mdiapp'.
		do
			ccom_tag_oifi_set_f_mdiapp (item, a_f_mdiapp)
		end

	set_hwnd_frame (a_hwnd_frame: POINTER)
			-- Set `hwnd_frame' with `a_hwnd_frame'.
		do
			ccom_tag_oifi_set_hwnd_frame (item, a_hwnd_frame)
		end

	set_h_accel (a_h_accel: POINTER)
			-- Set `h_accel' with `a_h_accel'.
		do
			ccom_tag_oifi_set_h_accel (item, a_h_accel)
		end

	set_c_accel_entries (a_c_accel_entries: INTEGER)
			-- Set `c_accel_entries' with `a_c_accel_entries'.
		do
			ccom_tag_oifi_set_c_accel_entries (item, a_c_accel_entries)
		end

feature {NONE}  -- Externals

	c_size_of_tag_oifi: INTEGER
			-- Size of structure
		external
			"C [macro <oleidl.h>]"
		alias
			"sizeof(OLEINPLACEFRAMEINFO)"
		end

	ccom_tag_oifi_cb (a_pointer: POINTER): INTEGER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagOIFI_s_impl.h%"](OLEINPLACEFRAMEINFO *):EIF_INTEGER"
		end

	ccom_tag_oifi_set_cb (a_pointer: POINTER; arg2: INTEGER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagOIFI_s_impl.h%"](OLEINPLACEFRAMEINFO *, UINT)"
		end

	ccom_tag_oifi_f_mdiapp (a_pointer: POINTER): INTEGER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagOIFI_s_impl.h%"](OLEINPLACEFRAMEINFO *):EIF_INTEGER"
		end

	ccom_tag_oifi_set_f_mdiapp (a_pointer: POINTER; arg2: INTEGER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagOIFI_s_impl.h%"](OLEINPLACEFRAMEINFO *, LONG)"
		end

	ccom_tag_oifi_hwnd_frame (a_pointer: POINTER): POINTER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagOIFI_s_impl.h%"](OLEINPLACEFRAMEINFO *):EIF_POINTER"
		end

	ccom_tag_oifi_set_hwnd_frame (a_pointer: POINTER; arg2: POINTER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagOIFI_s_impl.h%"](OLEINPLACEFRAMEINFO *, HWND)"
		end

	ccom_tag_oifi_h_accel (a_pointer: POINTER): POINTER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagOIFI_s_impl.h%"](OLEINPLACEFRAMEINFO *):EIF_POINTER"
		end

	ccom_tag_oifi_set_h_accel (a_pointer: POINTER; arg2: POINTER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagOIFI_s_impl.h%"](OLEINPLACEFRAMEINFO *, HACCEL)"
		end

	ccom_tag_oifi_c_accel_entries (a_pointer: POINTER): INTEGER
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagOIFI_s_impl.h%"](OLEINPLACEFRAMEINFO *):EIF_INTEGER"
		end

	ccom_tag_oifi_set_c_accel_entries (a_pointer: POINTER; arg2: INTEGER)
			-- No description available.
		external
			"C++ [macro %"ecom_control_library_tagOIFI_s_impl.h%"](OLEINPLACEFRAMEINFO *, UINT)"
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




end -- TAG_OIFI_RECORD


indexing
	description: "Implemented `IOleInPlaceUIWindow' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IOLE_IN_PLACE_UIWINDOW_IMPL

inherit
	IOLE_IN_PLACE_UIWINDOW_INTERFACE

	IOLE_WINDOW_IMPL
		redefine
			dispose
		end
	
	ECOM_EXCEPTION
		redefine
			dispose
		end
		
feature -- Basic Operations

	get_border (lprect_border: TAG_RECT_RECORD) is
			-- No description available.
			-- `lprect_border' [out].  
		do
			-- No Implementation.
		end

	request_border_space (pborderwidths: TAG_RECT_RECORD) is
			-- No description available.
			-- `pborderwidths' [in].  
		do
			trigger (INPLACE_E_NOTOOLSPACE)
		end

	set_border_space (pborderwidths: TAG_RECT_RECORD) is
			-- No description available.
			-- `pborderwidths' [in].  
		do
			-- No Implementation.
		end

	set_active_object (p_active_object: IOLE_IN_PLACE_ACTIVE_OBJECT_INTERFACE; psz_obj_name: STRING) is
			-- No description available.
			-- `p_active_object' [in].  
			-- `psz_obj_name' [in].  
		local
			retried: BOOLEAN
		do
			if not retried then
				create m_ole_in_place_object.make_from_other (p_active_object)
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	dispose is
		do
			Precursor {IOLE_WINDOW_IMPL}
			Precursor {ECOM_EXCEPTION}
		end

	m_ole_in_place_object: IOLE_IN_PLACE_OBJECT_IMPL_PROXY;
			-- IOleInPlaceObject interface of control.
		
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




end -- IOLE_IN_PLACE_UIWINDOW_IMPL


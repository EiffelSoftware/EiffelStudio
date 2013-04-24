note
	description: "Implemented `IAdviseSink' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IADVISE_SINK_IMPL

inherit
	IADVISE_SINK_INTERFACE
	
feature -- Basic Operations

	on_data_change (p_formatetc: TAG_FORMATETC_RECORD; p_stgmed: STGMEDIUM_RECORD)
			-- Advises that data has changed.
			-- `p_formatetc' [in].  
			-- `p_stgmed' [in].  
		do
			-- No Implementation.
		end

	on_view_change (dw_aspect: INTEGER; lindex: INTEGER)
			-- Advises that view of object has changed.
			-- `dw_aspect' [in].  
			-- `lindex' [in].  
		do
			-- No Implementation.
		end

	on_rename (pmk: IMONIKER_INTERFACE)
			-- Advises that name of object has changed.
			-- `pmk' [in].  
		do
			-- No Implementation.
		end

	on_save
			-- Advises that object has been saved to disk.
		do
			-- No Implementation.
		end

	on_close
			-- Advises that object has been closed.
		do
			-- No Implementation.
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




end -- IADVISE_SINK_IMPL


indexing
	description: "Represents abstraction of ICorDebug.. objects with associated frame"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_OBJECT_WITH_FRAME

inherit
	ICOR_OBJECT
	
feature {ICOR_EXPORTER} -- Extra Properties

	associated_frame: ICOR_DEBUG_FRAME
			-- Current is contained in `associated_frame' ICorDebugFrame
			
	set_associated_frame (f: like associated_frame) is
			-- Set `associated_frame' value
		require
			f_not_void: f /= Void
		do
			associated_frame := f
		ensure
			associated_frame_not_void:  associated_frame /= Void
		end	

end
	

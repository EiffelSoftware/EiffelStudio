indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.ImageAnimator"

frozen external class
	SYSTEM_DRAWING_IMAGEANIMATOR

create {NONE}

feature -- Basic Operations

	frozen animate (image: SYSTEM_DRAWING_IMAGE; on_frame_changed_handler: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.Drawing.Image, System.EventHandler): System.Void use System.Drawing.ImageAnimator"
		alias
			"Animate"
		end

	frozen stop_animate (image: SYSTEM_DRAWING_IMAGE; on_frame_changed_handler: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.Drawing.Image, System.EventHandler): System.Void use System.Drawing.ImageAnimator"
		alias
			"StopAnimate"
		end

	frozen thread_proc is
		external
			"IL static signature (): System.Void use System.Drawing.ImageAnimator"
		alias
			"ThreadProc"
		end

	frozen can_animate (image: SYSTEM_DRAWING_IMAGE): BOOLEAN is
		external
			"IL static signature (System.Drawing.Image): System.Boolean use System.Drawing.ImageAnimator"
		alias
			"CanAnimate"
		end

	frozen update_frames is
		external
			"IL static signature (): System.Void use System.Drawing.ImageAnimator"
		alias
			"UpdateFrames"
		end

	frozen update_frames_image (image: SYSTEM_DRAWING_IMAGE) is
		external
			"IL static signature (System.Drawing.Image): System.Void use System.Drawing.ImageAnimator"
		alias
			"UpdateFrames"
		end

end -- class SYSTEM_DRAWING_IMAGEANIMATOR

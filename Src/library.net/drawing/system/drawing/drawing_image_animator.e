indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.ImageAnimator"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_IMAGE_ANIMATOR

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen animate (image: DRAWING_IMAGE; on_frame_changed_handler: EVENT_HANDLER) is
		external
			"IL static signature (System.Drawing.Image, System.EventHandler): System.Void use System.Drawing.ImageAnimator"
		alias
			"Animate"
		end

	frozen stop_animate (image: DRAWING_IMAGE; on_frame_changed_handler: EVENT_HANDLER) is
		external
			"IL static signature (System.Drawing.Image, System.EventHandler): System.Void use System.Drawing.ImageAnimator"
		alias
			"StopAnimate"
		end

	frozen can_animate (image: DRAWING_IMAGE): BOOLEAN is
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

	frozen update_frames_image (image: DRAWING_IMAGE) is
		external
			"IL static signature (System.Drawing.Image): System.Void use System.Drawing.ImageAnimator"
		alias
			"UpdateFrames"
		end

end -- class DRAWING_IMAGE_ANIMATOR

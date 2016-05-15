note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_ANIMATION

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_COPYING_PROTOCOL
	NS_CODING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_duration__animation_curve_,
	make

feature {NONE} -- Initialization

	make_with_duration__animation_curve_ (a_duration: REAL_64; a_animation_curve: NATURAL_64)
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init_with_duration__animation_curve_(allocate_object, a_duration, a_animation_curve))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSAnimation Externals

	objc_init_with_duration__animation_curve_ (an_item: POINTER; a_duration: REAL_64; a_animation_curve: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAnimation *)$an_item initWithDuration:$a_duration animationCurve:$a_animation_curve];
			 ]"
		end

	objc_start_animation (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item startAnimation];
			 ]"
		end

	objc_stop_animation (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item stopAnimation];
			 ]"
		end

	objc_is_animating (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAnimation *)$an_item isAnimating];
			 ]"
		end

	objc_current_progress (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAnimation *)$an_item currentProgress];
			 ]"
		end

	objc_set_current_progress_ (an_item: POINTER; a_progress: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item setCurrentProgress:$a_progress];
			 ]"
		end

	objc_set_duration_ (an_item: POINTER; a_duration: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item setDuration:$a_duration];
			 ]"
		end

	objc_duration (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAnimation *)$an_item duration];
			 ]"
		end

	objc_animation_blocking_mode (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAnimation *)$an_item animationBlockingMode];
			 ]"
		end

	objc_set_animation_blocking_mode_ (an_item: POINTER; a_animation_blocking_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item setAnimationBlockingMode:$a_animation_blocking_mode];
			 ]"
		end

	objc_set_frame_rate_ (an_item: POINTER; a_frames_per_second: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item setFrameRate:$a_frames_per_second];
			 ]"
		end

	objc_frame_rate (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAnimation *)$an_item frameRate];
			 ]"
		end

	objc_set_animation_curve_ (an_item: POINTER; a_curve: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item setAnimationCurve:$a_curve];
			 ]"
		end

	objc_animation_curve (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAnimation *)$an_item animationCurve];
			 ]"
		end

	objc_current_value (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSAnimation *)$an_item currentValue];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAnimation *)$an_item delegate];
			 ]"
		end

	objc_progress_marks (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAnimation *)$an_item progressMarks];
			 ]"
		end

	objc_set_progress_marks_ (an_item: POINTER; a_progress_marks: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item setProgressMarks:$a_progress_marks];
			 ]"
		end

	objc_add_progress_mark_ (an_item: POINTER; a_progress_mark: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item addProgressMark:$a_progress_mark];
			 ]"
		end

	objc_remove_progress_mark_ (an_item: POINTER; a_progress_mark: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item removeProgressMark:$a_progress_mark];
			 ]"
		end

	objc_start_when_animation__reaches_progress_ (an_item: POINTER; a_animation: POINTER; a_start_progress: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item startWhenAnimation:$a_animation reachesProgress:$a_start_progress];
			 ]"
		end

	objc_stop_when_animation__reaches_progress_ (an_item: POINTER; a_animation: POINTER; a_stop_progress: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item stopWhenAnimation:$a_animation reachesProgress:$a_stop_progress];
			 ]"
		end

	objc_clear_start_animation (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item clearStartAnimation];
			 ]"
		end

	objc_clear_stop_animation (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSAnimation *)$an_item clearStopAnimation];
			 ]"
		end

	objc_run_loop_modes_for_animating (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSAnimation *)$an_item runLoopModesForAnimating];
			 ]"
		end

feature -- NSAnimation

	start_animation
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_start_animation (item)
		end

	stop_animation
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_stop_animation (item)
		end

	is_animating: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_animating (item)
		end

	current_progress: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_current_progress (item)
		end

	set_current_progress_ (a_progress: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_current_progress_ (item, a_progress)
		end

	set_duration_ (a_duration: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_duration_ (item, a_duration)
		end

	duration: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_duration (item)
		end

	animation_blocking_mode: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_animation_blocking_mode (item)
		end

	set_animation_blocking_mode_ (a_animation_blocking_mode: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_animation_blocking_mode_ (item, a_animation_blocking_mode)
		end

	set_frame_rate_ (a_frames_per_second: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_frame_rate_ (item, a_frames_per_second)
		end

	frame_rate: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_frame_rate (item)
		end

	set_animation_curve_ (a_curve: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_animation_curve_ (item, a_curve)
		end

	animation_curve: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_animation_curve (item)
		end

	current_value: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_current_value (item)
		end

	set_delegate_ (a_delegate: detachable NS_ANIMATION_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	delegate: detachable NS_ANIMATION_DELEGATE_PROTOCOL
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_delegate (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like delegate} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like delegate} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	progress_marks: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_progress_marks (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like progress_marks} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like progress_marks} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_progress_marks_ (a_progress_marks: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_progress_marks__item: POINTER
		do
			if attached a_progress_marks as a_progress_marks_attached then
				a_progress_marks__item := a_progress_marks_attached.item
			end
			objc_set_progress_marks_ (item, a_progress_marks__item)
		end

	add_progress_mark_ (a_progress_mark: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_add_progress_mark_ (item, a_progress_mark)
		end

	remove_progress_mark_ (a_progress_mark: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_progress_mark_ (item, a_progress_mark)
		end

	start_when_animation__reaches_progress_ (a_animation: detachable NS_ANIMATION; a_start_progress: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
			a_animation__item: POINTER
		do
			if attached a_animation as a_animation_attached then
				a_animation__item := a_animation_attached.item
			end
			objc_start_when_animation__reaches_progress_ (item, a_animation__item, a_start_progress)
		end

	stop_when_animation__reaches_progress_ (a_animation: detachable NS_ANIMATION; a_stop_progress: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
			a_animation__item: POINTER
		do
			if attached a_animation as a_animation_attached then
				a_animation__item := a_animation_attached.item
			end
			objc_stop_when_animation__reaches_progress_ (item, a_animation__item, a_stop_progress)
		end

	clear_start_animation
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_clear_start_animation (item)
		end

	clear_stop_animation
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_clear_stop_animation (item)
		end

	run_loop_modes_for_animating: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_run_loop_modes_for_animating (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like run_loop_modes_for_animating} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like run_loop_modes_for_animating} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSAnimation"
		end

end

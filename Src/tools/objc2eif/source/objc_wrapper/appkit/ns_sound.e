note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SOUND

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_contents_of_ur_l__by_reference_,
	make_with_contents_of_file__by_reference_,
	make_with_data_,
	make_with_pasteboard_,
	make

feature {NONE} -- Initialization

	make_with_contents_of_ur_l__by_reference_ (a_url: detachable NS_URL; a_by_ref: BOOLEAN)
			-- Initialize `Current'.
		local
			a_url__item: POINTER
		do
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_ur_l__by_reference_(allocate_object, a_url__item, a_by_ref))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_contents_of_file__by_reference_ (a_path: detachable NS_STRING; a_by_ref: BOOLEAN)
			-- Initialize `Current'.
		local
			a_path__item: POINTER
		do
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			make_with_pointer (objc_init_with_contents_of_file__by_reference_(allocate_object, a_path__item, a_by_ref))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_data_ (a_data: detachable NS_DATA)
			-- Initialize `Current'.
		local
			a_data__item: POINTER
		do
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			make_with_pointer (objc_init_with_data_(allocate_object, a_data__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_pasteboard_ (a_pasteboard: detachable NS_PASTEBOARD)
			-- Initialize `Current'.
		local
			a_pasteboard__item: POINTER
		do
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			make_with_pointer (objc_init_with_pasteboard_(allocate_object, a_pasteboard__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSSound Externals

	objc_init_with_contents_of_ur_l__by_reference_ (an_item: POINTER; a_url: POINTER; a_by_ref: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSound *)$an_item initWithContentsOfURL:$a_url byReference:$a_by_ref];
			 ]"
		end

	objc_init_with_contents_of_file__by_reference_ (an_item: POINTER; a_path: POINTER; a_by_ref: BOOLEAN): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSound *)$an_item initWithContentsOfFile:$a_path byReference:$a_by_ref];
			 ]"
		end

	objc_init_with_data_ (an_item: POINTER; a_data: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSound *)$an_item initWithData:$a_data];
			 ]"
		end

	objc_set_name_ (an_item: POINTER; a_string: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSound *)$an_item setName:$a_string];
			 ]"
		end

	objc_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSound *)$an_item name];
			 ]"
		end

	objc_init_with_pasteboard_ (an_item: POINTER; a_pasteboard: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSound *)$an_item initWithPasteboard:$a_pasteboard];
			 ]"
		end

	objc_write_to_pasteboard_ (an_item: POINTER; a_pasteboard: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSound *)$an_item writeToPasteboard:$a_pasteboard];
			 ]"
		end

	objc_play (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSound *)$an_item play];
			 ]"
		end

	objc_pause (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSound *)$an_item pause];
			 ]"
		end

	objc_resume (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSound *)$an_item resume];
			 ]"
		end

	objc_stop (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSound *)$an_item stop];
			 ]"
		end

	objc_is_playing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSound *)$an_item isPlaying];
			 ]"
		end

	objc_delegate (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSound *)$an_item delegate];
			 ]"
		end

	objc_set_delegate_ (an_item: POINTER; a_delegate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSound *)$an_item setDelegate:$a_delegate];
			 ]"
		end

	objc_duration (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSound *)$an_item duration];
			 ]"
		end

	objc_set_volume_ (an_item: POINTER; a_volume: REAL_32)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSound *)$an_item setVolume:$a_volume];
			 ]"
		end

	objc_volume (an_item: POINTER): REAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSound *)$an_item volume];
			 ]"
		end

	objc_current_time (an_item: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSound *)$an_item currentTime];
			 ]"
		end

	objc_set_current_time_ (an_item: POINTER; a_seconds: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSound *)$an_item setCurrentTime:$a_seconds];
			 ]"
		end

	objc_set_loops_ (an_item: POINTER; a_val: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSound *)$an_item setLoops:$a_val];
			 ]"
		end

	objc_loops (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSSound *)$an_item loops];
			 ]"
		end

	objc_set_playback_device_identifier_ (an_item: POINTER; a_device_uid: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSound *)$an_item setPlaybackDeviceIdentifier:$a_device_uid];
			 ]"
		end

	objc_playback_device_identifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSound *)$an_item playbackDeviceIdentifier];
			 ]"
		end

	objc_set_channel_mapping_ (an_item: POINTER; a_channel_mapping: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSSound *)$an_item setChannelMapping:$a_channel_mapping];
			 ]"
		end

	objc_channel_mapping (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSSound *)$an_item channelMapping];
			 ]"
		end

feature -- NSSound

	set_name_ (a_string: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			Result := objc_set_name_ (item, a_string__item)
		end

	name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	write_to_pasteboard_ (a_pasteboard: detachable NS_PASTEBOARD)
			-- Auto generated Objective-C wrapper.
		local
			a_pasteboard__item: POINTER
		do
			if attached a_pasteboard as a_pasteboard_attached then
				a_pasteboard__item := a_pasteboard_attached.item
			end
			objc_write_to_pasteboard_ (item, a_pasteboard__item)
		end

	play: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_play (item)
		end

	pause: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_pause (item)
		end

	resume: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_resume (item)
		end

	stop: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_stop (item)
		end

	is_playing: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_playing (item)
		end

	delegate: detachable NS_SOUND_DELEGATE_PROTOCOL
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

	set_delegate_ (a_delegate: detachable NS_SOUND_DELEGATE_PROTOCOL)
			-- Auto generated Objective-C wrapper.
		local
			a_delegate__item: POINTER
		do
			if attached a_delegate as a_delegate_attached then
				a_delegate__item := a_delegate_attached.item
			end
			objc_set_delegate_ (item, a_delegate__item)
		end

	duration: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_duration (item)
		end

	set_volume_ (a_volume: REAL_32)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_volume_ (item, a_volume)
		end

	volume: REAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_volume (item)
		end

	current_time: REAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_current_time (item)
		end

	set_current_time_ (a_seconds: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_current_time_ (item, a_seconds)
		end

	set_loops_ (a_val: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_loops_ (item, a_val)
		end

	loops: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_loops (item)
		end

	set_playback_device_identifier_ (a_device_uid: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_device_uid__item: POINTER
		do
			if attached a_device_uid as a_device_uid_attached then
				a_device_uid__item := a_device_uid_attached.item
			end
			objc_set_playback_device_identifier_ (item, a_device_uid__item)
		end

	playback_device_identifier: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_playback_device_identifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like playback_device_identifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like playback_device_identifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_channel_mapping_ (a_channel_mapping: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_channel_mapping__item: POINTER
		do
			if attached a_channel_mapping as a_channel_mapping_attached then
				a_channel_mapping__item := a_channel_mapping_attached.item
			end
			objc_set_channel_mapping_ (item, a_channel_mapping__item)
		end

	channel_mapping: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_channel_mapping (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like channel_mapping} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like channel_mapping} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSSound"
		end

end

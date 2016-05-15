note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_OBJECT

inherit
	NS_COMMON
	NS_OBJECT_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
		do
			make_with_pointer (objc_init(allocate_object))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSObject Externals

	objc_init (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item init];
			 ]"
		end

	objc_dealloc (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item dealloc];
			 ]"
		end

	objc_finalize (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item finalize];
			 ]"
		end

	objc_copy_objc (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item copy];
			 ]"
		end

	objc_mutable_copy (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item mutableCopy];
			 ]"
		end

--	objc_method_for_selector_ (an_item: POINTER; a_selector: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSObject *)$an_item methodForSelector:$a_selector];
--			 ]"
--		end

	objc_does_not_recognize_selector_ (an_item: POINTER; a_selector: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item doesNotRecognizeSelector:$a_selector];
			 ]"
		end

	objc_forwarding_target_for_selector_ (an_item: POINTER; a_selector: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item forwardingTargetForSelector:$a_selector];
			 ]"
		end

	objc_forward_invocation_ (an_item: POINTER; an_invocation: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item forwardInvocation:$an_invocation];
			 ]"
		end

	objc_method_signature_for_selector_ (an_item: POINTER; a_selector: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item methodSignatureForSelector:$a_selector];
			 ]"
		end

feature -- NSObject

	dealloc
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_dealloc (item)
		end

	finalize
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_finalize (item)
		end

	copy_objc: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_copy_objc (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like copy_objc} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like copy_objc} new_eiffel_object (result_pointer, False) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	mutable_copy: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_mutable_copy (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mutable_copy} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mutable_copy} new_eiffel_object (result_pointer, False) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

--	method_for_selector_ (a_selector: detachable OBJC_SELECTOR): UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--			a_selector__item: POINTER
--		do
--			if attached a_selector as a_selector_attached then
--				a_selector__item := a_selector_attached.item
--			end
--			result_pointer := objc_method_for_selector_ (item, a_selector__item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like method_for_selector_} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like method_for_selector_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

	does_not_recognize_selector_ (a_selector: detachable OBJC_SELECTOR)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			objc_does_not_recognize_selector_ (item, a_selector__item)
		end

	forwarding_target_for_selector_ (a_selector: detachable OBJC_SELECTOR): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			result_pointer := objc_forwarding_target_for_selector_ (item, a_selector__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like forwarding_target_for_selector_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like forwarding_target_for_selector_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	forward_invocation_ (an_invocation: detachable NS_INVOCATION)
			-- Auto generated Objective-C wrapper.
		local
			an_invocation__item: POINTER
		do
			if attached an_invocation as an_invocation_attached then
				an_invocation__item := an_invocation_attached.item
			end
			objc_forward_invocation_ (item, an_invocation__item)
		end

	method_signature_for_selector_ (a_selector: detachable OBJC_SELECTOR): detachable NS_METHOD_SIGNATURE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_selector__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			result_pointer := objc_method_signature_for_selector_ (item, a_selector__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like method_signature_for_selector_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like method_signature_for_selector_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature -- NSCoderMethods

	class_for_coder: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_class_for_coder (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_for_coder} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_for_coder} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	replacement_object_for_coder_ (a_coder: detachable NS_CODER): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_coder__item: POINTER
		do
			if attached a_coder as a_coder_attached then
				a_coder__item := a_coder_attached.item
			end
			result_pointer := objc_replacement_object_for_coder_ (item, a_coder__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like replacement_object_for_coder_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like replacement_object_for_coder_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	awake_after_using_coder_ (a_decoder: detachable NS_CODER): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_decoder__item: POINTER
		do
			if attached a_decoder as a_decoder_attached then
				a_decoder__item := a_decoder_attached.item
			end
			result_pointer := objc_awake_after_using_coder_ (item, a_decoder__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like awake_after_using_coder_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like awake_after_using_coder_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSCoderMethods Externals

	objc_class_for_coder (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item classForCoder];
			 ]"
		end

	objc_replacement_object_for_coder_ (an_item: POINTER; a_coder: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item replacementObjectForCoder:$a_coder];
			 ]"
		end

	objc_awake_after_using_coder_ (an_item: POINTER; a_decoder: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item awakeAfterUsingCoder:$a_decoder];
			 ]"
		end

feature -- NSDiscardableContentProxy

	auto_content_accessing_proxy: detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_auto_content_accessing_proxy (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like auto_content_accessing_proxy} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like auto_content_accessing_proxy} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSDiscardableContentProxy Externals

	objc_auto_content_accessing_proxy (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item autoContentAccessingProxy];
			 ]"
		end

feature -- NSErrorRecoveryAttempting

--	attempt_recovery_from_error__option_index__delegate__did_recover_selector__context_info_ (a_error: detachable NS_ERROR; a_recovery_option_index: NATURAL_64; a_delegate: detachable NS_OBJECT; a_did_recover_selector: detachable OBJC_SELECTOR; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_error__item: POINTER
--			a_delegate__item: POINTER
--			a_did_recover_selector__item: POINTER
--			a_context_info__item: POINTER
--		do
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			if attached a_delegate as a_delegate_attached then
--				a_delegate__item := a_delegate_attached.item
--			end
--			if attached a_did_recover_selector as a_did_recover_selector_attached then
--				a_did_recover_selector__item := a_did_recover_selector_attached.item
--			end
--			if attached a_context_info as a_context_info_attached then
--				a_context_info__item := a_context_info_attached.item
--			end
--			objc_attempt_recovery_from_error__option_index__delegate__did_recover_selector__context_info_ (item, a_error__item, a_recovery_option_index, a_delegate__item, a_did_recover_selector__item, a_context_info__item)
--		end

	attempt_recovery_from_error__option_index_ (a_error: detachable NS_ERROR; a_recovery_option_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_error__item: POINTER
		do
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			Result := objc_attempt_recovery_from_error__option_index_ (item, a_error__item, a_recovery_option_index)
		end

feature {NONE} -- NSErrorRecoveryAttempting Externals

--	objc_attempt_recovery_from_error__option_index__delegate__did_recover_selector__context_info_ (an_item: POINTER; a_error: POINTER; a_recovery_option_index: NATURAL_64; a_delegate: POINTER; a_did_recover_selector: POINTER; a_context_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSObject *)$an_item attemptRecoveryFromError:$a_error optionIndex:$a_recovery_option_index delegate:$a_delegate didRecoverSelector:$a_did_recover_selector contextInfo:];
--			 ]"
--		end

	objc_attempt_recovery_from_error__option_index_ (an_item: POINTER; a_error: POINTER; a_recovery_option_index: NATURAL_64): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item attemptRecoveryFromError:$a_error optionIndex:$a_recovery_option_index];
			 ]"
		end

feature -- NSFileManagerFileOperationAdditions

	file_manager__should_copy_item_at_path__to_path_ (a_file_manager: detachable NS_FILE_MANAGER; a_src_path: detachable NS_STRING; a_dst_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_src_path__item: POINTER
			a_dst_path__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_src_path as a_src_path_attached then
				a_src_path__item := a_src_path_attached.item
			end
			if attached a_dst_path as a_dst_path_attached then
				a_dst_path__item := a_dst_path_attached.item
			end
			Result := objc_file_manager__should_copy_item_at_path__to_path_ (item, a_file_manager__item, a_src_path__item, a_dst_path__item)
		end

	file_manager__should_copy_item_at_ur_l__to_ur_l_ (a_file_manager: detachable NS_FILE_MANAGER; a_src_url: detachable NS_URL; a_dst_url: detachable NS_URL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_src_url__item: POINTER
			a_dst_url__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_src_url as a_src_url_attached then
				a_src_url__item := a_src_url_attached.item
			end
			if attached a_dst_url as a_dst_url_attached then
				a_dst_url__item := a_dst_url_attached.item
			end
			Result := objc_file_manager__should_copy_item_at_ur_l__to_ur_l_ (item, a_file_manager__item, a_src_url__item, a_dst_url__item)
		end

	file_manager__should_proceed_after_error__copying_item_at_path__to_path_ (a_file_manager: detachable NS_FILE_MANAGER; a_error: detachable NS_ERROR; a_src_path: detachable NS_STRING; a_dst_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_error__item: POINTER
			a_src_path__item: POINTER
			a_dst_path__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			if attached a_src_path as a_src_path_attached then
				a_src_path__item := a_src_path_attached.item
			end
			if attached a_dst_path as a_dst_path_attached then
				a_dst_path__item := a_dst_path_attached.item
			end
			Result := objc_file_manager__should_proceed_after_error__copying_item_at_path__to_path_ (item, a_file_manager__item, a_error__item, a_src_path__item, a_dst_path__item)
		end

	file_manager__should_proceed_after_error__copying_item_at_ur_l__to_ur_l_ (a_file_manager: detachable NS_FILE_MANAGER; a_error: detachable NS_ERROR; a_src_url: detachable NS_URL; a_dst_url: detachable NS_URL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_error__item: POINTER
			a_src_url__item: POINTER
			a_dst_url__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			if attached a_src_url as a_src_url_attached then
				a_src_url__item := a_src_url_attached.item
			end
			if attached a_dst_url as a_dst_url_attached then
				a_dst_url__item := a_dst_url_attached.item
			end
			Result := objc_file_manager__should_proceed_after_error__copying_item_at_ur_l__to_ur_l_ (item, a_file_manager__item, a_error__item, a_src_url__item, a_dst_url__item)
		end

	file_manager__should_move_item_at_path__to_path_ (a_file_manager: detachable NS_FILE_MANAGER; a_src_path: detachable NS_STRING; a_dst_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_src_path__item: POINTER
			a_dst_path__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_src_path as a_src_path_attached then
				a_src_path__item := a_src_path_attached.item
			end
			if attached a_dst_path as a_dst_path_attached then
				a_dst_path__item := a_dst_path_attached.item
			end
			Result := objc_file_manager__should_move_item_at_path__to_path_ (item, a_file_manager__item, a_src_path__item, a_dst_path__item)
		end

	file_manager__should_move_item_at_ur_l__to_ur_l_ (a_file_manager: detachable NS_FILE_MANAGER; a_src_url: detachable NS_URL; a_dst_url: detachable NS_URL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_src_url__item: POINTER
			a_dst_url__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_src_url as a_src_url_attached then
				a_src_url__item := a_src_url_attached.item
			end
			if attached a_dst_url as a_dst_url_attached then
				a_dst_url__item := a_dst_url_attached.item
			end
			Result := objc_file_manager__should_move_item_at_ur_l__to_ur_l_ (item, a_file_manager__item, a_src_url__item, a_dst_url__item)
		end

	file_manager__should_proceed_after_error__moving_item_at_path__to_path_ (a_file_manager: detachable NS_FILE_MANAGER; a_error: detachable NS_ERROR; a_src_path: detachable NS_STRING; a_dst_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_error__item: POINTER
			a_src_path__item: POINTER
			a_dst_path__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			if attached a_src_path as a_src_path_attached then
				a_src_path__item := a_src_path_attached.item
			end
			if attached a_dst_path as a_dst_path_attached then
				a_dst_path__item := a_dst_path_attached.item
			end
			Result := objc_file_manager__should_proceed_after_error__moving_item_at_path__to_path_ (item, a_file_manager__item, a_error__item, a_src_path__item, a_dst_path__item)
		end

	file_manager__should_proceed_after_error__moving_item_at_ur_l__to_ur_l_ (a_file_manager: detachable NS_FILE_MANAGER; a_error: detachable NS_ERROR; a_src_url: detachable NS_URL; a_dst_url: detachable NS_URL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_error__item: POINTER
			a_src_url__item: POINTER
			a_dst_url__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			if attached a_src_url as a_src_url_attached then
				a_src_url__item := a_src_url_attached.item
			end
			if attached a_dst_url as a_dst_url_attached then
				a_dst_url__item := a_dst_url_attached.item
			end
			Result := objc_file_manager__should_proceed_after_error__moving_item_at_ur_l__to_ur_l_ (item, a_file_manager__item, a_error__item, a_src_url__item, a_dst_url__item)
		end

	file_manager__should_link_item_at_path__to_path_ (a_file_manager: detachable NS_FILE_MANAGER; a_src_path: detachable NS_STRING; a_dst_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_src_path__item: POINTER
			a_dst_path__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_src_path as a_src_path_attached then
				a_src_path__item := a_src_path_attached.item
			end
			if attached a_dst_path as a_dst_path_attached then
				a_dst_path__item := a_dst_path_attached.item
			end
			Result := objc_file_manager__should_link_item_at_path__to_path_ (item, a_file_manager__item, a_src_path__item, a_dst_path__item)
		end

	file_manager__should_link_item_at_ur_l__to_ur_l_ (a_file_manager: detachable NS_FILE_MANAGER; a_src_url: detachable NS_URL; a_dst_url: detachable NS_URL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_src_url__item: POINTER
			a_dst_url__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_src_url as a_src_url_attached then
				a_src_url__item := a_src_url_attached.item
			end
			if attached a_dst_url as a_dst_url_attached then
				a_dst_url__item := a_dst_url_attached.item
			end
			Result := objc_file_manager__should_link_item_at_ur_l__to_ur_l_ (item, a_file_manager__item, a_src_url__item, a_dst_url__item)
		end

	file_manager__should_proceed_after_error__linking_item_at_path__to_path_ (a_file_manager: detachable NS_FILE_MANAGER; a_error: detachable NS_ERROR; a_src_path: detachable NS_STRING; a_dst_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_error__item: POINTER
			a_src_path__item: POINTER
			a_dst_path__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			if attached a_src_path as a_src_path_attached then
				a_src_path__item := a_src_path_attached.item
			end
			if attached a_dst_path as a_dst_path_attached then
				a_dst_path__item := a_dst_path_attached.item
			end
			Result := objc_file_manager__should_proceed_after_error__linking_item_at_path__to_path_ (item, a_file_manager__item, a_error__item, a_src_path__item, a_dst_path__item)
		end

	file_manager__should_proceed_after_error__linking_item_at_ur_l__to_ur_l_ (a_file_manager: detachable NS_FILE_MANAGER; a_error: detachable NS_ERROR; a_src_url: detachable NS_URL; a_dst_url: detachable NS_URL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_error__item: POINTER
			a_src_url__item: POINTER
			a_dst_url__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			if attached a_src_url as a_src_url_attached then
				a_src_url__item := a_src_url_attached.item
			end
			if attached a_dst_url as a_dst_url_attached then
				a_dst_url__item := a_dst_url_attached.item
			end
			Result := objc_file_manager__should_proceed_after_error__linking_item_at_ur_l__to_ur_l_ (item, a_file_manager__item, a_error__item, a_src_url__item, a_dst_url__item)
		end

	file_manager__should_remove_item_at_path_ (a_file_manager: detachable NS_FILE_MANAGER; a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_path__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_file_manager__should_remove_item_at_path_ (item, a_file_manager__item, a_path__item)
		end

	file_manager__should_remove_item_at_ur_l_ (a_file_manager: detachable NS_FILE_MANAGER; a_url: detachable NS_URL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_url__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			Result := objc_file_manager__should_remove_item_at_ur_l_ (item, a_file_manager__item, a_url__item)
		end

	file_manager__should_proceed_after_error__removing_item_at_path_ (a_file_manager: detachable NS_FILE_MANAGER; a_error: detachable NS_ERROR; a_path: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_error__item: POINTER
			a_path__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			Result := objc_file_manager__should_proceed_after_error__removing_item_at_path_ (item, a_file_manager__item, a_error__item, a_path__item)
		end

	file_manager__should_proceed_after_error__removing_item_at_ur_l_ (a_file_manager: detachable NS_FILE_MANAGER; a_error: detachable NS_ERROR; a_url: detachable NS_URL): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_file_manager__item: POINTER
			a_error__item: POINTER
			a_url__item: POINTER
		do
			if attached a_file_manager as a_file_manager_attached then
				a_file_manager__item := a_file_manager_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			if attached a_url as a_url_attached then
				a_url__item := a_url_attached.item
			end
			Result := objc_file_manager__should_proceed_after_error__removing_item_at_ur_l_ (item, a_file_manager__item, a_error__item, a_url__item)
		end

feature {NONE} -- NSFileManagerFileOperationAdditions Externals

	objc_file_manager__should_copy_item_at_path__to_path_ (an_item: POINTER; a_file_manager: POINTER; a_src_path: POINTER; a_dst_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldCopyItemAtPath:$a_src_path toPath:$a_dst_path];
			 ]"
		end

	objc_file_manager__should_copy_item_at_ur_l__to_ur_l_ (an_item: POINTER; a_file_manager: POINTER; a_src_url: POINTER; a_dst_url: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldCopyItemAtURL:$a_src_url toURL:$a_dst_url];
			 ]"
		end

	objc_file_manager__should_proceed_after_error__copying_item_at_path__to_path_ (an_item: POINTER; a_file_manager: POINTER; a_error: POINTER; a_src_path: POINTER; a_dst_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldProceedAfterError:$a_error copyingItemAtPath:$a_src_path toPath:$a_dst_path];
			 ]"
		end

	objc_file_manager__should_proceed_after_error__copying_item_at_ur_l__to_ur_l_ (an_item: POINTER; a_file_manager: POINTER; a_error: POINTER; a_src_url: POINTER; a_dst_url: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldProceedAfterError:$a_error copyingItemAtURL:$a_src_url toURL:$a_dst_url];
			 ]"
		end

	objc_file_manager__should_move_item_at_path__to_path_ (an_item: POINTER; a_file_manager: POINTER; a_src_path: POINTER; a_dst_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldMoveItemAtPath:$a_src_path toPath:$a_dst_path];
			 ]"
		end

	objc_file_manager__should_move_item_at_ur_l__to_ur_l_ (an_item: POINTER; a_file_manager: POINTER; a_src_url: POINTER; a_dst_url: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldMoveItemAtURL:$a_src_url toURL:$a_dst_url];
			 ]"
		end

	objc_file_manager__should_proceed_after_error__moving_item_at_path__to_path_ (an_item: POINTER; a_file_manager: POINTER; a_error: POINTER; a_src_path: POINTER; a_dst_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldProceedAfterError:$a_error movingItemAtPath:$a_src_path toPath:$a_dst_path];
			 ]"
		end

	objc_file_manager__should_proceed_after_error__moving_item_at_ur_l__to_ur_l_ (an_item: POINTER; a_file_manager: POINTER; a_error: POINTER; a_src_url: POINTER; a_dst_url: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldProceedAfterError:$a_error movingItemAtURL:$a_src_url toURL:$a_dst_url];
			 ]"
		end

	objc_file_manager__should_link_item_at_path__to_path_ (an_item: POINTER; a_file_manager: POINTER; a_src_path: POINTER; a_dst_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldLinkItemAtPath:$a_src_path toPath:$a_dst_path];
			 ]"
		end

	objc_file_manager__should_link_item_at_ur_l__to_ur_l_ (an_item: POINTER; a_file_manager: POINTER; a_src_url: POINTER; a_dst_url: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldLinkItemAtURL:$a_src_url toURL:$a_dst_url];
			 ]"
		end

	objc_file_manager__should_proceed_after_error__linking_item_at_path__to_path_ (an_item: POINTER; a_file_manager: POINTER; a_error: POINTER; a_src_path: POINTER; a_dst_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldProceedAfterError:$a_error linkingItemAtPath:$a_src_path toPath:$a_dst_path];
			 ]"
		end

	objc_file_manager__should_proceed_after_error__linking_item_at_ur_l__to_ur_l_ (an_item: POINTER; a_file_manager: POINTER; a_error: POINTER; a_src_url: POINTER; a_dst_url: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldProceedAfterError:$a_error linkingItemAtURL:$a_src_url toURL:$a_dst_url];
			 ]"
		end

	objc_file_manager__should_remove_item_at_path_ (an_item: POINTER; a_file_manager: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldRemoveItemAtPath:$a_path];
			 ]"
		end

	objc_file_manager__should_remove_item_at_ur_l_ (an_item: POINTER; a_file_manager: POINTER; a_url: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldRemoveItemAtURL:$a_url];
			 ]"
		end

	objc_file_manager__should_proceed_after_error__removing_item_at_path_ (an_item: POINTER; a_file_manager: POINTER; a_error: POINTER; a_path: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldProceedAfterError:$a_error removingItemAtPath:$a_path];
			 ]"
		end

	objc_file_manager__should_proceed_after_error__removing_item_at_ur_l_ (an_item: POINTER; a_file_manager: POINTER; a_error: POINTER; a_url: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item fileManager:$a_file_manager shouldProceedAfterError:$a_error removingItemAtURL:$a_url];
			 ]"
		end

feature -- NSKeyValueCoding

	value_for_key_ (a_key: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_value_for_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_value__for_key_ (a_value: detachable NS_OBJECT; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
			a_key__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_set_value__for_key_ (item, a_value__item, a_key__item)
		end

--	validate_value__for_key__error_ (a_io_value: UNSUPPORTED_TYPE; a_in_key: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_io_value__item: POINTER
--			a_in_key__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_io_value as a_io_value_attached then
--				a_io_value__item := a_io_value_attached.item
--			end
--			if attached a_in_key as a_in_key_attached then
--				a_in_key__item := a_in_key_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			Result := objc_validate_value__for_key__error_ (item, a_io_value__item, a_in_key__item, a_out_error__item)
--		end

	mutable_array_value_for_key_ (a_key: detachable NS_STRING): detachable NS_MUTABLE_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_mutable_array_value_for_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mutable_array_value_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mutable_array_value_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	mutable_set_value_for_key_ (a_key: detachable NS_STRING): detachable NS_MUTABLE_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_mutable_set_value_for_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mutable_set_value_for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mutable_set_value_for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	value_for_key_path_ (a_key_path: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key_path__item: POINTER
		do
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			result_pointer := objc_value_for_key_path_ (item, a_key_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_for_key_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_for_key_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_value__for_key_path_ (a_value: detachable NS_OBJECT; a_key_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
			a_key_path__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			objc_set_value__for_key_path_ (item, a_value__item, a_key_path__item)
		end

--	validate_value__for_key_path__error_ (a_io_value: UNSUPPORTED_TYPE; a_in_key_path: detachable NS_STRING; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		local
--			a_io_value__item: POINTER
--			a_in_key_path__item: POINTER
--			a_out_error__item: POINTER
--		do
--			if attached a_io_value as a_io_value_attached then
--				a_io_value__item := a_io_value_attached.item
--			end
--			if attached a_in_key_path as a_in_key_path_attached then
--				a_in_key_path__item := a_in_key_path_attached.item
--			end
--			if attached a_out_error as a_out_error_attached then
--				a_out_error__item := a_out_error_attached.item
--			end
--			Result := objc_validate_value__for_key_path__error_ (item, a_io_value__item, a_in_key_path__item, a_out_error__item)
--		end

	mutable_array_value_for_key_path_ (a_key_path: detachable NS_STRING): detachable NS_MUTABLE_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key_path__item: POINTER
		do
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			result_pointer := objc_mutable_array_value_for_key_path_ (item, a_key_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mutable_array_value_for_key_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mutable_array_value_for_key_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	mutable_set_value_for_key_path_ (a_key_path: detachable NS_STRING): detachable NS_MUTABLE_SET
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key_path__item: POINTER
		do
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			result_pointer := objc_mutable_set_value_for_key_path_ (item, a_key_path__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like mutable_set_value_for_key_path_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like mutable_set_value_for_key_path_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	value_for_undefined_key_ (a_key: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_value_for_undefined_key_ (item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_for_undefined_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_for_undefined_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_value__for_undefined_key_ (a_value: detachable NS_OBJECT; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
			a_key__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_set_value__for_undefined_key_ (item, a_value__item, a_key__item)
		end

	set_nil_value_for_key_ (a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_set_nil_value_for_key_ (item, a_key__item)
		end

	dictionary_with_values_for_keys_ (a_keys: detachable NS_ARRAY): detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_keys__item: POINTER
		do
			if attached a_keys as a_keys_attached then
				a_keys__item := a_keys_attached.item
			end
			result_pointer := objc_dictionary_with_values_for_keys_ (item, a_keys__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like dictionary_with_values_for_keys_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like dictionary_with_values_for_keys_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_values_for_keys_with_dictionary_ (a_keyed_values: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_keyed_values__item: POINTER
		do
			if attached a_keyed_values as a_keyed_values_attached then
				a_keyed_values__item := a_keyed_values_attached.item
			end
			objc_set_values_for_keys_with_dictionary_ (item, a_keyed_values__item)
		end

feature {NONE} -- NSKeyValueCoding Externals

	objc_value_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item valueForKey:$a_key];
			 ]"
		end

	objc_set_value__for_key_ (an_item: POINTER; a_value: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item setValue:$a_value forKey:$a_key];
			 ]"
		end

--	objc_validate_value__for_key__error_ (an_item: POINTER; a_io_value: UNSUPPORTED_TYPE; a_in_key: POINTER; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSObject *)$an_item validateValue: forKey:$a_in_key error:];
--			 ]"
--		end

	objc_mutable_array_value_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item mutableArrayValueForKey:$a_key];
			 ]"
		end

	objc_mutable_set_value_for_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item mutableSetValueForKey:$a_key];
			 ]"
		end

	objc_value_for_key_path_ (an_item: POINTER; a_key_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item valueForKeyPath:$a_key_path];
			 ]"
		end

	objc_set_value__for_key_path_ (an_item: POINTER; a_value: POINTER; a_key_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item setValue:$a_value forKeyPath:$a_key_path];
			 ]"
		end

--	objc_validate_value__for_key_path__error_ (an_item: POINTER; a_io_value: UNSUPPORTED_TYPE; a_in_key_path: POINTER; a_out_error: UNSUPPORTED_TYPE): BOOLEAN
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return [(NSObject *)$an_item validateValue: forKeyPath:$a_in_key_path error:];
--			 ]"
--		end

	objc_mutable_array_value_for_key_path_ (an_item: POINTER; a_key_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item mutableArrayValueForKeyPath:$a_key_path];
			 ]"
		end

	objc_mutable_set_value_for_key_path_ (an_item: POINTER; a_key_path: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item mutableSetValueForKeyPath:$a_key_path];
			 ]"
		end

	objc_value_for_undefined_key_ (an_item: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item valueForUndefinedKey:$a_key];
			 ]"
		end

	objc_set_value__for_undefined_key_ (an_item: POINTER; a_value: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item setValue:$a_value forUndefinedKey:$a_key];
			 ]"
		end

	objc_set_nil_value_for_key_ (an_item: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item setNilValueForKey:$a_key];
			 ]"
		end

	objc_dictionary_with_values_for_keys_ (an_item: POINTER; a_keys: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item dictionaryWithValuesForKeys:$a_keys];
			 ]"
		end

	objc_set_values_for_keys_with_dictionary_ (an_item: POINTER; a_keyed_values: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item setValuesForKeysWithDictionary:$a_keyed_values];
			 ]"
		end

feature -- NSKeyValueObserving

--	observe_value_for_key_path__of_object__change__context_ (a_key_path: detachable NS_STRING; a_object: detachable NS_OBJECT; a_change: detachable NS_DICTIONARY; a_context: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_key_path__item: POINTER
--			a_object__item: POINTER
--			a_change__item: POINTER
--			a_context__item: POINTER
--		do
--			if attached a_key_path as a_key_path_attached then
--				a_key_path__item := a_key_path_attached.item
--			end
--			if attached a_object as a_object_attached then
--				a_object__item := a_object_attached.item
--			end
--			if attached a_change as a_change_attached then
--				a_change__item := a_change_attached.item
--			end
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			objc_observe_value_for_key_path__of_object__change__context_ (item, a_key_path__item, a_object__item, a_change__item, a_context__item)
--		end

feature {NONE} -- NSKeyValueObserving Externals

--	objc_observe_value_for_key_path__of_object__change__context_ (an_item: POINTER; a_key_path: POINTER; a_object: POINTER; a_change: POINTER; a_context: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSObject *)$an_item observeValueForKeyPath:$a_key_path ofObject:$a_object change:$a_change context:];
--			 ]"
--		end

feature -- NSKeyValueObserverRegistration

--	add_observer__for_key_path__options__context_ (a_observer: detachable NS_OBJECT; a_key_path: detachable NS_STRING; a_options: NATURAL_64; a_context: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_observer__item: POINTER
--			a_key_path__item: POINTER
--			a_context__item: POINTER
--		do
--			if attached a_observer as a_observer_attached then
--				a_observer__item := a_observer_attached.item
--			end
--			if attached a_key_path as a_key_path_attached then
--				a_key_path__item := a_key_path_attached.item
--			end
--			if attached a_context as a_context_attached then
--				a_context__item := a_context_attached.item
--			end
--			objc_add_observer__for_key_path__options__context_ (item, a_observer__item, a_key_path__item, a_options, a_context__item)
--		end

	remove_observer__for_key_path_ (a_observer: detachable NS_OBJECT; a_key_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_observer__item: POINTER
			a_key_path__item: POINTER
		do
			if attached a_observer as a_observer_attached then
				a_observer__item := a_observer_attached.item
			end
			if attached a_key_path as a_key_path_attached then
				a_key_path__item := a_key_path_attached.item
			end
			objc_remove_observer__for_key_path_ (item, a_observer__item, a_key_path__item)
		end

feature {NONE} -- NSKeyValueObserverRegistration Externals

--	objc_add_observer__for_key_path__options__context_ (an_item: POINTER; a_observer: POINTER; a_key_path: POINTER; a_options: NATURAL_64; a_context: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSObject *)$an_item addObserver:$a_observer forKeyPath:$a_key_path options:$a_options context:];
--			 ]"
--		end

	objc_remove_observer__for_key_path_ (an_item: POINTER; a_observer: POINTER; a_key_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item removeObserver:$a_observer forKeyPath:$a_key_path];
			 ]"
		end

feature -- NSKeyValueObserverNotification

	will_change_value_for_key_ (a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_will_change_value_for_key_ (item, a_key__item)
		end

	did_change_value_for_key_ (a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_did_change_value_for_key_ (item, a_key__item)
		end

	will_change__values_at_indexes__for_key_ (a_change_kind: NATURAL_64; a_indexes: detachable NS_INDEX_SET; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_indexes__item: POINTER
			a_key__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_will_change__values_at_indexes__for_key_ (item, a_change_kind, a_indexes__item, a_key__item)
		end

	did_change__values_at_indexes__for_key_ (a_change_kind: NATURAL_64; a_indexes: detachable NS_INDEX_SET; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_indexes__item: POINTER
			a_key__item: POINTER
		do
			if attached a_indexes as a_indexes_attached then
				a_indexes__item := a_indexes_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_did_change__values_at_indexes__for_key_ (item, a_change_kind, a_indexes__item, a_key__item)
		end

	will_change_value_for_key__with_set_mutation__using_objects_ (a_key: detachable NS_STRING; a_mutation_kind: NATURAL_64; a_objects: detachable NS_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
			a_objects__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			objc_will_change_value_for_key__with_set_mutation__using_objects_ (item, a_key__item, a_mutation_kind, a_objects__item)
		end

	did_change_value_for_key__with_set_mutation__using_objects_ (a_key: detachable NS_STRING; a_mutation_kind: NATURAL_64; a_objects: detachable NS_SET)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
			a_objects__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_objects as a_objects_attached then
				a_objects__item := a_objects_attached.item
			end
			objc_did_change_value_for_key__with_set_mutation__using_objects_ (item, a_key__item, a_mutation_kind, a_objects__item)
		end

feature {NONE} -- NSKeyValueObserverNotification Externals

	objc_will_change_value_for_key_ (an_item: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item willChangeValueForKey:$a_key];
			 ]"
		end

	objc_did_change_value_for_key_ (an_item: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item didChangeValueForKey:$a_key];
			 ]"
		end

	objc_will_change__values_at_indexes__for_key_ (an_item: POINTER; a_change_kind: NATURAL_64; a_indexes: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item willChange:$a_change_kind valuesAtIndexes:$a_indexes forKey:$a_key];
			 ]"
		end

	objc_did_change__values_at_indexes__for_key_ (an_item: POINTER; a_change_kind: NATURAL_64; a_indexes: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item didChange:$a_change_kind valuesAtIndexes:$a_indexes forKey:$a_key];
			 ]"
		end

	objc_will_change_value_for_key__with_set_mutation__using_objects_ (an_item: POINTER; a_key: POINTER; a_mutation_kind: NATURAL_64; a_objects: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item willChangeValueForKey:$a_key withSetMutation:$a_mutation_kind usingObjects:$a_objects];
			 ]"
		end

	objc_did_change_value_for_key__with_set_mutation__using_objects_ (an_item: POINTER; a_key: POINTER; a_mutation_kind: NATURAL_64; a_objects: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item didChangeValueForKey:$a_key withSetMutation:$a_mutation_kind usingObjects:$a_objects];
			 ]"
		end

feature -- NSKeyValueObservingCustomization

--	set_observation_info_ (a_observation_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		local
--			a_observation_info__item: POINTER
--		do
--			if attached a_observation_info as a_observation_info_attached then
--				a_observation_info__item := a_observation_info_attached.item
--			end
--			objc_set_observation_info_ (item, a_observation_info__item)
--		end

--	observation_info: UNSUPPORTED_TYPE
--			-- Auto generated Objective-C wrapper.
--		local
--			result_pointer: POINTER
--		do
--			result_pointer := objc_observation_info (item)
--			if result_pointer /= default_pointer then
--				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
--					check attached {like observation_info} existing_eiffel_object as valid_result then
--						Result := valid_result
--					end
--				else
--					check attached {like observation_info} new_eiffel_object (result_pointer, True) as valid_result_pointer then
--						Result := valid_result_pointer
--					end
--				end
--			end
--		end

feature {NONE} -- NSKeyValueObservingCustomization Externals

--	objc_set_observation_info_ (an_item: POINTER; a_observation_info: UNSUPPORTED_TYPE)
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				[(NSObject *)$an_item setObservationInfo:];
--			 ]"
--		end

--	objc_observation_info (an_item: POINTER): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSObject *)$an_item observationInfo];
--			 ]"
--		end

feature -- NSKeyedArchiverObjectSubstitution

	class_for_keyed_archiver: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_class_for_keyed_archiver (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_for_keyed_archiver} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_for_keyed_archiver} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	replacement_object_for_keyed_archiver_ (a_archiver: detachable NS_KEYED_ARCHIVER): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_archiver__item: POINTER
		do
			if attached a_archiver as a_archiver_attached then
				a_archiver__item := a_archiver_attached.item
			end
			result_pointer := objc_replacement_object_for_keyed_archiver_ (item, a_archiver__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like replacement_object_for_keyed_archiver_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like replacement_object_for_keyed_archiver_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSKeyedArchiverObjectSubstitution Externals

	objc_class_for_keyed_archiver (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item classForKeyedArchiver];
			 ]"
		end

	objc_replacement_object_for_keyed_archiver_ (an_item: POINTER; a_archiver: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item replacementObjectForKeyedArchiver:$a_archiver];
			 ]"
		end

feature -- NSDelayedPerforming

	perform_selector__with_object__after_delay__in_modes_ (a_selector: detachable OBJC_SELECTOR; an_argument: detachable NS_OBJECT; a_delay: REAL_64; a_modes: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
			an_argument__item: POINTER
			a_modes__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached an_argument as an_argument_attached then
				an_argument__item := an_argument_attached.item
			end
			if attached a_modes as a_modes_attached then
				a_modes__item := a_modes_attached.item
			end
			objc_perform_selector__with_object__after_delay__in_modes_ (item, a_selector__item, an_argument__item, a_delay, a_modes__item)
		end

	perform_selector__with_object__after_delay_ (a_selector: detachable OBJC_SELECTOR; an_argument: detachable NS_OBJECT; a_delay: REAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
			an_argument__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached an_argument as an_argument_attached then
				an_argument__item := an_argument_attached.item
			end
			objc_perform_selector__with_object__after_delay_ (item, a_selector__item, an_argument__item, a_delay)
		end

feature {NONE} -- NSDelayedPerforming Externals

	objc_perform_selector__with_object__after_delay__in_modes_ (an_item: POINTER; a_selector: POINTER; an_argument: POINTER; a_delay: REAL_64; a_modes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item performSelector:$a_selector withObject:$an_argument afterDelay:$a_delay inModes:$a_modes];
			 ]"
		end

	objc_perform_selector__with_object__after_delay_ (an_item: POINTER; a_selector: POINTER; an_argument: POINTER; a_delay: REAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item performSelector:$a_selector withObject:$an_argument afterDelay:$a_delay];
			 ]"
		end

feature -- NSThreadPerformAdditions

	perform_selector_on_main_thread__with_object__wait_until_done__modes_ (a_selector: detachable OBJC_SELECTOR; a_arg: detachable NS_OBJECT; a_wait: BOOLEAN; a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
			a_arg__item: POINTER
			a_array__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_arg as a_arg_attached then
				a_arg__item := a_arg_attached.item
			end
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_perform_selector_on_main_thread__with_object__wait_until_done__modes_ (item, a_selector__item, a_arg__item, a_wait, a_array__item)
		end

	perform_selector_on_main_thread__with_object__wait_until_done_ (a_selector: detachable OBJC_SELECTOR; a_arg: detachable NS_OBJECT; a_wait: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
			a_arg__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_arg as a_arg_attached then
				a_arg__item := a_arg_attached.item
			end
			objc_perform_selector_on_main_thread__with_object__wait_until_done_ (item, a_selector__item, a_arg__item, a_wait)
		end

	perform_selector__on_thread__with_object__wait_until_done__modes_ (a_selector: detachable OBJC_SELECTOR; a_thr: detachable NS_THREAD; a_arg: detachable NS_OBJECT; a_wait: BOOLEAN; a_array: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
			a_thr__item: POINTER
			a_arg__item: POINTER
			a_array__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_thr as a_thr_attached then
				a_thr__item := a_thr_attached.item
			end
			if attached a_arg as a_arg_attached then
				a_arg__item := a_arg_attached.item
			end
			if attached a_array as a_array_attached then
				a_array__item := a_array_attached.item
			end
			objc_perform_selector__on_thread__with_object__wait_until_done__modes_ (item, a_selector__item, a_thr__item, a_arg__item, a_wait, a_array__item)
		end

	perform_selector__on_thread__with_object__wait_until_done_ (a_selector: detachable OBJC_SELECTOR; a_thr: detachable NS_THREAD; a_arg: detachable NS_OBJECT; a_wait: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
			a_thr__item: POINTER
			a_arg__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_thr as a_thr_attached then
				a_thr__item := a_thr_attached.item
			end
			if attached a_arg as a_arg_attached then
				a_arg__item := a_arg_attached.item
			end
			objc_perform_selector__on_thread__with_object__wait_until_done_ (item, a_selector__item, a_thr__item, a_arg__item, a_wait)
		end

	perform_selector_in_background__with_object_ (a_selector: detachable OBJC_SELECTOR; a_arg: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_selector__item: POINTER
			a_arg__item: POINTER
		do
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached a_arg as a_arg_attached then
				a_arg__item := a_arg_attached.item
			end
			objc_perform_selector_in_background__with_object_ (item, a_selector__item, a_arg__item)
		end

feature {NONE} -- NSThreadPerformAdditions Externals

	objc_perform_selector_on_main_thread__with_object__wait_until_done__modes_ (an_item: POINTER; a_selector: POINTER; a_arg: POINTER; a_wait: BOOLEAN; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item performSelectorOnMainThread:$a_selector withObject:$a_arg waitUntilDone:$a_wait modes:$a_array];
			 ]"
		end

	objc_perform_selector_on_main_thread__with_object__wait_until_done_ (an_item: POINTER; a_selector: POINTER; a_arg: POINTER; a_wait: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item performSelectorOnMainThread:$a_selector withObject:$a_arg waitUntilDone:$a_wait];
			 ]"
		end

	objc_perform_selector__on_thread__with_object__wait_until_done__modes_ (an_item: POINTER; a_selector: POINTER; a_thr: POINTER; a_arg: POINTER; a_wait: BOOLEAN; a_array: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item performSelector:$a_selector onThread:$a_thr withObject:$a_arg waitUntilDone:$a_wait modes:$a_array];
			 ]"
		end

	objc_perform_selector__on_thread__with_object__wait_until_done_ (an_item: POINTER; a_selector: POINTER; a_thr: POINTER; a_arg: POINTER; a_wait: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item performSelector:$a_selector onThread:$a_thr withObject:$a_arg waitUntilDone:$a_wait];
			 ]"
		end

	objc_perform_selector_in_background__with_object_ (an_item: POINTER; a_selector: POINTER; a_arg: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item performSelectorInBackground:$a_selector withObject:$a_arg];
			 ]"
		end

feature -- NSURLConnectionDelegate

	connection__will_send_request__redirect_response_ (a_connection: detachable NS_URL_CONNECTION; a_request: detachable NS_URL_REQUEST; a_response: detachable NS_URL_RESPONSE): detachable NS_URL_REQUEST
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_connection__item: POINTER
			a_request__item: POINTER
			a_response__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			if attached a_response as a_response_attached then
				a_response__item := a_response_attached.item
			end
			result_pointer := objc_connection__will_send_request__redirect_response_ (item, a_connection__item, a_request__item, a_response__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like connection__will_send_request__redirect_response_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like connection__will_send_request__redirect_response_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	connection__need_new_body_stream_ (a_connection: detachable NS_URL_CONNECTION; a_request: detachable NS_URL_REQUEST): detachable NS_INPUT_STREAM
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_connection__item: POINTER
			a_request__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			result_pointer := objc_connection__need_new_body_stream_ (item, a_connection__item, a_request__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like connection__need_new_body_stream_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like connection__need_new_body_stream_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	connection__can_authenticate_against_protection_space_ (a_connection: detachable NS_URL_CONNECTION; a_protection_space: detachable NS_URL_PROTECTION_SPACE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_connection__item: POINTER
			a_protection_space__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			if attached a_protection_space as a_protection_space_attached then
				a_protection_space__item := a_protection_space_attached.item
			end
			Result := objc_connection__can_authenticate_against_protection_space_ (item, a_connection__item, a_protection_space__item)
		end

	connection__did_receive_authentication_challenge_ (a_connection: detachable NS_URL_CONNECTION; a_challenge: detachable NS_URL_AUTHENTICATION_CHALLENGE)
			-- Auto generated Objective-C wrapper.
		local
			a_connection__item: POINTER
			a_challenge__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			if attached a_challenge as a_challenge_attached then
				a_challenge__item := a_challenge_attached.item
			end
			objc_connection__did_receive_authentication_challenge_ (item, a_connection__item, a_challenge__item)
		end

	connection__did_cancel_authentication_challenge_ (a_connection: detachable NS_URL_CONNECTION; a_challenge: detachable NS_URL_AUTHENTICATION_CHALLENGE)
			-- Auto generated Objective-C wrapper.
		local
			a_connection__item: POINTER
			a_challenge__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			if attached a_challenge as a_challenge_attached then
				a_challenge__item := a_challenge_attached.item
			end
			objc_connection__did_cancel_authentication_challenge_ (item, a_connection__item, a_challenge__item)
		end

	connection_should_use_credential_storage_ (a_connection: detachable NS_URL_CONNECTION): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_connection__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			Result := objc_connection_should_use_credential_storage_ (item, a_connection__item)
		end

	connection__did_receive_response_ (a_connection: detachable NS_URL_CONNECTION; a_response: detachable NS_URL_RESPONSE)
			-- Auto generated Objective-C wrapper.
		local
			a_connection__item: POINTER
			a_response__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			if attached a_response as a_response_attached then
				a_response__item := a_response_attached.item
			end
			objc_connection__did_receive_response_ (item, a_connection__item, a_response__item)
		end

	connection__did_receive_data_ (a_connection: detachable NS_URL_CONNECTION; a_data: detachable NS_DATA)
			-- Auto generated Objective-C wrapper.
		local
			a_connection__item: POINTER
			a_data__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			if attached a_data as a_data_attached then
				a_data__item := a_data_attached.item
			end
			objc_connection__did_receive_data_ (item, a_connection__item, a_data__item)
		end

	connection__did_send_body_data__total_bytes_written__total_bytes_expected_to_write_ (a_connection: detachable NS_URL_CONNECTION; a_bytes_written: INTEGER_64; a_total_bytes_written: INTEGER_64; a_total_bytes_expected_to_write: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_connection__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			objc_connection__did_send_body_data__total_bytes_written__total_bytes_expected_to_write_ (item, a_connection__item, a_bytes_written, a_total_bytes_written, a_total_bytes_expected_to_write)
		end

	connection_did_finish_loading_ (a_connection: detachable NS_URL_CONNECTION)
			-- Auto generated Objective-C wrapper.
		local
			a_connection__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			objc_connection_did_finish_loading_ (item, a_connection__item)
		end

	connection__did_fail_with_error_ (a_connection: detachable NS_URL_CONNECTION; a_error: detachable NS_ERROR)
			-- Auto generated Objective-C wrapper.
		local
			a_connection__item: POINTER
			a_error__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			objc_connection__did_fail_with_error_ (item, a_connection__item, a_error__item)
		end

	connection__will_cache_response_ (a_connection: detachable NS_URL_CONNECTION; a_cached_response: detachable NS_CACHED_URL_RESPONSE): detachable NS_CACHED_URL_RESPONSE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_connection__item: POINTER
			a_cached_response__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			if attached a_cached_response as a_cached_response_attached then
				a_cached_response__item := a_cached_response_attached.item
			end
			result_pointer := objc_connection__will_cache_response_ (item, a_connection__item, a_cached_response__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like connection__will_cache_response_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like connection__will_cache_response_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSURLConnectionDelegate Externals

	objc_connection__will_send_request__redirect_response_ (an_item: POINTER; a_connection: POINTER; a_request: POINTER; a_response: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item connection:$a_connection willSendRequest:$a_request redirectResponse:$a_response];
			 ]"
		end

	objc_connection__need_new_body_stream_ (an_item: POINTER; a_connection: POINTER; a_request: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item connection:$a_connection needNewBodyStream:$a_request];
			 ]"
		end

	objc_connection__can_authenticate_against_protection_space_ (an_item: POINTER; a_connection: POINTER; a_protection_space: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item connection:$a_connection canAuthenticateAgainstProtectionSpace:$a_protection_space];
			 ]"
		end

	objc_connection__did_receive_authentication_challenge_ (an_item: POINTER; a_connection: POINTER; a_challenge: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item connection:$a_connection didReceiveAuthenticationChallenge:$a_challenge];
			 ]"
		end

	objc_connection__did_cancel_authentication_challenge_ (an_item: POINTER; a_connection: POINTER; a_challenge: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item connection:$a_connection didCancelAuthenticationChallenge:$a_challenge];
			 ]"
		end

	objc_connection_should_use_credential_storage_ (an_item: POINTER; a_connection: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item connectionShouldUseCredentialStorage:$a_connection];
			 ]"
		end

	objc_connection__did_receive_response_ (an_item: POINTER; a_connection: POINTER; a_response: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item connection:$a_connection didReceiveResponse:$a_response];
			 ]"
		end

	objc_connection__did_receive_data_ (an_item: POINTER; a_connection: POINTER; a_data: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item connection:$a_connection didReceiveData:$a_data];
			 ]"
		end

	objc_connection__did_send_body_data__total_bytes_written__total_bytes_expected_to_write_ (an_item: POINTER; a_connection: POINTER; a_bytes_written: INTEGER_64; a_total_bytes_written: INTEGER_64; a_total_bytes_expected_to_write: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item connection:$a_connection didSendBodyData:$a_bytes_written totalBytesWritten:$a_total_bytes_written totalBytesExpectedToWrite:$a_total_bytes_expected_to_write];
			 ]"
		end

	objc_connection_did_finish_loading_ (an_item: POINTER; a_connection: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item connectionDidFinishLoading:$a_connection];
			 ]"
		end

	objc_connection__did_fail_with_error_ (an_item: POINTER; a_connection: POINTER; a_error: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item connection:$a_connection didFailWithError:$a_error];
			 ]"
		end

	objc_connection__will_cache_response_ (an_item: POINTER; a_connection: POINTER; a_cached_response: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item connection:$a_connection willCacheResponse:$a_cached_response];
			 ]"
		end

feature -- NSArchiverCallback

	class_for_archiver: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_class_for_archiver (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_for_archiver} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_for_archiver} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	replacement_object_for_archiver_ (a_archiver: detachable NS_ARCHIVER): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_archiver__item: POINTER
		do
			if attached a_archiver as a_archiver_attached then
				a_archiver__item := a_archiver_attached.item
			end
			result_pointer := objc_replacement_object_for_archiver_ (item, a_archiver__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like replacement_object_for_archiver_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like replacement_object_for_archiver_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSArchiverCallback Externals

	objc_class_for_archiver (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item classForArchiver];
			 ]"
		end

	objc_replacement_object_for_archiver_ (an_item: POINTER; a_archiver: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item replacementObjectForArchiver:$a_archiver];
			 ]"
		end

feature -- NSDistributedObjects

	class_for_port_coder: detachable OBJC_CLASS
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_class_for_port_coder (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_for_port_coder} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_for_port_coder} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	replacement_object_for_port_coder_ (a_coder: detachable NS_PORT_CODER): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_coder__item: POINTER
		do
			if attached a_coder as a_coder_attached then
				a_coder__item := a_coder_attached.item
			end
			result_pointer := objc_replacement_object_for_port_coder_ (item, a_coder__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like replacement_object_for_port_coder_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like replacement_object_for_port_coder_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSDistributedObjects Externals

	objc_class_for_port_coder (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item classForPortCoder];
			 ]"
		end

	objc_replacement_object_for_port_coder_ (an_item: POINTER; a_coder: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item replacementObjectForPortCoder:$a_coder];
			 ]"
		end

feature -- NSClassDescriptionPrimitives

	class_description: detachable NS_CLASS_DESCRIPTION
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_class_description (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_description} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_description} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	attribute_keys: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_attribute_keys (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attribute_keys} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attribute_keys} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	to_one_relationship_keys: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_to_one_relationship_keys (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like to_one_relationship_keys} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like to_one_relationship_keys} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	to_many_relationship_keys: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_to_many_relationship_keys (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like to_many_relationship_keys} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like to_many_relationship_keys} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	inverse_for_relationship_key_ (a_relationship_key: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_relationship_key__item: POINTER
		do
			if attached a_relationship_key as a_relationship_key_attached then
				a_relationship_key__item := a_relationship_key_attached.item
			end
			result_pointer := objc_inverse_for_relationship_key_ (item, a_relationship_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like inverse_for_relationship_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like inverse_for_relationship_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSClassDescriptionPrimitives Externals

	objc_class_description (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item classDescription];
			 ]"
		end

	objc_attribute_keys (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item attributeKeys];
			 ]"
		end

	objc_to_one_relationship_keys (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item toOneRelationshipKeys];
			 ]"
		end

	objc_to_many_relationship_keys (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item toManyRelationshipKeys];
			 ]"
		end

	objc_inverse_for_relationship_key_ (an_item: POINTER; a_relationship_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item inverseForRelationshipKey:$a_relationship_key];
			 ]"
		end

feature -- NSScripting

	scripting_value_for_specifier_ (a_object_specifier: detachable NS_SCRIPT_OBJECT_SPECIFIER): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_object_specifier__item: POINTER
		do
			if attached a_object_specifier as a_object_specifier_attached then
				a_object_specifier__item := a_object_specifier_attached.item
			end
			result_pointer := objc_scripting_value_for_specifier_ (item, a_object_specifier__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like scripting_value_for_specifier_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like scripting_value_for_specifier_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	scripting_properties: detachable NS_DICTIONARY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_scripting_properties (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like scripting_properties} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like scripting_properties} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_scripting_properties_ (a_properties: detachable NS_DICTIONARY)
			-- Auto generated Objective-C wrapper.
		local
			a_properties__item: POINTER
		do
			if attached a_properties as a_properties_attached then
				a_properties__item := a_properties_attached.item
			end
			objc_set_scripting_properties_ (item, a_properties__item)
		end

	copy_scripting_value__for_key__with_properties_ (a_value: detachable NS_OBJECT; a_key: detachable NS_STRING; a_properties: detachable NS_DICTIONARY): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_value__item: POINTER
			a_key__item: POINTER
			a_properties__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_properties as a_properties_attached then
				a_properties__item := a_properties_attached.item
			end
			result_pointer := objc_copy_scripting_value__for_key__with_properties_ (item, a_value__item, a_key__item, a_properties__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like copy_scripting_value__for_key__with_properties_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like copy_scripting_value__for_key__with_properties_} new_eiffel_object (result_pointer, False) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	new_scripting_object_of_class__for_value_for_key__with_contents_value__properties_ (a_object_class: detachable OBJC_CLASS; a_key: detachable NS_STRING; a_contents_value: detachable NS_OBJECT; a_properties: detachable NS_DICTIONARY): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_object_class__item: POINTER
			a_key__item: POINTER
			a_contents_value__item: POINTER
			a_properties__item: POINTER
		do
			if attached a_object_class as a_object_class_attached then
				a_object_class__item := a_object_class_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_contents_value as a_contents_value_attached then
				a_contents_value__item := a_contents_value_attached.item
			end
			if attached a_properties as a_properties_attached then
				a_properties__item := a_properties_attached.item
			end
			result_pointer := objc_new_scripting_object_of_class__for_value_for_key__with_contents_value__properties_ (item, a_object_class__item, a_key__item, a_contents_value__item, a_properties__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like new_scripting_object_of_class__for_value_for_key__with_contents_value__properties_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like new_scripting_object_of_class__for_value_for_key__with_contents_value__properties_} new_eiffel_object (result_pointer, False) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSScripting Externals

	objc_scripting_value_for_specifier_ (an_item: POINTER; a_object_specifier: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item scriptingValueForSpecifier:$a_object_specifier];
			 ]"
		end

	objc_scripting_properties (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item scriptingProperties];
			 ]"
		end

	objc_set_scripting_properties_ (an_item: POINTER; a_properties: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item setScriptingProperties:$a_properties];
			 ]"
		end

	objc_copy_scripting_value__for_key__with_properties_ (an_item: POINTER; a_value: POINTER; a_key: POINTER; a_properties: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item copyScriptingValue:$a_value forKey:$a_key withProperties:$a_properties];
			 ]"
		end

	objc_new_scripting_object_of_class__for_value_for_key__with_contents_value__properties_ (an_item: POINTER; a_object_class: POINTER; a_key: POINTER; a_contents_value: POINTER; a_properties: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item newScriptingObjectOfClass:$a_object_class forValueForKey:$a_key withContentsValue:$a_contents_value properties:$a_properties];
			 ]"
		end

feature -- NSScriptClassDescription

	class_code: NATURAL_32
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_class_code (item)
		end

	class_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_class_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like class_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like class_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSScriptClassDescription Externals

	objc_class_code (an_item: POINTER): NATURAL_32
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item classCode];
			 ]"
		end

	objc_class_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item className];
			 ]"
		end

feature -- NSScriptKeyValueCoding

	value_at_index__in_property_with_key_ (a_index: NATURAL_64; a_key: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_value_at_index__in_property_with_key_ (item, a_index, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_at_index__in_property_with_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_at_index__in_property_with_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	value_with_name__in_property_with_key_ (a_name: detachable NS_STRING; a_key: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
			a_key__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_value_with_name__in_property_with_key_ (item, a_name__item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_with_name__in_property_with_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_with_name__in_property_with_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	value_with_unique_i_d__in_property_with_key_ (a_unique_id: detachable NS_OBJECT; a_key: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_unique_id__item: POINTER
			a_key__item: POINTER
		do
			if attached a_unique_id as a_unique_id_attached then
				a_unique_id__item := a_unique_id_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_value_with_unique_i_d__in_property_with_key_ (item, a_unique_id__item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like value_with_unique_i_d__in_property_with_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like value_with_unique_i_d__in_property_with_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	insert_value__at_index__in_property_with_key_ (a_value: detachable NS_OBJECT; a_index: NATURAL_64; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
			a_key__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_insert_value__at_index__in_property_with_key_ (item, a_value__item, a_index, a_key__item)
		end

	remove_value_at_index__from_property_with_key_ (a_index: NATURAL_64; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_remove_value_at_index__from_property_with_key_ (item, a_index, a_key__item)
		end

	replace_value_at_index__in_property_with_key__with_value_ (a_index: NATURAL_64; a_key: detachable NS_STRING; a_value: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_key__item: POINTER
			a_value__item: POINTER
		do
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			objc_replace_value_at_index__in_property_with_key__with_value_ (item, a_index, a_key__item, a_value__item)
		end

	insert_value__in_property_with_key_ (a_value: detachable NS_OBJECT; a_key: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_value__item: POINTER
			a_key__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			objc_insert_value__in_property_with_key_ (item, a_value__item, a_key__item)
		end

	coerce_value__for_key_ (a_value: detachable NS_OBJECT; a_key: detachable NS_STRING): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_value__item: POINTER
			a_key__item: POINTER
		do
			if attached a_value as a_value_attached then
				a_value__item := a_value_attached.item
			end
			if attached a_key as a_key_attached then
				a_key__item := a_key_attached.item
			end
			result_pointer := objc_coerce_value__for_key_ (item, a_value__item, a_key__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like coerce_value__for_key_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like coerce_value__for_key_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSScriptKeyValueCoding Externals

	objc_value_at_index__in_property_with_key_ (an_item: POINTER; a_index: NATURAL_64; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item valueAtIndex:$a_index inPropertyWithKey:$a_key];
			 ]"
		end

	objc_value_with_name__in_property_with_key_ (an_item: POINTER; a_name: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item valueWithName:$a_name inPropertyWithKey:$a_key];
			 ]"
		end

	objc_value_with_unique_i_d__in_property_with_key_ (an_item: POINTER; a_unique_id: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item valueWithUniqueID:$a_unique_id inPropertyWithKey:$a_key];
			 ]"
		end

	objc_insert_value__at_index__in_property_with_key_ (an_item: POINTER; a_value: POINTER; a_index: NATURAL_64; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item insertValue:$a_value atIndex:$a_index inPropertyWithKey:$a_key];
			 ]"
		end

	objc_remove_value_at_index__from_property_with_key_ (an_item: POINTER; a_index: NATURAL_64; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item removeValueAtIndex:$a_index fromPropertyWithKey:$a_key];
			 ]"
		end

	objc_replace_value_at_index__in_property_with_key__with_value_ (an_item: POINTER; a_index: NATURAL_64; a_key: POINTER; a_value: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item replaceValueAtIndex:$a_index inPropertyWithKey:$a_key withValue:$a_value];
			 ]"
		end

	objc_insert_value__in_property_with_key_ (an_item: POINTER; a_value: POINTER; a_key: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item insertValue:$a_value inPropertyWithKey:$a_key];
			 ]"
		end

	objc_coerce_value__for_key_ (an_item: POINTER; a_value: POINTER; a_key: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item coerceValue:$a_value forKey:$a_key];
			 ]"
		end

feature -- NSScriptObjectSpecifiers

	object_specifier: detachable NS_SCRIPT_OBJECT_SPECIFIER
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_object_specifier (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like object_specifier} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like object_specifier} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	indices_of_objects_by_evaluating_object_specifier_ (a_specifier: detachable NS_SCRIPT_OBJECT_SPECIFIER): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_specifier__item: POINTER
		do
			if attached a_specifier as a_specifier_attached then
				a_specifier__item := a_specifier_attached.item
			end
			result_pointer := objc_indices_of_objects_by_evaluating_object_specifier_ (item, a_specifier__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like indices_of_objects_by_evaluating_object_specifier_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like indices_of_objects_by_evaluating_object_specifier_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSScriptObjectSpecifiers Externals

	objc_object_specifier (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item objectSpecifier];
			 ]"
		end

	objc_indices_of_objects_by_evaluating_object_specifier_ (an_item: POINTER; a_specifier: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item indicesOfObjectsByEvaluatingObjectSpecifier:$a_specifier];
			 ]"
		end

feature -- NSComparisonMethods

	is_equal_to_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_is_equal_to_ (item, a_object__item)
		end

	is_less_than_or_equal_to_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_is_less_than_or_equal_to_ (item, a_object__item)
		end

	is_less_than_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_is_less_than_ (item, a_object__item)
		end

	is_greater_than_or_equal_to_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_is_greater_than_or_equal_to_ (item, a_object__item)
		end

	is_greater_than_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_is_greater_than_ (item, a_object__item)
		end

	is_not_equal_to_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_is_not_equal_to_ (item, a_object__item)
		end

	does_contain_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_does_contain_ (item, a_object__item)
		end

	is_like_ (a_object: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_is_like_ (item, a_object__item)
		end

	is_case_insensitive_like_ (a_object: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_is_case_insensitive_like_ (item, a_object__item)
		end

feature {NONE} -- NSComparisonMethods Externals

	objc_is_equal_to_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item isEqualTo:$a_object];
			 ]"
		end

	objc_is_less_than_or_equal_to_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item isLessThanOrEqualTo:$a_object];
			 ]"
		end

	objc_is_less_than_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item isLessThan:$a_object];
			 ]"
		end

	objc_is_greater_than_or_equal_to_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item isGreaterThanOrEqualTo:$a_object];
			 ]"
		end

	objc_is_greater_than_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item isGreaterThan:$a_object];
			 ]"
		end

	objc_is_not_equal_to_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item isNotEqualTo:$a_object];
			 ]"
		end

	objc_does_contain_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item doesContain:$a_object];
			 ]"
		end

	objc_is_like_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item isLike:$a_object];
			 ]"
		end

	objc_is_case_insensitive_like_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item isCaseInsensitiveLike:$a_object];
			 ]"
		end

feature -- NSScriptingComparisonMethods

	scripting_is_equal_to_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_scripting_is_equal_to_ (item, a_object__item)
		end

	scripting_is_less_than_or_equal_to_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_scripting_is_less_than_or_equal_to_ (item, a_object__item)
		end

	scripting_is_less_than_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_scripting_is_less_than_ (item, a_object__item)
		end

	scripting_is_greater_than_or_equal_to_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_scripting_is_greater_than_or_equal_to_ (item, a_object__item)
		end

	scripting_is_greater_than_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_scripting_is_greater_than_ (item, a_object__item)
		end

	scripting_begins_with_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_scripting_begins_with_ (item, a_object__item)
		end

	scripting_ends_with_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_scripting_ends_with_ (item, a_object__item)
		end

	scripting_contains_ (a_object: detachable NS_OBJECT): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_object__item: POINTER
		do
			if attached a_object as a_object_attached then
				a_object__item := a_object_attached.item
			end
			Result := objc_scripting_contains_ (item, a_object__item)
		end

feature {NONE} -- NSScriptingComparisonMethods Externals

	objc_scripting_is_equal_to_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item scriptingIsEqualTo:$a_object];
			 ]"
		end

	objc_scripting_is_less_than_or_equal_to_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item scriptingIsLessThanOrEqualTo:$a_object];
			 ]"
		end

	objc_scripting_is_less_than_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item scriptingIsLessThan:$a_object];
			 ]"
		end

	objc_scripting_is_greater_than_or_equal_to_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item scriptingIsGreaterThanOrEqualTo:$a_object];
			 ]"
		end

	objc_scripting_is_greater_than_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item scriptingIsGreaterThan:$a_object];
			 ]"
		end

	objc_scripting_begins_with_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item scriptingBeginsWith:$a_object];
			 ]"
		end

	objc_scripting_ends_with_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item scriptingEndsWith:$a_object];
			 ]"
		end

	objc_scripting_contains_ (an_item: POINTER; a_object: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item scriptingContains:$a_object];
			 ]"
		end

feature -- NSURLDownloadDelegate

	download_did_begin_ (a_download: detachable NS_URL_DOWNLOAD)
			-- Auto generated Objective-C wrapper.
		local
			a_download__item: POINTER
		do
			if attached a_download as a_download_attached then
				a_download__item := a_download_attached.item
			end
			objc_download_did_begin_ (item, a_download__item)
		end

	download__will_send_request__redirect_response_ (a_download: detachable NS_URL_DOWNLOAD; a_request: detachable NS_URL_REQUEST; a_redirect_response: detachable NS_URL_RESPONSE): detachable NS_URL_REQUEST
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_download__item: POINTER
			a_request__item: POINTER
			a_redirect_response__item: POINTER
		do
			if attached a_download as a_download_attached then
				a_download__item := a_download_attached.item
			end
			if attached a_request as a_request_attached then
				a_request__item := a_request_attached.item
			end
			if attached a_redirect_response as a_redirect_response_attached then
				a_redirect_response__item := a_redirect_response_attached.item
			end
			result_pointer := objc_download__will_send_request__redirect_response_ (item, a_download__item, a_request__item, a_redirect_response__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like download__will_send_request__redirect_response_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like download__will_send_request__redirect_response_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	download__can_authenticate_against_protection_space_ (a_connection: detachable NS_URL_DOWNLOAD; a_protection_space: detachable NS_URL_PROTECTION_SPACE): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_connection__item: POINTER
			a_protection_space__item: POINTER
		do
			if attached a_connection as a_connection_attached then
				a_connection__item := a_connection_attached.item
			end
			if attached a_protection_space as a_protection_space_attached then
				a_protection_space__item := a_protection_space_attached.item
			end
			Result := objc_download__can_authenticate_against_protection_space_ (item, a_connection__item, a_protection_space__item)
		end

	download__did_receive_authentication_challenge_ (a_download: detachable NS_URL_DOWNLOAD; a_challenge: detachable NS_URL_AUTHENTICATION_CHALLENGE)
			-- Auto generated Objective-C wrapper.
		local
			a_download__item: POINTER
			a_challenge__item: POINTER
		do
			if attached a_download as a_download_attached then
				a_download__item := a_download_attached.item
			end
			if attached a_challenge as a_challenge_attached then
				a_challenge__item := a_challenge_attached.item
			end
			objc_download__did_receive_authentication_challenge_ (item, a_download__item, a_challenge__item)
		end

	download__did_cancel_authentication_challenge_ (a_download: detachable NS_URL_DOWNLOAD; a_challenge: detachable NS_URL_AUTHENTICATION_CHALLENGE)
			-- Auto generated Objective-C wrapper.
		local
			a_download__item: POINTER
			a_challenge__item: POINTER
		do
			if attached a_download as a_download_attached then
				a_download__item := a_download_attached.item
			end
			if attached a_challenge as a_challenge_attached then
				a_challenge__item := a_challenge_attached.item
			end
			objc_download__did_cancel_authentication_challenge_ (item, a_download__item, a_challenge__item)
		end

	download_should_use_credential_storage_ (a_download: detachable NS_URL_DOWNLOAD): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_download__item: POINTER
		do
			if attached a_download as a_download_attached then
				a_download__item := a_download_attached.item
			end
			Result := objc_download_should_use_credential_storage_ (item, a_download__item)
		end

	download__did_receive_response_ (a_download: detachable NS_URL_DOWNLOAD; a_response: detachable NS_URL_RESPONSE)
			-- Auto generated Objective-C wrapper.
		local
			a_download__item: POINTER
			a_response__item: POINTER
		do
			if attached a_download as a_download_attached then
				a_download__item := a_download_attached.item
			end
			if attached a_response as a_response_attached then
				a_response__item := a_response_attached.item
			end
			objc_download__did_receive_response_ (item, a_download__item, a_response__item)
		end

	download__will_resume_with_response__from_byte_ (a_download: detachable NS_URL_DOWNLOAD; a_response: detachable NS_URL_RESPONSE; a_starting_byte: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		local
			a_download__item: POINTER
			a_response__item: POINTER
		do
			if attached a_download as a_download_attached then
				a_download__item := a_download_attached.item
			end
			if attached a_response as a_response_attached then
				a_response__item := a_response_attached.item
			end
			objc_download__will_resume_with_response__from_byte_ (item, a_download__item, a_response__item, a_starting_byte)
		end

	download__did_receive_data_of_length_ (a_download: detachable NS_URL_DOWNLOAD; a_length: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_download__item: POINTER
		do
			if attached a_download as a_download_attached then
				a_download__item := a_download_attached.item
			end
			objc_download__did_receive_data_of_length_ (item, a_download__item, a_length)
		end

	download__should_decode_source_data_of_mime_type_ (a_download: detachable NS_URL_DOWNLOAD; a_encoding_type: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			a_download__item: POINTER
			a_encoding_type__item: POINTER
		do
			if attached a_download as a_download_attached then
				a_download__item := a_download_attached.item
			end
			if attached a_encoding_type as a_encoding_type_attached then
				a_encoding_type__item := a_encoding_type_attached.item
			end
			Result := objc_download__should_decode_source_data_of_mime_type_ (item, a_download__item, a_encoding_type__item)
		end

	download__decide_destination_with_suggested_filename_ (a_download: detachable NS_URL_DOWNLOAD; a_filename: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_download__item: POINTER
			a_filename__item: POINTER
		do
			if attached a_download as a_download_attached then
				a_download__item := a_download_attached.item
			end
			if attached a_filename as a_filename_attached then
				a_filename__item := a_filename_attached.item
			end
			objc_download__decide_destination_with_suggested_filename_ (item, a_download__item, a_filename__item)
		end

	download__did_create_destination_ (a_download: detachable NS_URL_DOWNLOAD; a_path: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_download__item: POINTER
			a_path__item: POINTER
		do
			if attached a_download as a_download_attached then
				a_download__item := a_download_attached.item
			end
			if attached a_path as a_path_attached then
				a_path__item := a_path_attached.item
			end
			objc_download__did_create_destination_ (item, a_download__item, a_path__item)
		end

	download_did_finish_ (a_download: detachable NS_URL_DOWNLOAD)
			-- Auto generated Objective-C wrapper.
		local
			a_download__item: POINTER
		do
			if attached a_download as a_download_attached then
				a_download__item := a_download_attached.item
			end
			objc_download_did_finish_ (item, a_download__item)
		end

	download__did_fail_with_error_ (a_download: detachable NS_URL_DOWNLOAD; a_error: detachable NS_ERROR)
			-- Auto generated Objective-C wrapper.
		local
			a_download__item: POINTER
			a_error__item: POINTER
		do
			if attached a_download as a_download_attached then
				a_download__item := a_download_attached.item
			end
			if attached a_error as a_error_attached then
				a_error__item := a_error_attached.item
			end
			objc_download__did_fail_with_error_ (item, a_download__item, a_error__item)
		end

feature {NONE} -- NSURLDownloadDelegate Externals

	objc_download_did_begin_ (an_item: POINTER; a_download: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item downloadDidBegin:$a_download];
			 ]"
		end

	objc_download__will_send_request__redirect_response_ (an_item: POINTER; a_download: POINTER; a_request: POINTER; a_redirect_response: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSObject *)$an_item download:$a_download willSendRequest:$a_request redirectResponse:$a_redirect_response];
			 ]"
		end

	objc_download__can_authenticate_against_protection_space_ (an_item: POINTER; a_connection: POINTER; a_protection_space: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item download:$a_connection canAuthenticateAgainstProtectionSpace:$a_protection_space];
			 ]"
		end

	objc_download__did_receive_authentication_challenge_ (an_item: POINTER; a_download: POINTER; a_challenge: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item download:$a_download didReceiveAuthenticationChallenge:$a_challenge];
			 ]"
		end

	objc_download__did_cancel_authentication_challenge_ (an_item: POINTER; a_download: POINTER; a_challenge: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item download:$a_download didCancelAuthenticationChallenge:$a_challenge];
			 ]"
		end

	objc_download_should_use_credential_storage_ (an_item: POINTER; a_download: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item downloadShouldUseCredentialStorage:$a_download];
			 ]"
		end

	objc_download__did_receive_response_ (an_item: POINTER; a_download: POINTER; a_response: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item download:$a_download didReceiveResponse:$a_response];
			 ]"
		end

	objc_download__will_resume_with_response__from_byte_ (an_item: POINTER; a_download: POINTER; a_response: POINTER; a_starting_byte: INTEGER_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item download:$a_download willResumeWithResponse:$a_response fromByte:$a_starting_byte];
			 ]"
		end

	objc_download__did_receive_data_of_length_ (an_item: POINTER; a_download: POINTER; a_length: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item download:$a_download didReceiveDataOfLength:$a_length];
			 ]"
		end

	objc_download__should_decode_source_data_of_mime_type_ (an_item: POINTER; a_download: POINTER; a_encoding_type: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSObject *)$an_item download:$a_download shouldDecodeSourceDataOfMIMEType:$a_encoding_type];
			 ]"
		end

	objc_download__decide_destination_with_suggested_filename_ (an_item: POINTER; a_download: POINTER; a_filename: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item download:$a_download decideDestinationWithSuggestedFilename:$a_filename];
			 ]"
		end

	objc_download__did_create_destination_ (an_item: POINTER; a_download: POINTER; a_path: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item download:$a_download didCreateDestination:$a_path];
			 ]"
		end

	objc_download_did_finish_ (an_item: POINTER; a_download: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item downloadDidFinish:$a_download];
			 ]"
		end

	objc_download__did_fail_with_error_ (an_item: POINTER; a_download: POINTER; a_error: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSObject *)$an_item download:$a_download didFailWithError:$a_error];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSObject"
		end

end

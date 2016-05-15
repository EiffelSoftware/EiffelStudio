note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_UNDO_MANAGER

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make

feature -- NSUndoManager

	begin_undo_grouping
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_begin_undo_grouping (item)
		end

	end_undo_grouping
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_end_undo_grouping (item)
		end

	grouping_level: INTEGER_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_grouping_level (item)
		end

	disable_undo_registration
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_disable_undo_registration (item)
		end

	enable_undo_registration
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_enable_undo_registration (item)
		end

	is_undo_registration_enabled: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_undo_registration_enabled (item)
		end

	groups_by_event: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_groups_by_event (item)
		end

	set_groups_by_event_ (a_groups_by_event: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_groups_by_event_ (item, a_groups_by_event)
		end

	set_levels_of_undo_ (a_levels: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_levels_of_undo_ (item, a_levels)
		end

	levels_of_undo: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_levels_of_undo (item)
		end

	set_run_loop_modes_ (a_run_loop_modes: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_run_loop_modes__item: POINTER
		do
			if attached a_run_loop_modes as a_run_loop_modes_attached then
				a_run_loop_modes__item := a_run_loop_modes_attached.item
			end
			objc_set_run_loop_modes_ (item, a_run_loop_modes__item)
		end

	run_loop_modes: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_run_loop_modes (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like run_loop_modes} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like run_loop_modes} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	undo
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_undo (item)
		end

	redo
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_redo (item)
		end

	undo_nested_group
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_undo_nested_group (item)
		end

	can_undo: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_undo (item)
		end

	can_redo: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_can_redo (item)
		end

	is_undoing: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_undoing (item)
		end

	is_redoing: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_redoing (item)
		end

	remove_all_actions
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_all_actions (item)
		end

	remove_all_actions_with_target_ (a_target: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_target__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			objc_remove_all_actions_with_target_ (item, a_target__item)
		end

	register_undo_with_target__selector__object_ (a_target: detachable NS_OBJECT; a_selector: detachable OBJC_SELECTOR; an_object: detachable NS_OBJECT)
			-- Auto generated Objective-C wrapper.
		local
			a_target__item: POINTER
			a_selector__item: POINTER
			an_object__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			if attached a_selector as a_selector_attached then
				a_selector__item := a_selector_attached.item
			end
			if attached an_object as an_object_attached then
				an_object__item := an_object_attached.item
			end
			objc_register_undo_with_target__selector__object_ (item, a_target__item, a_selector__item, an_object__item)
		end

	prepare_with_invocation_target_ (a_target: detachable NS_OBJECT): detachable NS_OBJECT
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_target__item: POINTER
		do
			if attached a_target as a_target_attached then
				a_target__item := a_target_attached.item
			end
			result_pointer := objc_prepare_with_invocation_target_ (item, a_target__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like prepare_with_invocation_target_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like prepare_with_invocation_target_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	undo_action_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_undo_action_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like undo_action_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like undo_action_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	redo_action_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_redo_action_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like redo_action_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like redo_action_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_action_name_ (a_action_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_action_name__item: POINTER
		do
			if attached a_action_name as a_action_name_attached then
				a_action_name__item := a_action_name_attached.item
			end
			objc_set_action_name_ (item, a_action_name__item)
		end

	undo_menu_item_title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_undo_menu_item_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like undo_menu_item_title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like undo_menu_item_title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	redo_menu_item_title: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_redo_menu_item_title (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like redo_menu_item_title} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like redo_menu_item_title} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	undo_menu_title_for_undo_action_name_ (a_action_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_action_name__item: POINTER
		do
			if attached a_action_name as a_action_name_attached then
				a_action_name__item := a_action_name_attached.item
			end
			result_pointer := objc_undo_menu_title_for_undo_action_name_ (item, a_action_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like undo_menu_title_for_undo_action_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like undo_menu_title_for_undo_action_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	redo_menu_title_for_undo_action_name_ (a_action_name: detachable NS_STRING): detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_action_name__item: POINTER
		do
			if attached a_action_name as a_action_name_attached then
				a_action_name__item := a_action_name_attached.item
			end
			result_pointer := objc_redo_menu_title_for_undo_action_name_ (item, a_action_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like redo_menu_title_for_undo_action_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like redo_menu_title_for_undo_action_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSUndoManager Externals

	objc_begin_undo_grouping (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item beginUndoGrouping];
			 ]"
		end

	objc_end_undo_grouping (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item endUndoGrouping];
			 ]"
		end

	objc_grouping_level (an_item: POINTER): INTEGER_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUndoManager *)$an_item groupingLevel];
			 ]"
		end

	objc_disable_undo_registration (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item disableUndoRegistration];
			 ]"
		end

	objc_enable_undo_registration (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item enableUndoRegistration];
			 ]"
		end

	objc_is_undo_registration_enabled (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUndoManager *)$an_item isUndoRegistrationEnabled];
			 ]"
		end

	objc_groups_by_event (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUndoManager *)$an_item groupsByEvent];
			 ]"
		end

	objc_set_groups_by_event_ (an_item: POINTER; a_groups_by_event: BOOLEAN)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item setGroupsByEvent:$a_groups_by_event];
			 ]"
		end

	objc_set_levels_of_undo_ (an_item: POINTER; a_levels: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item setLevelsOfUndo:$a_levels];
			 ]"
		end

	objc_levels_of_undo (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUndoManager *)$an_item levelsOfUndo];
			 ]"
		end

	objc_set_run_loop_modes_ (an_item: POINTER; a_run_loop_modes: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item setRunLoopModes:$a_run_loop_modes];
			 ]"
		end

	objc_run_loop_modes (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUndoManager *)$an_item runLoopModes];
			 ]"
		end

	objc_undo (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item undo];
			 ]"
		end

	objc_redo (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item redo];
			 ]"
		end

	objc_undo_nested_group (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item undoNestedGroup];
			 ]"
		end

	objc_can_undo (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUndoManager *)$an_item canUndo];
			 ]"
		end

	objc_can_redo (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUndoManager *)$an_item canRedo];
			 ]"
		end

	objc_is_undoing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUndoManager *)$an_item isUndoing];
			 ]"
		end

	objc_is_redoing (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSUndoManager *)$an_item isRedoing];
			 ]"
		end

	objc_remove_all_actions (an_item: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item removeAllActions];
			 ]"
		end

	objc_remove_all_actions_with_target_ (an_item: POINTER; a_target: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item removeAllActionsWithTarget:$a_target];
			 ]"
		end

	objc_register_undo_with_target__selector__object_ (an_item: POINTER; a_target: POINTER; a_selector: POINTER; an_object: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item registerUndoWithTarget:$a_target selector:$a_selector object:$an_object];
			 ]"
		end

	objc_prepare_with_invocation_target_ (an_item: POINTER; a_target: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUndoManager *)$an_item prepareWithInvocationTarget:$a_target];
			 ]"
		end

	objc_undo_action_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUndoManager *)$an_item undoActionName];
			 ]"
		end

	objc_redo_action_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUndoManager *)$an_item redoActionName];
			 ]"
		end

	objc_set_action_name_ (an_item: POINTER; a_action_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSUndoManager *)$an_item setActionName:$a_action_name];
			 ]"
		end

	objc_undo_menu_item_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUndoManager *)$an_item undoMenuItemTitle];
			 ]"
		end

	objc_redo_menu_item_title (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUndoManager *)$an_item redoMenuItemTitle];
			 ]"
		end

	objc_undo_menu_title_for_undo_action_name_ (an_item: POINTER; a_action_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUndoManager *)$an_item undoMenuTitleForUndoActionName:$a_action_name];
			 ]"
		end

	objc_redo_menu_title_for_undo_action_name_ (an_item: POINTER; a_action_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSUndoManager *)$an_item redoMenuTitleForUndoActionName:$a_action_name];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSUndoManager"
		end

end

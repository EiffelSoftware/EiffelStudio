note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PREDICATE_EDITOR_ROW_TEMPLATE

inherit
	NS_OBJECT
		redefine
			wrapper_objc_class_name
		end

	NS_CODING_PROTOCOL
	NS_COPYING_PROTOCOL

create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_left_expressions__right_expressions__modifier__operators__options_,
	make_with_left_expressions__right_expression_attribute_type__modifier__operators__options_,
	make_with_compound_types_,
	make

feature -- NSPredicateEditorRowTemplate

	match_for_predicate_ (a_predicate: detachable NS_PREDICATE): REAL_64
			-- Auto generated Objective-C wrapper.
		local
			a_predicate__item: POINTER
		do
			if attached a_predicate as a_predicate_attached then
				a_predicate__item := a_predicate_attached.item
			end
			Result := objc_match_for_predicate_ (item, a_predicate__item)
		end

	template_views: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_template_views (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like template_views} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like template_views} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_predicate_ (a_predicate: detachable NS_PREDICATE)
			-- Auto generated Objective-C wrapper.
		local
			a_predicate__item: POINTER
		do
			if attached a_predicate as a_predicate_attached then
				a_predicate__item := a_predicate_attached.item
			end
			objc_set_predicate_ (item, a_predicate__item)
		end

	predicate_with_subpredicates_ (a_subpredicates: detachable NS_ARRAY): detachable NS_PREDICATE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_subpredicates__item: POINTER
		do
			if attached a_subpredicates as a_subpredicates_attached then
				a_subpredicates__item := a_subpredicates_attached.item
			end
			result_pointer := objc_predicate_with_subpredicates_ (item, a_subpredicates__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like predicate_with_subpredicates_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like predicate_with_subpredicates_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	displayable_subpredicates_of_predicate_ (a_predicate: detachable NS_PREDICATE): detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_predicate__item: POINTER
		do
			if attached a_predicate as a_predicate_attached then
				a_predicate__item := a_predicate_attached.item
			end
			result_pointer := objc_displayable_subpredicates_of_predicate_ (item, a_predicate__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like displayable_subpredicates_of_predicate_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like displayable_subpredicates_of_predicate_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	left_expressions: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_left_expressions (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like left_expressions} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like left_expressions} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	right_expressions: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_right_expressions (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like right_expressions} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like right_expressions} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	right_expression_attribute_type: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_right_expression_attribute_type (item)
		end

	modifier: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_modifier (item)
		end

	operators: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_operators (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like operators} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like operators} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	options: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_options (item)
		end

	compound_types: detachable NS_ARRAY
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_compound_types (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like compound_types} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like compound_types} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- NSPredicateEditorRowTemplate Externals

	objc_match_for_predicate_ (an_item: POINTER; a_predicate: POINTER): REAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPredicateEditorRowTemplate *)$an_item matchForPredicate:$a_predicate];
			 ]"
		end

	objc_template_views (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPredicateEditorRowTemplate *)$an_item templateViews];
			 ]"
		end

	objc_set_predicate_ (an_item: POINTER; a_predicate: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				[(NSPredicateEditorRowTemplate *)$an_item setPredicate:$a_predicate];
			 ]"
		end

	objc_predicate_with_subpredicates_ (an_item: POINTER; a_subpredicates: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPredicateEditorRowTemplate *)$an_item predicateWithSubpredicates:$a_subpredicates];
			 ]"
		end

	objc_displayable_subpredicates_of_predicate_ (an_item: POINTER; a_predicate: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPredicateEditorRowTemplate *)$an_item displayableSubpredicatesOfPredicate:$a_predicate];
			 ]"
		end

	objc_init_with_left_expressions__right_expressions__modifier__operators__options_ (an_item: POINTER; a_left_expressions: POINTER; a_right_expressions: POINTER; a_modifier: NATURAL_64; a_operators: POINTER; a_options: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPredicateEditorRowTemplate *)$an_item initWithLeftExpressions:$a_left_expressions rightExpressions:$a_right_expressions modifier:$a_modifier operators:$a_operators options:$a_options];
			 ]"
		end

	objc_init_with_left_expressions__right_expression_attribute_type__modifier__operators__options_ (an_item: POINTER; a_left_expressions: POINTER; a_attribute_type: NATURAL_64; a_modifier: NATURAL_64; a_operators: POINTER; a_options: NATURAL_64): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPredicateEditorRowTemplate *)$an_item initWithLeftExpressions:$a_left_expressions rightExpressionAttributeType:$a_attribute_type modifier:$a_modifier operators:$a_operators options:$a_options];
			 ]"
		end

	objc_init_with_compound_types_ (an_item: POINTER; a_compound_types: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPredicateEditorRowTemplate *)$an_item initWithCompoundTypes:$a_compound_types];
			 ]"
		end

	objc_left_expressions (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPredicateEditorRowTemplate *)$an_item leftExpressions];
			 ]"
		end

	objc_right_expressions (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPredicateEditorRowTemplate *)$an_item rightExpressions];
			 ]"
		end

	objc_right_expression_attribute_type (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPredicateEditorRowTemplate *)$an_item rightExpressionAttributeType];
			 ]"
		end

	objc_modifier (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPredicateEditorRowTemplate *)$an_item modifier];
			 ]"
		end

	objc_operators (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPredicateEditorRowTemplate *)$an_item operators];
			 ]"
		end

	objc_options (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return [(NSPredicateEditorRowTemplate *)$an_item options];
			 ]"
		end

	objc_compound_types (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <AppKit/AppKit.h>"
		alias
			"[
				return (EIF_POINTER)[(NSPredicateEditorRowTemplate *)$an_item compoundTypes];
			 ]"
		end

feature {NONE} -- Initialization

	make_with_left_expressions__right_expressions__modifier__operators__options_ (a_left_expressions: detachable NS_ARRAY; a_right_expressions: detachable NS_ARRAY; a_modifier: NATURAL_64; a_operators: detachable NS_ARRAY; a_options: NATURAL_64)
			-- Initialize `Current'.
		local
			a_left_expressions__item: POINTER
			a_right_expressions__item: POINTER
			a_operators__item: POINTER
		do
			if attached a_left_expressions as a_left_expressions_attached then
				a_left_expressions__item := a_left_expressions_attached.item
			end
			if attached a_right_expressions as a_right_expressions_attached then
				a_right_expressions__item := a_right_expressions_attached.item
			end
			if attached a_operators as a_operators_attached then
				a_operators__item := a_operators_attached.item
			end
			make_with_pointer (objc_init_with_left_expressions__right_expressions__modifier__operators__options_(allocate_object, a_left_expressions__item, a_right_expressions__item, a_modifier, a_operators__item, a_options))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_left_expressions__right_expression_attribute_type__modifier__operators__options_ (a_left_expressions: detachable NS_ARRAY; a_attribute_type: NATURAL_64; a_modifier: NATURAL_64; a_operators: detachable NS_ARRAY; a_options: NATURAL_64)
			-- Initialize `Current'.
		local
			a_left_expressions__item: POINTER
			a_operators__item: POINTER
		do
			if attached a_left_expressions as a_left_expressions_attached then
				a_left_expressions__item := a_left_expressions_attached.item
			end
			if attached a_operators as a_operators_attached then
				a_operators__item := a_operators_attached.item
			end
			make_with_pointer (objc_init_with_left_expressions__right_expression_attribute_type__modifier__operators__options_(allocate_object, a_left_expressions__item, a_attribute_type, a_modifier, a_operators__item, a_options))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

	make_with_compound_types_ (a_compound_types: detachable NS_ARRAY)
			-- Initialize `Current'.
		local
			a_compound_types__item: POINTER
		do
			if attached a_compound_types as a_compound_types_attached then
				a_compound_types__item := a_compound_types_attached.item
			end
			make_with_pointer (objc_init_with_compound_types_(allocate_object, a_compound_types__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSPredicateEditorRowTemplate"
		end

end

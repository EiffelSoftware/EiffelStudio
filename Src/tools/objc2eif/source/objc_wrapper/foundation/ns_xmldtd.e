note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_XMLDTD

inherit
	NS_XML_NODE
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_kind_,
	make_with_kind__options_,
	make

feature {NONE} -- Initialization

--	make_with_contents_of_ur_l__options__error_ (a_url: detachable NS_URL; a_mask: NATURAL_64; a_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_url__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_url as a_url_attached then
--				a_url__item := a_url_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			make_with_pointer (objc_init_with_contents_of_ur_l__options__error_(allocate_object, a_url__item, a_mask, a_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

--	make_with_data__options__error_ (a_data: detachable NS_DATA; a_mask: NATURAL_64; a_error: UNSUPPORTED_TYPE)
--			-- Initialize `Current'.
--		local
--			a_data__item: POINTER
--			a_error__item: POINTER
--		do
--			if attached a_data as a_data_attached then
--				a_data__item := a_data_attached.item
--			end
--			if attached a_error as a_error_attached then
--				a_error__item := a_error_attached.item
--			end
--			make_with_pointer (objc_init_with_data__options__error_(allocate_object, a_data__item, a_mask, a_error__item))
--			if item = default_pointer then
--				-- TODO: handle initialization error.
--			end
--		end

feature {NONE} -- NSXMLDTD Externals

--	objc_init_with_contents_of_ur_l__options__error_ (an_item: POINTER; a_url: POINTER; a_mask: NATURAL_64; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSXMLDTD *)$an_item initWithContentsOfURL:$a_url options:$a_mask error:];
--			 ]"
--		end

--	objc_init_with_data__options__error_ (an_item: POINTER; a_data: POINTER; a_mask: NATURAL_64; a_error: UNSUPPORTED_TYPE): POINTER
--			-- Auto generated Objective-C wrapper.
--		external
--			"C inline use <Foundation/Foundation.h>"
--		alias
--			"[
--				return (EIF_POINTER)[(NSXMLDTD *)$an_item initWithData:$a_data options:$a_mask error:];
--			 ]"
--		end

	objc_set_public_i_d_ (an_item: POINTER; a_public_id: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDTD *)$an_item setPublicID:$a_public_id];
			 ]"
		end

	objc_public_id (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDTD *)$an_item publicID];
			 ]"
		end

	objc_set_system_i_d_ (an_item: POINTER; a_system_id: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDTD *)$an_item setSystemID:$a_system_id];
			 ]"
		end

	objc_system_id (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDTD *)$an_item systemID];
			 ]"
		end

	objc_insert_child__at_index_ (an_item: POINTER; a_child: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDTD *)$an_item insertChild:$a_child atIndex:$a_index];
			 ]"
		end

	objc_insert_children__at_index_ (an_item: POINTER; a_children: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDTD *)$an_item insertChildren:$a_children atIndex:$a_index];
			 ]"
		end

	objc_remove_child_at_index_ (an_item: POINTER; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDTD *)$an_item removeChildAtIndex:$a_index];
			 ]"
		end

	objc_set_children_ (an_item: POINTER; a_children: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDTD *)$an_item setChildren:$a_children];
			 ]"
		end

	objc_add_child_ (an_item: POINTER; a_child: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDTD *)$an_item addChild:$a_child];
			 ]"
		end

	objc_replace_child_at_index__with_node_ (an_item: POINTER; a_index: NATURAL_64; a_node: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDTD *)$an_item replaceChildAtIndex:$a_index withNode:$a_node];
			 ]"
		end

	objc_entity_declaration_for_name_ (an_item: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDTD *)$an_item entityDeclarationForName:$a_name];
			 ]"
		end

	objc_notation_declaration_for_name_ (an_item: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDTD *)$an_item notationDeclarationForName:$a_name];
			 ]"
		end

	objc_element_declaration_for_name_ (an_item: POINTER; a_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDTD *)$an_item elementDeclarationForName:$a_name];
			 ]"
		end

	objc_attribute_declaration_for_name__element_name_ (an_item: POINTER; a_name: POINTER; a_element_name: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDTD *)$an_item attributeDeclarationForName:$a_name elementName:$a_element_name];
			 ]"
		end

feature -- NSXMLDTD

	set_public_i_d_ (a_public_id: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_public_id__item: POINTER
		do
			if attached a_public_id as a_public_id_attached then
				a_public_id__item := a_public_id_attached.item
			end
			objc_set_public_i_d_ (item, a_public_id__item)
		end

	public_id: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_public_id (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like public_id} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like public_id} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	set_system_i_d_ (a_system_id: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_system_id__item: POINTER
		do
			if attached a_system_id as a_system_id_attached then
				a_system_id__item := a_system_id_attached.item
			end
			objc_set_system_i_d_ (item, a_system_id__item)
		end

	system_id: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_system_id (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like system_id} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like system_id} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	insert_child__at_index_ (a_child: detachable NS_XML_NODE; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_child__item: POINTER
		do
			if attached a_child as a_child_attached then
				a_child__item := a_child_attached.item
			end
			objc_insert_child__at_index_ (item, a_child__item, a_index)
		end

	insert_children__at_index_ (a_children: detachable NS_ARRAY; a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
			a_children__item: POINTER
		do
			if attached a_children as a_children_attached then
				a_children__item := a_children_attached.item
			end
			objc_insert_children__at_index_ (item, a_children__item, a_index)
		end

	remove_child_at_index_ (a_index: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_remove_child_at_index_ (item, a_index)
		end

	set_children_ (a_children: detachable NS_ARRAY)
			-- Auto generated Objective-C wrapper.
		local
			a_children__item: POINTER
		do
			if attached a_children as a_children_attached then
				a_children__item := a_children_attached.item
			end
			objc_set_children_ (item, a_children__item)
		end

	add_child_ (a_child: detachable NS_XML_NODE)
			-- Auto generated Objective-C wrapper.
		local
			a_child__item: POINTER
		do
			if attached a_child as a_child_attached then
				a_child__item := a_child_attached.item
			end
			objc_add_child_ (item, a_child__item)
		end

	replace_child_at_index__with_node_ (a_index: NATURAL_64; a_node: detachable NS_XML_NODE)
			-- Auto generated Objective-C wrapper.
		local
			a_node__item: POINTER
		do
			if attached a_node as a_node_attached then
				a_node__item := a_node_attached.item
			end
			objc_replace_child_at_index__with_node_ (item, a_index, a_node__item)
		end

	entity_declaration_for_name_ (a_name: detachable NS_STRING): detachable NS_XMLDTD_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			result_pointer := objc_entity_declaration_for_name_ (item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like entity_declaration_for_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like entity_declaration_for_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	notation_declaration_for_name_ (a_name: detachable NS_STRING): detachable NS_XMLDTD_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			result_pointer := objc_notation_declaration_for_name_ (item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like notation_declaration_for_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like notation_declaration_for_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	element_declaration_for_name_ (a_name: detachable NS_STRING): detachable NS_XMLDTD_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			result_pointer := objc_element_declaration_for_name_ (item, a_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like element_declaration_for_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like element_declaration_for_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

	attribute_declaration_for_name__element_name_ (a_name: detachable NS_STRING; a_element_name: detachable NS_STRING): detachable NS_XMLDTD_NODE
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
			a_name__item: POINTER
			a_element_name__item: POINTER
		do
			if attached a_name as a_name_attached then
				a_name__item := a_name_attached.item
			end
			if attached a_element_name as a_element_name_attached then
				a_element_name__item := a_element_name_attached.item
			end
			result_pointer := objc_attribute_declaration_for_name__element_name_ (item, a_name__item, a_element_name__item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like attribute_declaration_for_name__element_name_} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like attribute_declaration_for_name__element_name_} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSXMLDTD"
		end

end

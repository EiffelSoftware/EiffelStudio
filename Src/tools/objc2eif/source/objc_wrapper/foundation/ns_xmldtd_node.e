note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_XMLDTD_NODE

inherit
	NS_XML_NODE
		redefine
			wrapper_objc_class_name
		end


create {NS_ANY}
	make_with_pointer,
	make_with_pointer_and_retain

create
	make_with_xml_string_,
	make_with_kind_,
	make_with_kind__options_,
	make

feature {NONE} -- Initialization

	make_with_xml_string_ (a_string: detachable NS_STRING)
			-- Initialize `Current'.
		local
			a_string__item: POINTER
		do
			if attached a_string as a_string_attached then
				a_string__item := a_string_attached.item
			end
			make_with_pointer (objc_init_with_xml_string_(allocate_object, a_string__item))
			if item = default_pointer then
				-- TODO: handle initialization error.
			end
		end

feature {NONE} -- NSXMLDTDNode Externals

	objc_init_with_xml_string_ (an_item: POINTER; a_string: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDTDNode *)$an_item initWithXMLString:$a_string];
			 ]"
		end

	objc_set_dtd_kind_ (an_item: POINTER; a_kind: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDTDNode *)$an_item setDTDKind:$a_kind];
			 ]"
		end

	objc_dtd_kind (an_item: POINTER): NATURAL_64
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLDTDNode *)$an_item DTDKind];
			 ]"
		end

	objc_is_external (an_item: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(NSXMLDTDNode *)$an_item isExternal];
			 ]"
		end

	objc_set_public_i_d_ (an_item: POINTER; a_public_id: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDTDNode *)$an_item setPublicID:$a_public_id];
			 ]"
		end

	objc_public_id (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDTDNode *)$an_item publicID];
			 ]"
		end

	objc_set_system_i_d_ (an_item: POINTER; a_system_id: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDTDNode *)$an_item setSystemID:$a_system_id];
			 ]"
		end

	objc_system_id (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDTDNode *)$an_item systemID];
			 ]"
		end

	objc_set_notation_name_ (an_item: POINTER; a_notation_name: POINTER)
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				[(NSXMLDTDNode *)$an_item setNotationName:$a_notation_name];
			 ]"
		end

	objc_notation_name (an_item: POINTER): POINTER
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return (EIF_POINTER)[(NSXMLDTDNode *)$an_item notationName];
			 ]"
		end

feature -- NSXMLDTDNode

	set_dtd_kind_ (a_kind: NATURAL_64)
			-- Auto generated Objective-C wrapper.
		local
		do
			objc_set_dtd_kind_ (item, a_kind)
		end

	dtd_kind: NATURAL_64
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_dtd_kind (item)
		end

	is_external: BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
		do
			Result := objc_is_external (item)
		end

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

	set_notation_name_ (a_notation_name: detachable NS_STRING)
			-- Auto generated Objective-C wrapper.
		local
			a_notation_name__item: POINTER
		do
			if attached a_notation_name as a_notation_name_attached then
				a_notation_name__item := a_notation_name_attached.item
			end
			objc_set_notation_name_ (item, a_notation_name__item)
		end

	notation_name: detachable NS_STRING
			-- Auto generated Objective-C wrapper.
		local
			result_pointer: POINTER
		do
			result_pointer := objc_notation_name (item)
			if result_pointer /= default_pointer then
				if attached objc_get_eiffel_object (result_pointer) as existing_eiffel_object then
					check attached {like notation_name} existing_eiffel_object as valid_result then
						Result := valid_result
					end
				else
					check attached {like notation_name} new_eiffel_object (result_pointer, True) as valid_result_pointer then
						Result := valid_result_pointer
					end
				end
			end
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSXMLDTDNode"
		end

end

note
	description: "Auto-generated Objective-C wrapper class"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_URL_DOWNLOAD_UTILS

inherit
	NS_OBJECT_UTILS
		redefine
			wrapper_objc_class_name,
			is_subclass_instance
		end


feature -- NSURLDownload

	can_resume_download_decoded_with_encoding_mime_type_ (a_mime_type: detachable NS_STRING): BOOLEAN
			-- Auto generated Objective-C wrapper.
		local
			l_objc_class: OBJC_CLASS
			a_mime_type__item: POINTER
		do
			if attached a_mime_type as a_mime_type_attached then
				a_mime_type__item := a_mime_type_attached.item
			end
			create l_objc_class.make_with_name (get_class_name)
			check l_objc_class_registered: l_objc_class.registered end
			Result := objc_can_resume_download_decoded_with_encoding_mime_type_ (l_objc_class.item, a_mime_type__item)
		end

feature {NONE} -- NSURLDownload Externals

	objc_can_resume_download_decoded_with_encoding_mime_type_ (a_class_object: POINTER; a_mime_type: POINTER): BOOLEAN
			-- Auto generated Objective-C wrapper.
		external
			"C inline use <Foundation/Foundation.h>"
		alias
			"[
				return [(Class)$a_class_object canResumeDownloadDecodedWithEncodingMIMEType:$a_mime_type];
			 ]"
		end

feature {NONE} -- Implementation

	wrapper_objc_class_name: STRING
			-- The class name used for classes of the generated wrapper classes.
		do
			Result := "NSURLDownload"
		end

	is_subclass_instance: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

end

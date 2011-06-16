note
	description: "Summary description for {ER_INTERFACE_NAMES}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_INTERFACE_NAMES

feature -- Query

	cannot_find_images: STRING_32
			--
		do
			Result := "Cannot find images in $ISE_EIFFEL\tools\ribbon\images"
		end

	cannot_find_templates: STRING_32
			--
		do
			Result := "Cannot find templates in $ISE_EIFFEL\tools\ribbon\template"
		end

	cannot_find_ribbon_folders: STRING_32
			--
		do
			Result := "Cannot find EiffelRibbon folders in $ISE_EIFFEL\tools\ribbon"
		end

	ok: STRING_32
			--
		do
			Result := "OK"
		end
end

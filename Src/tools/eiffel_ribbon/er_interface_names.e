note
	description: "Summary description for {ER_INTERFACE_NAMES}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_INTERFACE_NAMES

feature -- Query

	cannot_find_images (a_ise_eiffel: STRING_32): STRING_32
			--
		do
			Result := "Cannot find images in " + a_ise_eiffel + "\tools\ribbon\images"
		end

	cannot_find_templates (a_ise_eiffel: STRING_32): STRING_32
			--
		do
			Result := "Cannot find templates in " + a_ise_eiffel + "\tools\ribbon\template"
		end

	cannot_find_ribbon_folders (a_ise_eiffel: STRING_32): STRING_32
			--
		require
			not_void: a_ise_eiffel /= Void
		do
			Result := "Cannot find EiffelRibbon folders in " + a_ise_eiffel + "\tools\ribbon"
		end

	ise_eiffel_not_defined: STRING_32
			--
		do
			Result := "The $ISE_EIFFEL is not defined"
		end

	ok: STRING_32
			--
		do
			Result := "OK"
		end
end

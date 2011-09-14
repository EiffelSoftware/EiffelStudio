note
	description: "[
					GUI names
																					]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_INTERFACE_NAMES

feature -- Query

	cannot_find_images (a_ise_eiffel: STRING_32): STRING_32
			-- Cannot find images...
		do
			Result := "Cannot find images in " + a_ise_eiffel + "\tools\ribbon\images"
		end

	cannot_find_templates (a_ise_eiffel: STRING_32): STRING_32
			-- Cannot find templates...
		do
			Result := "Cannot find templates in " + a_ise_eiffel + "\tools\ribbon\template"
		end

	cannot_find_ribbon_folders (a_ise_eiffel: STRING_32): STRING_32
			-- Cannot find ribbon folders...
		require
			not_void: a_ise_eiffel /= Void
		do
			Result := "Cannot find EiffelRibbon folders in " + a_ise_eiffel + "\tools\ribbon"
		end

	ise_eiffel_not_defined: STRING_32
			-- ISE_EIFFEL not defined
		do
			Result := "The $ISE_EIFFEL is not defined"
		end

	ok: STRING_32
			-- OK
		do
			Result := "OK"
		end
end

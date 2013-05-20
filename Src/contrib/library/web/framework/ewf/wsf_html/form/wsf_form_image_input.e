note
	description: "Summary description for {WSF_FORM_IMAGE_INPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_IMAGE_INPUT

inherit
	WSF_FORM_INPUT
		redefine
			specific_input_attributes_string
		end

create
	make

feature -- Access

	input_type: STRING = "image"

	src: detachable READABLE_STRING_8
			-- Specifies the URL of the image to use as a submit button

	alt: detachable READABLE_STRING_8
			-- Alternate text for an image.

feature -- Change

	set_src (v: like src)
		do
			src := v
		end

	set_alt (v: like alt)
		do
			alt := v
		end

feature {NONE} -- Implementation

	specific_input_attributes_string: detachable STRING_8
			-- Specific input attributes if any.	
			-- To redefine if needed
		do
			create Result.make_empty
			if attached src as l_src then
				Result.append (" src=%"" + l_src + "%"")
			end
			if attached alt as l_alt then
				Result.append (" alt=%"" + l_alt + "%"")
			end
		end

invariant

end

indexing
	description: "Sample rich text"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TEXT_SAMPLE_DISPLAY

inherit
	EV_RICH_TEXT
		redefine
			make
		end

	EB_GRAPHICAL_PARAMETERS
		rename
			make as jnmhr_teiopgheroiu_gnfhmbre98owig
		end
			-- as you can figure out, this rename clause is NOT meant to be permanent

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		local
			ft: EV_CHARACTER_FORMAT
		do
			Precursor (par)
--			set_editable (False)
			Create ft.make
			set_text ("Obiwan is a JEDI%NEvery JEDI has a lightsaber")
			reset
		end
		
feature -- reset

	reset is
		do
			apply_format (format)
		end

	apply is
		do
			apply_format (format)
		end


	format: EV_TEXT_FORMAT is
		do
			Create Result.make

			Result.add_character_format_with_regions
				(object_text.actual_value, <<1, 6>>)

			Result.add_character_format_with_regions
				(default_text.actual_value, <<7, 12, 17, 23, 28, 34>>)

			Result.add_character_format_with_regions
				(class_text.actual_value, <<13, 16, 24, 27>>)

			Result.add_character_format_with_regions
				(feature_text.actual_value, <<35, 44>>)
		end

end -- class EB_TEXT_SAMPLE_DISPLAY

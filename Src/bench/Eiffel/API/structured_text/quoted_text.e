indexing

	description: 
		"Text within comments that have been `quoted'.";
	date: "$Date$";
	revision: "$Revision $"

class QUOTED_TEXT

inherit
	FEATURE_TEXT
		rename
			make as feature_text_make
		redefine
			append_to
		end

	CLASS_NAME_TEXT
		rename
			make as class_text_make
		redefine
			append_to
		end

	CLUSTER_NAME_TEXT
		rename
			make as cluster_text_make
		redefine
			append_to
		end

	DOCUMENTATION_FACILITIES
		export
			{NONE} all
		end

creation

	make

feature -- Initialization

	make (text: like image) is
			-- Initialize image_without_quotes with `text'.
		require
			valid_text: text /= Void
		do
			image_without_quotes := text
			image := clone (text)
			image.precede ('`')
			image.extend ('%'')
			e_feature := feature_by_name (text)
			if e_feature = Void then
				if is_class_name (text) then
					class_i := class_by_name (text)
				end
				if class_i = Void then
					cluster_i := cluster_by_name (text)
				end
			end
		ensure
			image_without_quotes = text
		end

feature -- Properties

	image_without_quotes: STRING
			-- Used by documentation generation.

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append quoted text to `text'.
		do
			if e_feature /= Void then
				text.process_feature_text (Current)
			elseif class_i /= Void then
				text.process_class_name_text (Current)
			elseif cluster_i /= Void then
				text.process_cluster_name_text (Current)
			else
				text.process_quoted_text (Current)
			end
		end

end -- class QUOTED_TEXT

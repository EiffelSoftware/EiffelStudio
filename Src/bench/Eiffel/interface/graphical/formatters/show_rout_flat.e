-- Command to flat of routine

class SHOW_ROUT_FLAT

inherit

	SHOW_TEXT
		redefine
			format
		end
	SHARED_SERVER

creation

	make

feature

	format (stone: STONE) is
			-- Show text of `stone' in `text_window'
		local
			stone_text: STRING
			feature_stone: FEATURE_STONE
			feature_i: FEATURE_I
			class_c: CLASS_C
			format_context: FORMAT_FEAT_CONTEXT
			feature_as: FEATURE_AS
		do
			feature_stone ?= stone
			if feature_stone /= Void and then feature_stone.is_valid then
				text_window.clean
				display_header (stone)
				text_window.set_root_stone (stone)
				feature_i := feature_stone.feature_i
				class_c := feature_stone.class_c
				feature_as := Body_server.item (feature_i.body_id)
				!!format_context.format_feature (feature_i.written_class, 
												class_c, feature_as)
				text_window.process_text (format_context.text)
				text_window.set_editable
				text_window.show_image
				text_window.set_read_only
				text_window.set_last_format (Current)
			end
		end

	
end

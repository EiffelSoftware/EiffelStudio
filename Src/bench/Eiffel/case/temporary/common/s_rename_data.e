indexing

	description: 
		"Data representing the renamed feature.";
	date: "$Date$";
	revision: "$Revision $"

class S_RENAME_DATA

inherit

	S_ELEMENT_DATA

feature -- Properties

	origin_feature_key: S_FEATURE_KEY;
			-- Origin feature before being renamed

	free_form_text: STRING;
			-- Text entered if origin feature is not
			-- specified	

feature -- Setting 

	set_free_form_text (txt: STRING) is
			-- Set text to `txt'.
		require
			valid_txt: txt /= Void;
			origin_feature_key_void: origin_feature_key = Void
		do
			free_form_text := txt;
		ensure
			free_form_text_set: free_form_text = txt;
		end;

	set_origin_feature_key (key: like origin_feature_key) is
			-- Set origin_feature_key to `key'.
		require
			free_form_text_void: free_form_text = Void
			valid_key: key /= Void 
		do
			origin_feature_key := key;
		ensure
			key_set: origin_feature_key = key;
		end;
	
end -- class S_RENAME_DATA

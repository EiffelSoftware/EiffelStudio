deferred class TEXT_FORMATTER

feature

	process_text (text: STRUCTURED_TEXT) is
		do
			from
				text.start
			until
				text.after
			loop
				process_item (text.item);
				text.forth
			end;
		end;


	process_item (t: TEXT_ITEM) is
		local
			before_class: BEFORE_CLASS;
			after_class: AFTER_CLASS;
			before_feature: BEFORE_FEATURE;
			after_feature: AFTER_FEATURE;
			new_line_text: NEW_LINE_TEXT;
			basic_text: BASIC_TEXT;
			clickable_text: CLICKABLE_TEXT;
			breakable_mark: BREAKABLE_MARK;
			filter_item: FILTER_ITEM;
			class_name_text: CLASS_NAME_TEXT
		do
			new_line_text ?= t;
			basic_text ?= t;
			clickable_text ?= t;
			breakable_mark ?= t;
			class_name_text ?= t;
		
			if class_name_text /= Void then
				process_class_name_text (class_name_text)
			elseif clickable_text /= void then
				process_clickable_text (clickable_text)
			elseif basic_text /= void then
				process_basic_text (basic_text)
			elseif breakable_mark /= void then
				process_breakable_mark (breakable_mark);
			elseif new_line_text /= void then
				process_new_line_text (new_line_text)
			else
				before_class ?= t;
				after_class ?= t;
				before_feature ?= t;
				after_feature ?= t;
				filter_item ?= t;
				if after_feature /= void then
					process_after_feature (after_feature)
				elseif before_feature /= void then
					process_before_feature (before_feature)
				elseif after_class /= void then
					process_after_class (after_class)
				elseif before_class /= void then
					process_before_class (before_class)
				elseif filter_item /= Void then
					process_filter_item (filter_item)
				end
			end;
		end;
				
				
	process_basic_text (t: BASIC_TEXT) is
		deferred
		end;

	process_clickable_text (t: CLICKABLE_TEXT) is
		do
			process_basic_text (t);
		end;

	process_class_name_text (t: CLASS_NAME_TEXT) is
		do
			process_clickable_text (t)
		end;

	process_breakable_mark (t: BREAKABLE_MARK) is
		do
		end;

	process_new_line_text (t: NEW_LINE_TEXT) is
		deferred
		end;

	process_after_feature (t: AFTER_FEATURE) is
		do
		end;

	process_before_feature (t: BEFORE_FEATURE) is
		do
		end;
	
	process_after_class (t: AFTER_CLASS) is
		do
		end;

	process_before_class (t: BEFORE_CLASS) is
		do
		end;

	process_filter_item (t: FILTER_ITEM) is
		do
		end;

end

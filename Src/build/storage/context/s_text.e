

class S_TEXT 

inherit

	S_CONTEXT
		redefine
			set_context_attributes
		end


creation

	make

	
feature 

	make (node: TEXT_C) is
		do
			save_attributes (node);
			if node.max_size_modified then
				maximum_size := node.maximum_size
			else
				maximum_size := Not_set
			end;
			if node.margin_width_modified then
				margin_width := node.margin_width
			else
				margin_width := Not_set
			end;
			if node.margin_height_modified then
				margin_height := node.margin_height
			else
				margin_height := Not_set
			end;
			read_only_modified := node.read_only_modified;
			is_read_only := node.is_read_only;
			word_wrap_modified := node.word_wrap_modified;
			is_word_wrap_enable := node.is_word_wrap_enable;
			height_resizable_modified := node.height_resizable_modified;
			is_height_resizable := node.is_height_resizable;
			width_resizable_modified := node.width_resizable_modified;
			is_width_resizable := node.is_width_resizable;
		end;

	context (a_parent: COMPOSITE_C): TEXT_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

	set_context_attributes (a_context: TEXT_C) is
		do
			if margin_width /= Not_set then
				a_context.set_margin_width (margin_width);
			end;
			if margin_height /= Not_set then
				a_context.set_margin_height (margin_height);
			end;
			if maximum_size /= Not_set then
				a_context.set_maximum_size (maximum_size);
			end;
			if read_only_modified then
				a_context.set_read_only (is_read_only);
			end;
			if word_wrap_modified then
				a_context.enable_word_wrap (is_word_wrap_enable);
			end;
			if height_resizable_modified then
				a_context.enable_resize_height (is_height_resizable);
			end;
			if width_resizable_modified then
				a_context.enable_resize_width (is_width_resizable);
			end;
			set_attributes (a_context);
		end;

	
feature {NONE}

	maximum_size: INTEGER;

	is_read_only: BOOLEAN;

	read_only_modified: BOOLEAN;

	margin_height: INTEGER;

	margin_width: INTEGER;

	is_word_wrap_enable: BOOLEAN;

	word_wrap_modified: BOOLEAN;

	is_height_resizable: BOOLEAN;

	height_resizable_modified: BOOLEAN;

	is_width_resizable: BOOLEAN;

	width_resizable_modified: BOOLEAN;

end


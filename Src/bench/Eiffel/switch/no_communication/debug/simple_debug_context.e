indexing

	description: 
		"Adding debug breakpoints to simple format text.";
	date: "$Date$";
	revision: "$Revision $"

class SIMPLE_DEBUG_CONTEXT

inherit

	FORMAT_CONTEXT
		rename
			emit_tabs as old_emit_tabs,
			make as old_make
		redefine
			put_breakable, formal_name, put_class_name
		end
	FORMAT_CONTEXT
		rename
			make as old_make
		redefine
			put_breakable, emit_tabs,
			formal_name, put_class_name
		select
			emit_tabs
		end;
	SHARED_WORKBENCH

create

	make

feature {NONE} -- Initialization

	make (a_feat: E_FEATURE) is
			-- Initialize current with `a_class'.
		require
			valid_feat: a_feat /= Void
		local
			ast: FEATURE_AS
		do
			make_for_case;
			e_class := a_feat.associated_class;
			e_feature := a_feat;	
			ast := a_feat.ast;	
			create eiffel_file.make_with_positions 
				(a_feat.written_class.file_name, 
					ast.start_position, ast.end_position);
			eiffel_file.set_current_feature (ast);
			if ast = Void then
				execution_error := True
			else
				formatter.format (ast)
			end;
		end;

feature -- Access

	e_class: CLASS_C;
			-- Class where feature is defined

	e_feature: E_FEATURE;
			-- Class where feature is defined

feature -- Element change

	formal_name (pos: INTEGER): ID_AS is
			-- Formal name of class_c generics at position `pos.
		do
			Result := e_class.generics.i_th (pos).name.as_upper
		end;

	put_class_name (s: STRING) is
			-- Append `s' to `text'.
		local
			classi: CLASS_I;
			tmp: STRING
		do
			if not tabs_emitted then
				emit_tabs;
			end;
			tmp := s.as_lower
			classi := Universe.class_named (tmp, e_class.cluster);
			if classi = Void then
				text.add_string (s);
			else
				text.add_classi (classi, s);
			end
		end;

feature {NONE} -- Implementation

	breakpoint_index: INTEGER;
			-- Breakpoint index in feature

	added_breakpoint: BOOLEAN
			-- Was a break point added?

	put_breakable is
		local
			bp: BREAKPOINT_ITEM
		do
			breakpoint_index := breakpoint_index + 1;
			create bp.make (e_feature, breakpoint_index);
			added_breakpoint := True;
			text.add (bp)
		end;

	emit_tabs is
		do
			if added_breakpoint then
				added_breakpoint := false;
			else
				text.add (ti_padded_debug_mark)
			end;
			old_emit_tabs;
		end;

end	 -- class SIMPLE_DEBUG_CONTEXT

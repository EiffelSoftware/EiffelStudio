indexing

	description: 
		"Formats Eiffel class text.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_TEXT_FORMATTER

inherit
	E_TEXT_FORMATTER

	SHARED_INST_CONTEXT

	SHARED_WORKBENCH

	SHARED_FORMAT_INFO
		rename
			is_short as format_is_short,
			set_is_short as format_set_is_short,
			set_order_same_as_text as format_set_order_same_as_text
		end

feature -- Properties

	is_one_class_only: BOOLEAN;
			-- Is the format performed on one class only?
	
	is_short: BOOLEAN;
			-- Is the format doing a short? 

	ordered_same_as_text: BOOLEAN;
			-- Will the format output be in the same order as text file?

	feature_clause_order: ARRAY [STRING]
			-- Array of orderd feature clause comments

	is_flat: BOOLEAN is
			-- Is the format doing a flat? 
		do
			Result := not is_short
		ensure
			not_short: Result = not is_short
		end;

feature -- Setting

	set_is_short is
			-- Set `is_short' to True.
		do
			is_short := True
		ensure
			is_short: is_short
		end;

	set_order_same_as_text is
			-- Set ordered_same_as_text_bool to True.
		do
			ordered_same_as_text := True
		ensure
			ordered_same_as_text: ordered_same_as_text
		end;

	set_one_class_only is
			-- Set current_class_only to True.
		do
			is_one_class_only := True;
		ensure
			is_one_class_only: is_one_class_only
		end;

	set_feature_clause_order (fco: like feature_clause_order) is
			-- Set `feature_clause_order' to `fco'.
		require
			not_orded_same_as_text: not ordered_same_as_text
		do
			feature_clause_order := fco
		ensure
			set: feature_clause_order = fco
		end;

feature -- Output

	format (e_class: CLASS_C) is
			-- Format text for eiffel class `e_class'.
		require
			valid_e_class: e_class /= Void
		local
			f: FORMAT_CONTEXT
		do
			if is_with_breakable then
				create {CLASS_DEBUG_CONTEXT} f.make (e_class)
			else
				create f.make (e_class)
			end
			if is_short or else e_class.lace_class.hide_implementation then
				f.set_is_short
			end;
			if is_one_class_only then
				f.set_current_class_only
			end;
			if is_clickable then
				f.set_in_bench_mode
			end;
			if ordered_same_as_text then
				f.set_order_same_as_text
			else
				f.set_feature_clause_order (feature_clause_order)
			end;
			f.execute;
			text := f.text;
			error := f.execution_error
		end;

	format_invariants (e_class: CLASS_C) is
			-- Format invariants for eiffel class `e_class'.
		require
			valid_e_class: e_class /= Void
		local
			f: FORMAT_CONTEXT;
			old_cluster: CLUSTER_I;
			old_class, class_c: CLASS_C;
		do
			!! f.make (e_class);
			if is_clickable then
				f.set_in_bench_mode
			end;
			old_class := System.current_class;
			old_cluster := Inst_context.cluster;
			class_c ?= e_class;
			System.set_current_class (class_c);
			Inst_context.set_cluster (e_class.cluster);
			f.register_ancestors_invariants;
			f.format_invariants;
			System.set_current_class (old_class);
			Inst_context.set_cluster (old_cluster);
			text := f.text;
			error := f.execution_error
		end;

end -- class CLASS_TEXT_FORMATTER

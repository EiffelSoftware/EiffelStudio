indexing

	description: 
		"Displays flat/short of a class in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_FS 

inherit

	EWB_COMPILED_CLASS
		rename
			make as compiled_class_make
		redefine
			name, help_message, abbreviation
		end;
	EB_CONSTANTS

creation

	make, do_nothing

feature -- Initialization

	make (cn, fn: STRING) is
			-- Initialization
		require
			cn_not_void: cn /= Void;
			fn_not_void: fn /= Void
		do
			class_make (cn);
			init (fn);
		ensure
			filter_name_set: filter_name = fn;
			class_name_set: class_name = cn
		end;

feature -- Properties

	name: STRING is
		do
			Result := flatshort_cmd_name;
		end;

	help_message: STRING is
		do
			Result := flatshort_help
		end;

	abbreviation: CHARACTER is
		do
			Result := flatshort_abb
		end;

feature {NONE} -- Execution

	associated_cmd: E_SHOW_FS is
		do
			!! Result.do_nothing;
			Result.set_feature_clause_order 
				(Class_tool_resources.feature_clause_order.actual_value)
		end;

end -- class EWB_FS

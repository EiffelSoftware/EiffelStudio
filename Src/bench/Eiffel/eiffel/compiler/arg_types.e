-- Controler of argument types: useful for conformance involving
-- like-argument types

class ARG_TYPES 

inherit

	SHARED_AST_CONTEXT
		export
			{ANY} context
		end
	
feature

	offset: INTEGER;
			-- Offset for accessing to `container'

	container: ARRAY [TYPE];
			-- Argument types 

	i_th (i: INTEGER): TYPE_A is
			-- I_th argument type
		require
			good_context: container /= Void;
			consistency: container.count >= offset + i;
		do
			Result := container.item (i + offset).actual_type;
		end; -- i_th

	init1 (f: FEATURE_I) is
			-- Initialization for redeclaration conformance
		require
			good_argument: f /= Void;
		do
			offset := 0;
			container := f.arguments;
		end;

	init2 (f: FEATURE_I) is
			-- Initialization for validity call conformance
		require
			good_argument: f /= Void;
			consistency: Context.count >= f.argument_count;
		do
			container := Context;
			offset := Context.count - f.argument_count;
		end;

end

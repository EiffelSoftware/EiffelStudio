indexing
	description: "AST structure in Lace file for hide%
			%option for hiding precompiled classes.";
	date: "$Date$";
	revision: "$Revision$"

class HIDE_IMPLEMENTATION_SD

inherit

	OPTION_SD

feature -- Properties

	option_name: STRING is "hide_implementation"

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			error_raised, is_hidden: BOOLEAN
		do
			if Compilation_modes.is_precompiling then
				if value /= Void then
					if (value.is_yes or else value.is_all) then
						is_hidden := True
					elseif not value.is_no then
						error_raised := True;
						error (value);
					end;
				end;
				if not error_raised then
					if list = Void then
						Context.current_cluster.set_hide_implementation (is_hidden)
					end
				end;
			end;
		end;

end -- class HIDE_IMPLEMENATION_SD 

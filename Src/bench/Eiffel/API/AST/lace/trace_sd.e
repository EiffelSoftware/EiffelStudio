class TRACE_SD

inherit

	OPTION_SD
		redefine
			is_trace
		end

feature

	is_trace: BOOLEAN is
			-- Is the option a trace one ?
		do
			Result := True;
		end

end

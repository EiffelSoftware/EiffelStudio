class SHARED_ENV

feature

	Environ: ENV_INTERP is
			-- Shared access to environment variables interpreter
		once
			create Result;
		end;

end

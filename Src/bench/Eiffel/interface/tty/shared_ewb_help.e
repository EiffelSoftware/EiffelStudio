
class SHARED_EWB_HELP

feature

	help_messages: EXTEND_TABLE [STRING, STRING] is
		once
			!! Result.make (21);

			Result.put ("print this help message", "help");
			Result.put ("run es3 as a command loop", "loop");
			Result.put ("freeze the system", "freeze");
			Result.put ("finalize the system (discard assertions by default)", "finalize");
			Result.put ("precompile the system", "precompile");
--			Result.put ("clean the compilation structures", "clean");
			Result.put ("specify the Ace file", "ace");
			Result.put ("specify the compilation directory", "project");
			Result.put ("print the clients of a class", "clients");
			Result.put ("print the suppliers of a class", "suppliers");
			Result.put ("print the callers of a class feature", "callers");
			Result.put ("print the descendants of a class", "descendants");
			Result.put ("print the ancestors of a class", "ancestors");
			Result.put ("print the flat-short form of a class", "flatshort");
			Result.put ("print the flat form of a class", "flat");
			Result.put ("print the short form of a class", "short");
			Result.put ("print the classes implementing a class feature", "implementers");
			Result.put ("print the ancestor versions of a class feature", "aversions");
			Result.put ("print the descendant versions of a class feature", "dversions");
--			Result.put ("print the classes depending on a class feature", "dependents")
			Result.put ("stop on error", "stop")
		end

end

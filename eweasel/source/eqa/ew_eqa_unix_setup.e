note
	description: "[
					Setup Unix environment variables before running eweasel tests
																					]"
	date: "$Date$"
	revision: "$Revision$"

class
	EW_EQA_UNIX_SETUP

inherit
	EW_EQA_WINDOWS_SETUP
		redefine
			setup
		end

create
	make

feature -- Command

	setup
			-- <Precursor>
		local
			l_eweasel: EW_EQA_EWEASEL_MT
		do
			create l_eweasel.make_empty

			l_eweasel.output_arg (output_path)

			l_eweasel.define ("ISE_EIFFEL", ise_eiffel)

			l_eweasel.init ("$ISE_EIFFEL/control/init")

			-- Copy from $EWEASEL\bin\run_eweasel_filter
			l_eweasel.define ("ISE_PLATFORM", ise_platform)
			l_eweasel.define ("EWEASEL", "$ISE_EIFFEL/eweasel")
			l_eweasel.define ("INCLUDE", "$EWEASEL/control")
			l_eweasel.define ("EWEASEL_PLATFORM", "UNIX")
			l_eweasel.define ("UNIX", "1")
			l_eweasel.define ("PLATFORM_TYPE", "unix")
			l_eweasel.define ("EWEASEL_DOTNET_SETTING", "")

			-- Copy from $EWEASEL\control\unix_platform
			l_eweasel.define_file ("EWEASEL_COMPILE",	<<"$ISE_EIFFEL", "studio", "spec", "$ISE_PLATFORM", "bin", "ec">>)
			l_eweasel.define_file ("EWEASEL_FREEZE",	<<"$EWEASEL", "bin", "eiffel_freeze">>)
			l_eweasel.define_file ("EWEASEL_EXECUTE", <<"$EWEASEL", "bin", "eiffel_execute">>)

			-- Copy from $EWEASEL\control\standard
			l_eweasel.define_file ("PRECOMPILED_BASE", <<"$ISE_PRECOMP", "base.ecf">>)
			l_eweasel.define_file ("PRECOMPILED_BASE_MT", <<"$ISE_PRECOMP", "base-mt.ecf">>)

			-- Copy from $EWEASEL/control/unix_platform
			l_eweasel.define ("KERNEL_CLASSIC", "<cluster name=%"kernel%" location=%"$ISE_LIBRARY\library\base\elks\kernel%"/><cluster name=%"exceptions%" location=%"$ISE_LIBRARY\library\base\ise\kernel\exceptions%"/><cluster name=%"elks_exceptions%" location=%"$ISE_LIBRARY\library\base\elks\kernel\exceptions%"/>")
			l_eweasel.define ("KERNEL_DOTNET", "")
			l_eweasel.define ("SUPPORT_DOTNET", "")
			l_eweasel.define ("EWEASEL_DOTNET_SETTING", "")
			l_eweasel.define ("KERNEL_DOTNET_NO_EXCEPTION", "")

			-- Copy from $EWEASEL/control/standard
			l_eweasel.define_file ("BASE", <<"$ISE_LIBRARY", "library", "base", "elks">>)
			l_eweasel.define_file ("BASE_ISE", <<"$ISE_LIBRARY", "library", "base", "ise">>)
			l_eweasel.define_file ("KERNEL",	<<"$BASE", "kernel">>)
			l_eweasel.define_file ("EXCEPTIONS",	<<"$BASE", "kernel", "exceptions">>)
			l_eweasel.define_file ("EXCEPTIONS_ISE",	<<"$BASE_ISE", "kernel", "exceptions">>)
			l_eweasel.define_file ("EXCEPTIONS_ELKS", <<"$BASE", "kernel", "exceptions">>)
			l_eweasel.define_file ("REFACTORING", <<"$BASE", "refactoring">>)
			l_eweasel.define_file ("SERIALIZATION", <<"$BASE_ISE", "serialization">>)
			l_eweasel.define_file ("SUPPORT", <<"$BASE", "support">>)
			l_eweasel.define_file ("ACCESS", <<"$BASE", "structures", "access">>)
			l_eweasel.define_file ("CURSORS", <<"$BASE", "structures", "cursors">>)
			l_eweasel.define_file ("CURSOR_TREE", <<"$BASE", "structures", "cursor_tree">>)
			l_eweasel.define_file ("DISPENSER", <<"$BASE", "structures", "dispenser">>)
			l_eweasel.define_file ("ITERATION",	<<"$BASE", "structures", "iteration">>)
			l_eweasel.define_file ("LIST", <<"$BASE", "structures", "list">>)
			l_eweasel.define_file ("OBSOLETE", <<"$BASE", "structures", "obsolete">>)
			l_eweasel.define_file ("SET", <<"$BASE", "structures", "set">>)
			l_eweasel.define_file ("STRATEGY", <<"$BASE", "structures", "set", "strategies">>)
			l_eweasel.define_file ("SORT", <<"$BASE", "structures", "sort">>)
			l_eweasel.define_file ("STORAGE", <<"$BASE", "structures", "storage">>)
			l_eweasel.define_file ("TABLE", <<"$BASE", "structures", "table">>)
			l_eweasel.define_file ("TRAVERSING", <<"$BASE", "structures", "traversing">>)
			l_eweasel.define_file ("TREE", <<"$BASE", "structures", "tree">>)
			l_eweasel.define_file ("THREAD", <<"$ISE_LIBRARY", "library", "thread">>)
			-- EiffelTime directories
			l_eweasel.define_file ("TIME", <<"$ISE_LIBRARY", "library", "time">>)
			l_eweasel.define_file ("TIME_FORMAT", <<"$TIME", "format">>)
			l_eweasel.define_file ("TIME_ENGLISH", <<"$TIME", "format", "english">>)
			l_eweasel.define_file ("TIME_GERMAN", <<"$TIME", "format", "german">>)
			-- EiffelStore directories
			l_eweasel.define_file ("STORE", <<"$ISE_LIBRARY", "library", "store">>)
			l_eweasel.define_file ("DATE_TIME", <<"$STORE", "date_and_time">>)
			l_eweasel.define_file ("RDBMS_ORACLE", <<"$STORE", "dbms", "rdbms", "oracle">>)
			l_eweasel.define_file ("RDBMS_SUPPORT", <<"$STORE", "dbms", "rdbms", "support">>)
			l_eweasel.define_file ("DBMS_SUPPORT", <<"$STORE", "dbms", "support">>)
			l_eweasel.define_file ("STORE_INTERFACE", <<"$STORE", "interface">>)
			l_eweasel.define_file ("STORE_SUPPORT", <<"$STORE", "support">>)

			prepare
			source_path (source_directory)
		end

end

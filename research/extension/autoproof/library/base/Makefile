BASE_SRC=$(ISE_LIBRARY)/library/base/base.ecf
ANY_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/any.e
ARGUMENTS_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/arguments.e
ARGUMENTS_32_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/arguments_32.e
ARRAY_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/array.e
FIBONACCI_SRC=$(ISE_LIBRARY)/library/base/elks/support/fibonacci.e
ITERABLE_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/iterable.e
ITERATION_CURSOR_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/iteration_cursor.e
PRIMES_SRC=$(ISE_LIBRARY)/library/base/elks/support/primes.e
STD_FILES_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/std_files.e

GENERATED_FILES= \
	base.ecf \
	base-safe.ecf \
	base-scoop-safe.ecf \
	eve/any.e \
	eve/arguments.e \
	eve/arguments_32.e \
	eve/array.e \
	eve/fibonacci.e \
	eve/iterable.e \
	eve/iteration_cursor.e \
	eve/primes.e \
	eve/std_files.e

ARRAY_CONVERSION=,$(ISE_WIN_CR)\n\
\	to_mml_set: {MML_SET [G]},$(ISE_WIN_CR)\n\
\	to_mml_sequence: {MML_SEQUENCE [G]},$(ISE_WIN_CR)\n\
\	to_simple_array: {SIMPLE_ARRAY [G]}$(ISE_WIN_CR)\n\

ARRAY_SPECIFICATION=\
feature -- Specification$(ISE_WIN_CR)\n\
$(ISE_WIN_CR)\n\
\	to_mml_set: MML_SET [G]$(ISE_WIN_CR)\n\
\	\	do$(ISE_WIN_CR)\n\
\	\	\	check is_executable: False then end$(ISE_WIN_CR)\n\
\	\	end$(ISE_WIN_CR)\n\
$(ISE_WIN_CR)\n\
\	to_mml_sequence: MML_SEQUENCE [G]$(ISE_WIN_CR)\n\
\	\	do$(ISE_WIN_CR)\n\
\	\	\	check is_executable: False then end$(ISE_WIN_CR)\n\
\	\	end$(ISE_WIN_CR)\n\
$(ISE_WIN_CR)\n\
\	to_simple_array: SIMPLE_ARRAY [G]$(ISE_WIN_CR)\n\
\	\	do$(ISE_WIN_CR)\n\
\	\	\	check is_executable: False then end$(ISE_WIN_CR)\n\
\	\	end$(ISE_WIN_CR)\n\

.SILENT:

all:
	echo Available targets:
	echo.
	echo 	update	- Update source code from the library pointed by ISE_LIBRARY
	echo 	clean 	- Remove generated files

update: $(GENERATED_FILES)

base.ecf: $(BASE_SRC) base.sed Makefile
	echo Updating $@
	sed -f base.sed $(BASE_SRC) > $@

base-safe.ecf: base.ecf base-safe.sed Makefile
	echo Updating $@
	sed -f base-safe.sed base.ecf > $@

base-scoop-safe.ecf: base-safe.ecf base-scoop-safe.sed Makefile
	echo Updating $@
	sed -f base-scoop-safe.sed base-safe.ecf > $@

eve/any.e: $(ANY_SRC) any.sed any.txt Makefile
	echo Updating $@
	sed -f any.sed $(ANY_SRC) > $@

eve/arguments.e: $(ARGUMENTS_SRC) arguments.sed Makefile
	echo Updating $@
	sed -f arguments.sed $(ARGUMENTS_SRC) > $@

eve/arguments_32.e: $(ARGUMENTS_32_SRC) primes.sed Makefile
	echo Updating $@
	sed -f primes.sed $(ARGUMENTS_32_SRC) > $@

eve/array.e: $(ARRAY_SRC) primes.sed Makefile
	echo Updating $@
	sed \
		-e "s/\(make_from_cil ({NATIVE_ARRAY \[G\]})\)/\1$(ARRAY_CONVERSION)/" \
		-e "/^invariant/i$(ARRAY_SPECIFICATION)" \
		-f primes.sed \
		$(ARRAY_SRC) > $@

eve/fibonacci.e: $(FIBONACCI_SRC) primes.sed Makefile
	echo Updating $@
	sed -f primes.sed $(FIBONACCI_SRC) > $@

eve/iterable.e: $(ITERABLE_SRC) iterable.sed Makefile
	echo Updating $@
	sed -f iterable.sed $(ITERABLE_SRC) > $@

eve/iteration_cursor.e: $(ITERATION_CURSOR_SRC) iteration_cursor.sed Makefile
	echo Updating $@
	sed -f iteration_cursor.sed $(ITERATION_CURSOR_SRC) > $@

eve/primes.e: $(PRIMES_SRC) primes.sed Makefile
	echo Updating $@
	sed -f primes.sed $(PRIMES_SRC) > $@

eve/std_files.e: $(STD_FILES_SRC) std_files.sed Makefile
	echo Updating $@
	sed -f std_files.sed $(STD_FILES_SRC) > $@

clean:
	-cmd /v/c "set GENERATED_FILES=$(GENERATED_FILES) && set FILES_TO_DELETE=!GENERATED_FILES:/=^\! && del !FILES_TO_DELETE!"
	-rm $(GENERATED_FILES)

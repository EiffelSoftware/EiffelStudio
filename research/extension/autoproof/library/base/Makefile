BASE_SRC=$(ISE_LIBRARY)/library/base/base.ecf
ANY_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/any.e
ARGUMENTS_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/arguments.e
ARGUMENTS_32_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/arguments_32.e
ARRAY_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/array.e
ITERABLE_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/iterable.e
ITERATION_CURSOR_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/iteration_cursor.e
STD_FILES_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/std_files.e
TUPLE_SRC=$(ISE_LIBRARY)/library/base/elks/kernel/tuple.e

GENERATED_FILES=base.ecf eve/any.e eve/arguments.e eve/arguments_32.e eve/array.e eve/iterable.e eve/iteration_cursor.e eve/std_files.e eve/tuple.e

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

TUPLE_CONVERSION=$(ISE_WIN_CR)\n\
$(ISE_WIN_CR)\nconvert$(ISE_WIN_CR)\n\
$(ISE_WIN_CR)\n\
\	to_mml_set: {MML_SET [ANY]}$(ISE_WIN_CR)\n\
$(ISE_WIN_CR)\nfeature -- MML$(ISE_WIN_CR)\n\
$(ISE_WIN_CR)\n\
\	to_mml_set: MML_SET [ANY]$(ISE_WIN_CR)\n\
\	\	do$(ISE_WIN_CR)\n\
\	\	\	check is_executable: False then end$(ISE_WIN_CR)\n\
\	\	end

.SILENT:

all:
	echo Available targets:
	echo 	
	echo 	update	- Update source code from the library pointed by ISE_LIBRARY
	echo 	clean 	- Remove generated files

update: $(GENERATED_FILES)

base.ecf: $(BASE_SRC) base.sed Makefile
	sed -f base.sed $(BASE_SRC) > $@

eve/any.e: $(ANY_SRC) any.sed any.txt Makefile
	sed -f any.sed $(ANY_SRC) > $@

eve/arguments.e: $(ARGUMENTS_SRC) arguments.sed Makefile
	sed -f arguments.sed $(ARGUMENTS_SRC) > $@

eve/arguments_32.e: $(ARGUMENTS_32_SRC) arguments.sed Makefile
	sed -f arguments.sed $(ARGUMENTS_32_SRC) > $@

eve/array.e: $(ARRAY_SRC) Makefile
	sed \
		-e "s/\(make_from_cil ({NATIVE_ARRAY \[G\]})\)/\1$(ARRAY_CONVERSION)/" \
		-e "/^invariant/i$(ARRAY_SPECIFICATION)" \
		$(ARRAY_SRC) > $@

eve/iterable.e: $(ITERABLE_SRC) iterable.sed Makefile
	sed -f iterable.sed $(ITERABLE_SRC) > $@

eve/iteration_cursor.e: $(ITERATION_CURSOR_SRC) iteration_cursor.sed Makefile
	sed -f iteration_cursor.sed $(ITERATION_CURSOR_SRC) > $@

eve/std_files.e: $(STD_FILES_SRC) std_files.sed Makefile
	sed -f std_files.sed $(STD_FILES_SRC) > $@

eve/tuple.e: $(TUPLE_SRC) Makefile
	sed \
		-e "s/\(^\tdefault_create\)/\1$(TUPLE_CONVERSION)/" \
		$(TUPLE_SRC) > $@

clean:
	-del base.ecf eve\any.e eve\arguments.e eve\arguments_32.e eve\array.e eve\iterable.e eve\iteration_cursor.e eve\std_files.e eve\tuple.e
	-rm $(GENERATED_FILES)

/*

  ####   #    #  #    #   ####   #####   #####            ####
 #       #    #  #    #  #    #  #    #  #    #          #    #
  ####   ######  #    #  #    #  #    #  #    #          #
      #  #    #  # ## #  #    #  #####   #    #   ###    #
 #    #  #    #  ##  ##  #    #  #   #   #    #   ###    #    #
  ####   #    #  #    #   ####   #    #  #####    ###     ####

	Shell word parsing of a command string.

	For Windows:
		From UNIX - should be checked for more complex expressions such as:
			command args "'a'"
			command args "'hello" "'godbye"
 */

#include "eif_config.h"
#include "eif_portable.h"
#include "shword.h"
#include <string.h>

#define ARGV_NUMBER		5		/* Initial number of arguments expected */
#define ARGV_INCREASE	10		/* Amount by which argument array increases */
#define MAX_WORD_SIZE	1024	/* Maximum size for each collected word */
#define is_separator(c)	(ifs[0] == (char) (c))? 1 : 0		/* Test whether char is an IFS */

/* The variable IFS is used by the shell to perform the split of each word.
 * It contains a list of single characters which are to be taken as Input
 * Field Separator. To maintain generality, we mimic that behaviour here.
 */
rt_private char *ifs = " ";		/* Input field separator */

/* Array of strings built by shword, each word being stored in one slot of the
 * argument array. This pointer can be passed as-is to the execvp() system call.
 */
rt_private char **argv = 0;		/* Argument pointer */
rt_private int argc;				/* Argument count */
rt_private int where;				/* Current position within argv[] */

/* Function declarations */
rt_private void free_argv(void);		/* Free inside of argv[] array */
rt_private int init_argv(void);		/* Initialize argv[] for new command */
rt_private char *add_argv(char *word);		/* Append one word to the argv[] array */
rt_public void shfree(void);			/* Free structure used by argv[] */
rt_public char **shword(char *cmd);			/* Parse command string and split into words */

#ifdef EIF_WIN32
rt_private char *str_save(char *s);		/* Save string somewhere in memory */
#else
extern char *str_save(char *s);			/* Save string somewhere in memory */
#endif

rt_private void free_argv(void)
{
	/* Loop over the argv array and free all the strings it holds. Note that
	 * argv[argc] is always a null pointer and thus is not stored in the argv
	 * array.
	 */

	int i;

	for (i = 0; i < argc; i++)
		if (argv[i] != (char *) 0)
			free(argv[i]);
}

rt_private int init_argv(void)
{
	/* Initializes the argument pointer array. If the reference is not already
	 * a null pointer, the strings held in the argument array are freed but
	 * the array in itself is kept. The function returns 0 if all is ok, -1 if
	 * it cannot initialize the array correctly.
	 */

	int size = ARGV_NUMBER * sizeof(char *);

	if (argv != (char **) 0) {		/* Array already allocated */
		free_argv();				/* Free strings held within */
		where = 0;					/* Reset allocation counter to beginning */
		return 0;					/* We are re-using the existing array */
	}

	argv = (char **) malloc(size);
	if (argv == (char **) 0)		/* Not enough memory */
		return -1;

	memset (argv, 0, size);				/* Ensure all slots are null pointers */
	argc = ARGV_NUMBER;				/* Record dynamic size of argv[] */
	where = 0;						/* Next allocation will be done here */

	return 0;
}

rt_private char *add_argv(char *word)
{
	/* Add a "word" at the end of the argv[] array and return a pointer to the
	 * dynmically allocated string which holds this word (in the shell sense),
	 * or a null pointer if it cannot be allocated or inserted in the array.
	 */

	char *saved;					/* Save copy of string */
	char **new_argv;				/* When reallocation is necessary */
	int new_size;

	if (word != (char *) 0) {
		saved = str_save(word);		/* Save string in memory (duplicata) */
		if (saved == (char *) 0)	/* Not enough memory to save string */
			return (char *) 0;
	} else
		saved = word;

	if (where < argc) {				/* Still some room within argv[] */
		argv[where++] = saved;		/* Store item */
		return saved;				/* Operation succeeded */
	}

	new_size = (argc + ARGV_INCREASE) * sizeof(char *);
	new_argv = (char **) realloc(argv, new_size);
	if (new_argv == (char **) 0)
		return (char *) 0;			/* Out of memory */

	argc += ARGV_INCREASE;
	argv = new_argv;
	argv[where++] = saved;

	return saved;			/* Operation succeded */
}

rt_public void shfree(void)
{
	/* Free memory used by argument array */

	free_argv();		/* Free inside */
	free(argv);			/* Free container */

	argv = (char **) 0;
	argc = 0;
}

rt_public char **shword(char *cmd)
          		/* The command string */
{
	/* Break the shell command held in 'cmd' according to the IFS, putting
	 * each shell word in a separate array entry, hence building an argument
	 * suitable for the execvp() system call.
	 */

	int in_simple = 0;			/* Not in simple quotes */
	int in_quote = 0;			/* Not in double quotes */
	int was_backslash = 0;		/* Previous character was a backslash */
	char word[MAX_WORD_SIZE];	/* Where word is collected */
	int pos;					/* Position within word[] buffer */
	char c;						/* Current character */

	if (-1 == init_argv())		/* Initialize array storing collected words */
		return (char **) 0;		/* Cannot get a valid argv[] array */

	for (pos = 0, c = *cmd++; c != '\0'; c = *cmd++) {
		if (in_simple) {				/* In simple quote */
			if (was_backslash) {		/* Last character was a backslash */
				was_backslash = 0;		/* Reset backslash indicator */
				if (c == '\\')			/* Current character also a backslash */
					continue;			/* Leave char, in effect last is a \ */
				else if (c == '\'') {	/* Backslash wanted to escape a ' */
					word[pos - 1] = c;	/* Override backslash with quote */
					continue;
				}
			}
			if (c == '\'') {			/* Reached end of quoted string? */
				in_simple = 0;
				continue;				/* The ' is swallowed */
			}
		} else if (in_quote) {			/* In double quote */
			if (was_backslash) {		/* Previous char was a backslash */
				was_backslash = 0;		/* Reset backslash indicator */
				word[pos - 1] = c;		/* Current char overrides backslash */
				continue;
			}
			if (c == '"') {				/* Un-escaped quote */
				in_quote = 0;			/* Marks the end of the quoted string */
				continue;				/* The " is swallowed */
			}
		}
		switch (c) {
			case '\\':
			was_backslash = 1;			/* Remember that previous was a \ */
			word[pos++] = c;			/* Record character */
			break;
		case '\'':
			in_simple = 1;				/* Entering simple quote */
			break;
		case '"':
			if (!in_simple)
				in_quote = 1;			/* Entering double quote */
			else
#ifdef EIF_WIN32
				if (!in_quote)
					word[pos++] = c;		/* Must have been escaped */
				else {
					in_quote = 0;
					continue;
				}
#else
				word[pos++] = c;		/* Must have been escaped */
#endif
			break;
		default:
			if (in_simple || in_quote)
				word[pos++] = c;
			else if (is_separator(c)) {	/* Reached the end of a word */
				if (pos > 0) {			/* Adjacent separators are skipped */
					word[pos] = '\0';	/* Ensure it forms a string */
					add_argv(word);		/* Record word */
					pos = 0;			/* Ready for next word */
				}
			} else
				word[pos++] = c;		/* Record character */
		}
	}

	if (pos > 0) {				/* Record last word, if any */
		word[pos] = '\0';
		add_argv(word);
	}
	add_argv((char *) 0);		/* Make sure it is null terminated */

	return argv;				/* Pointer to argument word array */
}

#ifdef EIF_WIN32
rt_private char *str_save(char *s)
{
	/* Save string 's' somewhere in memory */

	char *new;

	if (s == (char *) 0)
		return (char *) 0;

	new = (char *) malloc(strlen(s) + 1);
	if (new == (char *) 0) {
#ifdef USE_ADD_LOG
		add_log(2, "ERROR cannot malloc %d bytes", strlen(s) + 1);
#endif
		return (char *) 0;
	}

	(void) strcpy(new, s);
	return new;
}
#endif

#ifdef TEST
print_argv(void)
{
	char **array = argv;
	char *str;

	printf("BEGIN\n");

	while (str = *array++)
		printf("\"%s\"\n", str);

	printf("END\n");
}

test(char *cmd)
{
	printf("%s\n", cmd);
	shword(cmd);
	print_argv();
}

main()
{
	test("   ls -al /home");
	test("'ls -al' /home");
	test("ls '-al \\\"\\'/home'");
	test("ls \"-al \\'\\\"/home'\"");
}

#endif


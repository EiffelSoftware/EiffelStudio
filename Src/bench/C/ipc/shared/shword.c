/*

  ####   #    #  #    #   ####   #####   #####            ####
 #       #    #  #    #  #    #  #    #  #    #          #    #
  ####   ######  #    #  #    #  #    #  #    #          #
      #  #    #  # ## #  #    #  #####   #    #   ###    #
 #    #  #    #  ##  ##  #    #  #   #   #    #   ###    #    #
  ####   #    #  #    #   ####   #    #  #####    ###     ####

	Shell word parsing of a command string.
*/

#include "config.h"
#include "portable.h"

#define ARGV_NUMBER		5		/* Initial number of arguments expected */
#define ARGV_INCREASE	10		/* Amount by which argument array increases */
#define MAX_WORD_SIZE	1024	/* Maximum size for each collected word */

/* The variable IFS is used by the shell to perform the split of each word.
 * It contains a list of single characters which are to be taken as Input
 * Field Separator. To maintain generality, we mimic that behaviour here.
 */
private char *ifs = " ";		/* Input field separator */

/* Array of strings built by shword, each word being stored in one slot of the
 * argument array. This pointer can be passed as-is to the execvp() system call.
 */
private char **argv = 0;		/* Argument pointer */
private int argc;				/* Argument count */
private int where;				/* Current position within argv[] */

/* Function declarations */
private int is_separator();		/* Test whether char is an IFS */
private void free_argv();		/* Free inside of argv[] array */
private int init_argv();		/* Initialize argv[] for new command */
private char *add_argv();		/* Append one word to the argv[] array */
public void shfree();			/* Free structure used by argv[] */
public char **shword();			/* Parse command string and split into words */

extern char *strsave();			/* Save string somewhere in memory */

private int is_separator(c)
char c;			/* Character to be tested among those in the ifs set */
{
	/* Is char 'c' a valid input field separator ? */

	char *p = ifs;			/* To parse the input field separator string */
	char d;					/* Current char in IFS string */

	while ((d = *p) && c != d)	/* Loop over, until end of string or match */
		p++;
	
	return d ? 1 : 0;		/* Boolean stating whether we found it */
}

private void free_argv()
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

private int init_argv()
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
	
	bzero(argv, size);				/* Ensure all slots are null pointers */
	argc = ARGV_NUMBER;				/* Record dynamic size of argv[] */
	where = 0;						/* Next allocation will be done here */

	return 0;
}

private char *add_argv(word)
char *word;
{
	/* Add a "word" at the end of the argv[] array and return a pointer to the
	 * dynmically allocated string which holds this word (in the shell sense),
	 * or a null pointer if it cannot be allocated or inserted in the array.
	 */

	char *saved;					/* Save copy of string */
	char **new_argv;				/* When reallocation is necessary */
	int new_size;

	if (word != (char *) 0) {
		saved = strsave(word);		/* Save string in memory (duplicata) */
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

public void shfree()
{
	/* Free memory used by argument array */

	free_argv();		/* Free inside */
	free(argv);			/* Free container */

	argv = (char **) 0;
	argc = 0;
}

public char **shword(cmd)
char *cmd;		/* The command string */
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
				word[pos++] = c;		/* Must have been escaped */
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

#ifdef TEST
print_argv()
{
	char **array = argv;
	char *str;

	printf("BEGIN\n");

	while (str = *array++)
		printf("\"%s\"\n", str);
	
	printf("END\n");
}

test(cmd)
char *cmd;
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


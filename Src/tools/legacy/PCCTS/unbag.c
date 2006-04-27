/*
 * unbag
 *
 * This program "unbags" files "bagged" by bag.  Can be used for non-UNIX
 * folks that need to unbag stuff.
 */
#include <stdio.h>

static int line=0;

main(argc, argv)
int argc;
char **argv;
{
	FILE *f;

	if ( argc <= 1 )
	{
		fprintf(stderr, "unbag: missing bagfile name\n");
		exit(-1);
	}
	f = fopen(argv[1], "r");
	if ( f == NULL )
	{
		fprintf(stderr, "unbag: cannot open %s\n", argv[1]);
		exit(-1);
	}

	unbag( f );

	fclose( f );
}

unbag(f)
FILE *f;
{
	FILE *output;
	static char text[2048];
	char *nm, *p;

	while ( fgets(text, 2048, f) != NULL )
	{
		line++;
		if ( strncmp(text, "cat << \\EOF_", strlen("cat << \\EOF_"))!= 0 )
		{
			fprintf(stderr, "unbag: line %d: bad file format (missing BEGIN)\n", line);
			fprintf(stderr, "unbag: text was '%s'\n", text);
			exit(-1);
		}
		nm = &text[strlen("cat << \\EOF_")];
		for (p=nm; *p!=' '; p++) {;}	/* find end of filename */
		*p = '\0';
		output = fopen(nm, "w");
		if ( output == NULL )
		{
			fprintf(stderr, "unbag: cannot open ouput file %s\n", nm);
			exit(-1);
		}
		extract(f, output, nm);
		fclose(output);
	}
}

/* Cat a f to f2 (lines <= 2047 characters) stopping after reading 'stop' */
extract(f, f2, stop)
FILE *f, *f2;
char *stop;
{
	static char text[2048];
	char *p;

	while ( fgets(text, 2048, f)!=NULL )
	{
		line++;
		text[strlen(text)-1] = '\0';	/* rm \n */
		if ( strncmp(text, "EOF_", strlen("EOF_")) == 0 )
			if ( strcmp(&text[strlen("EOF_")], stop) == 0 ) return;
		if ( text[0] != '>' )
		{
			fprintf(stderr,"unbag: line %d: bad file format: %s\n", line, stop);
			exit(-1);
		}
		fprintf(f2, "%s\n", &text[1]);
/*
		for (p=&text[1]; *p!='\0'; p++)
		{
			if ( *p=='\\' ) p++;
			putc(*p, f2);
		}
		putc('\n', f2);
*/
	}
}

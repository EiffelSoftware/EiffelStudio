#include <langinfo.h>
#include <locale.h>
#include <malloc.h>
#include <string.h>
#include <stdio.h>
#include <iconv.h>
#include <errno.h>

#define BUFSIZE 30

/***********************************
 *  CHARACTER CONVERTION FUNCTION  *
************************************/

void convert (char * inbuf, size_t insize, wchar_t **out, size_t *outsize) {
        iconv_t cd;
        size_t nconv, avail, alloc;
        char *res, *tres, *wrptr, *inptr;

        *out = NULL;
        *outsize = 0;
        alloc = avail = insize + insize/4;
        if (!(res = malloc(alloc))) {
          perror("malloc");
          return;
        }

        wrptr = res;   // duplicate pointers because they
        inptr = inbuf; // get modified by iconv

        char *charset = nl_langinfo (CODESET);   //get charset used by current locale
        cd = iconv_open ("UTF-8", charset);
        if (cd == (iconv_t)(-1)) {
                perror("iconv_open");
                free(res);
                return;
        }

        do {
                nconv = iconv (cd, &inptr, &insize, &wrptr, &avail); //convertions
                if (nconv == (size_t)(-1)) {
                        if (errno == E2BIG) { // need more room for result
                                tres = realloc(res, alloc += 20);
                                avail += 20;
                                if (!tres) {
                                        perror("realloc");
                                        break;
                                }
                                wrptr = tres + (wrptr - res);
                                res = tres;
                        }
                        else // something wrong with input
                                break;
                }
        } while (insize);

        if (iconv_close(cd))
                perror("iconv_close");
       
        *out = (wchar_t*) res;
        *outsize = wrptr - res; // should be == to (alloc - avail + 1)
        // TODO: should possibly null-terminate the result
}


/********************************
 *   INITIALIZATION FUNCTIONS   *
*********************************/

//String with the name of the current locale name
char lc_locale_name[BUFSIZE];

//Retuns pointer to current locale name
char * locale_name () {
	return lc_locale_name;
}

/*Set the locale to a_locale, if the locale is available,
* otherwise we use the POSIX locale*/
void set_locale (char *a_locale) {
	char * t;
	t = setlocale (LC_ALL, a_locale);
	if (t != NULL) {
		strncpy( lc_locale_name, t, BUFSIZE-1);
	} else { //a_locale is not available
		strcpy(lc_locale_name,"POSIX");
	}
	lc_locale_name[BUFSIZE-1] = '\0';
}

/*****************************
*   LOCALE-INFO FUNTIONS     *
*****************************/

wchar_t * get_locale_info (int a_int) {
	char *dname;
	wchar_t *res;
	size_t s, res_s;

	dname = nl_langinfo(a_int);
	s = strlen(dname);
	convert (dname, s+1, &res, &res_s);
	return res;
};


/********************************
 * TEST AVAILABILITY OF LOCALES *
*********************************/

//is a_locale available?
int is_available (char *a_locale) {
	char *prev_locale; //previous locale string
	char *t;
	prev_locale = lc_locale_name;
	t = setlocale (LC_ALL, a_locale); //try to set the locale
	set_locale (prev_locale);//restore the previous locale
	if (t != NULL) { //a_locale exists
		return 1;
	} else {	/*setlocale returned a NULL
			pointer therefore a_locale
			is not available*/
		return 0;
	}
}

#include <stdio.h>

char *strsave(s)
char *s;
{
    char *result;

    if (!s)
        return (char *)0;
    result = (char *) malloc(strlen(s)+1);
    strcpy(result, s);

    return result;
}

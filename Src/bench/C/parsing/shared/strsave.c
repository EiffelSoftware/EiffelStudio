#include <stdio.h>

char *str_save(char *s)
{
    char *result;

    if (!s)
        return (char *)0;
    result = (char *) malloc(strlen(s)+1);
    strcpy(result, s);

    return result;
}

/*********************************************************/
/* Copyright (C) Interactive Software Engineering, Inc.  */
/* 270 Storke Road, Suite 7 Goleta, California 93117 USA */
/*              (805) 685-1006                           */
/*            All rights reserved                        */
/*      Duplication or distribution prohibited           */
/*********************************************************/

#include <stdio.h>

int col_nb;
int lin_nb;
int pos_in_s;

/* Set lin_nb and col_nb to 1. */
void reset ()
{
	lin_nb = 1;
	col_nb = 1;
	pos_in_s = 0;
}

/*
 * Copy the characters from the b+1-th to the e-th in the beginning
 * of the buffer buf, and fill the other part of buf with the
 * characters of file f.
 */
int fill_buf (f, buf, linarea, colarea, allowed, b, e, end)
FILE *f;
char *buf;
int *linarea, *colarea;
char *allowed;
int b, e, end;
{
	int c;
	int i = 0;
	int n = e - b;

	if (b != 0)
		while (i < n)
		{
				*(buf + i) = *(buf + i + b);
				*(linarea+i) = *(linarea+i+b);
				*(colarea+i) = *(colarea+i+b);
				i++;
		}
	else
		i = e;

	while (i < end)
	{
		c = getc(f);
		if ((c == '\n') || (c == '\r'))
		{
			*(buf + i) = c;
			*(linarea+i) = lin_nb++;
			*(colarea+i) = col_nb;
			col_nb = 1;
			i++;
		}
		else if (c == EOF)
		{
			*(buf + i) = c;
			*(linarea+i) = -1;
			*(colarea+i) = -1;
			break;
		}
		else
		{
			if (!(allowed[col_nb-1]==0))
			{
				*(buf + i) = c;
				*(linarea+i) = lin_nb;
				*(colarea+i) = col_nb;
				i++;
			}
			col_nb++;
		}
	}
	return (i - n);
}

int fill_f_s (s, buf, linarea, colarea, allowed, b, e, end)
char s [];
char *buf;
int *linarea, *colarea;
char *allowed;
int b,e,end;
{
	int c;
	int i = 0;
	int n = e - b;

	if (b != 0)
		while (i < n)
		{
				*(buf + i) = *(buf + i + b);
				*(linarea+i) = *(linarea+i+b);
				*(colarea+i) = *(colarea+i+b);
				i++;
		}
	else
		i = e;

	while (i < end)
	{
		c = s [pos_in_s++];
		if ((c == '\n')||(c == '\r'))
		{
			*(buf + i) = c;
			*(linarea+i) = lin_nb++;
			*(colarea+i) = col_nb;
			col_nb = 1;
			i++;
		}
		else if (c == '\0')
		{
			*(buf + i) = EOF;
			*(linarea+i) = -1;
			*(colarea+i) = -1;
			break;
		}
		else
		{
			if (!(allowed[col_nb-1] == 0))
			{
				*(buf + i) = c;
				*(linarea+i) = lin_nb;
				*(colarea+i) = col_nb;
				i++;
			}
			col_nb++;
		}
	}
	return (i - n);
}

%{
/*

 ######     #    ######          #               #
 #          #    #               #               #
 #####      #    #####           #               #
 #          #    #               #        ###    #
 #          #    #               #        ###    #
 ######     #    #      #######  ######   ###    ######

	Lace lexical parsing, looking for classes inside file.
*/

#include "config.h"
#include "portable.h"
%}

%p 3400
%start CLASS INIT

A		([a-z]|[A-Z])
X		([A-Z]|[a-z]|[0-9]|_)
W		[ \t\n]
c		[cC]
l		[lL]
a		[aA]
s		[sS]

%%
<INIT,CLASS>--.*					{/* Delete comments first */}
<INIT,CLASS>{W}+					{/* Ignore white space */}
<INIT,CLASS>\"([^"\n]|\\\"|\\\n)*\" ;

<INIT>{c}{l}{a}{s}{s}				BEGIN CLASS ;
<CLASS>{A}{X}*						{	BEGIN INIT; return 1;}
.|\n								;
%%

public int yywrap()
{
	return 1;
}

public int init_lace()
{
	/* This function must be called prior any invocation of the lexical
	 * analyzer. Its purpose is to put the automaton in the known INIT
	 * state. I could have used the undocumented INITIAL state, but this
	 * is not supported everywhere (which is why it's undocumented)--RAM.
	 */

	BEGIN INIT;
}


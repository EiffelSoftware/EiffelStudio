#ifndef tokens_h
#define tokens_h
/* tokens.h -- List of labelled tokens and stuff
 *
 * Generated from: dlg_p.g
 *
 * Terence Parr, Will Cohen, and Hank Dietz: 1989-1994
 * Purdue University Electrical Engineering
 * ANTLR Version 1.32
 */
#define zzEOF_TOKEN 1
#define L_EOF 4
#define PER_PER 5
#define NAME_PER_PER 6
#define ACTION 7
#define GREAT_GREAT 8
#define L_BRACE 9
#define R_BRACE 10
#define L_PAR 11
#define R_PAR 12
#define L_BRACK 13
#define R_BRACK 14
#define ZERO_MORE 15
#define ONE_MORE 16
#define OR 17
#define RANGE 18
#define NOT 19
#define OCTAL_VALUE 20
#define HEX_VALUE 21
#define DEC_VALUE 22
#define TAB 23
#define NL 24
#define CR 25
#define BS 26
#define LIT 27
#define REGCHAR 28

#ifdef __STDC__
void grammar(void);
#else
extern void grammar();
#endif

#ifdef __STDC__
void start_states(void);
#else
extern void start_states();
#endif

#ifdef __STDC__
void do_conversion(void);
#else
extern void do_conversion();
#endif

#ifdef __STDC__
void rule_list(void);
#else
extern void rule_list();
#endif

#ifdef __STDC__
void rule(void);
#else
extern void rule();
#endif

#ifdef __STDC__
void reg_expr(void);
#else
extern void reg_expr();
#endif

#ifdef __STDC__
void and_expr(void);
#else
extern void and_expr();
#endif

#ifdef __STDC__
void repeat_expr(void);
#else
extern void repeat_expr();
#endif

#ifdef __STDC__
void expr(void);
#else
extern void expr();
#endif

#ifdef __STDC__
void atom_list(void);
#else
extern void atom_list();
#endif

#ifdef __STDC__
void near_atom(void);
#else
extern void near_atom();
#endif

#ifdef __STDC__
void atom(void);
#else
extern void atom();
#endif

#ifdef __STDC__
void anychar(void);
#else
extern void anychar();
#endif

#endif
extern SetWordType zzerr1[];
extern SetWordType zzerr2[];
extern SetWordType zzerr3[];
extern SetWordType setwd1[];
extern SetWordType zzerr4[];
extern SetWordType zzerr5[];
extern SetWordType setwd2[];
extern SetWordType zzerr6[];
extern SetWordType setwd3[];

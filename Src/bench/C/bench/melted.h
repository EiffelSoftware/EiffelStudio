/*------------------------------------------------------------------*/

#define BC_START                (unsigned char) 0                   
#define BC_PRECOND              (unsigned char) 1   
#define BC_POSTCOND             (unsigned char) 2   
#define BC_DEFERRED             (unsigned char) 3
#define BC_REVERSE              (unsigned char) 4
#define BC_CHECK                (unsigned char) 5
#define BC_ASSERT               (unsigned char) 6
#define BC_NULL                 (unsigned char) 7
#define BC_PRE                  (unsigned char) 8
#define BC_PST                  (unsigned char) 9
#define BC_CHK                  (unsigned char) 10
#define BC_LINV                 (unsigned char) 11
#define BC_LVAR                 (unsigned char) 12
#define BC_INV                  (unsigned char) 13
#define BC_END_ASSERT           (unsigned char) 14
#define BC_TAG                  (unsigned char) 15
#define BC_NOTAG                (unsigned char) 16
#define BC_JMP_F                (unsigned char) 17
#define BC_JMP                  (unsigned char) 18
#define BC_LOOP                 (unsigned char) 19
#define BC_END_VARIANT          (unsigned char) 20
#define BC_INIT_VARIANT         (unsigned char) 21
#define BC_DEBUG                (unsigned char) 22
#define BC_RASSIGN              (unsigned char) 23
#define BC_LASSIGN              (unsigned char) 24
#define BC_ASSIGN               (unsigned char) 25
#define BC_CREATE               (unsigned char) 26
#define BC_CTYPE                (unsigned char) 27
#define BC_CARG                 (unsigned char) 28
#define BC_CLIKE                (unsigned char) 29
#define BC_CCUR                 (unsigned char) 30
#define BC_INSPECT              (unsigned char) 31
#define BC_RANGE                (unsigned char) 32
#define BC_INSPECT_EXCEP        (unsigned char) 33
#define BC_LREVERSE             (unsigned char) 34
#define BC_RREVERSE             (unsigned char) 35
#define BC_FEATURE              (unsigned char) 36
#define BC_METAMORPHOSE         (unsigned char) 37
#define BC_CURRENT              (unsigned char) 38
#define BC_ROTATE               (unsigned char) 39
#define BC_FEATURE_INV          (unsigned char) 40
#define BC_ATTRIBUTE            (unsigned char) 41
#define BC_ATTRIBUTE_INV        (unsigned char) 42
#define BC_EXTERN               (unsigned char) 43
#define BC_EXTERN_INV           (unsigned char) 44
#define BC_CHAR                 (unsigned char) 45
#define BC_BOOL                 (unsigned char) 46
#define BC_INT                  (unsigned char) 47
#define BC_DOUBLE               (unsigned char) 48
#define BC_RESULT               (unsigned char) 49
#define BC_LOCAL                (unsigned char) 50
#define BC_ARG                  (unsigned char) 51
#define BC_UPLUS                (unsigned char) 52
#define BC_UMINUS               (unsigned char) 53
#define BC_NOT                  (unsigned char) 54
#define BC_LT                   (unsigned char) 55
#define BC_GT                   (unsigned char) 56
#define BC_MINUS                (unsigned char) 57
#define BC_XOR                  (unsigned char) 58
#define BC_GE                   (unsigned char) 59
#define BC_EQ                   (unsigned char) 60
#define BC_NE                   (unsigned char) 61
#define BC_STAR                 (unsigned char) 62
#define BC_POWER                (unsigned char) 63
#define BC_LE                   (unsigned char) 64
#define BC_DIV                  (unsigned char) 65
#define BC_BREAK                (unsigned char) 66
#define BC_AND                  (unsigned char) 67
#define BC_SLASH                (unsigned char) 68
#define BC_MOD                  (unsigned char) 69
#define BC_PLUS                 (unsigned char) 70
#define BC_OR                   (unsigned char) 71
#define BC_ADDR                 (unsigned char) 72
#define BC_STRING               (unsigned char) 73
#define BC_AND_THEN             (unsigned char) 74
#define BC_OR_ELSE              (unsigned char) 75
#define BC_PROTECT              (unsigned char) 76
#define BC_RELEASE              (unsigned char) 77
#define BC_JMP_T                (unsigned char) 78
#define BC_DEBUGABLE            (unsigned char) 79
#define BC_RESCUE               (unsigned char) 80
#define BC_END_RESCUE           (unsigned char) 81
#define BC_RETRY                (unsigned char) 82
#define BC_EXP_ASSIGN           (unsigned char) 83
#define BC_CLONE                (unsigned char) 84
#define BC_EXP_EXCEP            (unsigned char) 85
#define BC_VOID                 (unsigned char) 86
#define BC_NONE_ASSIGN          (unsigned char) 87
#define BC_LEXP_ASSIGN          (unsigned char) 88
#define BC_REXP_ASSIGN          (unsigned char) 89
#define BC_CLONE_ARG            (unsigned char) 90
#define BC_NO_CLONE_ARG         (unsigned char) 91
#define BC_FALSE_COMPAR         (unsigned char) 92
#define BC_TRUE_COMPAR          (unsigned char) 93
#define BC_STANDARD_EQUAL       (unsigned char) 94
#define BC_BIT_STD_EQUAL        (unsigned char) 95
#define BC_NEXT                 (unsigned char) 96
#define BC_BIT                  (unsigned char) 97
#define BC_ARRAY                (unsigned char) 98
#define BC_RETRIEVE_OLD         (unsigned char) 99
#define BC_FLOAT                (unsigned char) 100 
#define BC_OLD                  (unsigned char) 101
#define BC_ADD_STRIP            (unsigned char) 102
#define BC_END_STRIP            (unsigned char) 103
#define BC_LBIT_ASSIGN          (unsigned char) 104
#define BC_RAISE_PREC           (unsigned char) 105
#define BC_GOTO_BODY            (unsigned char) 106
#define BC_NOT_REC              (unsigned char) 107
#define BC_END_PRE              (unsigned char) 108
#define BC_END_FST_PRE          (unsigned char) 109
#define BC_CAST_LONG            (unsigned char) 110
#define BC_CAST_FLOAT           (unsigned char) 111
#define BC_CAST_DOUBLE          (unsigned char) 112
#define BC_INV_NULL             (unsigned char) 113
#define BC_CREAT_INV            (unsigned char) 114
#define BC_END_EVAL_OLD         (unsigned char) 115
#define BC_START_EVAL_OLD       (unsigned char) 116
#define BC_OBJECT_ADDR          (unsigned char) 117
#define BC_PFEATURE             (unsigned char) 118
#define BC_PFEATURE_INV         (unsigned char) 119
#define BC_PEXTERN              (unsigned char) 120
#define BC_PEXTERN_INV          (unsigned char) 121
#define BC_PARRAY               (unsigned char) 122
#define BC_PATTRIBUTE           (unsigned char) 123
#define BC_PATTRIBUTE_INV       (unsigned char) 124
#define BC_PEXP_ASSIGN          (unsigned char) 125
#define BC_PASSIGN              (unsigned char) 126
#define BC_PREVERSE             (unsigned char) 127
#define BC_PCLIKE               (unsigned char) 128
#define BC_OBJECT_EXPR_ADDR     (unsigned char) 129
#define BC_RESERVE              (unsigned char) 130
#define BC_POP                  (unsigned char) 131
#define BC_REF_TO_PTR           (unsigned char) 132
#define BC_RCREATE              (unsigned char) 133
#define BC_GEN_PARAM_CREATE     (unsigned char) 134
#define BC_CREATE_EXP           (unsigned char) 135
#define UNUSED_136              (unsigned char) 136
#define UNUSED_137              (unsigned char) 137
#define UNUSED_138              (unsigned char) 138
#define UNUSED_139              (unsigned char) 139
#define UNUSED_140              (unsigned char) 140
#define UNUSED_141              (unsigned char) 141
#define UNUSED_142              (unsigned char) 142
#define UNUSED_143              (unsigned char) 143
#define UNUSED_144              (unsigned char) 144
#define UNUSED_145              (unsigned char) 145
#define UNUSED_146              (unsigned char) 146
#define UNUSED_147              (unsigned char) 147
#define UNUSED_148              (unsigned char) 148
#define UNUSED_149              (unsigned char) 149
#define BC_SEP_SET              (unsigned char) 150
#define BC_SEP_UNSET            (unsigned char) 151
#define BC_SEP_RESERVE          (unsigned char) 152
#define BC_SEP_FREE             (unsigned char) 153
#define BC_SEP_TO_SEP           (unsigned char) 154
#define BC_SEP_RAISE_PREC       (unsigned char) 155
#define BC_SEP_CREATE           (unsigned char) 156
#define BC_SEP_CREATE_END       (unsigned char) 157
#define BC_SEP_ATTRIBUTE_INV    (unsigned char) 158
#define BC_SEP_EXTERN_INV       (unsigned char) 159
#define BC_SEP_FEATURE_INV      (unsigned char) 160
#define BC_SEP_PATTRIBUTE_INV   (unsigned char) 161
#define BC_SEP_PEXTERN_INV      (unsigned char) 162
#define BC_SEP_PFEATURE_INV     (unsigned char) 163
#define BC_SEP_EXTERN           (unsigned char) 164
#define BC_SEP_FEATURE          (unsigned char) 165
#define BC_SEP_PEXTERN          (unsigned char) 166
#define BC_SEP_PFEATURE         (unsigned char) 167

#define BC_JAVA_RTYPE           (unsigned char) 200
#define BC_JAVA_EXTERNAL        (unsigned char) 201

#define MAX_CODE                201     /* Maximum legal byte code */

/*------------------------------------------------------------------*/

#define BCDB_TAG    't'

/*------------------------------------------------------------------*/

#define SK_EXP      0x80000000          /* Type is an expanded */
#define SK_MASK     0x7fffffff          /* Mask to get real type */
#define SK_BOOL     0x04000000          /* Simple boolean type */
#define SK_CHAR     0x08000000          /* Simple character type */
#define SK_INT      0x10000000          /* Simple integer type */
#define SK_FLOAT    0x18000000          /* Simple float type */
#define SK_DOUBLE   0x20000000          /* Simple double type */
#define SK_BIT      0x28000000          /* Signals bits type */
#define SK_POINTER  0x40000000          /* Signals pointer type */
#define SK_BMASK    0x07ffffff          /* Bits number (coded on 27 bits) */
#define SK_SIMPLE   0x78000000          /* Mask to test for simple type */
#define SK_REF      0xf8000000          /* Mask to test for reference type */
#define SK_VOID     0x00000000          /* Mask for void type */
#define SK_DTYPE    0x0000ffff          /* Value of reference type */
#define SK_HEAD     0xff000000          /* Mask for header value */
#define SK_INVALID  0xffffffff          /* Invalid value, may be used as flag */

/*------------------------------------------------------------------*/

#define BYTSIZ  8       /* Size of a byte, in bits */
#define BIT_PACKSIZE    sizeof(uint32)  
						/* Size of a bit unit in bytes */
#define BIT_UNIT        (sizeof(uint32) * BYTSIZ)       
						/* Size of a bit unit in bits */
#define BIT_NBPACK(s)   (((s) / BIT_UNIT) + (((s) % BIT_UNIT) ? 1 : 0))
#define BITACS(n)       ((1 + BIT_NBPACK((n)))*BIT_PACKSIZE)

/*------------------------------------------------------------------*/


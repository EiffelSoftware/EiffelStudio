#ifndef __EXML_PARSER__
#define __EXML_PARSER__

#include "xmlparse.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef (* EIF_ON_START_TAG_PROC)
	(EIF_OBJ,     /* XML_PARSER Eiffel object */
	 EIF_POINTER, /* const XML_Char *name */
	 EIF_POINTER  /* const XML_Char **atts */
	 );

typedef (* EIF_ON_END_TAG_PROC)
	(EIF_OBJ,     /* XML_PARSER Eiffel object */
	 EIF_POINTER /* const XML_Char *name */
	 );

typedef (* EIF_ON_START_NAMESPACE_DECL_PROC)
	(EIF_OBJ,     /* XML_PARSER Eiffel object */
	 EIF_POINTER, /* const XML_Char *prefix */
	 EIF_POINTER  /* const XML_Char *uri */
	 );

typedef (* EIF_ON_END_NAMESPACE_DECL_PROC)
	(EIF_OBJ,     /* XML_PARSER Eiffel object */
	 EIF_POINTER /* const XML_Char *prefix */
	 );

typedef (* EIF_ON_CONTENT_PROC)
	(EIF_OBJ,     /* XML_PARSER Eiffel object */
	 EIF_POINTER, /* const XML_Char *s */
	 EIF_INTEGER  /* int len */
	 );


typedef (* EIF_ON_PROCESSING_INSTRUCTION_PROC)
	(EIF_OBJ,     /* XML_PARSER Eiffel object */
	 EIF_POINTER, /* const XML_Char *target */
	 EIF_POINTER  /* const XML_Char *data */
	 );

typedef (* EIF_ON_DEFAULT_PROC)
	(EIF_OBJ,     /* XML_PARSER Eiffel object */
	 EIF_POINTER, /* const XML_Char *s */
	 EIF_INTEGER  /* int len */
	 );

typedef (* EIF_ON_UNPARSED_ENTITY_DECLARATION_PROC)
	(EIF_OBJ,     /* XML_PARSER Eiffel object */
	 EIF_POINTER, /* const XML_Char *entityName */
	 EIF_POINTER, /* const XML_Char *base */
	 EIF_POINTER, /* const XML_Char *systemId */
	 EIF_POINTER, /* const XML_Char *publicId */
	 EIF_POINTER  /* const XML_Char *notationName */
	 );

typedef (* EIF_ON_NOTATION_DECLARATION_PROC)
	(EIF_OBJ,     /* XML_PARSER Eiffel object */
	 EIF_POINTER, /* const XML_Char *notationName */
	 EIF_POINTER, /* const XML_Char *base */
	 EIF_POINTER, /* const XML_Char *systemId */
	 EIF_POINTER  /* const XML_Char *publicId */
	 );



typedef EIF_INTEGER (* EIF_ON_EXTERNAL_ENTITY_REFERENCE_PROC)
	(EIF_POINTER,     /* XML_Parser parser */
	 EIF_POINTER, /* const XML_Char *openEntityName */
	 EIF_POINTER, /* const XML_Char *base */
	 EIF_POINTER, /* const XML_Char *systemId */
	 EIF_POINTER  /* const XML_Char *publicId */
	 );

typedef EIF_INTEGER (* EIF_ON_UNKNOWN_ENCODING_PROC)
	(EIF_OBJ,     /* XML_PARSER Eiffel object */
	 EIF_POINTER, /* const XML_Char *name */
	 EIF_POINTER  /* XML_Encoding *info */
	 );

typedef (* EIF_ON_COMMENT_PROC)
	(EIF_OBJ,     /* XML_PARSER Eiffel object */
	 EIF_POINTER /* const XML_Char *data (0 term) */
	 );


#define ptr_contents(_ptr_) (EIF_POINTER)*((void**)_ptr_)
#define ptr_move(_ptr_,_pos_) (EIF_POINTER)(((EIF_POINTER *)_ptr_) + _pos_)


#define EXML_ParserCreate(_a_) (EIF_POINTER) XML_ParserCreate ((const char*)_a_)
#define EXML_ParserCreateNS(_a_,_b_) (EIF_POINTER) XML_ParserCreateNS ((const char*)_a_,(char) _b_)
#define EXML_ExternalEntityParserCreate(_a_,_b_,_c_) (EIF_POINTER) XML_ExternalEntityParserCreate ((XML_Parser)_a_,(const char*)_b_,(const char*)_c_)
#define EXML_DefaultCurrent(_a_) XML_DefaultCurrent ((XML_Parser)_a_)
#define EXML_SetUserData(_a_,_b_) XML_SetUserData ((XML_Parser)_a_,(void*)_b_)
#define EXML_GetUserData(_a_) (EIF_POINTER)XML_GetUserData ((XML_Parser)_a_)
#define EXML_UseParserAsHandlerArg(_a_) XML_UseParserAsHandlerArg ((XML_Parser)_a_)
#define EXML_SetBase(_a_,_b_) XML_SetBase ((XML_Parser)_a_,(const XML_Char*) _b_)
#define EXML_GetBase(_a_) (EIF_POINTER) XML_GetBase ((XML_Parser)_a_)
#define EXML_Parse(_a_,_b_,_c_,_d_) (EIF_INTEGER) XML_Parse ((XML_Parser)_a_,(const char*)_b_,(int)_c_, (int)_d_)
#define EXML_GetErrorCode(_a_) (EIF_INTEGER) XML_GetErrorCode ((XML_Parser)_a_)
#define EXML_GetCurrentLineNumber(_a_) (EIF_INTEGER) XML_GetCurrentLineNumber ((XML_Parser)_a_)
#define EXML_GetCurrentColumnNumber(_a_) (EIF_INTEGER) XML_GetCurrentColumnNumber ((XML_Parser)_a_)
#define EXML_GetCurrentByteIndex(_a_) (EIF_INTEGER) XML_GetCurrentByteIndex ((XML_Parser)_a_)
#define EXML_ParserFree(_a_) XML_ParserFree ((XML_Parser)_a_)
#define EXML_ErrorString(_a_) (EIF_POINTER) XML_ErrorString ((enum XML_Error) _a_)

#ifdef __cplusplus
}
#endif

#endif



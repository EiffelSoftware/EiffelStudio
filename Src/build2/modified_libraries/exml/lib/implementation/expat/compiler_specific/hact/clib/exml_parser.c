// this file is needed as glue code for expat annd eXML. Mainly it consists of C-callback-functions
// that will delegate the signal further to the Eiffel side. the rest of the code is used to initialize
// the expat-eXML glue-code

// currently this module is not thread safe, as it uses global variables. this could be rewritten using
// a special C Struct as XML-Handle that covers the Eiffel Object and its callback routines instead of just
// the plain Eiffel object as it is now. After that change I don't see anything that speaks against using
// eXML in a multithreaded application.

#include <eiffel.h>
#include "xmlparse.h"
#include "exml_parser.h"

// local variables that store the addresses of the Eiffel callback routines
EIF_ON_START_TAG_PROC exml_on_start_tag_proc;
EIF_ON_END_TAG_PROC exml_on_end_tag_proc;
EIF_ON_CONTENT_PROC exml_on_content_proc;

EIF_ON_PROCESSING_INSTRUCTION_PROC exml_on_processing_instruction_proc;
EIF_ON_DEFAULT_PROC exml_on_default_proc;
EIF_ON_UNPARSED_ENTITY_DECLARATION_PROC exml_on_unparsed_entity_declaration_proc;
EIF_ON_NOTATION_DECLARATION_PROC exml_on_notation_declaration_proc;
EIF_ON_EXTERNAL_ENTITY_REFERENCE_PROC exml_on_external_entity_reference_proc;
EIF_ON_UNKOWN_ENCODING_PROC exml_on_unkown_encoding_proc;

// C intermediate callbacks
// the exml_on_* functions will be registered in expat
// when expat then calls such a function, this function will
// dispatch the signal further to the Eiffel side using
// the registered eiffel_object
void exml_on_start_tag (void *eiffel_object, const char *name, const char **atts)
{
	((exml_on_start_tag_proc) (
		(EIF_OBJ) eif_access (eiffel_object),
		(EIF_POINTER) name,
		(EIF_POINTER) atts));
}

void exml_on_end_tag (void *eiffel_object, const char *name)
{
	((exml_on_end_tag_proc) (
		(EIF_OBJ) eif_access (eiffel_object),
		(EIF_POINTER) name));
}

void exml_on_content (void *eiffel_object, const XML_Char *s, int len)
{
	((exml_on_content_proc) (
		(EIF_OBJ) eif_access (eiffel_object),
		(EIF_POINTER) s,
		(EIF_INTEGER) len));
}

void exml_on_processing_instruction (void *eiffel_object, const XML_Char *target, const XML_Char *data)
{
	((exml_on_processing_instruction_proc) (
		(EIF_OBJ) eif_access (eiffel_object),
		(EIF_POINTER) target,
		(EIF_POINTER) data));
}

void exml_on_default (void *eiffel_object, const XML_Char *data, int len)
{
	((exml_on_default_proc) (
		(EIF_OBJ) eif_access (eiffel_object),
		(EIF_POINTER) data,
		(EIF_INTEGER) len));
}


void exml_on_unparsed_entity_declaration (void *eiffel_object, const XML_Char *entityName, const XML_Char *base, const XML_Char *systemId, const XML_Char *publicId, const XML_Char *notationName)
{
	((exml_on_unparsed_entity_declaration_proc) (
		(EIF_OBJ) eif_access (eiffel_object),
		(EIF_POINTER) entityName,
		(EIF_POINTER) base,
		(EIF_POINTER) systemId,
		(EIF_POINTER) publicId,
		(EIF_POINTER) notationName));
}

void exml_on_notation_declaration (void *eiffel_object, const XML_Char *notationName, const XML_Char *base, const XML_Char *systemId, const XML_Char *publicId)
{
	((exml_on_notation_declaration_proc) (
		(EIF_OBJ) eif_access (eiffel_object),
		(EIF_POINTER) notationName,
		(EIF_POINTER) base,
		(EIF_POINTER) systemId,
		(EIF_POINTER) publicId));
}

int exml_on_external_entity_reference (XML_Parser parser, const XML_Char *openEntityName, const XML_Char *base, const XML_Char *systemId, const XML_Char *publicId)
{
	return ((exml_on_external_entity_reference_proc) (
		(EIF_OBJ) eif_access (XML_GetUserData(parser)),
		(EIF_POINTER) openEntityName,
		(EIF_POINTER) base,
		(EIF_POINTER) systemId,
		(EIF_POINTER) publicId));
}

int exml_on_unkown_encoding (void *eiffel_object, const XML_Char *name, XML_Encoding *info)
{
	return ((exml_on_unkown_encoding_proc) (
		(EIF_OBJ) eif_access (eiffel_object),
		(EIF_POINTER) name,
		(EIF_POINTER) info));
}




// exml_register_* functions will register the C intermediate callback functions (exml_on_*)
// It is no good idea to register all functions by default, because this changes the behavior
// of the parser in a probabl unwanted way.

void exml_register_start_end_tag_hook (XML_Parser parser)
{
	XML_SetElementHandler(parser, exml_on_start_tag, exml_on_end_tag);
}
void exml_register_content_hook (XML_Parser parser)
{
	XML_SetCharacterDataHandler(parser, exml_on_content);
}
void exml_register_processing_instruction_hook (XML_Parser parser)
{
	XML_SetProcessingInstructionHandler(parser, exml_on_processing_instruction);
}
void exml_register_default_hook (XML_Parser parser)
{
	XML_SetDefaultHandler(parser, exml_on_default);
}
void exml_register_unparsed_entity_declaration_hook (XML_Parser parser)
{
	XML_SetUnparsedEntityDeclHandler(parser, exml_on_unparsed_entity_declaration);
}
void exml_register_notation_declaration_hook (XML_Parser parser)
{
	XML_SetNotationDeclHandler(parser, exml_on_notation_declaration);
}
void exml_register_external_entity_reference_hook (XML_Parser parser)
{
	XML_SetExternalEntityRefHandler(parser, exml_on_external_entity_reference);
}
void exml_register_unkown_encoding (XML_Parser parser)
{
	XML_SetUnknownEncodingHandler(parser, exml_on_unkown_encoding, NULL);
		// second parater currently unused
}


// the exml_set_on_* functions will register the features that will be called by
// the intermediate C callback functions (exml_on_*). The current implementation
// requires the same (frozen) features for all derivates of the EXML_PARSER.
// The object on which the feature should be called is determined by the user_data
// (eiffel_object) pointer.

void exml_set_on_start_tag_procedure_address( EIF_POINTER _addr_)
{
	exml_on_start_tag_proc = (EIF_ON_START_TAG_PROC) _addr_ 	;
}

void exml_set_on_end_tag_procedure_address( EIF_POINTER _addr_)
{
	exml_on_end_tag_proc = (EIF_ON_END_TAG_PROC) _addr_ 	;
}

void exml_set_on_content_procedure_address( EIF_POINTER _addr_)
{
	exml_on_content_proc = (EIF_ON_CONTENT_PROC) _addr_ 	;
}

void exml_set_on_processing_instruction_procedure_address( EIF_POINTER _addr_)
{
	exml_on_processing_instruction_proc = (EIF_ON_PROCESSING_INSTRUCTION_PROC) _addr_ 	;
}

void exml_set_on_default_procedure_address( EIF_POINTER _addr_)
{
	exml_on_default_proc = (EIF_ON_CONTENT_PROC) _addr_ 	;
}

void exml_set_on_unparsed_entity_declaration_procedure_address( EIF_POINTER _addr_)
{
	exml_on_unparsed_entity_declaration_proc = (EIF_ON_UNPARSED_ENTITY_DECLARATION_PROC) _addr_ 	;
}

void exml_set_on_notation_declaration_procedure_address( EIF_POINTER _addr_)
{
	exml_on_notation_declaration_proc = (EIF_ON_NOTATION_DECLARATION_PROC) _addr_ 	;
}

void exml_set_on_external_entity_reference_procedure_address( EIF_POINTER _addr_)
{
	exml_on_external_entity_reference_proc = (EIF_ON_EXTERNAL_ENTITY_REFERENCE_PROC) _addr_ 	;
}

void exml_set_on_unkown_encoding_procedure_address( EIF_POINTER _addr_)
{
	exml_on_unkown_encoding_proc = (EIF_ON_UNKOWN_ENCODING_PROC) _addr_ 	;
}



// function wrappers for ISE CECIL utilities (because of the object moving gc)

EIF_OBJ exml_adopt_object (EIF_OBJ _addr_)
{
	return (EIF_OBJ) eif_adopt (_addr_);
}

void exml_release_object (EIF_OBJ _addr_)
{
	eif_wean (_addr_);
}


// this file is needed as glue code for expat annd eXML. Mainly it consists of C-callback-functions
// that will delegate the signal further to the Eiffel side. the rest of the code is used to initialize
// the expat-eXML glue-code

// this module should be perfectly thread safe. (although SE does not support MT yet)

#include <xmlparse.h>
#include <eiffel.h>
/* TODO: Replace all // comments with SLASH STAR */

/* This is just a wrapper aroung memcpy to supress a warning during C compilation */
void* exml_memcpy (void* dest, void* src, int c)
{
  return memcpy (dest, (const void*)src, c);
}

// C intermediate callbacks
// the exml_on_* functions will be registered in expat
// when expat then calls such a function, this function will
// dispatch the signal further to the Eiffel side using
// the registered eiffel_object

void exml_on_start_tag (void *eiffel_object, const char *name, const char **atts)
{
  ((eif_exml_on_start_tag_proc) (eiffel_object, (void*) name, (void*) atts));
}

void exml_on_end_tag (void *eiffel_object, const char *name)
{
  ((eif_exml_on_end_tag_proc) (eiffel_object, (void*) name));
}
void exml_on_start_namespace_decl (void *eiffel_object, const char *prefix, const char *uri)
{
  ((eif_exml_on_start_namespace_decl_proc) (eiffel_object, (void*) prefix, (void*) uri));
}

void exml_on_end_namespace_decl (void *eiffel_object, const char *prefix)
{
  ((eif_exml_on_end_namespace_decl_proc) (eiffel_object, (void*) prefix));
}

void exml_on_content (void *eiffel_object, const XML_Char *s, int len)
{
  ((eif_exml_on_content_tag_proc) (eiffel_object, (void*) s, (int) len));

}

void exml_on_processing_instruction (void *eiffel_object, const XML_Char *target, const XML_Char *data)
{
  ((eif_exml_on_processing_instruction) (eiffel_object, (void*) target, (void*) data));
}

void exml_on_default (void *eiffel_object, const XML_Char *data, int len)
{
  ((eif_exml_on_default) (eiffel_object, (void*) data, (int) len));
}


void exml_on_unparsed_entity_declaration (void *eiffel_object, const XML_Char *entityName, const XML_Char *base, const XML_Char *systemId, const XML_Char *publicId, const XML_Char *notationName)
{
  ((eif_exml_on_unparsed_entity_declaration) (eiffel_object, (void*) entityName, (void*) base, (void*) systemId,
					      (void*) publicId, (void*) notationName));

}

void exml_on_notation_declaration (void *eiffel_object, const XML_Char *notationName, const XML_Char *base, const XML_Char *systemId, const XML_Char *publicId)
{
  ((eif_exml_on_notation_declaration) (eiffel_object, (void*) notationName, (void*) base, (void*) systemId,
				       (void*) publicId));

}

int exml_on_external_entity_reference (XML_Parser parser, const XML_Char *openEntityName, const XML_Char *base, const XML_Char *systemId, const XML_Char *publicId)
{
  return ((eif_exml_on_external_entity_reference) (XML_GetUserData(parser), (void*) openEntityName, (void*) base,
						   (void*) systemId, (void*) publicId));

}

int exml_on_unknown_encoding (void *eiffel_object, const XML_Char *name, XML_Encoding *info)
{
  return ((eif_exml_on_unknown_encoding) (eiffel_object, (void*) name, (void*) info));
}

void exml_on_comment (void *eiffel_object, const XML_Char *data)
{
  ((eif_exml_on_comment_proc) (eiffel_object, (void*) data));
}




// exml_register_* functions will register the C intermediate callback functions (exml_on_*)
// It is no good idea to register all functions by default, because this changes the behavior
// of the parser in a probabl unwanted way.

void exml_register_start_end_tag_hook (XML_Parser parser)
{
  XML_SetElementHandler(parser, exml_on_start_tag, exml_on_end_tag);
}
void exml_register_start_end_namespace_decl_hook (XML_Parser parser)
{
  XML_SetNamespaceDeclHandler(parser, exml_on_start_namespace_decl, exml_on_end_namespace_decl);
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
void exml_register_unknown_encoding (XML_Parser parser)
{
  XML_SetUnknownEncodingHandler(parser, exml_on_unknown_encoding, NULL);
  // second parameter currently unused
}

void exml_register_comment_hook (XML_Parser parser)
{
  XML_SetCommentHandler (parser, exml_on_comment);
}

// stub used to prevent the C-compiler from issuing warnings about wrong types
void* memcpy_wrap (void* dest, void* src, int c)
{
  return memcpy (dest, src, c);
}


void* ptr_contents (void* ptr)
{
  return *((void**)ptr);
}

void* ptr_move (void* ptr, int pos)
{
  return (((int*)ptr) + pos);
}



















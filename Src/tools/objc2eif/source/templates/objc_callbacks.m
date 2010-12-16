/*
 *  objc_callbacks.m
 *  
 *
 *  Created by Matteo Cortonesi on 9/27/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

#import "objc_callbacks.h"

void * pointer_callbacks_hijacker (id self, SEL _cmd, ...) {
	va_list variableArguments;
	va_start(variableArguments, _cmd);

	NSMethodSignature *methodSignature = [self methodSignatureForSelector:_cmd];
	int argumentsCount = [methodSignature numberOfArguments];

	void **arguments = NULL;
	if (argumentsCount > 2) {
		arguments = malloc(sizeof(void *) * (argumentsCount - 2)); // Freeing is done in eiffel code.
	}
	int i;
	for (i = 2; i < argumentsCount; i++) {
		const char *argumentType = [methodSignature getArgumentTypeAtIndex:i];
		BOOL argumentRead = YES;
		switch (argumentType[0]) {
			case 'c':
			case 'i':
			case 's':
			case 'C':
			case 'I':
			case 'S': {
				int *value_pointer = malloc(sizeof(value_pointer)); // Freeing is done in eiffel code.
				*value_pointer = va_arg(variableArguments, int);
				arguments[i - 2] = value_pointer;
				break;
			}
			case 'q':
			case 'Q': {
				long long *value_pointer = malloc(sizeof(value_pointer)); // Freeing is done in eiffel code.
				*value_pointer = va_arg(variableArguments, long long);
				arguments[i - 2] = value_pointer;
				break;
			}
			case 'f':
			case 'd': {
				double *value_pointer = malloc(sizeof(value_pointer)); // Freeing is done in eiffel code.
				*value_pointer = va_arg(variableArguments, double);
				arguments[i - 2] = value_pointer;
				break;
			}
			case '@':
			case '#':
			case ':': {
				void *object = va_arg(variableArguments, void *);
				arguments[i - 2] = object;
				break;
			}
			default: {
				argumentRead = NO;
				break;
			}
		}
		
$STRUCTS_TESTS
		
		if (!argumentRead) {
			NSLog(@"callbacks_hijacker: failed to read argument of type encoding '%s'", argumentType);
			assert(0);
		}
	}
	
	va_end(variableArguments);
	
	typedef void * (*eiffel_callback_bridge_type)(EIF_REFERENCE, EIF_POINTER, EIF_POINTER);
	eiffel_callback_bridge_type eiffel_callback_bridge = (eiffel_callback_bridge_type) objc_getAssociatedObject(self, (void *)1);
	// Get the EIF_OBJECT.
	// First try to get the EIF_OBJECT created with eif_protect.
	EIF_OBJECT eiffel_object = (EIF_OBJECT)objc_getAssociatedObject(self, (void *)-1);
	if (eiffel_object == nil) {
		// If there is no eiffel object created with eif_protect() associated with self
		// then there is one created with eif_create_weak_reference().
		eiffel_object = (EIF_OBJECT)objc_getAssociatedObject(self, NULL);
	}
	
	return eiffel_callback_bridge(eif_access(eiffel_object), _cmd, arguments);
}

id retain_imp(id self, SEL _cmd) {
	if ([self retainCount] <= 1) {
		EIF_OBJECT associated_object = (EIF_OBJECT)objc_getAssociatedObject(self, NULL);
		assert(associated_object);
		EIF_OBJECT object_to_associate = eif_protect(eif_access(associated_object));
		objc_setAssociatedObject(self, (void *)-1, (id)object_to_associate, OBJC_ASSOCIATION_ASSIGN);
	}
	// Call super implementation
	SEL retain_selector = @selector(retain);
	Method super_retain_method = class_getInstanceMethod([self superclass], retain_selector);
	IMP super_retain_imp = method_getImplementation(super_retain_method);
	return super_retain_imp(self, retain_selector);
}

void release_imp(id self, SEL _cmd) {
	if ([self retainCount] == 2) {
		EIF_OBJECT associated_object = (EIF_OBJECT)objc_getAssociatedObject(self, (void *)-1);
		assert(associated_object);
		eif_wean(associated_object);
		objc_setAssociatedObject(self, (void *)-1, nil, OBJC_ASSOCIATION_ASSIGN);
	}
	// Call super implementation
	SEL release_selector = @selector(release);
	Method super_release_method = class_getInstanceMethod([self superclass], release_selector);
	IMP super_release_imp = method_getImplementation(super_release_method);
	super_release_imp(self, release_selector);
}


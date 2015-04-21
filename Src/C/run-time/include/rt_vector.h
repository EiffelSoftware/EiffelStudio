/*
	description: "A dynamically growing array, intended to replace the C++ std::vector."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2015, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.

			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _rt_vector_h_
#define _rt_vector_h_

#include "eif_portable.h"
#include "rt_portable.h"
#include "rt_assert.h"
#include "eif_error.h"

#include <stdlib.h>

/* The initial capacity to be used when starting from an empty vector. */
#define RT_VECTOR_FIRST_RESERVE 2


/*
 * This macro defines the basic features of a vector.
 *
 * _vector_name: This name will be used as the name of the struct
 * and the prefix to all features.
 *
 * _vector_element_type: This is the static type of the elements of
 * the vector. It is possible to use a pointer type or a user-defined struct.
 *
 * The macro defines the following types and functions:
 *
 * The vector struct (struct _vector_name)
 * The constructor (_vector_name_init)
 * The deconstructor (_vector_name_deinit)
 *
 * Note that _vector_name is replaced with the actual name given by the user.
 */
#define RT_DECLARE_VECTOR_BASE(_vector_name, _vector_element_type) \
\
\
/* \
doc:	<struct name="_vector_name", export="private"> \
doc:		<summary> The main data structure for a dynamically growing array. This structure can be used as a replacement to the C++ std::vector. </summary> \
doc:		<field name="area", type="_vector_element_type*"> A dynamically allocated array containing the elements. </field> \
doc:		<field name="count", type="size_t"> The current number of elements in the vector. </field> \
doc:		<field name="capacity", type="size_t"> The currently reserved space in 'area', measured in number of elements. </field> \
doc:	</struct> \
 */ \
struct _vector_name { \
		/* Note: These fields are private. Do not modify them. */ \
	_vector_element_type* area; \
	size_t capacity; \
	size_t count; \
}; \
\
\
/* \
doc:	<routine name="_vector_name_init" return_type="void" export="private"> \
doc:		<summary> Initialize the vector to a consistent state. This feature does not yet allocate any memory. </summary> \
doc:		<param name="self" type="struct _vector_name*"> The vector to be initialized. Must not be NULL. </param> \
doc:		<thread_safety> Not safe. </thread_safety> \
doc:		<synchronization> None. </synchronization> \
doc:	</routine> \
*/ \
rt_private rt_inline void CAT2(_vector_name, _init) (struct _vector_name *self) \
{ \
	REQUIRE ("not_null", self != NULL); \
	self->area = NULL; \
	self->capacity = 0; \
	self->count = 0; \
} \
\
\
/* \
doc:	<routine name="_vector_name_deinit" return_type="void" export="private"> \
doc:		<summary> Deconstruct the vector. This also frees the internal memory, but it does not free the 'self' pointer. </summary> \
doc:		<param name="self" type="struct _vector_name*"> The vector to be de-initialized. Must not be NULL.</param> \
doc:		<thread_safety> Not safe. </thread_safety> \
doc:		<synchronization> None. </synchronization> \
doc:	</routine> \
*/ \
rt_private rt_inline void CAT2(_vector_name,_deinit) (struct _vector_name *self) \
{ \
	REQUIRE ("not_null", self != NULL); \
	free (self->area); \
	self->area = NULL; \
	self->capacity = 0; \
	self->count = 0; \
} \
\


/*
 * This macro defines features to query and modify the size
 * and capacity of a vector.
 *
 * _vector_name: This name will be used as the name of the struct
 * and the prefix to all features.
 *
 * _vector_element_type: This is the static type of the elements of
 * the vector. It is possible to use a pointer type or a user-defined struct.
 *
 * The _vector_name and _vector_element_type arguments have to be
 * the same as in RT_DECLARE_VECTOR_BASE.
 *
 * The macro defines the following functions:
 *
 * The reserve() function to increase the capacity (_vector_name_reserve)
 * A query for the number of elements ( _vector_name_count )
 *
 * Note that _vector_name is replaced with the actual name given by the user.
 */

#define RT_DECLARE_VECTOR_SIZE_FUNCTIONS(_vector_name,_vector_element_type) \
\
/* \
doc:	<routine name="_vector_name_reserve" return_type="int" export="private"> \
doc:		<summary> Allocate space in the vector to accomodate at least 'new_capacity' total elements. Newly allocated space does not have a defined value. </summary> \
doc:		<param name="self" type="struct _vector_name*"> The vector on which to allocate elements. Must not be NULL. </param> \
doc:		<param name="new_capacity" type="size_t"> The new capacity of the vector. If 'new_capacity' is smaller than the current capacity, nothing happens. </param> \
doc:		<return> T_OK on success, T_NO_MORE_MEMORY if allocation failed. </return> \
doc:		<thread_safety> Not safe. </thread_safety> \
doc:		<synchronization> None. </synchronization> \
doc:	</routine> \
*/ \
rt_private rt_inline int CAT2(_vector_name,_reserve) (struct _vector_name* self, size_t new_capacity) \
{ \
	int error = T_OK; \
	_vector_element_type* new_area = NULL; \
\
	REQUIRE ("not_null", self != NULL); \
\
	if (self->capacity < new_capacity) { \
		new_area = (_vector_element_type*) realloc (self->area, sizeof (_vector_element_type) * new_capacity); \
		if (new_area) { \
			self->area = new_area; \
			self->capacity = new_capacity; \
		} else { \
			error = T_NO_MORE_MEMORY; \
		} \
	} \
	return error; \
} \
\
/* \
doc:	<routine name="_vector_name_count)" return_type="size_t" export="private"> \
doc:		<summary> Return the number of elements in the vector. </summary> \
doc:		<param name="self" type="struct _vector_name*"> The vector struct. Must not be NULL. </param> \
doc:		<return> The element count in the vector. </return> \
doc:		<thread_safety> Not safe. </thread_safety> \
doc:		<synchronization> None. </synchronization> \
doc:	</routine> \
*/ \
rt_unused rt_private rt_inline size_t CAT2(_vector_name,_count) (struct _vector_name* self) \
{ \
	REQUIRE ("not_null", self != NULL); \
	return self->count; \
} \
\

/*
 * This macro defines array access features for a vector.
 *
 * _vector_name: This name will be used as the name of the struct
 * and the prefix to all features.
 *
 * _vector_element_type: This is the static type of the elements of
 * the vector. It is possible to use a pointer type or a user-defined struct.
 *
 * The _vector_name and _vector_element_type arguments have to be
 * the same as in RT_DECLARE_VECTOR_BASE.
 *
 * The macro defines the following functions:
 *
 * An array access function ( _vector_name_item )
 * An access function returning a pointer to an element (_vector_name_item_pointer)
 * An array modification function ( _vector_name_put )
 *
 * Note that _vector_name is replaced with the actual name given by the user.
 */

#define RT_DECLARE_VECTOR_ARRAY_FUNCTIONS(_vector_name, _vector_element_type) \
\
/* \
doc:	<routine name="_vector_name_item" return_type="_vector_element_type" export="private"> \
doc:		<summary> Return the element at index 'position' in vector 'self'. </summary> \
doc:		<param name="self" type="struct _vector_name*"> The vector struct. Must not be NULL. </param> \
doc:		<param name="position" type="size_t"> The index of the requested element. Valid indices are in the range [0 <= position < _vector_name_count(self)]. </param> \
doc:		<return> The element at the specified index. </return> \
doc:		<thread_safety> Not safe. </thread_safety> \
doc:		<synchronization> None. </synchronization> \
doc:	</routine> \
*/ \
rt_unused rt_private rt_inline _vector_element_type CAT2 (_vector_name, _item) (struct _vector_name* self, size_t position) \
{ \
	REQUIRE ("not_null", self != NULL); \
	REQUIRE ("within_bounds", position < self->count); \
	return (self->area)[position]; \
} \
\
\
/* \
doc:	<routine name="_vector_name_item_pointer" return_type="_vector_element_type*" export="private"> \
doc:		<summary> Return a pointer to the element at index 'position' in vector 'self'. </summary> \
doc:		<param name="self" type="struct _vector_name*"> The vector struct. Must not be NULL. </param> \
doc:		<param name="position" type="size_t"> The index of the requested element. Valid indices are in the range [0 <= position < _vector_name_count(self)]. </param> \
doc:		<return> A pointer to the element at the specified index. </return> \
doc:		<thread_safety> Not safe. </thread_safety> \
doc:		<synchronization> None. </synchronization> \
doc:	</routine> \
*/ \
rt_unused rt_private rt_inline _vector_element_type* CAT2 (_vector_name, _item_pointer) (struct _vector_name* self, size_t position) \
{ \
	REQUIRE ("not_null", self != NULL); \
	REQUIRE ("within_bounds", position < self->count); \
	return (self->area) + position; \
} \
\
\
/* \
doc:	<routine name="_vector_name_put)" return_type="void" export="private"> \
doc:		<summary> Put 'element' at index 'position' in vector 'self'. This replaces any previous value at the specified position. </summary> \
doc:		<param name="self" type="struct _vector_name*"> The vector struct. Must not be NULL. </param> \
doc:		<param name="position" type="size_t"> The target index to put the element. Valid indices are in the range [0 <= position < _vector_name_count(self)]. </param> \
doc:		<param name="element" type="_vector_element_type"> The element to be inserted. </param> \
doc:		<thread_safety> Not safe. </thread_safety> \
doc:		<synchronization> None. </synchronization> \
doc:	</routine> \
*/ \
rt_unused rt_private rt_inline void CAT2(_vector_name,_put) (struct _vector_name* self, size_t position, _vector_element_type element) \
{ \
	REQUIRE ("not_null", self != NULL); \
	REQUIRE ("within_bounds", position < self->count); \
	(self->area)[position] = element; \
} \
\

/*
 * This macro defines stack features for a vector.
 *
 * _vector_name: This name will be used as the name of the struct
 * and the prefix to all features.
 *
 * _vector_element_type: This is the static type of the elements of
 * the vector. It is possible to use a pointer type or a user-defined struct.
 *
 * The _vector_name and _vector_element_type arguments have to be
 * the same as in RT_DECLARE_VECTOR_BASE.
 *
 * The macro defines the following functions:
 *
 * A query for the last element ( _vector_name_last )
 * A push operation ( _vector_name_put_last )
 * A pop operation ( _vector_name_remove_last )
 *
 * Note that _vector_name is replaced with the actual name given by the user.
 */

#define RT_DECLARE_VECTOR_STACK_FUNCTIONS(_vector_name, _vector_element_type) \
\
/* \
doc:	<routine name="_vector_name_last" return_type="_vector_element_type" export="private"> \
doc:		<summary> Return the last element in vector 'self'. </summary> \
doc:		<param name="self" type="struct _vector_name*"> The vector struct. Must not be NULL and must not be empty. </param> \
doc:		<return> The last element of the vector. </return> \
doc:		<thread_safety> Not safe. </thread_safety> \
doc:		<synchronization> None. </synchronization> \
doc:	</routine> \
*/ \
rt_unused rt_private rt_inline _vector_element_type CAT2(_vector_name,_last) (struct _vector_name* self) \
{ \
	REQUIRE ("not_null", self != NULL); \
	REQUIRE ("not_empty", self->count > 0); \
	return (self->area) [self->count - 1]; \
} \
\
\
/* \
doc:	<routine name="_vector_name_last_pointer" return_type="_vector_element_type*" export="private"> \
doc:		<summary> Return a pointer to the last element in vector 'self'. </summary> \
doc:		<param name="self" type="struct _vector_name*"> The vector struct. Must not be NULL and must not be empty. </param> \
doc:		<return> A pointer to the last element of the vector. </return> \
doc:		<thread_safety> Not safe. </thread_safety> \
doc:		<synchronization> None. </synchronization> \
doc:	</routine> \
*/ \
rt_unused rt_private rt_inline _vector_element_type* CAT2(_vector_name,_last_pointer) (struct _vector_name* self) \
{ \
	REQUIRE ("not_null", self != NULL); \
	REQUIRE ("not_empty", self->count > 0); \
	return (self->area) + (self->count - 1); \
} \
\
\
/* \
doc:	<routine name="_vector_name_extend" return_type="int" export="private"> \
doc:		<summary> Put 'element' at the end of the vector 'self', increasing the count by one. If the vector is full, its capacity will be automatically increased. </summary> \
doc:		<param name="self" type="struct _vector_name*"> The vector struct. Must not be NULL. </param> \
doc:		<return> T_OK on success. T_NO_MORE_MEMORY when storage allocation fails. In case of a memory allocation error the vector is not modified. </return> \
doc:		<thread_safety> Not safe. </thread_safety> \
doc:		<synchronization> None. </synchronization> \
doc:	</routine> \
*/ \
rt_unused rt_private rt_inline int CAT2(_vector_name,_extend) (struct _vector_name* self, _vector_element_type element) \
{ \
	int l_error = T_OK; \
	size_t l_count = 0; \
	size_t l_capacity = 0; \
	size_t l_new_capacity = 0; \
\
	REQUIRE ("not_null", self != NULL); \
\
	l_count = self->count; \
	l_capacity = self->capacity; \
\
	if (l_count == l_capacity) { \
		l_new_capacity = (l_capacity < RT_VECTOR_FIRST_RESERVE) ? RT_VECTOR_FIRST_RESERVE : 2 * l_capacity; \
		l_error = CAT2(_vector_name,_reserve) (self, l_new_capacity); \
	} \
\
	if (l_error == T_OK) { \
		(self->area) [l_count] = element; \
		self->count = l_count + 1; \
	} \
	return l_error; \
} \
\
\
/* \
doc:	<routine name="_vector_name_remove_last" return_type="void" export="private"> \
doc:		<summary> Remove the last element at the end of vector 'self', decreasing the count by one. </summary> \
doc:		<param name="self" type="struct _vector_name*"> The vector struct. Must not be NULL and must not be empty. </param> \
doc:		<thread_safety> Not safe. </thread_safety> \
doc:		<synchronization> None. </synchronization> \
doc:		<fixme> If we add a resize function one day, we should ensure that elements are zero-initialized. This can be done either here or in resize. </fixme> \
doc:	</routine> \
*/ \
rt_unused rt_private rt_inline void CAT2(_vector_name,_remove_last) (struct _vector_name* self) \
{ \
	REQUIRE ("not_null", self != NULL); \
	REQUIRE ("not_empty", self->count > 0); \
	(self->count)--; \
} \
\


/*
 * Support features for heap allocation.
 *
 * This macro declares support functions to allocate
 * and deallocate structures on the heap, using malloc and free.
 *
 * The declared features assume the presence of the following declarations:
 *
 * struct _struct_name {...};
 * void _struct_name_init (_struct_name*);
 * void _struct_name_deinit (_struct_name*);
 *
 * Note that _struct_name is replaced by the acutal name given to the macro.
 * The _init and _deinit functions are the respective constructor and destructor functions.
 *
 * FIXME: These features are intentionally more general than the vector features.
 * If the need arises, one can move them to their own header.
 */
#define RT_DECLARE_HEAP_ALLOCATION_FUNCTIONS(_struct_name) \
\
/* \
doc:	<routine name="_struct_name_create" return_type="struct _struct_name*" export="private"> \
doc:		<summary> Allocate a new _struct_name structure on the heap and initialize it with _struct_name_init(). </summary> \
doc:		<return> A pointer to a _struct_name object. If memory allocation fails, the result is NULL. </return> \
doc:		<thread_safety> Not safe. </thread_safety> \
doc:		<synchronization> None. </synchronization> \
doc:	</routine> \
*/ \
rt_unused rt_private rt_inline struct _struct_name* CAT2(_struct_name,_create) (void) \
{ \
	struct _struct_name* result = (struct _struct_name*) malloc (sizeof (struct _struct_name)); \
	if (result) { \
		CAT2(_struct_name,_init) (result); \
	}\
	return result; \
} \
\
/* \
doc:	<routine name="_struct_name_create" return_type="void" export="private"> \
doc:		<summary> De-initialize the heap-allocated _struct_name object (using _struct_name_deinit()) and free the associated memory. </summary> \
doc:		<param name="self" type="struct _vector_name*"> A pointer to the _struct_name object on the heap. Can be NULL. </param> \
doc:		<thread_safety> Not safe. </thread_safety> \
doc:		<synchronization> None. </synchronization> \
doc:	</routine> \
*/ \
rt_unused rt_private rt_inline void CAT2(_struct_name,_destroy) (struct _struct_name* self) \
{ \
	if (self) { \
		CAT2(_struct_name,_deinit) (self); \
		free (self); \
	} \
} \
\


#define RT_DECLARE_VECTOR(_vector_name,_vector_element_type) \
RT_DECLARE_VECTOR_BASE (_vector_name, _vector_element_type) \
RT_DECLARE_VECTOR_SIZE_FUNCTIONS (_vector_name, _vector_element_type) \
RT_DECLARE_VECTOR_ARRAY_FUNCTIONS (_vector_name, _vector_element_type) \
RT_DECLARE_VECTOR_STACK_FUNCTIONS (_vector_name, _vector_element_type) \
RT_DECLARE_HEAP_ALLOCATION_FUNCTIONS (_vector_name)

#endif /* _rt_vector_h_ */

